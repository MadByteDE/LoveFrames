local example = {}
example.title = "Custom State"
example.category = "Example Implementations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Custom State")
	frame:setWidth(500)
	frame:center()
	frame:showCloseButton(false)
	
	local text = loveframes.create("text", frame)
	text:setText("Love Frames is now in a custom state. The objects that you are currently seeing are registered with this custom state and will only be visible while the state is active. All the objects that you were able to see before the state was activated still exist, they just won't be visible until the custom state is deactivated.")
	text:setMaxWidth(490)
	text:setPosition(5, 30)
	
	local button = loveframes.create("button", frame)
	button:setWidth(490)
	button:setText("Return to main state")
	button:center()
	button.onClick = function(object, x, y)
		loveframes.setState("none")
		frame:remove()
	end
	
	button:setY(text:getHeight() + 35)
	frame:setHeight(text:getHeight() + 65)
	frame:setState("newstate")
	
	loveframes.setState("newstate")
	
end

return example