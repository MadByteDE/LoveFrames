--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- textinput object
local newobject = loveframes.newObject("textinput", "loveframes_object_textinput", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()

	self.type = "textinput"
	self.keydown = "none"
	self.tabreplacement = "        "
	self.maskchar = "*"
	self.font = loveframes.basicfont
	self.width = 200
	self.height = 25
	self.delay = 0
	self.repeatdelay = 0.80
	self.repeatrate = 0.02
	self.offsetx = 0
	self.offsety = 0
	self.indincatortime = 0
	self.indicatornum = 0
	self.indicatorx = 0
	self.indicatory = 0
	self.textx = 0
	self.texty = 0
	self.textoffsetx = 5
	self.textoffsety = 5
	self.unicode = 0
	self.limit = 0
	self.line = 1
	self.itemwidth = 0
	self.itemheight = 0
	self.extrawidth = 0
	self.extraheight = 0
	self.rightpadding = 0
	self.bottompadding = 0
	self.lastclicktime = 0
	self.maxx = 0
	self.buttonscrollamount = 0.10
	self.mousewheelscrollamount = 5
	self.usable = {}
	self.unusable = {}
	self.lines = {""}
	self.placeholder = ""
	self.internals = {}
	self.showindicator = true
	self.focus = false
	self.multiline = false
	self.vbar = false
	self.hbar = false
	self.alltextselected = false
	self.linenumbers = true
	self.linenumberspanel = false
	self.editable = true
	self.internal = false
	self.autoscroll = false
	self.masked = false
	self.trackindicator = true
	self.onEnter = nil
	self.onTextChanged = nil
	self.onFocusGained = nil
	self.onFocusLost = nil
	self.onCopy = nil
	self.onPaste = nil

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

	-- check to see if the object is being hovered over
	self:checkHover()

	local time = love.timer.getTime()
	local keydown = self.keydown
	local parent = self.parent
	local base = loveframes.base
	local update = self.update
	local font = self.font
	local theight = font:getHeight()
	local delay = self.delay
	local lines = self.lines
	local numlines = #lines
	local multiline = self.multiline
	local width = self.width
	local height = self.height
	local vbar = self.vbar
	local hbar = self.hbar
	local inputobject = loveframes.inputobject
	local internals = self.internals
	local repeatrate = self.repeatrate
	local hover = self.hover

	-- move to parent if there is a parent
	if parent ~= base then
		local parentx = parent.x
		local parenty = parent.y
		local staticx = self.staticx
		local staticy = self.staticy
		self.x = parentx + staticx
		self.y = parenty + staticy
	end

	if inputobject ~= self then
		self.focus = false
		self.alltextselected = false
	end

	self:positionText()
	self:updateIndicator()

	-- calculations for multiline mode
	if multiline then
		local twidth = 0
		local panel = self:getLineNumbersPanel()
		local textoffsetx = self.textoffsetx
		local textoffsety = self.textoffsety
		local linenumbers = self.linenumbers
		local masked = self.masked
		local maskchar = self.maskchar
		-- get the longest line of text
		for k, v in ipairs(lines) do
			local linewidth = 0
			if masked then
				linewidth = font:getWidth(loveframes.utf8.gsub(v, ".", maskchar))
			else
				linewidth = font:getWidth(v)
			end
			if linewidth > twidth then
				twidth = linewidth
			end
		end
		-- item width calculation
		if vbar then
			self.itemwidth = twidth + 16 + textoffsetx * 2
		else
			self.itemwidth = twidth + (textoffsetx * 2)
		end
		if panel then
			local panelwidth = panel.width
			self.itemwidth = self.itemwidth + panelwidth + textoffsetx + 5
		end
		-- item height calculation
		if hbar then
			self.itemheight = theight * numlines + 16 + textoffsety * 2
		else
			self.itemheight = theight * numlines
		end
		-- extra width and height calculations
		self.extrawidth = self.itemwidth - width
		self.extraheight = self.itemheight - height
		local itemwidth = self.itemwidth
		local itemheight = self.itemheight
		if itemheight > height then
			if not vbar then
				local scrollbody = loveframes.objects["scrollbody"]:new(self, "vertical")
				scrollbody.internals[1].internals[1].autoscroll = self.autoscroll
				table.insert(self.internals, scrollbody)
				self.vbar = true
				if hbar then
					local vbody = self:getVerticalScrollBody()
					local vbodyheight = vbody:getHeight() - 15
					local hbody = self:getHorizontalScrollBody()
					local hbodywidth = hbody:getWidth() - 15
					vbody:setHeight(vbodyheight)
					hbody:setWidth(hbodywidth)
				end
			end
		else
			if vbar then
				self:getVerticalScrollBody():remove()
				self.vbar = false
				self.offsety = 0
				if self.hbar then
					local hbody = self:getHorizontalScrollBody()
					local hbodywidth = hbody:getWidth() - 15
					hbody:setWidth(hbodywidth)
				end
			end
		end

		if itemwidth > width then
			if not hbar then
				local scrollbody = loveframes.objects["scrollbody"]:new(self, "horizontal")
				scrollbody.internals[1].internals[1].autoscroll = self.autoscroll
				table.insert(self.internals, scrollbody)
				self.hbar = true
				if self.vbar then
					local vbody = self:getVerticalScrollBody()
					local hbody = self:getHorizontalScrollBody()
					vbody:setHeight(vbody:getHeight() - 15)
					hbody:setWidth(hbody:getWidth() - 15)
				end
			end
		else
			if hbar then
				self:getHorizontalScrollBody():remove()
				self.hbar = false
				self.offsetx = 0
				if vbar then
					local vbody = self:getVerticalScrollBody()
					if vbody then
						vbody:setHeight(vbody:getHeight() + 15)
					end
				end
			end
		end
		if linenumbers then
			if not self.linenumberspanel then
				local linenumberspanel = loveframes.objects["linenumberspanel"]:new(self)
				table.insert(internals, linenumberspanel)
				self.linenumberspanel = true
			end
		else
			if self.linenumberspanel then
				table.remove(internals, 1)
				self.linenumberspanel = false
			end
		end
	end

	for k, v in ipairs(internals) do
		v:_update(dt)
	end

	if update then
		update(self, dt)
	end

end

--[[---------------------------------------------------------
	- func: draw()
	- desc: draws the object
--]]---------------------------------------------------------
function newobject:_draw()
	if loveframes.state ~= self.state then
		return
	end

	if not self.visible then
		return
	end

	local x = self.x
	local y = self.y
	local width = self.width
	local height = self.height
	local stencilfunc = function() love.graphics.rectangle("fill", x, y, width, height) end
	local vbar = self.vbar
	local hbar = self.hbar

	-- set the object's draw order
	self:setDrawOrder()

	if vbar and hbar then
		stencilfunc = function() love.graphics.rectangle("fill", x, y, width - 16, height - 16) end
	end

	love.graphics.stencil(stencilfunc)
	love.graphics.setStencilTest("greater", 0)

	local drawfunc = self.draw or self.drawfunc
	if drawfunc then
		drawfunc(self)
	end

	love.graphics.setStencilTest()

	local internals = self.internals
	if internals then
		for k, v in ipairs(internals) do
			v:_draw()
		end
	end

	drawfunc = self.drawOver or self.drawoverfunc
	if drawfunc then
		drawfunc(self)
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
	local internals = self.internals
	local alt = love.keyboard.isDown("lalt", "ralt")
	local vbar = self.vbar
	local hbar = self.hbar
	local scrollamount = self.mousewheelscrollamount
	local focus = self.focus
	local alltextselected = self.alltextselected
	local onfocusgained = self.onFocusGained
	local onfocuslost = self.onFocusLost
	local time = love.timer.getTime()
	local inputobject = loveframes.inputobject

	if hover then
		if button == 1 then
			if inputobject ~= self then
				loveframes.inputobject = self
			end
			if not alltextselected then
				local lastclicktime = self.lastclicktime
				if (time > lastclicktime) and time < (lastclicktime + 0.25) then
					if not self.multiline then
						if self.lines[1] ~= "" then
							self.alltextselected = true
						end
					else
						self.alltextselected = true
					end
				end
			else
				self.alltextselected = false
			end
			self.focus = true
			self.lastclicktime = time
			self:getTextCollisions(x, y)
			if onfocusgained and not focus then
				onfocusgained(self)
			end
			local baseparent = self:getBaseParent()
			if baseparent and baseparent.type == "frame" then
				baseparent:makeTop()
			end
		elseif button == "wu" then
			if not alt then
				if focus then
					self.line = math.max(self.line - scrollamount, 1)
				elseif vbar then
					local vbar = self:getVerticalScrollBody().internals[1].internals[1]
					vbar:scroll(-scrollamount)
				end
			else
				if focus then
					self:moveIndicator(-scrollamount)
				elseif hbar then
					local hbar = self:getHorizontalScrollBody().internals[1].internals[1]
					hbar:scroll(-scrollamount)
				end
			end
		elseif button == "wd" then
			if not alt then
				if focus then
					self.line = math.min(self.line + scrollamount, #self.lines)
				elseif vbar then
					local vbar = self:getVerticalScrollBody().internals[1].internals[1]
					vbar:scroll(scrollamount)
				end
			else
				if focus then
					self:moveIndicator(scrollamount)
				elseif hbar then
					local hbar = self:getHorizontalScrollBody().internals[1].internals[1]
					hbar:scroll(scrollamount)
				end
			end
		end
	else
		if inputobject == self then
			loveframes.inputobject = false
			if onfocuslost then
				onfocuslost(self)
			end
		end
	end

	for k, v in ipairs(internals) do
		v:mousepressed(x, y, button)
	end

end

--[[---------------------------------------------------------
	- func: mousereleased(x, y, button)
	- desc: called when the player releases a mouse button
--]]---------------------------------------------------------
function newobject:mousereleased(x, y, button)

	local state = loveframes.state
	local selfstate = self.state

	if state ~= selfstate then
		return
	end

	local visible = self.visible
	if not visible then
		return
	end

	local internals = self.internals
	for k, v in ipairs(internals) do
		v:mousereleased(x, y, button)
	end

end

--[[---------------------------------------------------------
	- func: keypressed(key, isrepeat)
	- desc: called when the player presses a key
--]]---------------------------------------------------------
function newobject:keypressed(key, isrepeat)

	local state = loveframes.state
	local selfstate = self.state

	if state ~= selfstate then
		return
	end

	local visible = self.visible

	if not visible then
		return
	end

	local time = love.timer.getTime()
	local focus = self.focus
	local repeatdelay = self.repeatdelay
	local alltextselected = self.alltextselected
	local editable = self.editable

	self.delay = time + repeatdelay
	self.keydown = key

	if (loveframes.IsCtrlDown()) and focus then
		if key == "a" then
			if not self.multiline then
				if self.lines[1] ~= "" then
					self.alltextselected = true
				end
			else
				self.alltextselected = true
			end
		elseif key == "c" and alltextselected then
			local text = self:getText()
			local oncopy = self.onCopy
			love.system.setClipboardText(text)
			if oncopy then
				oncopy(self, text)
			end
		elseif key == "x" and alltextselected and editable then
			local text = self:getText()
			local oncut = self.OnCut
			love.system.setClipboardText(text)
			if oncut then
				oncut(self, text)
			else
				self:setText("")
			end
		elseif key == "v" and editable then
			self:paste()
		else
			self:runKey(key, false)
		end
	else
		self:runKey(key, false)
	end

end

--[[---------------------------------------------------------
	- func: keyreleased(key)
	- desc: called when the player releases a key
--]]---------------------------------------------------------
function newobject:keyreleased(key)

	local state = loveframes.state
	local selfstate = self.state

	if state ~= selfstate then
		return
	end

	local visible = self.visible
	if not visible then
		return
	end

	self.keydown = "none"

end

--[[---------------------------------------------------------
	- func: textinput(text)
	- desc: called when the inputs text
--]]---------------------------------------------------------
function newobject:textinput(text)

	if loveframes.utf8.find(text, "kp.") then
		text = loveframes.utf8.gsub(text, "kp", "")
	end

	self:runKey(text, true)

end

--[[---------------------------------------------------------
	- func: runKey(key, istext)
	- desc: runs a key event on the object
--]]---------------------------------------------------------
function newobject:runKey(key, istext)

	local visible = self.visible
	local focus = self.focus

	if not visible then
		return
	end

	if not focus then
		return
	end

	local x = self.x
	local offsetx = self.offsetx
	local lines = self.lines
	local line = self.line
	local numlines = #lines
	local curline = lines[line]
	local text = curline
	local ckey = ""
	local font = self.font
	local swidth = self.width
	local textoffsetx = self.textoffsetx
	local indicatornum = self.indicatornum
	local multiline = self.multiline
	local alltextselected = self.alltextselected
	local editable = self.editable
	local initialtext = self:getText()
	local ontextchanged = self.onTextChanged
	local onenter = self.onEnter

	if not istext then
		if key == "left" then
			indicatornum = self.indicatornum
			if not multiline then
				self:moveIndicator(-1)
				local indicatorx = self.indicatorx
				if indicatorx <= x and indicatornum ~= 0 then
					local width = font:getWidth(loveframes.utf8.sub(text, indicatornum, indicatornum + 1))
					self.offsetx = offsetx - width
				elseif indicatornum == 0 and offsetx ~= 0 then
					self.offsetx = 0
				end
			else
				if indicatornum == 0 then
					if line > 1 then
						self.line = line - 1
						local numchars = loveframes.utf8.len(lines[self.line])
						self:moveIndicator(numchars)
					end
				else
					self:moveIndicator(-1)
				end
			end
			if alltextselected then
				self.line = 1
				self.indicatornum = 0
				self.alltextselected = false
			end
			return
		elseif key == "right" then
			indicatornum = self.indicatornum
			if not multiline then
				self:moveIndicator(1)
				local indicatorx = self.indicatorx
				if indicatorx >= (x + swidth) and indicatornum ~= loveframes.utf8.len(text) then
					local width = font:getWidth(loveframes.utf8.sub(text, indicatornum, indicatornum))
					self.offsetx = offsetx + width
				elseif indicatornum == loveframes.utf8.len(text) and offsetx ~= ((font:getWidth(text)) - swidth + 10) and font:getWidth(text) + textoffsetx > swidth then
					self.offsetx = ((font:getWidth(text)) - swidth + 10)
				end
			else
				if indicatornum == loveframes.utf8.len(text) then
					if line < numlines then
						self.line = line + 1
						self:moveIndicator(0, true)
					end
				else
					self:moveIndicator(1)
				end
			end
			if alltextselected then
				self.line = #lines
				self.indicatornum = loveframes.utf8.len(lines[#lines])
				self.alltextselected = false
			end
			return
		elseif key == "up" then
			if multiline then
				if line > 1 then
					self.line = line - 1
					if indicatornum > loveframes.utf8.len(lines[self.line]) then
						self.indicatornum = loveframes.utf8.len(lines[self.line])
					end
				end
			end
			return
		elseif key == "down" then
			if multiline then
				if line < #lines then
					self.line = line + 1
					if indicatornum > loveframes.utf8.len(lines[self.line]) then
						self.indicatornum = loveframes.utf8.len(lines[self.line])
					end
				end
			end
			return
		end

		if not editable then
			return
		end

		-- key input checking system
		if key == "backspace" then
			ckey = key
			if alltextselected then
				self:clear()
				self.alltextselected = false
				indicatornum = self.indicatornum
			else
				if text ~= "" and indicatornum ~= 0 then
					text = self:removeFromText(indicatornum)
					self:moveIndicator(-1)
					lines[line] = text
				end
				if multiline then
					if line > 1 and indicatornum == 0 then
						local newindicatornum = 0
						local oldtext = lines[line]
						table.remove(lines, line)
						self.line = line - 1
						if loveframes.utf8.len(oldtext) > 0 then
							newindicatornum = loveframes.utf8.len(lines[self.line])
							lines[self.line] = lines[self.line] .. oldtext
							self:moveIndicator(newindicatornum)
						else
							self:moveIndicator(loveframes.utf8.len(lines[self.line]))
						end
					end
				end
				local masked = self.masked
				local cwidth = 0
				if masked then
					local maskchar = self.maskchar
					cwidth = font:getWidth(loveframes.utf8.gsub(text, ".", maskchar))
				else
					cwidth = font:getWidth(text)
				end
				if self.offsetx > 0 then
					self.offsetx = self.offsetx - cwidth
				elseif self.offsetx < 0 then
					self.offsetx = 0
				end
			end
		elseif key == "delete" then
			if not editable then
				return
			end
			ckey = key
			if alltextselected then
				self:clear()
				self.alltextselected = false
				indicatornum = self.indicatornum
			else
				if text ~= "" and indicatornum < loveframes.utf8.len(text) then
					text = self:removeFromText(indicatornum + 1)
					lines[line] = text
				elseif indicatornum == loveframes.utf8.len(text) and line < #lines then
					local oldtext = lines[line + 1]
					if loveframes.utf8.len(oldtext) > 0 then
						-- FIXME: newindicatornum here???
						-- newindicatornum = loveframes.utf8.len(lines[self.line])
						lines[self.line] = lines[self.line] .. oldtext
					end
					table.remove(lines, line + 1)
				end
			end
		elseif key == "return" or key == "kpenter" then
			ckey = key
			-- call onenter if it exists
			if onenter then
				onenter(self, text)
			end
			-- newline calculations for multiline mode
			if multiline then
				if alltextselected then
					self.alltextselected = false
					self:clear()
					indicatornum = self.indicatornum
					line = self.line
				end
				local newtext = ""
				if indicatornum == 0 then
					newtext = self.lines[line]
					self.lines[line] = ""
				elseif indicatornum > 0 and indicatornum < loveframes.utf8.len(self.lines[line]) then
					newtext = loveframes.utf8.sub(self.lines[line], indicatornum + 1, loveframes.utf8.len(self.lines[line]))
					self.lines[line] = loveframes.utf8.sub(self.lines[line], 1, indicatornum)
				end
				if line ~= #lines then
					table.insert(self.lines, line + 1, newtext)
					self.line = line + 1
				else
					table.insert(self.lines, newtext)
					self.line = line + 1
				end
				self.indicatornum = 0
				local hbody = self:getHorizontalScrollBody()
				if hbody then
					hbody:getScrollBar():scroll(-hbody:getWidth())
				end
			end
		elseif key == "tab" then
			if alltextselected then
				return
			end
			ckey = key
			self.lines[self.line] = self:addIntoText(self.tabreplacement, self.indicatornum)
			self:moveIndicator(loveframes.utf8.len(self.tabreplacement))
		end
	else
		if not editable then
			return
		end
		-- do not continue if the text limit has been reached or exceeded
		if loveframes.utf8.len(text) >= self.limit and self.limit ~= 0 and not alltextselected then
			return
		end
		-- check for unusable characters
		if #self.usable > 0 then
			local found = false
			for k, v in ipairs(self.usable) do
				if v == key then
					found = true
				end
			end
			if not found then
				return
			end
		end
		-- check for usable characters
		if #self.unusable > 0 then
			local found = false
			for k, v in ipairs(self.unusable) do
				if v == key then
					found = true
				end
			end
			if found then
				return
			end
		end
		if alltextselected then
			self.alltextselected = false
			self:clear()
			indicatornum = self.indicatornum
			text = ""
			lines = self.lines
			line = self.line
		end
		if indicatornum ~= 0 and indicatornum ~= loveframes.utf8.len(text) then
			text = self:addIntoText(key, indicatornum)
			lines[line] = text
			self:moveIndicator(1)
		elseif indicatornum == loveframes.utf8.len(text) then
			text = text .. key
			lines[line] = text
			self:moveIndicator(1)
		elseif indicatornum == 0 then
			text = self:addIntoText(key, indicatornum)
			lines[line] = text
			self:moveIndicator(1)
		end
		lines = self.lines
		line = self.line
		curline = lines[line]
		text = curline
		if not multiline then
			local masked = self.masked
			local twidth = 0
			local cwidth = 0
			if masked then
				local maskchar = self.maskchar
				twidth = font:getWidth(loveframes.utf8.gsub(text, ".", maskchar))
				cwidth = font:getWidth(loveframes.utf8.gsub(key, ".", maskchar))
			else
				twidth = font:getWidth(text)
				cwidth = font:getWidth(key)
			end
			-- swidth - 1 is for the "-" character
			if (twidth + textoffsetx) >= (swidth - 1) then
				self.offsetx = self.offsetx + cwidth
			end
		end
	end

	local curtext = self:getText()
	if ontextchanged and initialtext ~= curtext then
		ontextchanged(self, key)
	end

	return self

end

--[[---------------------------------------------------------
	- func: moveIndicator(num, exact)
	- desc: moves the object's indicator
--]]---------------------------------------------------------
function newobject:moveIndicator(num, exact)

	local lines = self.lines
	local line = self.line
	local curline = lines[line]
	local text = curline
	local indicatornum = self.indicatornum

	if not exact then
		self.indicatornum = indicatornum + num
	else
		self.indicatornum = num
	end

	if self.indicatornum > loveframes.utf8.len(text) then
		self.indicatornum = loveframes.utf8.len(text)
	elseif self.indicatornum < 0 then
		self.indicatornum = 0
	end

	self.showindicator = true
	self:updateIndicator()

	return self

end

--[[---------------------------------------------------------
	- func: updateIndicator()
	- desc: updates the object's text insertion position
			indicator
--]]---------------------------------------------------------
function newobject:updateIndicator()

	local time = love.timer.getTime()
	local indincatortime = self.indincatortime
	local indicatornum = self.indicatornum
	local lines = self.lines
	local line = self.line
	local curline = lines[line]
	local text = curline
	local font = self.font
	local theight = font:getHeight()
	local offsetx = self.offsetx
	local multiline = self.multiline
	local showindicator = self.showindicator
	local alltextselected = self.alltextselected
	local textx = self.textx
	local texty = self.texty
	local masked = self.masked

	if indincatortime < time then
		if showindicator then
			self.showindicator = false
		else
			self.showindicator = true
		end
		self.indincatortime = time + 0.50
	end

	if alltextselected then
		self.showindicator = false
	else
		if love.keyboard.isDown("up", "down", "left", "right") then
			self.showindicator = true
		end
	end

	local width = 0
	if masked then
		width = font:getWidth(string.rep(self.maskchar,indicatornum))
	else
		if indicatornum == 0 then
			width = 0
		elseif indicatornum >= loveframes.utf8.len(text) then
			width = font:getWidth(text)
		else
			width = font:getWidth(loveframes.utf8.sub(text, 1, indicatornum))
		end
	end

	if multiline then
		self.indicatorx = textx + width
		self.indicatory	= texty + theight * line - theight
	else
		self.indicatorx = textx + width
		self.indicatory	= texty
	end

	-- indicator should be visible, so correcting scrolls
	if self.focus and self.trackindicator then
		local indicatorRelativeX = width + self.textoffsetx - self.offsetx
		local leftlimit, rightlimit = 1, self:getWidth() - 1
		if self.linenumberspanel then
			rightlimit = rightlimit - self:getLineNumbersPanel().width
		end
		if self.vbar then
			rightlimit = rightlimit - self:getVerticalScrollBody().width
		end
		if not (indicatorRelativeX > leftlimit and indicatorRelativeX < rightlimit) then
			local hbody = self:getHorizontalScrollBody()
			if hbody then
				local twidth = 0
				for k, v in ipairs(lines) do
					local linewidth = 0
					if self.masked then
						linewidth = font:getWidth(loveframes.utf8.gsub(v, ".", self.maskchar))
					else
						linewidth = font:getWidth(v)
					end
					if linewidth > twidth then
						twidth = linewidth
					end
				end
				local correction = self:getWidth() / 8
				if indicatorRelativeX < leftlimit then
					correction = correction * -1
				end
				hbody:getScrollBar():scrollTo((width + correction) / twidth)
			end
		end
		local indicatorRelativeY = (line - 1) * theight + self.textoffsety - self.offsety
		local uplimit, downlimit = theight, self:getHeight() - theight
		if self.hbar then
			downlimit = downlimit - self:getHorizontalScrollBody().height
		end
		if not (indicatorRelativeY > uplimit and indicatorRelativeY < downlimit) then
			local vbody = self:getVerticalScrollBody()
			if vbody then
				local correction = self:getHeight() / 8 / theight
				if indicatorRelativeY < uplimit then
					correction = correction * -1
				end
				vbody:getScrollBar():scrollTo((line - 1 + correction)/#lines)
			end
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: addIntoText(t, p)
	- desc: adds text into the object's text at a given
			position
--]]---------------------------------------------------------
function newobject:addIntoText(t, p)

	local lines = self.lines
	local line = self.line
	local curline = lines[line]
	local text = curline
	local part1 = loveframes.utf8.sub(text, 1, p)
	local part2 = loveframes.utf8.sub(text, p + 1)
	local new = part1 .. t .. part2

	return new

end

--[[---------------------------------------------------------
	- func: removeFromText(p)
	- desc: removes text from the object's text a given
			position
--]]---------------------------------------------------------
function newobject:removeFromText(p)

	local lines = self.lines
	local line = self.line
	local curline = lines[line]
	local text = curline
	local part1 = loveframes.utf8.sub(text, 1, p - 1)
	local part2 = loveframes.utf8.sub(text, p + 1)
	local new = part1 .. part2
	return new

end

--[[---------------------------------------------------------
	- func: getTextCollisions(x, y)
	- desc: gets text collisions with the mouse
--]]---------------------------------------------------------
function newobject:getTextCollisions(x, y)

	local font = self.font
	local lines = self.lines
	local numlines = #lines
	local line = self.line
	local curline = lines[line]
	local text = curline
	local xpos = 0
	local line = 0
	local vbar = self.vbar
	local hbar = self.hbar
	local multiline = self.multiline
	local selfx = self.x
	local selfy = self.y
	local selfwidth = self.width
	local masked = self.masked

	if multiline then
		local theight = font:getHeight()
		local liney = 0
		local selfcol
		if vbar and not hbar then
			selfcol = loveframes.boundingBox(selfx, x, selfy, y, selfwidth - 16, 1, self.height, 1)
		elseif hbar and not vbar then
			selfcol = loveframes.boundingBox(selfx, x, selfy, y, selfwidth, 1, self.height - 16, 1)
		elseif not vbar and not hbar then
			selfcol = loveframes.boundingBox(selfx, x, selfy, y, selfwidth, 1, self.height, 1)
		elseif vbar and hbar then
			selfcol = loveframes.boundingBox(selfx, x, selfy, y, selfwidth - 16, 1, self.height - 16, 1)
		end
		if selfcol then
			local offsety = self.offsety
			local textoffsety = self.textoffsety
			for i=1, numlines do
				local linecol = loveframes.boundingBox(selfx, x, (selfy - offsety) + textoffsety + (theight * i) - theight, y, self.width, 1, theight, 1)
				if linecol then
					liney = (selfy - offsety) + textoffsety + (theight * i) - theight
					self.line = i
				end
			end
			local line = self.line
			local curline = lines[line]
			for i=1, loveframes.utf8.len(curline) do
				local char = loveframes.utf8.sub(text, i, i)
				local width = 0
				if masked then
					local maskchar = self.maskchar
					width = font:getWidth(maskchar)
				else
					width = font:getWidth(char)
				end
				local height = font:getHeight()
				local tx = self.textx + xpos
				local ty = self.texty
				local col = loveframes.boundingBox(tx, x, liney, y, width, 1, height, 1)

				xpos = xpos + width

				if col then
					self:moveIndicator(i - 1, true)
					break
				else
					self.indicatornum = loveframes.utf8.len(curline)
				end

				if x < tx then
					self:moveIndicator(0, true)
				end

				if x > (tx + width) then
					self:moveIndicator(loveframes.utf8.len(curline), true)
				end
			end

			if loveframes.utf8.len(curline) == 0 then
				self.indicatornum = 0
			end
		end
	else
		local i = 0
		for p, c in loveframes.utf8.codes(text) do
			i = i + 1
			local char = loveframes.utf8.char(c)
			local width = 0
			if masked then
				local maskchar = self.maskchar
				width = font:getWidth(maskchar)
			else
				width = font:getWidth(char)
			end
			local height = font:getHeight()
			local tx = self.textx + xpos
			local ty = self.texty
			local col = loveframes.boundingBox(tx, x, ty, y, width, 1, height, 1)
			xpos = xpos + width
			if col then
				self:moveIndicator(i - 1, true)
				break
			end
			if x < tx then
				self:moveIndicator(0, true)
			end
			if x > (tx + width) then
				self:moveIndicator(loveframes.utf8.len(text), true)
			end
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: positionText()
	- desc: positions the object's text
--]]---------------------------------------------------------
function newobject:positionText()

	local multiline = self.multiline
	local x = self.x
	local y = self.y
	local offsetx = self.offsetx
	local offsety = self.offsety
	local textoffsetx = self.textoffsetx
	local textoffsety = self.textoffsety
	local linenumberspanel = self.linenumberspanel

	if multiline then
		if linenumberspanel then
			local panel = self:getLineNumbersPanel()
			self.textx = ((x + panel.width) - offsetx) + textoffsetx
			self.texty = (y - offsety) + textoffsety
		else
			self.textx = (x - offsetx) + textoffsetx
			self.texty = (y - offsety) + textoffsety
		end
	else
		self.textx = (x - offsetx) + textoffsetx
		self.texty = (y - offsety) + textoffsety
	end

	return self

end

--[[---------------------------------------------------------
	- func: setTextOffsetX(num)
	- desc: sets the object's text x offset
--]]---------------------------------------------------------
function newobject:setTextOffsetX(num)

	self.textoffsetx = num
	return self

end

--[[---------------------------------------------------------
	- func: setTextOffsetY(num)
	- desc: sets the object's text y offset
--]]---------------------------------------------------------
function newobject:setTextOffsetY(num)

	self.textoffsety = num
	return self

end

--[[---------------------------------------------------------
	- func: setFont(font)
	- desc: sets the object's font
--]]---------------------------------------------------------
function newobject:setFont(font)

	self.font = font
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
	- func: setFocus(focus)
	- desc: sets the object's focus
--]]---------------------------------------------------------
function newobject:setFocus(focus)

	local inputobject = loveframes.inputobject
	local onfocusgained = self.onFocusGained
	local onfocuslost = self.onFocusLost

	self.focus = focus

	if focus then
		loveframes.inputobject = self
		if onfocusgained then
			onfocusgained(self)
		end
	else
		if inputobject == self then
			loveframes.inputobject = false
		end
		if onfocuslost then
			onfocuslost(self)
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: getFocus()
	- desc: gets the object's focus
