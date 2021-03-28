--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

--[[------------------------------------------------
	-- note: the text wrapping of this object is
			 experimental and not final
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- text object
local newobject = loveframes.newObject("text", "loveframes_object_text", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()

	self.type = "text"
	self.text = ""
	self.font = loveframes.basicfont
	self.width = 5
	self.height = 5
	self.maxw = 0
	self.shadowxoffset = 1
	self.shadowyoffset = 1
	self.lines = 0
	self.formattedtext = {}
	self.original = {}
	self.defaultcolor = {0, 0, 0, 1}
	self.shadowcolor = {0, 0, 0, 1}
	self.linkcolor = {0, .4, 1, 1}
	self.linkhovercolor = {0, 0, 1, 1}
	self.ignorenewlines = false
	self.shadow = false
	self.linkcol = false
	self.internal = false
	self.linksenabled = false
	self.detectlinks = false
	self.onClickLink = nil

	local skin = loveframes.getActiveSkin()
	if not skin then
		skin = loveframes.config["DEFAULTSKIN"]
	end

	local directives = skin.directives
	if directives then
		local text_default_color = directives.text_default_color
		local text_default_shadowcolor = directives.text_default_shadowcolor
		local text_default_font = directives.text_default_font
		if text_default_color then
			self.defaultcolor = text_default_color
		end
		if text_default_shadowcolor then
			self.shadowcolor = text_default_shadowcolor
		end
		if text_default_font then
			self.font = text_default_font
		end
	end
	self:setDrawFunc()
end

--[[---------------------------------------------------------
	- func: update(deltatime)
	- desc: updates the object
--]]---------------------------------------------------------
function newobject:_update(dt)

	local state = loveframes.state
	local selfstate = self.state

	if state ~= selfstate then
		return
	end

	local visible = self.visible
	local alwaysupdate = self.alwaysupdate

	if not visible then
		if not alwaysupdate then
			return
		end
	end

	local parent = self.parent
	local base = loveframes.base
	local update = self.update

	self:checkHover()

	local hover = self.hover
	local linksenabled = self.linksenabled
	local linkcol = false

	if hover and linksenabled and not loveframes.resizeobject then
		local formattedtext = self.formattedtext
		local x = self.x
		local y = self.y
		for k, v in ipairs(formattedtext) do
			local link = v.link
			if link then
				local mx, my = love.mouse.getPosition()
				local font = v.font
				local linkx = v.x
				local linky = v.y
				local text = v.text
				local twidth = font:getWidth(text)
				local theight = font:getHeight()
				local col = loveframes.boundingBox(x + linkx, mx, y + linky, my, twidth, 1, theight, 1)
				v.hover = false
				if col then
					v.hover = true
					linkcol = true
				end
			end
		end
		self.linkcol = linkcol
	end

	-- move to parent if there is a parent
	if parent ~= base then
		self.x = self.parent.x + self.staticx
		self.y = self.parent.y + self.staticy
	end

	if update then
		update(self, dt)
	end

end

--[[---------------------------------------------------------
	- func: mousepressed(x, y, button)
	- desc: called when the player presses a mouse button
--]]---------------------------------------------------------
function newobject:mousepressed(x, y, button)

	local state = loveframes.state
	local selfstate = self.state

	if state ~= selfstate then
		return
	end

	local visible = self.visible

	if not visible then
		return
	end

	local hover = self.hover
	if hover and button == 1 then
		local baseparent = self:getBaseParent()
		if baseparent and baseparent.type == "frame" then
			baseparent:makeTop()
		end
		local linksenabled = self.linksenabled
		if linksenabled then
			local formattedtext = self.formattedtext
			local objx = self.x
			local objy = self.y
			for k, v in ipairs(formattedtext) do
				local link = v.link
				if link then
					local linkx = v.x
					local linky = v.y
					local font = v.font
					local text = v.text
					local twidth = font:getWidth(text)
					local theight = font:getHeight()
					local col = loveframes.boundingBox(objx + linkx, x, objy + linky, y, twidth, 1, theight, 1)
					if col then
						local onclicklink = self.onClickLink
						if onclicklink then
							onclicklink(self, text)
						end
					end
				end
			end
		end
	end

end

--[[---------------------------------------------------------
	- func: setText(text)
	- desc: sets the object's text
--]]---------------------------------------------------------
function newobject:setText(t)

	local dtype = type(t)
	local maxw = self.maxw
	local font = self.font
	local defaultcolor = self.defaultcolor
	local inserts = {}
	local prevcolor = defaultcolor
	local prevlinkcolor = self.linkcolor
	local prevlinkhovercolor = self.linkhovercolor
	local prevfont = font
	local link = false
	local tdata

	self.text = ""
	self.formattedtext = {}

	if dtype == "string" then
		tdata = {t}
		self.original = {t}
	elseif dtype == "number" then
		tdata = {tostring(t)}
		self.original = {tostring(t)}
	elseif dtype == "table" then
		tdata = t
		self.original = t
	else
		return
	end

	for k, v in ipairs(tdata) do
		dtype = type(v)
		if dtype == "table" then
			if v.color then
				prevcolor = v.color
			end
			if v.linkcolor then
				prevlinkcolor = v.linkcolor
			end
			if v.linkhovercolor then
				prevlinkhovercolor = v.linkhovercolor
			end
			if v.font then
				prevfont = v.font
			end
			if v.link then
				link = true
			else
				link = false
			end
		elseif dtype == "number" then
			table.insert(self.formattedtext, {
				font = prevfont,
				color = prevcolor,
				linkcolor = prevlinkcolor,
				linkhovercolor = prevlinkhovercolor,
				link = link,
				text = tostring(v)
			})
		elseif dtype == "string" then
			if self.ignorenewlines then
				v = loveframes.utf8.gsub(v, "\n", " ")
			end
			v = loveframes.utf8.gsub(v, string.char(9), "    ")
			v = loveframes.utf8.gsub(v, "\n", " \n ")
			local parts = loveframes.splitString(v, " ")
			for i, j in ipairs(parts) do
				table.insert(self.formattedtext, {
					font = prevfont,
					color = prevcolor,
					linkcolor = prevlinkcolor,
					linkhovercolor = prevlinkhovercolor,
					link = link,
					text = j
				})
			end
		end
	end

	if maxw > 0 then
		for k, v in ipairs(self.formattedtext) do
			local data = v.text
			local width = v.font:getWidth(data)
			local curw = 0
			local new = ""
			local key = k
			if width > maxw then
				table.remove(self.formattedtext, k)
				for n=1, loveframes.utf8.len(data) do
					local item = loveframes.utf8.sub(data, n, n)
					local itemw = v.font:getWidth(item)
					if n ~= loveframes.utf8.len(data) then
						if (curw + itemw) > maxw then
							table.insert(inserts, {
								key = key,
								font = v.font,
								color = v.color,
								linkcolor = prevlinkcolor,
								linkhovercolor = v.linkhovercolor,
								link = v.link,
								text = new
							})
							new = item
							curw = 0 + itemw
							key = key + 1
						else
							new = new .. item
							curw = curw + itemw
						end
					else
						new = new .. item
						table.insert(inserts, {
							key = key,
							font = v.font,
							color = v.color,
							linkcolor = prevlinkcolor,
							linkhovercolor = v.linkhovercolor,
							link = v.link,
							text = new
						})
					end
				end
			end
		end
	end

	for k, v in ipairs(inserts) do
		table.insert(self.formattedtext, v.key, {
			font = v.font,
			color = v.color,
			linkcolor = prevlinkcolor,
			linkhovercolor = v.linkhovercolor,
			link = v.link,
			text = v.text
		})
	end

	local textdata = self.formattedtext
	local maxw = self.maxw
	local font = self.font
	local twidth = 0
	local drawx = 0
	local drawy = 0
	local lines = 1
	local textwidth = 0
	local lastwidth = 0
	local totalwidth = 0
	local x = self.x
	local y = self.y
	local prevtextwidth = 0
	local prevtextheight = 0
	local prevlargestheight = 0
	local largestwidth = 0
	local largestheight = 0
	local initialwidth = 0
	local detectlinks = self.detectlinks

	for k, v in ipairs(textdata) do
		local text = v.text
		local color = v.color
		if detectlinks then
			if loveframes.utf8.len(text) > 7 and (loveframes.utf8.sub(text, 1, 7) == "http://" or loveframes.utf8.sub(text, 1, 8) == "https://") then
				v.link = true
			end
		end
		if type(text) == "string" then
			self.text = self.text .. text
			local width = v.font:getWidth(text)
			local height = v.font:getHeight("a")
			if height > largestheight then
				largestheight = height
				prevlargestheight = height
			end
			totalwidth = totalwidth + width
			if maxw > 0 then
				if k ~= 1 then
					if string.byte(text) == 10 then
						twidth = 0
						drawx = 0
						width = 0
						drawy = drawy + largestheight
						largestheight = 0
						text = ""
						lines = lines + 1
					elseif (twidth + width) > maxw then
						twidth = 0 + width
						drawx = 0
						drawy = drawy + largestheight
						largestheight = 0
						lines = lines + 1
					else
						twidth = twidth + width
						drawx = drawx + prevtextwidth
					end
				else
					twidth = twidth + width
				end
				prevtextwidth = width
				prevtextheight = height
				v.x = drawx
				v.y = drawy
			else
				if string.byte(text) == 10 then
					twidth = 0
					drawx = 0
					width = 0
					drawy = drawy + largestheight
					largestheight = 0
					text = ""
					lines = lines + 1
					if lastwidth < textwidth then
						lastwidth = textwidth
					end
					if largestwidth < textwidth then
						largestwidth = textwidth
					end
					textwidth = 0
				else
					drawx = drawx + prevtextwidth
					textwidth = textwidth + width
				end
				prevtextwidth = width
				prevtextheight = height
				v.x = drawx
				v.y = drawy
			end
		end
	end

	self.lines = lines

	if lastwidth == 0 then
		textwidth = totalwidth
	end

	if textwidth < largestwidth then
		textwidth = largestwidth
	end

	if maxw > 0 then
		self.width = maxw
	else
		self.width = textwidth
	end

	self.height = drawy + prevlargestheight
	return self

end

--[[---------------------------------------------------------
	- func: getText()
	- desc: gets the object's text
--]]---------------------------------------------------------
function newobject:getText()

	return self.text

end

--[[---------------------------------------------------------
	- func: getFormattedText()
	- desc: gets the object's formatted text
--]]---------------------------------------------------------
function newobject:getFormattedText()

	return self.formattedtext

end

--[[---------------------------------------------------------
	- func: drawText()
	- desc: draws the object's text
--]]---------------------------------------------------------
function newobject:drawText()

	local textdata = self.formattedtext
	local x = self.x
	local y = self.y
	local shadow = self.shadow
	local shadowxoffset = self.shadowxoffset
	local shadowyoffset = self.shadowyoffset
	local shadowcolor = self.shadowcolor
	local inlist, list = self:isInList()
	local printfunc = function(text, x, y)
		love.graphics.print(text, math.floor(x + 0.5), math.floor(y + 0.5))
	end

	for k, v in ipairs(textdata) do
		local textx = v.x
		local texty = v.y
		local text = v.text
		local color = v.color
		local font = v.font
		local link = v.link
		local theight = font:getHeight("a")
		if inlist then
			local listy = list.y
			local listhieght = list.height
			if (y + texty) <= (listy + listhieght) and y + ((texty + theight)) >= listy then
				love.graphics.setFont(font)
				if shadow then
					love.graphics.setColor(unpack(shadowcolor))
					printfunc(text, x + textx + shadowxoffset, y + texty + shadowyoffset)
				end
				if link then
					local linkcolor = v.linkcolor
					local linkhovercolor = v.linkhovercolor
					local hover = v.hover
					if hover then
						love.graphics.setColor(linkhovercolor)
					else
						love.graphics.setColor(linkcolor)
					end
				else
					love.graphics.setColor(unpack(color))
				end
				printfunc(text, x + textx, y + texty)
			end
		else
			love.graphics.setFont(font)
			if shadow then
				love.graphics.setColor(unpack(shadowcolor))
				printfunc(text, x + textx + shadowxoffset, y + texty + shadowyoffset)
			end
			if link then
				local linkcolor = v.linkcolor
				local linkhovercolor = v.linkhovercolor
				local hover = v.hover
				if hover then
					love.graphics.setColor(linkhovercolor)
				else
					love.graphics.setColor(linkcolor)
				end
			else
				love.graphics.setColor(unpack(color))
			end
			printfunc(text, x + textx, y + texty)
		end
	end

	return self
end

--[[---------------------------------------------------------
	- func: setMaxWidth(width)
	- desc: sets the object's maximum width
--]]---------------------------------------------------------
function newobject:setMaxWidth(width)

	local original = self.original

	self.maxw = width
	self:setText(original)

	return self

end

--[[---------------------------------------------------------
	- func: getMaxWidth()
	- desc: gets the object's maximum width
--]]---------------------------------------------------------
function newobject:getMaxWidth()

	return self.maxw

end

--[[---------------------------------------------------------
	- func: setWidth(width, relative)
	- desc: sets the object's width
--]]---------------------------------------------------------
function newobject:setWidth(width, relative)

	if relative then
		self:setMaxWidth(self.parent.width * width)
	else
		self:setMaxWidth(width)
	end

	return self

end

--[[---------------------------------------------------------
	- func: setHeight()
	- desc: sets the object's height
--]]---------------------------------------------------------
function newobject:setHeight(height)

	return

end

--[[---------------------------------------------------------
	- func: setSize(width, height, relative)
	- desc: sets the object's size
--]]---------------------------------------------------------
function newobject:setSize(width, height, relative)

	if relative then
		self:setMaxWidth(self.parent.width * width)
	else
		self:setMaxWidth(width)
	end

	return self

end

--[[---------------------------------------------------------
	- func: setFont(font)
	- desc: sets the object's font
	- note: font argument must be a font object
--]]---------------------------------------------------------
function newobject:setFont(font)

	local original = self.original

	self.font = font

	if original then
		self:setText(original)
	end

	return self

end

--[[---------------------------------------------------------
	- func: getFont()
	- desc: gets the object's font
--]]---------------------------------------------------------
function newobject:getFont()

	return self.font

end

--[[---------------------------------------------------------
	- func: getLines()
	- desc: gets the number of lines the object's text uses
--]]---------------------------------------------------------
function newobject:getLines()

	return self.lines

end

--[[---------------------------------------------------------
	- func: setIgnoreNewlines(bool)
	- desc: sets whether the object should ignore \n or not
--]]---------------------------------------------------------
function newobject:setIgnoreNewlines(bool)

	self.ignorenewlines = bool
	return self

end

--[[---------------------------------------------------------
	- func: getIgnoreNewlines()
	- desc: gets whether the object should ignore \n or not
--]]---------------------------------------------------------
function newobject:getIgnoreNewlines()

	return self.ignorenewlines

end

--[[---------------------------------------------------------
	- func: setShadow(bool)
	- desc: sets whether or not the object should draw a
			shadow behind its text
--]]---------------------------------------------------------
function newobject:setShadow(bool)

	self.shadow = bool
	return self

end

--[[---------------------------------------------------------
	- func: getShadow()
	- desc: gets whether or not the object should draw a
			shadow behind its text
--]]---------------------------------------------------------
function newobject:getShadow()

	return self.shadow

end

--[[---------------------------------------------------------
	- func: setShadowOffsets(offsetx, offsety)
	- desc: sets the object's x and y shadow offsets
--]]---------------------------------------------------------
function newobject:setShadowOffsets(offsetx, offsety)

	self.shadowxoffset = offsetx
	self.shadowyoffset = offsety

	return self

end

--[[---------------------------------------------------------
	- func: getShadowOffsets()
	- desc: gets the object's x and y shadow offsets
--]]---------------------------------------------------------
function newobject:getShadowOffsets()

	return self.shadowxoffset, self.shadowyoffset

end

--[[---------------------------------------------------------
	- func: setShadowColor(r, g, b, a)
	- desc: sets the object's shadow color
--]]---------------------------------------------------------
function newobject:setShadowColor(r, g, b, a)

	self.shadowcolor = {r, g, b, a}
	return self

end

--[[---------------------------------------------------------
	- func: getShadowColor()
	- desc: gets the object's shadow color
--]]---------------------------------------------------------
function newobject:getShadowColor()

	return self.shadowcolor

end

--[[---------------------------------------------------------
	- func: setDefaultColor(r, g, b, a)
	- desc: sets the object's default text color
--]]---------------------------------------------------------
function newobject:setDefaultColor(r, g, b, a)

	self.defaultcolor = {r, g, b, a}
	return self

end

--[[---------------------------------------------------------
	- func: getDefaultColor()
	- desc: gets whether or not the object should draw a
			shadow behind its text
--]]---------------------------------------------------------
function newobject:getDefaultColor()

	return self.defaultcolor

end

--[[---------------------------------------------------------
	- func: setLinksEnabled(enabled)
	- desc: sets whether or not the object should process
			urls into clickable links
--]]---------------------------------------------------------
function newobject:setLinksEnabled(enabled)

	self.linksenabled = enabled
	return self

end

--[[---------------------------------------------------------
	- func: getLinksEnabled()
	- desc: gets whether or not the object should process
			urls into clickable links
--]]---------------------------------------------------------
function newobject:getLinksEnabled()

	return self.linksenabled

end

--[[---------------------------------------------------------
	- func: setDetectLinks(detect)
	- desc: sets whether or not the object should detect
			links when processing new text
--]]---------------------------------------------------------
function newobject:setDetectLinks(detect)

	self.detectlinks = detect
	return self

end

--[[---------------------------------------------------------
	- func: getDetectLinks()
	- desc: gets whether or not the object should detect
			links when processing new text
--]]---------------------------------------------------------
function newobject:getDetectLinks()

	return self.detectlinks

end

---------- module end ----------
end
