local example = {}
example.title = "Collapsible Category"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Collapsible Category")
	frame:setSize(500, 300)
	frame:centerWithinArea(unpack(centerarea))
		
	local panel = loveframes.create("panel")
	panel:setHeight(230)
	
	local text = loveframes.create("text", panel)
	text:setText("Collapsible Category")
	
	local collapsiblecategory = loveframes.create("collapsiblecategory", frame)
	collapsiblecategory:setPosition(5, 30)
	collapsiblecategory:setSize(490, 265)
	collapsiblecategory:setText("Category 1")
	collapsiblecategory:setObject(panel)
	
	text:center()
	
end

return example