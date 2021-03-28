local example = {}
example.title = "Frame"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Frame")
	frame:centerWithinArea(unpack(centerarea))
	frame:setIcon("resources/food/Apple.png")
	frame:setDockable(true)
	frame:setScreenLocked(true)
	frame:setResizable(true)
	frame:setMaxWidth(800)
	frame:setMaxHeight(600)
	frame:setMinWidth(200)
	frame:setMinHeight(100)
		
	local button = loveframes.create("button", frame)
	button:setText("Modal")
	button:setImage("resources/food/Onion.png")
	button:setWidth(125)
	button:center()
	button.update = function(object, dt)
		object:center()
		local modal = object:getParent():getModal()
		if modal then
			object:setText("remove Modal")
			object.onClick = function()
				object:getParent():setModal(false)
			end
		else
			object:setText("set Modal")
			object.onClick = function()
				object:getParent():setModal(true)
			end
		end
	end
	
end

return example