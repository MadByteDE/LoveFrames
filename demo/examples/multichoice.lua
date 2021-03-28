local example = {}
example.title = "Multichoice"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Multichoice")
	frame:setSize(210, 60)
	frame:centerWithinArea(unpack(centerarea))
		
	local multichoice = loveframes.create("multichoice", frame)
	multichoice:setPosition(5, 30)
		
	for i=1, 10 do
		multichoice:addChoice(i)
	end
	
end

return example