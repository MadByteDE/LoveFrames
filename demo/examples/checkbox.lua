local example = {}
example.title = "Checkbox"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)

	local frame = loveframes.create("frame")
	frame:setName("Checkbox")
	frame:setHeight(85)
	frame:centerWithinArea(unpack(centerarea))

	local checkbox1 = loveframes.create("checkbox", frame)
	checkbox1:setText("Checkbox 1")
	checkbox1:setPosition(5, 30)

	local checkbox2 = loveframes.create("checkbox", frame)
	checkbox2:setText("Checkbox 2")
	checkbox2:setPosition(5, 60)

end

return example
