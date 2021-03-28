local example = {}
example.title = "Grid"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Grid")
	frame:centerWithinArea(unpack(centerarea))
		
	local grid = loveframes.create("grid", frame)
	grid:setPosition(5, 30)
	grid:setRows(5)
	grid:setColumns(5)
	grid:setCellWidth(25)
	grid:setCellHeight(25)
	grid:setCellPadding(5)
	grid:setItemAutoSize(true)
		
	local id = 1
		
	for i=1, 5 do
		for n=1, 5 do
			local button = loveframes.create("button")
			button:setSize(15, 15)
			button:setText(id)
			grid:addItem(button, i, n)
			id = id + 1
		end
	end
		
	grid.onSizeChanged = function(object)
		frame:setSize(object:getWidth() + 10, object:getHeight() + 35)
		frame:centerWithinArea(unpack(centerarea))
	end
	
end

return example