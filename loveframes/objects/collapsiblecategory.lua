--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- collapsiblecategory object
local newobject = loveframes.newObject("collapsiblecategory", "loveframes_object_collapsiblecategory", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()

	self.type = "collapsiblecategory"
	self.text = "Category"
	self.width = 200
	self.height = 25
	self.closedheight = 25
	self.padding = 5
	self.internal = false
	self.open = false
	self.down = false
	self.children = {}
	self.onOpenedClosed = nil

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

	local open = self.open
	local children = self.children
	local curobject = children[1]
	local parent = self.parent
	local base = loveframes.base
	local update = self.update

	self:checkHover()

	-- move to parent if there is a parent
	if parent ~= base and parent.type ~= "list" then
		self.x = self.parent.x + self.staticx
		self.y = self.parent.y + self.staticy
	end

	if open and curobject then
		curobject:setWidth(self.width - self.padding * 2)
		curobject:_update(dt)
	elseif not open and curobject then
		if curobject:getVisible() then
			curobject:setVisible(false)
		end
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
	local open = self.open
	local children = self.children
	local curobject = children[1]

	if hover then
		local col = loveframes.boundingBox(self.x, x, self.y, y, self.width, 1, self.closedheight, 1)
		if button == 1 and col then
			local baseparent = self:getBaseParent()
			if baseparent and baseparent.type == "frame" then
				baseparent:makeTop()
			end
			self.down = true
			loveframes.downobject = self
		end
	end

	if open and curobject then
		curobject:mousepressed(x, y, button)
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
	local clickable = self.clickable
	local enabled = self.enabled
	local open = self.open
	local col = loveframes.boundingBox(self.x, x, self.y, y, self.width, 1, self.closedheight, 1)
	local children = self.children
	local curobject = children[1]

	if hover and col and down and button == 1 then
		if open then
			self:setOpen(false)
		else
			self:setOpen(true)
		end
		self.down = false
	end

	if open and curobject then
		curobject:mousereleased(x, y, button)
	end

end

--[[---------------------------------------------------------
	- func: setText(text)
	- desc: sets the object's text
--]]---------------------------------------------------------
function newobject:setText(text)

	self.text = text
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
	- func: setObject(object)
	- desc: sets the category's object
--]]---------------------------------------------------------
function newobject:setObject(object)

	local children = self.children
	local curobject = children[1]

	if curobject then
		curobject:remove()
		self.children = {}
	end

	object:remove()
	object.parent = self
	object:setState(self.state)
	object:setWidth(self.width - self.padding*2)
	object:setPosition(self.padding, self.closedheight + self.padding)
	table.insert(self.children, object)

	return self

end

--[[---------------------------------------------------------
	- func: setObject(object)
	- desc: sets the category's object
--]]---------------------------------------------------------
function newobject:getObject()

	local children = self.children
	local curobject = children[1]

	if curobject then
		return curobject
	else
		return false
	end

end

--[[---------------------------------------------------------
	- func: setSize(width, height, relative)
	- desc: sets the object's size
--]]---------------------------------------------------------
function newobject:setSize(width, height, relative)

	if relative then
		self.width = self.parent.width * width
	else
		self.width = width
	end

	return self

end

--[[---------------------------------------------------------
	- func: setHeight(height)
	- desc: sets the object's height
--]]---------------------------------------------------------
function newobject:setHeight(height)

	return self

end

--[[---------------------------------------------------------
	- func: setClosedHeight(height)
	- desc: sets the object's closed height
--]]---------------------------------------------------------
function newobject:setClosedHeight(height)

	self.closedheight = height
	return self

end

--[[---------------------------------------------------------
	- func: getClosedHeight()
	- desc: gets the object's closed height
--]]---------------------------------------------------------
function newobject:getClosedHeight()

	return self.closedheight

end

--[[---------------------------------------------------------
	- func: setOpen(bool)
	- desc: sets whether the object is opened or closed
--]]---------------------------------------------------------
function newobject:setOpen(bool)

	local children = self.children
	local curobject = children[1]
	local closedheight = self.closedheight
	local padding = self.padding
	local onopenedclosed = self.onOpenedClosed

	self.open = bool

	if not bool then
		self.height = closedheight
		if curobject then
			local curobjectheight = curobject.height
			curobject:setVisible(false)
		end
	else
		if curobject then
			local curobjectheight = curobject.height
			self.height = closedheight + padding * 2 + curobjectheight
			curobject:setVisible(true)
		end
	end

	-- call the on opened closed callback if it exists
	if onopenedclosed then
		onopenedclosed(self)
	end

	return self

end

--[[---------------------------------------------------------
	- func: getOpen()
	- desc: gets whether the object is opened or closed
--]]---------------------------------------------------------
function newobject:getOpen()

	return self.open

end

---------- module end ----------
end
