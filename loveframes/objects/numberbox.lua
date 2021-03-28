--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- numberbox object
local newobject = loveframes.newObject("numberbox", "loveframes_object_numberbox", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()

	self.type = "numberbox"
	self.width = 80
	self.height = 20
	self.value = 0
	self.increaseamount = 1
	self.decreaseamount = 1
	self.min = -100
	self.max = 100
	self.delay = 0
	self.decimals = 0
	self.internal = false
	self.canmodify = false
	self.lastbuttonclicked = false
	self.internals = {}
	self.onValueChanged = nil

	local input = loveframes.objects["textinput"]:new()
	input.parent = self
	input:setSize(50, 20)
	input:setUsable({"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".", "-"})
	input:setTabReplacement("")
	input:setText(self.value)
	input.onTextChanged = function(object)
		local value = self.value
		local newvalue = tonumber(object.lines[1])
		if not newvalue then
			self.value = value
			input:setText(value)
			return
		end
		self.value = newvalue
		if self.value > self.max then
			self.value = self.max
			object:setText(self.value)
		end
		if self.value < self.min then
			self.value = self.min
			object:setText(self.value)
		end
		if value ~= self.value then
			if self.onValueChanged then
				self.onValueChanged(self, self.value)
			end
		end
	end
	input.update = function(object)
		object:setSize(object.parent.width - 20, object.parent.height)
	end

	local increasebutton = loveframes.objects["button"]:new()
	increasebutton.parent = self
	increasebutton:setWidth(21)
	increasebutton:setText("+")
	increasebutton.onClick = function()
		local canmodify = self.canmodify
		if not canmodify then
			self:modifyValue("add")
		else
			self.canmodify = false
		end
	end
	increasebutton.update = function(object)
		local time = 0
		time = love.timer.getTime()
		local delay = self.delay
		local down = object.down
		local canmodify = self.canmodify
		local lastbuttonclicked = self.lastbuttonclicked
		object:setPosition(object.parent.width - 21, 0)
		object:setHeight(object.parent.height/2 + 1)
		if down and not canmodify then
			self:modifyValue("add")
			self.canmodify = true
			self.delay = time + 0.80
			self.lastbuttonclicked = object
		elseif down and canmodify and delay < time then
			self:modifyValue("add")
			self.delay = time + 0.02
		elseif not down and canmodify and lastbuttonclicked == object then
			self.canmodify = false
			self.delay = time + 0.80
		end
	end

	local decreasesbutton = loveframes.objects["button"]:new()
	decreasesbutton.parent = self
	decreasesbutton:setWidth(21)
	decreasesbutton:setText("-")
	decreasesbutton.onClick = function()
		local canmodify = self.canmodify
		if not canmodify then
			self:modifyValue("subtract")
		else
			self.canmodify = false
		end
	end
	decreasesbutton.update = function(object)
		local time = 0
		time = love.timer.getTime()
		local delay = self.delay
		local down = object.down
		local canmodify = self.canmodify
		local lastbuttonclicked = self.lastbuttonclicked
		object:setPosition(object.parent.width - 21, object.parent.height/2)
		object:setHeight(object.parent.height/2)
		if down and not canmodify then
			self:modifyValue("subtract")
			self.canmodify = true
			self.delay = time + 0.80
			self.lastbuttonclicked = object
		elseif down and canmodify and delay < time then
			self:modifyValue("subtract")
			self.delay = time + 0.02
		elseif not down and canmodify and lastbuttonclicked == object then
			self.canmodify = false
			self.delay = time + 0.80
		end
	end

	table.insert(self.internals, input)
	table.insert(self.internals, increasebutton)
	table.insert(self.internals, decreasesbutton)

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

	local internals = self.internals
	local parent = self.parent
	local base = loveframes.base
	local update = self.update

	-- move to parent if there is a parent
	if parent ~= base and parent.type ~= "list" then
		self.x = self.parent.x + self.staticx
		self.y = self.parent.y + self.staticy
	end

	self:checkHover()

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

	local internals = self.internals
	local hover = self.hover

	if hover and button == 1 then
		local baseparent = self:getBaseParent()
		if baseparent and baseparent.type == "frame" then
			baseparent:makeTop()
		end
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

	local min = self.min
	local curvalue = self.value
	local value = tonumber(value) or min
	local internals = self.internals
	local input = internals[1]
	local onvaluechanged = self.onValueChanged

	self.value = value
	input:setText(value)

	if value ~= curvalue and onvaluechanged then
		onvaluechanged(self, value)
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
	- func: setIncreaseAmount(amount)
	- desc: sets the object's increase amount
--]]---------------------------------------------------------
function newobject:setIncreaseAmount(amount)

	self.increaseamount = amount
	return self

end

--[[---------------------------------------------------------
	- func: getIncreaseAmount()
	- desc: gets the object's increase amount
--]]---------------------------------------------------------
function newobject:getIncreaseAmount()

	return self.increaseamount

end

--[[---------------------------------------------------------
	- func: setDecreaseAmount(amount)
	- desc: sets the object's decrease amount
--]]---------------------------------------------------------
function newobject:setDecreaseAmount(amount)

	self.decreaseamount = amount
	return self

end

--[[---------------------------------------------------------
	- func: getDecreaseAmount()
	- desc: gets the object's decrease amount
--]]---------------------------------------------------------
function newobject:getDecreaseAmount()

	return self.decreaseamount

end

--[[---------------------------------------------------------
	- func: setMax(max)
	- desc: sets the object's maximum value
--]]---------------------------------------------------------
function newobject:setMax(max)

	local internals = self.internals
	local input = internals[1]
	local onvaluechanged = self.onValueChanged

	self.max = max

	if self.value > max then
		self.value = max
		input:setValue(max)
		if onvaluechanged then
			onvaluechanged(self, max)
		end
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

	local internals = self.internals
	local input = internals[1]
	local onvaluechanged = self.onValueChanged

	self.min = min

	if self.value < min then
		self.value = min
		input:setValue(min)
		if onvaluechanged then
			onvaluechanged(self, min)
		end
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

	local internals = self.internals
	local input = internals[1]
	local onvaluechanged = self.onValueChanged

	self.min = min
	self.max = max

	if self.value > max then
		self.value = max
		input:setValue(max)
		if onvaluechanged then
			onvaluechanged(self, max)
		end
	end

	if self.value < min then
		self.value = min
		input:setValue(min)
		if onvaluechanged then
			onvaluechanged(self, min)
		end
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
	- func: modifyValue(type)
	- desc: modifies the object's value
--]]---------------------------------------------------------
function newobject:modifyValue(type)

	local value = self.value
	local internals = self.internals
	local input = internals[1]
	local decimals = self.decimals
	local onvaluechanged = self.onValueChanged

	if not value then
		return
	end

	if type == "add" then
		local increaseamount = self.increaseamount
		local max = self.max
		self.value = value + increaseamount
		if self.value > max then
			self.value = max
		end
		self.value = loveframes.round(self.value, decimals)
		input:setText(self.value)
		if value ~= self.value then
			if onvaluechanged then
				onvaluechanged(self, self.value)
			end
		end
	elseif type == "subtract" then
		local decreaseamount = self.decreaseamount
		local min = self.min
		self.value = value - decreaseamount
		if self.value < min then
			self.value = min
		end
		self.value = loveframes.round(self.value, decimals)
		input:setText(self.value)
		if value ~= self.value then
			if onvaluechanged then
				onvaluechanged(self, self.value)
			end
		end
	end

	return self

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

---------- module end ----------
end
