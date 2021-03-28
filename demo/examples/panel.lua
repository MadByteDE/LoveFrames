local example = {}
example.title = "Panel"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Panel")
	frame:setSize(210, 85)
	frame:centerWithinArea(unpack(centerarea))
		
	local panel = loveframes.create("panel", frame)
	panel:setPosition(5, 30)
	
end

return example