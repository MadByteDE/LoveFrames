local example = {}
example.title = "Numberbox"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Numberbox")
	frame:setSize(210, 60)
	frame:centerWithinArea(unpack(centerarea))
		
	local numberbox = loveframes.create("numberbox", frame)
	numberbox:setPosition(5, 30)
	numberbox:setSize(200, 25)
	
end

return example