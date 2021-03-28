--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- multichoice object
local newobject = loveframes.newObject("multichoice", "loveframes_object_multichoice", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()

	self.type = "multichoice"
	self.choice = ""
	self.text = "Select an option"
	self.width = 200
	self.height = 25
	self.listpadding = 0
	self.listspacing = 0
	self.buttonscrollamount = 200
	self.mousewheelscrollamount = 1500
	self.sortfunc = function(a, b) return a < b end
	self.haslist = false
	self.dtscrolling = true
	self.enabled = true
	self.internal = false
	self.choices = {}
	self.listheight = nil

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
	local haslist = self.haslist
	local enabled = self.enabled

	if hover and not haslist and enabled and button == 1 then
		local baseparent = self:getBaseParent()
		if baseparent and baseparent.type == "frame" then
			baseparent:makeTop()
		end
		self.haslist = true
		self.list = loveframes.objects["multichoicelist"]:new(self)
		self.list:setState(self.state)
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

end

--[[---------------------------------------------------------
	- func: addChoice(choice)
	- desc: adds a choice to the current list of choices
--]]---------------------------------------------------------
function newobject:addChoice(choice)

	local choices = self.choices
	table.insert(choices, choice)

	return self

end

--[[---------------------------------------------------------
	- func: removeChoice(choice)
	- desc: removes the specified choice from the object's
			list of choices
--]]---------------------------------------------------------
function newobject:removeChoice(choice)

	local choices = self.choices

	for k, v in ipairs(choices) do
		if v == choice then
			table.remove(choices, k)
			break
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: setChoice(choice)
	- desc: sets the current choice
--]]---------------------------------------------------------
function newobject:setChoice(choice)

	self.choice = choice
	return self

end

--[[---------------------------------------------------------
	- func: selectChoice(choice)
	- desc: selects a choice
--]]---------------------------------------------------------
function newobject:selectChoice(choice)

	local onChoiceSelected = self.onChoiceSelected

	self.choice = choice

	if self.list then
		self.list:close()
	end

	if onChoiceSelected then
		onChoiceSelected(self, choice)
	end

	return self

end

--[[---------------------------------------------------------
	- func: setListHeight(height)
	- desc: sets the height of the list of choices
--]]---------------------------------------------------------
function newobject:setListHeight(height)

	self.listheight = height
	return self

end

--[[---------------------------------------------------------
	- func: setPadding(padding)
	- desc: sets the padding of the list of choices
--]]---------------------------------------------------------
function newobject:setPadding(padding)

	self.listpadding = padding
	return self

end

--[[---------------------------------------------------------
	- func: setSpacing(spacing)
	- desc: sets the spacing of the list of choices
--]]---------------------------------------------------------
function newobject:setSpacing(spacing)

	self.listspacing = spacing
	return self

end

--[[---------------------------------------------------------
	- func: getValue()
	- desc: gets the value (choice) of the object
--]]---------------------------------------------------------
function newobject:getValue()

	return self.choice

end

--[[---------------------------------------------------------
	- func: getChoice()
	- desc: gets the current choice (same as get value)
--]]---------------------------------------------------------
function newobject:getChoice()

	return self.choice

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
	- func: setDTScrolling(bool)
	- desc: sets whether or not the object should use delta
			time when scrolling
--]]---------------------------------------------------------
function newobject:setDTScrolling(bool)

	self.dtscrolling = bool
	return self

end

--[[---------------------------------------------------------
	- func: getDTScrolling()
	- desc: gets whether or not the object should use delta
			time when scrolling
--]]---------------------------------------------------------
function newobject:getDTScrolling()

	return self.dtscrolling

end

--[[---------------------------------------------------------
	- func: sort(func)
	- desc: sorts the object's choices
--]]---------------------------------------------------------
function newobject:sort(func)

	local default = self.sortfunc

	if func then
		table.sort(self.choices, func)
	else
		table.sort(self.choices, default)
	end

	return self

end

--[[---------------------------------------------------------
	- func: setSortFunction(func)
	- desc: sets the object's default sort function
--]]---------------------------------------------------------
function newobject:setSortFunction(func)

	self.sortfunc = func
	return self

end

--[[---------------------------------------------------------
	- func: getSortFunction(func)
	- desc: gets the object's default sort function
--]]---------------------------------------------------------
function newobject:getSortFunction()

	return self.sortfunc

end

--[[---------------------------------------------------------
	- func: clear()
	- desc: removes all choices from the object's list
			of choices
--]]---------------------------------------------------------
function newobject:clear()

	self.choices = {}
	self.choice = ""
	self.text = "Select an option"

	return self

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
