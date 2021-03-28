local example = {}
example.title = "Radiobutton"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Radiobutton")
	frame:setHeight(150)
	frame:centerWithinArea(unpack(centerarea))
		
	local group1 = {}
	
	local radiobutton1 = loveframes.create("radiobutton", frame)
	radiobutton1:setText("Radiobutton 1 in Group 1")
	radiobutton1:setPosition(5, 30)
	radiobutton1:setGroup(group1)
		
	local radiobutton2 = loveframes.create("radiobutton", frame)
	radiobutton2:setText("Radiobutton 2 in Group 1")
	radiobutton2:setPosition(5, 60)
	radiobutton2:setGroup(group1)
	
	local group2 = {}
	
	local radiobutton3 = loveframes.create("radiobutton", frame)
	radiobutton3:setText("Radiobutton 3 in Group 2")
	radiobutton3:setPosition(5, 90)
	radiobutton3:setGroup(group2)
		
	local radiobutton4 = loveframes.create("radiobutton", frame)
	radiobutton4:setText("Radiobutton 4 in Group 2")
	radiobutton4:setPosition(5, 120)
	radiobutton4:setGroup(group2)
	
end

return example