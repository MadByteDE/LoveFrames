local example = {}
example.title = "Button"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)

	local frame = loveframes.create("frame")
	frame:setName("Button")
	frame:centerWithinArea(unpack(centerarea))

	local button = loveframes.create("button", frame)
	button:setWidth(200)
	button:setText("Button")
	button:center()
	button.onClick = function(object, x, y)
		object:setText("You clicked the button!")
	end
	button.onMouseEnter = function(object)
		object:setText("The mouse entered the button.")
	end
	button.onMouseExit = function(object)
		object:setText("The mouse exited the button.")
	end

end

return example
