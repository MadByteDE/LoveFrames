local example = {}
example.title = "Column List"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Column List")
	frame:setSize(500, 300)
	frame:centerWithinArea(unpack(centerarea))
		
	local list = loveframes.create("columnlist", frame)
	list:setPosition(5, 30)
	list:setSize(490, 265)
	list:addColumn("Column 1")
	list:addColumn("Column 2")
	list:addColumn("Column 3")
	list:addColumn("Column 4")
		
	for i=1, 20 do
		list:addRow("Row " ..i.. ", column 1", "Row " ..i.. ", column 2", "Row " ..i.. ", column 3", "Row " ..i.. ", column 4")
	end
	
end

return example