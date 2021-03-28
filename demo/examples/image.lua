local example = {}
example.title = "Image"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)

	local frame = loveframes.create("frame")
	frame:setName("Image")
	frame:setSize(138, 340)
	frame:centerWithinArea(unpack(centerarea))

	local image = loveframes.create("image", frame)
	image:setImage("resources/magic.png")
	image:setPosition(5, 30)
	image:setSize(128, 120)

	local panel = loveframes.create("panel", frame)
	panel:setPosition(5, 160)
	panel:setSize(128, 170)

	local text1 = loveframes.create("text", panel)
	text1:setPosition(5, 5)
	text1:setText("Orientation: ")

	local slider1 = loveframes.create("slider", panel)
	slider1:setPosition(5, 20)
	slider1:setWidth(118)
	slider1:setMinMax(0, loveframes.round(math.pi * 2, 5))
	slider1:setDecimals(5)
	slider1.onValueChanged = function(object)
		image:setOrientation(object:getValue())
	end

	text1.update = function(object, dt)
		local value = slider1:getValue()
		local max = slider1:getMax()
		local progress = value/max
		local final = loveframes.round(360 * progress)
		object:setText("Orientation: " ..final)
	end

	local text2 = loveframes.create("text", panel)
	text2:setPosition(5, 40)
	text2:setText("Scale")

	local slider2 = loveframes.create("slider", panel)
	slider2:setPosition(5, 55)
	slider2:setWidth(118)
	slider2:setMinMax(.5, 2)
	slider2:setValue(1)
	slider2:setDecimals(5)
	slider2.onValueChanged = function(object)
		image:setScale(object:getValue(), object:getValue())
	end

	text2.update = function(object, dt)
		object:setText("Scale: " ..slider2:getValue())
	end

	local text3 = loveframes.create("text", panel)
	text3:setPosition(5, 75)
	text3:setText("Offset")

	local slider3 = loveframes.create("slider", panel)
	slider3:setPosition(5, 90)
	slider3:setWidth(118)
	slider3:setMinMax(0, 50)
	slider3:setDecimals(5)
	slider3.onValueChanged = function(object)
		image:setOffset(object:getValue(), object:getValue())
	end

	text3.update = function(object, dt)
		object:setText("Offset: " ..slider3:getValue())
	end

	local text4 = loveframes.create("text", panel)
	text4:setPosition(5, 110)
	text4:setText("Shear")

	local slider4 = loveframes.create("slider", panel)
	slider4:setPosition(5, 125)
	slider4:setWidth(118)
	slider4:setMinMax(0, 40)
	slider4:setDecimals(5)
	slider4.onValueChanged = function(object)
		image:setShear(object:getValue(), object:getValue())
	end

	text4.update = function(object, dt)
		object:setText("Shear: " ..slider4:getValue())
	end

    local checkbox5 = loveframes.create("checkbox", panel)
	checkbox5:setText("Stretched")
	checkbox5:setPosition(5, 150)
	checkbox5.onChanged = function(object, value)
		image.stretch = value
	end

end

return example