--]]---------------------------------------------------------
function newobject:getFocus()

	return self.focus

end

--[[---------------------------------------------------------
	- func: getIndicatorVisibility()
	- desc: gets the object's indicator visibility
--]]---------------------------------------------------------
function newobject:getIndicatorVisibility()

	return self.showindicator

end

--[[---------------------------------------------------------
	- func: setLimit(limit)
	- desc: sets the object's text limit
--]]---------------------------------------------------------
function newobject:setLimit(limit)

	self.limit = limit
	return self

end

--[[---------------------------------------------------------
	- func: setUsable(usable)
	- desc: sets what characters can be used for the
			object's text
--]]---------------------------------------------------------
function newobject:setUsable(usable)

	self.usable = usable
	return self

end

--[[---------------------------------------------------------
	- func: getUsable()
	- desc: gets what characters can be used for the
			object's text
--]]---------------------------------------------------------
function newobject:getUsable()

	return self.usable

end

--[[---------------------------------------------------------
	- func: setUnusable(unusable)
	- desc: sets what characters can not be used for the
			object's text
--]]---------------------------------------------------------
function newobject:setUnusable(unusable)

	self.unusable = unusable
	return self

end

--[[---------------------------------------------------------
	- func: getUnusable()
	- desc: gets what characters can not be used for the
			object's text
--]]---------------------------------------------------------
function newobject:getUnusable()

	return self.unusable

