local example = {}
example.title = "Button Group"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)

	local frame = loveframes.create("frame")
	frame:setName("Button Group with image")
	frame:centerWithinArea(unpack(centerarea))

	local button1 = loveframes.create("button", frame)
	button1:setWidth(200)
	button1:setText("Folder 1")
    button1:setImage("resources/folder.png")
	button1:setPosition(50, 30)
    button1.groupIndex = 1

	local button2 = loveframes.create("button", frame)
	button2:setWidth(200)
	button2:setText("Folder 2")
    button2:setImage("resources/folder.png")
	button2:setPosition(50, 60)
    button2.groupIndex = 1

	local button3 = loveframes.create("button", frame)
	button3:setWidth(200)
	button3:setText("File 1")
    button3:setImage("resources/file.png")
	button3:setPosition(50, 90)
    button3.groupIndex = 2

	local button4 = loveframes.create("button", frame)
	button4:setWidth(200)
	button4:setText("File 2")
    button4:setImage("resources/file.png")
	button4:setPosition(50, 120)
    button4.groupIndex = 2

end

return example
