local example = {}
example.title = "Slider"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Slider")
	frame:setSize(300, 275)
	frame:centerWithinArea(unpack(centerarea))
		
	local slider1 = loveframes.create("slider", frame)
	slider1:setPosition(5, 30)
	slider1:setWidth(290)
	slider1:setMinMax(0, 100)
		
	local slider2 = loveframes.create("slider", frame)
	slider2:setPosition(5, 60)
	slider2:setHeight(200)
	slider2:setMinMax(0, 100)
	slider2:setButtonSize(20, 10)
	slider2:setSlideType("vertical")
	slider2.update = function(object, dt)
		object:centerX()
	end
	
end

return example