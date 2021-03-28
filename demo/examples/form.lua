local example = {}
example.title = "Form"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Form")
	frame:setSize(500, 80)
	frame:centerWithinArea(unpack(centerarea))
		
	local form = loveframes.create("form", frame)
	form:setPosition(5, 25)
	form:setSize(490, 65)
	form:setLayoutType("horizontal")
	
	for i=1, 3 do
		local button = loveframes.create("button")
		button:setText(i)
		button:setWidth((490/3) - 7)
		form:addItem(button)
	end
	
end

return example