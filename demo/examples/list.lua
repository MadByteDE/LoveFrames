local example = {}
example.title = "List"
example.category = "Object Demonstrations"

local font = love.graphics.newFont(10)

function example.func(loveframes, centerarea)

	local frame = loveframes.create("frame")
	frame:setName("List")
	frame:setSize(500, 470)
	frame:centerWithinArea(unpack(centerarea))

	local list = loveframes.create("list", frame)
	list:setPosition(5, 30)
	list:setSize(490, 300)
	list:setPadding(5)
	list:setSpacing(5)

	local panel = loveframes.create("panel")
	panel:setSize(490, 115)
	panel.draw = function() end

	local text1 = loveframes.create("text", panel)
	local text2 = loveframes.create("text", panel)
	local slider1 = loveframes.create("slider", panel)
	slider1:setPosition(5, 20)
	slider1:setWidth(480)
	slider1:setMinMax(0, 100)
	slider1:setValue(5)
	slider1:setText("Padding")
	slider1:setDecimals(0)
	slider1.onValueChanged = function(object2, value)
		list:setPadding(value)
		text2:setPosition(slider1:getWidth() - text2:getWidth(), 5)
		text2:setText(slider1:getValue())
	end

	text1:setPosition(5, 5)
	text1:setFont(font)
	text1:setText(slider1:getText())

	text2:setText(slider1:getValue())
	text2:setFont(font)
	text2:setPosition(slider1:getWidth() - text2:getWidth(), 5)

	local text3 = loveframes.create("text", panel)
	local text4 = loveframes.create("text", panel)
	local slider2 = loveframes.create("slider", panel)
	slider2:setPosition(5, 60)
	slider2:setWidth(480)
	slider2:setMinMax(0, 100)
	slider2:setValue(5)
	slider2:setText("Spacing")
	slider2:setDecimals(0)
	slider2.onValueChanged = function(object2, value)
		list:setSpacing(value)
		text4:setPosition(slider2:getWidth() - text4:getWidth(), 45)
		text4:setText(slider2:getValue())
	end

	text3:setPosition(5, 45)
	text3:setFont(font)
	text3:setText(slider2:getText())

	text4:setText(slider2:getValue())
	text4:setFont(font)
	text4:setPosition(slider2:getWidth() - text4:getWidth(), 45)

	local button1 = loveframes.create("button", panel)
	button1:setPosition(5, 85)
	button1:setSize(237, 25)
	button1:setText("Change List Type")
	button1.onClick = function(object2, x, y)
		if list:getDisplayType() == "vertical" then
			list:setDisplayType("horizontal")
		else
			list:setDisplayType("vertical")
		end
		list:clear()
		for i=1, 100 do
			local button = loveframes.create("button")
			button:setText(i)
			list:addItem(button)
		end
	end

	local button2 = loveframes.create("button", panel)
	button2:setPosition(247, 85)
	button2:setSize(237, 25)
	button2:setText("Toggle Horizontal Stacking")
	button2.onClick = function(object2, x, y)
		local enabled = list:getHorizontalStacking()
		list:enableHorizontalStacking(not enabled)
		list:clear()
		for i=1, 100 do
			local button = loveframes.create("button")
			button:setSize(100, 25)
			button:setText(i)
			list:addItem(button)
		end
	end
	button2.update = function(object)
	local displaytype = list:getDisplayType()
		if displaytype ~= "vertical" then
			object:setEnabled(false)
			object:setClickable(false)
		else
			object:setEnabled(true)
			object:setClickable(true)
		end
	end

	local form = loveframes.create("form", frame)
	form:setPosition(5, 335)
	form.padding = 0
	form.spacing = 0
	form:setName("List Controls")
	form:addItem(panel)

	for i=1, 100 do
		local button = loveframes.create("button")
		button:setText(i)
		list:addItem(button)
	end

end

return example
