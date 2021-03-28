local example = {}
example.title = "Progress Bar"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Progress Bar")
	frame:setSize(500, 160)
	frame:centerWithinArea(unpack(centerarea))
		
	local progressbar = loveframes.create("progressbar", frame)
	progressbar:setPosition(5, 30)
	progressbar:setWidth(490)
	progressbar:setLerpRate(10)
		
	local button1 = loveframes.create("button", frame)
	button1:setPosition(5, 60)
	button1:setWidth(490)
	button1:setText("Change bar value")
	button1.onClick = function(object2, x, y)
		progressbar:setValue(math.random(progressbar:getMin(), progressbar:getMax()))
	end
		
	local button2 = loveframes.create("button", frame)
	button2:setPosition(5, 90)
	button2:setWidth(490)
	button2:setText("Toggle bar lerp")
	button2.onClick = function(object2, x, y)
		if progressbar:getLerp() == true then
			progressbar:setLerp(false)
		else
			progressbar:setLerp(true)
		end
	end
		
	local slider = loveframes.create("slider", frame)
	slider:setPosition(5, 135)
	slider:setWidth(490)
	slider:setText("Progressbar lerp rate")
	slider:setMinMax(0, 50)
	slider:setDecimals(0)
	slider:setValue(10)
	slider.onValueChanged = function(object2, value)
		progressbar:setLerpRate(value)
	end
		
	local text1 = loveframes.create("text", frame)
	text1:setPosition(5, 120)
	text1:setText("Lerp Rate")
	text1:setFont(love.graphics.newFont(10))
		
	local text2 = loveframes.create("text", frame)
	text2:setFont(love.graphics.newFont(10))
	text2.update = function(object, dt)
		object:setPosition(slider:getWidth() - object:getWidth(), 120)
		object:setText(slider:getValue())
	end
	
end

return example