end

--[[---------------------------------------------------------
	- func: clear()
	- desc: clears the object's text
--]]---------------------------------------------------------
function newobject:clear()

	self.lines = {""}
	self.line = 1
	self.offsetx = 0
	self.offsety = 0
	self.indicatornum = 0

	return self

end

--[[---------------------------------------------------------
	- func: setText(text)
	- desc: sets the object's text
--]]---------------------------------------------------------
function newobject:setText(text)

	local tabreplacement = self.tabreplacement
	local multiline = self.multiline

	text = tostring(text)
	text = loveframes.utf8.gsub(text, string.char(9), tabreplacement)
	text = loveframes.utf8.gsub(text, string.char(13), "")

	if multiline then
		text = loveframes.utf8.gsub(text, string.char(92) .. string.char(110), string.char(10))
		local t = loveframes.splitString(text, string.char(10))
		if #t > 0 then
			self.lines = t
		else
			self.lines = {""}
		end
		self.line = #self.lines
		self.indicatornum = loveframes.utf8.len(self.lines[#self.lines])
	else
		text = loveframes.utf8.gsub(text, string.char(92) .. string.char(110), "")
		text = loveframes.utf8.gsub(text, string.char(10), "")
		self.lines = {text}
		self.line = 1
		self.indicatornum = loveframes.utf8.len(text)
	end

	return self

end

--[[---------------------------------------------------------
	- func: getText()
	- desc: gets the object's text
--]]---------------------------------------------------------
function newobject:getText()

	local multiline = self.multiline
	local lines = self.lines
	local text = ""

	if multiline then
		for k, v in ipairs(lines) do
			text = text .. v
			if k ~= #lines then
				text = text .. "\n"
			end
		end
	else
		text = lines[1]
	end

	return text

end

--[[---------------------------------------------------------
	- func: setMultiline(bool)
	- desc: enables or disables allowing multiple lines for
			text entry
--]]---------------------------------------------------------
function newobject:setMultiline(bool)

	local text = ""
	local lines = self.lines

	self.multiline = bool

	if bool then
		self:clear()
	else
		for k, v in ipairs(lines) do
			text = text .. v
		end
		self:setText(text)
		self.internals = {}
		self.vbar = false
		self.hbar = false
		self.linenumberspanel = false
	end

	return self

end

--[[---------------------------------------------------------
	- func: getMultiLine()
	- desc: gets whether or not the object is using multiple
			lines
--]]---------------------------------------------------------
function newobject:getMultiLine()

	return self.multiline

end

--[[---------------------------------------------------------
	- func: getVerticalScrollBody()
	- desc: gets the object's vertical scroll body
--]]---------------------------------------------------------
function newobject:getVerticalScrollBody()

	local vbar = self.vbar
	local internals = self.internals
	local item = false

	if vbar then
		for k, v in ipairs(internals) do
			if v.type == "scrollbody" and v.bartype == "vertical" then
				item = v
			end
		end
	end

	return item

end

--[[---------------------------------------------------------
	- func: getHorizontalScrollBody()
	- desc: gets the object's horizontal scroll body
--]]---------------------------------------------------------
function newobject:getHorizontalScrollBody()

	local hbar = self.hbar
	local internals = self.internals
	local item = false

	if hbar then
		for k, v in ipairs(internals) do
			if v.type == "scrollbody" and v.bartype == "horizontal" then
				item = v
			end
		end
	end

	return item

end

--[[---------------------------------------------------------
	- func: hasVerticalScrollBar()
	- desc: gets whether or not the object has a vertical
			scroll bar
--]]---------------------------------------------------------
function newobject:hasVerticalScrollBar()

	return self.vbar

end

--[[---------------------------------------------------------
	- func: hasHorizontalScrollBar()
	- desc: gets whether or not the object has a horizontal
			scroll bar
--]]---------------------------------------------------------
function newobject:hasHorizontalScrollBar()

	return self.hbar

end

--[[---------------------------------------------------------
	- func: getLineNumbersPanel()
	- desc: gets the object's line numbers panel
--]]---------------------------------------------------------
function newobject:getLineNumbersPanel()

	local panel = self.linenumberspanel
	local internals = self.internals
	local item = false

	if panel then
		for k, v in ipairs(internals) do
			if v.type == "linenumberspanel" then
				item = v
			end
		end
	end

	return item

end

--[[---------------------------------------------------------
	- func: showLineNumbers(bool)
	- desc: sets whether or not to show line numbers when
			using multiple lines
--]]---------------------------------------------------------
function newobject:showLineNumbers(bool)

	local multiline = self.multiline

	if multiline then
		self.linenumbers = bool
	end

	return self

end

--[[---------------------------------------------------------
	- func: getTextX()
	- desc: gets the object's text x
--]]---------------------------------------------------------
function newobject:getTextX()

	return self.textx

end

--[[---------------------------------------------------------
	- func: getTextY()
	- desc: gets the object's text y
--]]---------------------------------------------------------
function newobject:getTextY()

	return self.texty

end

--[[---------------------------------------------------------
	- func: isAllTextSelected()
	- desc: gets whether or not all of the object's text is
			selected
--]]---------------------------------------------------------
function newobject:isAllTextSelected()

	return self.alltextselected

end

--[[---------------------------------------------------------
	- func: getLines()
	- desc: gets the object's lines
--]]---------------------------------------------------------
function newobject:getLines()

	return self.lines

end

--[[---------------------------------------------------------
	- func: getOffsetX()
	- desc: gets the object's x offset
--]]---------------------------------------------------------
function newobject:getOffsetX()

	return self.offsetx

end

--[[---------------------------------------------------------
	- func: getOffsetY()
	- desc: gets the object's y offset
--]]---------------------------------------------------------
function newobject:getOffsetY()

	return self.offsety

end

--[[---------------------------------------------------------
	- func: getIndicatorX()
	- desc: gets the object's indicator's xpos
--]]---------------------------------------------------------
function newobject:getIndicatorX()

	return self.indicatorx

end

--[[---------------------------------------------------------
	- func: getIndicatorY()
	- desc: gets the object's indicator's ypos
--]]---------------------------------------------------------
function newobject:getIndicatorY()

	return self.indicatory

end

--[[---------------------------------------------------------
	- func: getLineNumbersEnabled()
	- desc: gets whether line numbers are enabled on the
			object or not
--]]---------------------------------------------------------
function newobject:getLineNumbersEnabled()

	return self.linenumbers

end

--[[---------------------------------------------------------
	- func: getItemWidth()
	- desc: gets the object's item width
--]]---------------------------------------------------------
function newobject:getItemWidth()

	return self.itemwidth

end

--[[---------------------------------------------------------
	- func: getItemHeight()
	- desc: gets the object's item height
--]]---------------------------------------------------------
function newobject:getItemHeight()

	return self.itemheight

end

--[[---------------------------------------------------------
	- func: setTabReplacement(tabreplacement)
	- desc: sets a string to replace tabs with
--]]---------------------------------------------------------
function newobject:setTabReplacement(tabreplacement)

	self.tabreplacement = tabreplacement
	return self

end

--[[---------------------------------------------------------
	- func: getTabReplacement()
	- desc: gets the object's tab replacement
--]]---------------------------------------------------------
function newobject:getTabReplacement()

	return self.tabreplacement

end

--[[---------------------------------------------------------
	- func: setEditable(bool)
	- desc: sets whether or not the user can edit the
			object's text
--]]---------------------------------------------------------
function newobject:setEditable(bool)

	self.editable = bool
	return self

end

--[[---------------------------------------------------------
	- func: getEditable
	- desc: gets whether or not the user can edit the
			object's text
--]]---------------------------------------------------------
function newobject:getEditable()

	return self.editable

end

--[[---------------------------------------------------------
	- func: setButtonScrollAmount(speed)
	- desc: sets the scroll amount of the object's scrollbar
			buttons
--]]---------------------------------------------------------
function newobject:setButtonScrollAmount(amount)

	self.buttonscrollamount = amount
	return self

end

--[[---------------------------------------------------------
	- func: getButtonScrollAmount()
	- desc: gets the scroll amount of the object's scrollbar
			buttons
--]]---------------------------------------------------------
function newobject:getButtonScrollAmount()

	return self.buttonscrollamount

end

--[[---------------------------------------------------------
	- func: setMouseWheelScrollAmount(amount)
	- desc: sets the scroll amount of the mouse wheel
--]]---------------------------------------------------------
function newobject:setMouseWheelScrollAmount(amount)

	self.mousewheelscrollamount = amount
	return self

end

--[[---------------------------------------------------------
	- func: getMouseWheelScrollAmount()
	- desc: gets the scroll amount of the mouse wheel
--]]---------------------------------------------------------
function newobject:getButtonScrollAmount()

	return self.mousewheelscrollamount

end

--[[---------------------------------------------------------
	- func: setAutoScroll(bool)
	- desc: sets whether or not the object should autoscroll
			when in multiline mode
--]]---------------------------------------------------------
function newobject:setAutoScroll(bool)

	local internals = self.internals

	self.autoscroll = bool

	if internals[2] then
		internals[2].internals[1].internals[1].autoscroll = bool
	end

	return self

end

--[[---------------------------------------------------------
	- func: getAutoScroll()
	- desc: gets whether or not the object should autoscroll
			when in multiline mode
--]]---------------------------------------------------------
function newobject:getAutoScroll()

	return self.autoscroll

end

--[[---------------------------------------------------------
	- func: setRepeatDelay(delay)
	- desc: sets the object's repeat delay
--]]---------------------------------------------------------
function newobject:setRepeatDelay(delay)

	self.repeatdelay = delay
	return self

end

--[[---------------------------------------------------------
	- func: getRepeatDelay()
	- desc: gets the object's repeat delay
--]]---------------------------------------------------------
function newobject:getRepeatDelay()

	return self.repeatdelay

end

--[[---------------------------------------------------------
	- func: setRepeatRate(rate)
	- desc: sets the object's repeat rate
--]]---------------------------------------------------------
function newobject:setRepeatRate(rate)

	self.repeatrate = rate
	return self

end

--[[---------------------------------------------------------
	- func: getRepeatRate()
	- desc: gets the object's repeat rate
--]]---------------------------------------------------------
function newobject:getRepeatRate()

	return self.repeatrate

end

--[[---------------------------------------------------------
	- func: setValue(value)
	- desc: sets the object's value (alias of setText)
--]]---------------------------------------------------------
function newobject:setValue(value)

	self:setText(value)
	return self

end

--[[---------------------------------------------------------
	- func: getValue()
	- desc: gets the object's value (alias of getText)
--]]---------------------------------------------------------
function newobject:getValue()

	return self:getText()

end

--[[---------------------------------------------------------
	- func: setVisible(bool)
	- desc: sets the object's visibility
--]]---------------------------------------------------------
function newobject:setVisible(bool)

	self.visible = bool

	if not bool then
		self.keydown = "none"
	end

	return self

end

--[[---------------------------------------------------------
	- func: copy()
	- desc: copies the object's text to the user's clipboard
--]]---------------------------------------------------------
function newobject:copy()

	local text = self:getText()
	love.system.setClipboardText(text)

	return self

end

--[[---------------------------------------------------------
	- func: paste()
	- desc: pastes the current contents of the clipboard
			into the object's text
--]]---------------------------------------------------------
function newobject:paste()

	local text = love.system.getClipboardText()
	local usable = self.usable
	local unusable = self.unusable
	local limit = self.limit
	local alltextselected = self.alltextselected
	local onpaste = self.onPaste
	local ontextchanged = self.onTextChanged

	if limit > 0 then
		local curtext = self:getText()
		local curlength = loveframes.utf8.len(curtext)
		if curlength == limit then
			return
		else
			local inputlimit = limit - curlength
			if loveframes.utf8.len(text) > inputlimit then
				text = loveframes.utf8.sub(text, 1, inputlimit)
			end
		end
	end
	local charcheck = function(a)
		if #usable > 0 then
			if not loveframes.tableHasValue(usable, a) then
				return ""
			end
		elseif #unusable > 0 then
			if loveframes.tableHasValue(unusable, a) then
				return ""
			end
		end
	end
	if #usable > 0 or #unusable > 0 then
		text = loveframes.utf8.gsub(text, ".", charcheck)
	end
	if alltextselected then
		self:setText(text)
		self.alltextselected = false
		if ontextchanged then
			ontextchanged(self, text)
		end
	else
		local tabreplacement = self.tabreplacement
		local indicatornum = self.indicatornum
		local lines = self.lines
		local multiline = self.multiline
		if multiline then
			local parts = loveframes.splitString(text, string.char(10))
			local numparts = #parts
			local oldlinedata = {}
			local line = self.line
			local first = loveframes.utf8.sub(lines[line], 0, indicatornum)
			local last = loveframes.utf8.sub(lines[line], indicatornum + 1)
			if numparts > 1 then
				for i=1, numparts do
					local part = loveframes.utf8.gsub(parts[i], string.char(13),  "")
					part = loveframes.utf8.gsub(part, string.char(9), "    ")
					if i ~= 1 then
						table.insert(oldlinedata, lines[line])
						lines[line] = part
						if i == numparts then
							self.indicatornum = loveframes.utf8.len(part)
							lines[line] = lines[line] .. last
							self.line = line
						end
					else
						lines[line] = first .. part
					end
					line = line + 1
				end
				for i=1, #oldlinedata do
					lines[line] = oldlinedata[i]
					line = line + 1
				end
				if ontextchanged then
					ontextchanged(self, text)
				end
			elseif numparts == 1 then
				text = loveframes.utf8.gsub(text, string.char(10), " ")
				text = loveframes.utf8.gsub(text, string.char(13), " ")
				text = loveframes.utf8.gsub(text, string.char(9), tabreplacement)
				local length = loveframes.utf8.len(text)
				local new = first .. text .. last
				lines[line] = new
				self.indicatornum = indicatornum + length
				if ontextchanged then
					ontextchanged(self, text)
				end
			end
		else
			text = loveframes.utf8.gsub(text, string.char(10), " ")
			text = loveframes.utf8.gsub(text, string.char(13), " ")
			text = loveframes.utf8.gsub(text, string.char(9), tabreplacement)
			local length = loveframes.utf8.len(text)
			local linetext = lines[1]
			local part1 = loveframes.utf8.sub(linetext, 1, indicatornum)
			local part2 = loveframes.utf8.sub(linetext, indicatornum + 1)
			local new = part1 .. text .. part2
			lines[1] = new
			self.indicatornum = indicatornum + length
			if ontextchanged then
				ontextchanged(self, text)
			end
		end
	end
	if onpaste then
		onpaste(self, text)
	end

	return self

end

--[[---------------------------------------------------------
	- func: selectAll()
	- desc: selects all of the object's text
--]]---------------------------------------------------------
function newobject:selectAll()

	if not self.multiline then
		if self.lines[1] ~= "" then
			self.alltextselected = true
		end
	else
		self.alltextselected = true
	end

	return self

end

--[[---------------------------------------------------------
	- func: deselectAll()
	- desc: deselects all of the object's text
--]]---------------------------------------------------------
function newobject:deselectAll()

	self.alltextselected = false
	return self

end

--[[---------------------------------------------------------
	- func: setMasked(masked)
	- desc: sets whether or not the object is masked
--]]---------------------------------------------------------
function newobject:setMasked(masked)

	self.masked = masked
	return self

end

--[[---------------------------------------------------------
	- func: getMasked()
	- desc: gets whether or not the object is masked
--]]---------------------------------------------------------
function newobject:getMasked()

	return self.masked

end

--[[---------------------------------------------------------
	- func: setMaskChar(char)
	- desc: sets the object's mask character
--]]---------------------------------------------------------
function newobject:setMaskChar(char)

	self.maskchar = char
	return self

end

--[[---------------------------------------------------------
	- func: getMaskChar()
	- desc: gets the object's mask character
--]]---------------------------------------------------------
function newobject:getMaskChar()

	return self.maskchar

end

--[[---------------------------------------------------------
	- func: setPlaceholderText(text)
	- desc: sets the object's placeholder text
--]]---------------------------------------------------------
function newobject:setPlaceholderText(text)

	self.placeholder = text
	return self

end

--[[---------------------------------------------------------
	- func: getPlaceholderText()
	- desc: gets the object's placeholder text
--]]---------------------------------------------------------
function newobject:getPlaceholderText()

	return self.placeholder

end

--[[---------------------------------------------------------
	- func: clearLine(line)
	- desc: clears the specified line
--]]---------------------------------------------------------
function newobject:clearLine(line)

	if self.lines[line] then
		self.lines[line] = ""
	end

	return self

end

--[[---------------------------------------------------------
	- func: setTrackingEnabled(bool)
	- desc: sets whether or not the object should
			automatically scroll to the position of its
			indicator
--]]---------------------------------------------------------
function newobject:setTrackingEnabled(bool)

	self.trackindicator = bool
	return self

end

--[[---------------------------------------------------------
	- func: getTrackingEnabled()
	- desc: gets whether or not the object should
			automatically scroll to the position of its
			indicator
--]]---------------------------------------------------------
function newobject:getTrackingEnabled()

	return self.trackindicator

end

---------- module end ----------
end
