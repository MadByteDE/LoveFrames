--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- form object
local newobject = loveframes.newObject("form", "loveframes_object_form", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()

	self.type = "form"
	self.name = "Form"
	self.layout = "vertical"
	self.width = 200
	self.height = 50
	self.padding = 5
	self.spacing = 5
	self.topmargin = 12
	self.internal = false
	self.children = {}

	self:setDrawFunc()
end

--[[---------------------------------------------------------
	- func: update(deltatime)
	- desc: updates the element
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

	local children = self.children
	local parent = self.parent
	local base = loveframes.base
	local update = self.update

	-- move to parent if there is a parent
	if parent ~= base and parent.type ~= "list" then
		self.x = self.parent.x + self.staticx
		self.y = self.parent.y + self.staticy
	end

	self:checkHover()

	for k, v in ipairs(children) do
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

	local children = self.children
	local hover = self.hover

	if hover and button == 1 then
		local baseparent = self:getBaseParent()
		if baseparent and baseparent.type == "frame" then
			baseparent:makeTop()
		end
	end

	for k, v in ipairs(children) do
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

	local visible  = self.visible
	local children = self.children

	if not visible then
		return
	end

	for k, v in ipairs(children) do
		v:mousereleased(x, y, button)
	end

end

--[[---------------------------------------------------------
	- func: addItem(object)
	- desc: adds an item to the object
--]]---------------------------------------------------------
function newobject:addItem(object)

	local objtype = object.type
	if objtype == "frame" then
		return
	end

	local children = self.children
	local state = self.state

	object:remove()
	object.parent = self
	object:setState(state)

	table.insert(children, object)
	self:layoutObjects()

	return self

end

--[[---------------------------------------------------------
	- func: removeItem(object or number)
	- desc: removes an item from the object
--]]---------------------------------------------------------
function newobject:removeItem(data)

	local dtype = type(data)

	if dtype == "number" then
		local children = self.children
		local item = children[data]
		if item then
			item:remove()
		end
	else
		data:remove()
	end

	self:layoutObjects()
	return self

end

--[[---------------------------------------------------------
	- func: layoutObjects()
	- desc: positions the object's children and calculates
			a new size for the object
--]]---------------------------------------------------------
function newobject:layoutObjects()

	local layout = self.layout
	local padding = self.padding
	local spacing = self.spacing
	local topmargin = self.topmargin
	local children = self.children
	local width = padding * 2
	local height = padding * 2 + topmargin
	local x = padding
	local y = padding + topmargin

	if layout == "vertical" then
		local largest_width = 0
		for k, v in ipairs(children) do
			v.staticx = x
			v.staticy = y
			y = y + v.height + spacing
			height = height + v.height + spacing
			if v.width > largest_width then
				largest_width = v.width
			end
		end
		height = height - spacing
		self.width = width + largest_width
		self.height = height
	elseif layout == "horizontal" then
		local largest_height = 0
		for k, v in ipairs(children) do
			v.staticx = x
			v.staticy = y
			x = x + v.width + spacing
			width = width + v.width + spacing
			if v.height > largest_height then
				largest_height = v.height
			end
		end
		width = width - spacing
		self.width = width
		self.height = height + largest_height
	end

	return self

end

--[[---------------------------------------------------------
	- func: setLayoutType(ltype)
	- desc: sets the object's layout type
--]]---------------------------------------------------------
function newobject:setLayoutType(ltype)

	self.layout = ltype
	return self

end

--[[---------------------------------------------------------
	- func: getLayoutType()
	- desc: gets the object's layout type
--]]---------------------------------------------------------
function newobject:getLayoutType()

	return self.layout

end

--[[---------------------------------------------------------
	- func: setTopMargin(margin)
	- desc: sets the margin between the top of the object
			and its children
--]]---------------------------------------------------------
function newobject:setTopMargin(margin)

	self.topmargin = margin
	return self

end

--[[---------------------------------------------------------
	- func: getTopMargin()
	- desc: gets the margin between the top of the object
			and its children
--]]---------------------------------------------------------
function newobject:getTopMargin()

	return self.topmargin

end

--[[---------------------------------------------------------
	- func: setName(name)
	- desc: sets the object's name
--]]---------------------------------------------------------
function newobject:setName(name)

	self.name = name
	return self

end

--[[---------------------------------------------------------
	- func: getName()
	- desc: gets the object's name
--]]---------------------------------------------------------
function newobject:getName()

	return self.name

end

---------- module end ----------
end
