local example = {}
example.title = "Resizeable Layout"
example.category = "Example Implementations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Resizeable Layout")
	frame:setSize(500, 300)
	frame:centerWithinArea(unpack(centerarea))
	frame:setResizable(true)
	frame:setMaxWidth(800)
	frame:setMaxHeight(600)
	frame:setMinWidth(200)
	frame:setMinHeight(200)
	
	local panel1 = loveframes.create("panel", frame)
	panel1:setPosition(5, 30)
	panel1:setSize(frame:getWidth()/2 - 2, frame:getHeight() - 65)
	panel1.update = function(object)
		object:setSize(frame:getWidth()/2 - 7, frame:getHeight() - 65)
	end
	
	local panel2 = loveframes.create("panel", frame)
	panel2:setPosition(frame:getWidth()/2 + 2, 30)
	panel2:setSize(frame:getWidth()/2 - 7, frame:getHeight()/2 - 35)
	panel2.update = function(object)
		object:setPosition(frame:getWidth()/2 + 2, 30)
		object:setSize(frame:getWidth()/2 - 7, frame:getHeight()/2 - 35)
	end
	
	local panel3 = loveframes.create("panel", frame)
	panel3:setPosition(frame:getWidth()/2 + 2, (panel2.staticy + panel2:getHeight()) + 5)
	panel3:setSize(frame:getWidth()/2 - 7, frame:getHeight()/2 - 35)
	panel3.update = function(object)
		object:setPosition(frame:getWidth()/2 + 2, (panel2.staticy + panel2:getHeight()) + 5)
		object:setSize(frame:getWidth()/2 - 7, frame:getHeight()/2 - 35)
	end
	
	local panel4 = loveframes.create("panel", frame)
	panel4:setPosition(5, frame:getHeight() - 30)
	panel4:setSize(frame:getWidth(), 25)
	panel4.update = function(object)
		object:setY(frame:getHeight() - 30)
		object:setWidth(frame:getWidth() - 10)
	end
	
end

return example