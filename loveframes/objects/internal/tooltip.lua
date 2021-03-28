--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- tooltip class
local newobject = loveframes.newObject("tooltip", "loveframes_object_tooltip", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize(object, text)
	
	self.type = "tooltip"
	self.parent = loveframes.base
	self.object = object or nil
	self.width = 0
	self.height = 0
	self.padding = 5
	self.xoffset = 10
	self.yoffset = -10
	self.internal = true
	self.followcursor = true
	self.followobject = false
	self.alwaysupdate = true
	self.internals = {}
	
	-- create the object's text
	local textobject = loveframes.create("text")
	textobject:remove()
	textobject.parent = self
	textobject:setText(text or "")
	textobject:setPosition(10000, 0) -- textobject interferes with hover detection
	table.insert(self.internals, textobject)
	
	-- apply template properties to the object
	loveframes.applyTemplatesToObject(self)
	table.insert(loveframes.base.internals, self)
	
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
	local internals = self.internals
	local textobject = internals[1]
	
	if not visible then
		textobject:setPosition(10000, 0) -- textobject interferes with hover detection
		if not alwaysupdate then
			return
		end
	end
	
	local padding = self.padding
	local object = self.object
	local draworder = self.draworder
	local update = self.update
	
	self.width = textobject.width + padding * 2
	self.height = textobject.height + padding * 2
	
	if object then
		if object == loveframes.base then
			self:remove()
			return
		end
		--local ovisible = object.visible
		local ohover = object.hover
		local ostate = object.state
		if ostate ~= state then
			self.visible = false
			return
		end
		self.visible = ohover
		if ohover then
			local top = self:isTopInternal()
			local followcursor = self.followcursor
			local followobject = self.followobject
			local xoffset = self.xoffset
			local yoffset = self.yoffset
			if followcursor then
				local height = self.height
				local mx, my = love.mouse.getPosition()
				self.x = mx + xoffset
				self.y = my - height + yoffset
			elseif followobject then
				local ox = object.x
				local oy = object.y
				self.x = ox + xoffset
				self.y = oy + yoffset
			end
			if not top then
				self:moveToTop()
			end
			textobject:setPosition(padding, padding)
		end
	end
	
	--textobject:setVisible(self.show)
	textobject:setState(selfstate)
	textobject:_update(dt)
	
	if update then
		update(self, dt)
	end

end

--[[---------------------------------------------------------
	- func: setFollowCursor(bool)
	- desc: sets whether or not the tooltip should follow the
			cursor
--]]---------------------------------------------------------
function newobject:setFollowCursor(bool)

	self.followcursor = bool
	return self
	
end

--[[---------------------------------------------------------
	- func: getFollowCursor()
	- desc: gets whether or not the tooltip should follow the
			cursor
--]]---------------------------------------------------------
function newobject:getFollowCursor()

	return self.followcursor
	
end

--[[---------------------------------------------------------
	- func: setObject(object)
	- desc: sets the tooltip's object
--]]---------------------------------------------------------
function newobject:setObject(object)

	self.object = object
	self.x = object.x
	self.y = object.y
	
	return self
	
end

--[[---------------------------------------------------------
	- func: getObject()
	- desc: gets the tooltip's object
--]]---------------------------------------------------------
function newobject:getObject()

	return self.object
	
end

--[[---------------------------------------------------------
	- func: setText(text)
	- desc: sets the tooltip's text
--]]---------------------------------------------------------
function newobject:setText(text)

	local internals = self.internals
	local textobject = internals[1]
	
	textobject:setText(text)
	return self
	
end

--[[---------------------------------------------------------
	- func: getText()
	- desc: gets the tooltip's text
--]]---------------------------------------------------------
function newobject:getText()

	local internals = self.internals
	local textobject = internals[1]
	local text = textobject:getText()
	
	return text
	
end

--[[---------------------------------------------------------
	- func: setTextMaxWidth(text)
	- desc: sets the tooltip's text max width
--]]---------------------------------------------------------
function newobject:setTextMaxWidth(width)

	local internals = self.internals
	local textobject = internals[1]
	
	textobject:setMaxWidth(width)
	return self
	
end

--[[---------------------------------------------------------
	- func: setOffsetX(xoffset)
	- desc: sets the tooltip's x offset
--]]---------------------------------------------------------
function newobject:setOffsetX(xoffset)

	self.xoffset = xoffset
	return self
	
end

--[[---------------------------------------------------------
	- func: getOffsetX()
	- desc: gets the tooltip's x offset
--]]---------------------------------------------------------
function newobject:getOffsetX()

	return self.xoffset
	
end

--[[---------------------------------------------------------
	- func: setOffsetY(yoffset)
	- desc: sets the tooltip's y offset
--]]---------------------------------------------------------
function newobject:setOffsetY(yoffset)

	self.yoffset = yoffset
	return self
	
end

--[[---------------------------------------------------------
	- func: getOffsetY()
	- desc: gets the tooltip's y offset
--]]---------------------------------------------------------
function newobject:getOffsetY()

	return self.yoffset
	
end

--[[---------------------------------------------------------
	- func: setOffsets(xoffset, yoffset)
	- desc: sets the tooltip's x and y offset
--]]---------------------------------------------------------
function newobject:setOffsets(xoffset, yoffset)

	self.xoffset = xoffset
	self.yoffset = yoffset
	
	return self
	
end

--[[---------------------------------------------------------
	- func: getOffsets()
	- desc: gets the tooltip's x and y offset
--]]---------------------------------------------------------
function newobject:getOffsets()

	return self.xoffset, self.yoffset
	
end

--[[---------------------------------------------------------
	- func: setPadding(padding)
	- desc: sets the tooltip's padding
--]]---------------------------------------------------------
function newobject:setPadding(padding)

	self.padding = padding
	return self
	
end

--[[---------------------------------------------------------
	- func: getPadding()
	- desc: gets the tooltip's padding
--]]---------------------------------------------------------
function newobject:getPadding()

	return self.padding
	
end

--[[---------------------------------------------------------
	- func: setFont(font)
	- desc: sets the tooltip's font
--]]---------------------------------------------------------
function newobject:setFont(font)

	local internals = self.internals
	local textobject = internals[1]
	
	textobject:setFont(font)
	return self
	
end

--[[---------------------------------------------------------
	- func: getFont()
	- desc: gets the tooltip's font
--]]---------------------------------------------------------
function newobject:getFont()

	local internals = self.internals
	local textobject = internals[1]
	
	return textobject:getFont()
	
end

--[[---------------------------------------------------------
	- func: setFollowObject(bool)
	- desc: sets whether or not the tooltip should follow
			its assigned object
--]]---------------------------------------------------------
function newobject:setFollowObject(bool)

	self.followobject = bool
	return self
	
end

--[[---------------------------------------------------------
	- func: getFollowObject()
	- desc: gets whether or not the tooltip should follow
			its assigned object
--]]---------------------------------------------------------
function newobject:getFollowObject()

	return self.followobject
	
end

---------- module end ----------
end
