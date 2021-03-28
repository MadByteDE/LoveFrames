--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- slider object
local newobject = loveframes.newObject("slider", "loveframes_object_slider", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()

	self.type = "slider"
	self.text = "Slider"
	self.slidetype = "horizontal"
	self.width = 5
	self.height = 5
	self.max = 10
	self.min = 0
	self.value = 0
	self.decimals = 5
	self.scrollincrease = 1
	self.scrolldecrease = 1
	self.scrollable = true
	self.enabled = true
	self.internal = false
	self.internals = {}
	self.onValueChanged	= nil
	self.onRelease = nil

	-- create the slider button
	local sliderbutton = loveframes.objects["sliderbutton"]:new(self)
	sliderbutton.state = self.state
	table.insert(self.internals, sliderbutton)

	-- set initial value to minimum
	self:setValue(self.min)

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

	local internals = self.internals
	local sliderbutton 	= internals[1]
	local parent = self.parent
	local base = loveframes.base
	local update = self.update

	self:checkHover()

	-- move to parent if there is a parent
	if parent ~= base and parent.type ~= "list" then
		self.x = self.parent.x + self.staticx
		self.y = self.parent.y + self.staticy
	end

	if sliderbutton then
		local slidetype = self.slidetype
		local buttonwidth = sliderbutton.width
		local buttonheight = sliderbutton.height
		if slidetype == "horizontal" then
			self.height = buttonheight
		elseif slidetype == "vertical" then
			self.width = buttonwidth
		end
	end

	-- update internals
	for k, v in ipairs(self.internals) do
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

	local enabled = self.enabled

	if not enabled then
		return
	end

	local internals = self.internals
	local hover = self.hover
	local slidetype = self.slidetype
	local scrollable = self.scrollable

	if hover and button == 1 then
		if slidetype == "horizontal" then
			local xpos = x - self.x
			local button = internals[1]
			local baseparent = self:getBaseParent()
			if baseparent and baseparent.type == "frame" then
				baseparent:makeTop()
			end
			button:moveToX(xpos)
			button.down = true
			button.dragging = true
			button.startx = button.staticx
			button.clickx = x
		elseif slidetype == "vertical" then
			local ypos = y - self.y
			local button = internals[1]
			local baseparent = self:getBaseParent()
			if baseparent and baseparent.type == "frame" then
				baseparent:makeTop()
			end
			button:moveToY(ypos)
			button.down = true
			button.dragging = true
			button.starty = button.staticy
			button.clicky = y
		end
	elseif hover and scrollable and button == "wu" then
		local value = self.value
		local increase = self.scrollincrease
		local newvalue = value + increase
		self:setValue(newvalue)
	elseif hover and scrollable and button == "wd" then
		local value = self.value
		local decrease = self.scrolldecrease
		local newvalue = value - decrease
		self:setValue(newvalue)
	end

	for k, v in ipairs(internals) do
		v:mousepressed(x, y, button)
	end

end

--[[---------------------------------------------------------
	- func: setValue(value)
	- desc: sets the object's value
--]]---------------------------------------------------------
function newobject:setValue(value)

	if value > self.max then
		return
	end

	if value < self.min then
		return
	end

	local decimals = self.decimals
	local newval = loveframes.round(value, decimals)
	local internals = self.internals
	local onvaluechanged = self.onValueChanged

	-- set the new value
	self.value = newval

	-- slider button object
	local sliderbutton = internals[1]
	local slidetype = self.slidetype
	local width = self.width
	local height = self.height
	local min = self.min
	local max = self.max

	-- move the slider button to the new position
	if slidetype == "horizontal" then
		local xpos = width * ((newval - min) / (max - min))
		sliderbutton:moveToX(xpos)
	elseif slidetype == "vertical" then
		local ypos = height - height * ((newval - min) / (max - min))
		sliderbutton:moveToY(ypos)
	end

	-- call onValueChanged
	if onvaluechanged then
		onvaluechanged(self, newval)
	end

	return self

end

--[[---------------------------------------------------------
	- func: getValue()
	- desc: gets the object's value
--]]---------------------------------------------------------
function newobject:getValue()

	return self.value

end

--[[---------------------------------------------------------
	- func: setMax(max)
	- desc: sets the object's maximum value
--]]---------------------------------------------------------
function newobject:setMax(max)

	self.max = max

	if self.value > self.max then
		self.value = self.max
	end

	return self

end

--[[---------------------------------------------------------
	- func: getMax()
	- desc: gets the object's maximum value
--]]---------------------------------------------------------
function newobject:getMax()

	return self.max

end

--[[---------------------------------------------------------
	- func: setMin(min)
	- desc: sets the object's minimum value
--]]---------------------------------------------------------
function newobject:setMin(min)

	self.min = min

	if self.value < self.min then
		self.value = self.min
	end

	return self

end

--[[---------------------------------------------------------
	- func: getMin()
	- desc: gets the object's minimum value
--]]---------------------------------------------------------
function newobject:getMin()

	return self.min

end

--[[---------------------------------------------------------
	- func: setMinMax()
	- desc: sets the object's minimum and maximum values
--]]---------------------------------------------------------
function newobject:setMinMax(min, max)

	self.min = min
	self.max = max

	if self.value > self.max then
		self.value = self.max
	end

	if self.value < self.min then
		self.value = self.min
	end

	return self

end

--[[---------------------------------------------------------
	- func: getMinMax()
	- desc: gets the object's minimum and maximum values
--]]---------------------------------------------------------
function newobject:getMinMax()

	return self.min, self.max

end

--[[---------------------------------------------------------
	- func: setText(name)
	- desc: sets the objects's text
--]]---------------------------------------------------------
function newobject:setText(text)

	self.text = text
	return self

end

--[[---------------------------------------------------------
	- func: getText()
	- desc: gets the objects's text
--]]---------------------------------------------------------
function newobject:getText()

	return self.text

end

--[[---------------------------------------------------------
	- func: setDecimals(decimals)
	- desc: sets how many decimals the object's value
			can have
--]]---------------------------------------------------------
function newobject:setDecimals(decimals)

	self.decimals = decimals
	return self

end

--[[---------------------------------------------------------
	- func: getDecimals()
	- desc: gets how many decimals the object's value
			can have
--]]---------------------------------------------------------
function newobject:getDecimals()

	return self.decimals

end

--[[---------------------------------------------------------
	- func: setButtonSize(width, height)
	- desc: sets the objects's button size
--]]---------------------------------------------------------
function newobject:setButtonSize(width, height)

	local internals = self.internals
	local sliderbutton = internals[1]

	if sliderbutton then
		sliderbutton.width = width
		sliderbutton.height = height
	end

	return self

end

--[[---------------------------------------------------------
	- func: getButtonSize()
	- desc: gets the objects's button size
--]]---------------------------------------------------------
function newobject:getButtonSize()

	local internals = self.internals
	local sliderbutton = internals[1]

	if sliderbutton then
		return sliderbutton.width, sliderbutton.height
	end

end

--[[---------------------------------------------------------
	- func: setSlideType(slidetype)
	- desc: sets the objects's slide type
--]]---------------------------------------------------------
function newobject:setSlideType(slidetype)

	self.slidetype = slidetype

	if slidetype == "vertical" then
		self:setValue(self.min)
	end

	return self

end

--[[---------------------------------------------------------
	- func: getSlideType()
	- desc: gets the objects's slide type
--]]---------------------------------------------------------
function newobject:getSlideType()

	return self.slidetype

end

--[[---------------------------------------------------------
	- func: setScrollable(bool)
	- desc: sets whether or not the object can be scrolled
			via the mouse wheel
--]]---------------------------------------------------------
function newobject:setScrollable(bool)

	self.scrollable = bool
	return self

end

--[[---------------------------------------------------------
	- func: getScrollable()
	- desc: gets whether or not the object can be scrolled
			via the mouse wheel
--]]---------------------------------------------------------
function newobject:getScrollable()

	return self.scrollable

end

--[[---------------------------------------------------------
	- func: setScrollIncrease(increase)
	- desc: sets the amount to increase the object's value
			by when scrolling with the mouse wheel
--]]---------------------------------------------------------
function newobject:setScrollIncrease(increase)

	self.scrollincrease = increase
	return self

end

--[[---------------------------------------------------------
	- func: getScrollIncrease()
	- desc: gets the amount to increase the object's value
			by when scrolling with the mouse wheel
--]]---------------------------------------------------------
function newobject:getScrollIncrease()

	return self.scrollincrease

end

--[[---------------------------------------------------------
	- func: setScrollDecrease(decrease)
	- desc: sets the amount to decrease the object's value
			by when scrolling with the mouse wheel
--]]---------------------------------------------------------
function newobject:setScrollDecrease(decrease)

	self.scrolldecrease = decrease
	return self

end

--[[---------------------------------------------------------
	- func: getScrollDecrease()
	- desc: gets the amount to decrease the object's value
			by when scrolling with the mouse wheel
--]]---------------------------------------------------------
function newobject:getScrollDecrease()

	return self.scrolldecrease

end

--[[---------------------------------------------------------
	- func: setEnabled(bool)
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
