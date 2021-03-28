local example = {}
example.title = "Image Button"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)

	local frame = loveframes.create("frame")
	frame:setName("Image Button")
	frame:setSize(138, 163)
	frame:centerWithinArea(unpack(centerarea))

	local imagebutton = loveframes.create("imagebutton", frame)
	imagebutton:setImage("resources/magic.png")
	imagebutton:setPosition(5, 30)
	imagebutton:sizeToImage()
	imagebutton:center()

end

return example
