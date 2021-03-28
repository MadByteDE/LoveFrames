--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- checkbox object
local newobject = loveframes.newObject("checkbox", "loveframes_object_checkbox", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()
	self.type = "checkbox"
	self.width = 0
	self.height = 0
	self.boxwidth = 16
	self.boxheight = 16
	self.font = loveframes.basicfont
	self.checked = false
	self.lastvalue = false
	self.internal = false
	self.down = true
	self.enabled = true
	self.internals = {}
	self.onChanged = nil
	self.groupIndex = 0

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

	self:checkHover()

	local hover = self.hover
	local internals = self.internals
	local boxwidth = self.boxwidth
	local boxheight = self.boxheight
	local parent = self.parent
	local base = loveframes.base
	local update = self.update

	if not hover then
		self.down = false
	else
		if loveframes.downobject == self then
			self.down = true
		end
	end

	if not self.down and loveframes.downobject == self then
		self.hover = true
	end

	-- move to parent if there is a parent
	if parent ~= base and parent.type ~= "list" then
		self.x = self.parent.x + self.staticx
		self.y = self.parent.y + self.staticy
	end

	if internals[1] then
		self.width = boxwidth + 5 + internals[1].width
		if internals[1].height == boxheight then
			self.height = boxheight
		else
			if internals[1].height > boxheight then
				self.height = internals[1].height
			else
				self.height = boxheight
			end
		end
	else
		self.width = boxwidth
		self.height = boxheight
	end

	for k, v in ipairs(internals) do
		v:_update(dt)
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
		self.down = true
		loveframes.downobject = self
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

	local hover = self.hover
	local down = self.down
	local enabled = self.enabled
	local checked = self.checked
	local onchanged = self.onChanged

	if hover and down and enabled and button == 1 then
		if checked then
			if self.groupIndex == 0 then self.checked = false end
		else
			if self.groupIndex ~= 0 then
				local baseparent = self.parent
				if baseparent then
					for k, v in ipairs(baseparent.children) do
						if v.groupIndex then
							if v.groupIndex == self.groupIndex then
								v.checked = false
							end
						end
					end
				end
			end
			self.checked = true
		end
		if onchanged then
			onchanged(self, self.checked)
		end
	end

end

--[[---------------------------------------------------------
	- func: setText(text)
	- desc: sets the object's text
--]]---------------------------------------------------------
function newobject:setText(text)

	local boxwidth = self.boxwidth
	local boxheight = self.boxheight

	if text ~= "" then
		self.internals = {}
		local textobject = loveframes.create("text")
		local skin = loveframes.getActiveSkin()
		if not skin then
			skin = loveframes.config["DEFAULTSKIN"]
		end
		local directives = skin.directives
		if directives then
			local default_color = directives.checkbox_text_default_color
			local default_shadowcolor = directives.checkbox_text_default_shadowcolor
			local default_font = directives.checkbox_text_default_font
			if default_color then
				textobject.defaultcolor = default_color
			end
			if default_shadowcolor then
				textobject.shadowcolor = default_shadowcolor
			end
			if default_font then
				self.font = default_font
			end
		end
		textobject:remove()
		textobject.parent = self
		textobject.state = self.state
		textobject.collide = false
		textobject:setFont(self.font)
		textobject:setText(text)
		textobject.update = function(object, dt)
			if object.height > boxheight then
				object:setPosition(boxwidth + 5, 0)
			else
				object:setPosition(boxwidth + 5, boxheight/2 - object.height/2)
			end
		end
		table.insert(self.internals, textobject)
	else
		self.width = boxwidth
		self.height = boxheight
		self.internals = {}
	end

	return self

end

--[[---------------------------------------------------------
	- func: getText()
	- desc: gets the object's text
--]]---------------------------------------------------------
function newobject:getText()

	local internals = self.internals
	local text = internals[1]

	if text then
		return text.text
	else
		return false
	end

end

--[[---------------------------------------------------------
	- func: setSize(width, height, r1, r2)
	- desc: sets the object's size
--]]---------------------------------------------------------
function newobject:setSize(width, height, r1, r2)

	if r1 then
		self.boxwidth = self.parent.width * width
	else
		self.boxwidth = width
	end

	if r2 then
		self.boxheight = self.parent.height * height
	else
		self.boxheight = height
	end

	return self

end

--[[---------------------------------------------------------
	- func: setWidth(width, relative)
	- desc: sets the object's width
--]]---------------------------------------------------------
function newobject:setWidth(width, relative)

	if relative then
		self.boxwidth = self.parent.width * width
	else
		self.boxwidth = width
	end

	return self

end

--[[---------------------------------------------------------
	- func: setHeight(height, relative)
	- desc: sets the object's height
--]]---------------------------------------------------------
function newobject:setHeight(height, relative)

	if relative then
		self.boxheight = self.parent.height * height
	else
		self.boxheight = height
	end

	return self

end

--[[---------------------------------------------------------
	- func: setChecked(bool)
	- desc: sets whether the object is checked or not
--]]---------------------------------------------------------
function newobject:setChecked(bool)

	local onchanged = self.onChanged

	self.checked = bool

	if onchanged then
		onchanged(self)
	end

	return self

end

--[[---------------------------------------------------------
	- func: getChecked()
	- desc: gets whether the object is checked or not
--]]---------------------------------------------------------
function newobject:getChecked()

	return self.checked

end

--[[---------------------------------------------------------
	- func: setFont(font)
	- desc: sets the font of the object's text
--]]---------------------------------------------------------
function newobject:setFont(font)

	local internals = self.internals
	local text = internals[1]

	self.font = font

	if text then
		text:setFont(font)
	end

	return self

end

--[[---------------------------------------------------------
	- func: newobject:getFont()
	- desc: gets the font of the object's text
--]]---------------------------------------------------------
function newobject:getFont()

	return self.font

end

--[[---------------------------------------------------------
	- func: newobject:getBoxHeight()
	- desc: gets the object's box size
--]]---------------------------------------------------------
function newobject:getBoxSize()

	return self.boxwidth, self.boxheight

end

--[[---------------------------------------------------------
	- func: newobject:getBoxWidth()
	- desc: gets the object's box width
--]]---------------------------------------------------------
function newobject:getBoxWidth()

	return self.boxwidth

end

--[[---------------------------------------------------------
	- func: newobject:getBoxHeight()
	- desc: gets the object's box height
--]]---------------------------------------------------------
function newobject:getBoxHeight()

	return self.boxheight

end

--[[---------------------------------------------------------
	- func: setClickable(bool)
	- desc: sets whether or not the object is enabled
--]]---------------------------------------------------------
function newobject:setEnabled(bool)

	self.enabled = bool
	return self

end

--[[---------------------------------------------------------
	- func: getEnabled()
	- desc: gets whether or not the object is enabled
--]]---------------------------------------------------------
function newobject:getEnabled()

	return self.enabled

end

---------- module end ----------
end
