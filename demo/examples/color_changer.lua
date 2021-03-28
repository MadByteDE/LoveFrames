local example = {}
example.title = "Color Changer"
example.category = "Example Implementations"

function example.func(loveframes, centerarea)

	local color = {0, 0, 0, 1}

	local frame = loveframes.create("frame")
	frame:setName("Color Changer")
	frame:setSize(500, 255)
	frame:centerWithinArea(unpack(centerarea))

	local colorbox = loveframes.create("panel", frame)
	colorbox:setPosition(5, 30)
	colorbox:setSize(490, 100)
	colorbox.draw = function(object)
		love.graphics.setColor(color)
		love.graphics.rectangle("fill", object:getX(), object:getY(), object:getWidth(), object:getHeight())
		love.graphics.setColor(.6, .6, .6, 1)
		love.graphics.setLineWidth(1)
		love.graphics.setLineStyle("smooth")
		love.graphics.rectangle("line", object:getX(), object:getY(), object:getWidth(), object:getHeight())
	end

	local slider1 = loveframes.create("slider", frame)
	slider1:setPosition(5, 150)
	slider1:setWidth(490)
	slider1:setMax(255)
	slider1:setDecimals(0)
	slider1.onValueChanged = function(object, value)
		color[1] = value / 255
	end

	local slider1name = loveframes.create("text", frame)
	slider1name:setPosition(5, 135)
	slider1name:setText("Red")

	local slider1value = loveframes.create("text", frame)
	slider1value:setPosition(470, 135)
	slider1value.update = function(object)
		object:setText(slider1:getValue())
	end

	local slider2 = loveframes.create("slider", frame)
	slider2:setPosition(5, 190)
	slider2:setWidth(490)
	slider2:setMax(255)
	slider2:setDecimals(0)
	slider2.onValueChanged = function(object, value)
		color[2] = value / 255
	end

	local slider2name = loveframes.create("text", frame)
	slider2name:setPosition(5, 175)
	slider2name:setText("Green")

	local slider2value = loveframes.create("text", frame)
	slider2value:setPosition(470, 175)
	slider2value.update = function(object)
		object:setText(slider2:getValue())
	end

	local slider3 = loveframes.create("slider", frame)
	slider3:setPosition(5, 230)
	slider3:setWidth(490)
	slider3:setMax(255)
	slider3:setDecimals(0)
	slider3.onValueChanged = function(object, value)
		color[3] = value / 255
	end

	local slider3name = loveframes.create("text", frame)
	slider3name:setPosition(5, 215)
	slider3name:setText("Blue")

	local slider3value = loveframes.create("text", frame)
	slider3value:setPosition(470, 215)
	slider3value.update = function(object)
		object:setText(slider3:getValue())
	end

end

return example
