local example = {}
example.title = "User Input Form"
example.category = "Example Implementations"

function example.func(loveframes, centerarea)

	local frame = loveframes.create("frame")
	frame:setName("User Input Form")
	frame:setSize(500, 180)
	frame:centerWithinArea(unpack(centerarea))

	local text1 = loveframes.create("text", frame)
	text1:setPosition(5, 35)
	text1:setText("Username")

	local textinput1 = loveframes.create("textinput", frame)
	textinput1:setPosition(125, 30)
	textinput1:setWidth(370)

	local text2 = loveframes.create("text", frame)
	text2:setPosition(5, 65)
	text2:setText("E-mail")

	local textinput2 = loveframes.create("textinput", frame)
	textinput2:setPosition(125, 60)
	textinput2:setWidth(370)

	local text3 = loveframes.create("text", frame)
	text3:setPosition(5, 95)
	text3:setText("Password")

	local textinput3 = loveframes.create("textinput", frame)
	textinput3:setPosition(125, 90)
	textinput3:setWidth(370)

	local text4 = loveframes.create("text", frame)
	text4:setPosition(5, 125)
	text4:setText("Confirm Password")

	local textinput4 = loveframes.create("textinput", frame)
	textinput4:setPosition(125, 120)
	textinput4:setWidth(370)

	local donebutton = loveframes.create("button", frame)
	donebutton:setPosition(5, 150)
	donebutton:setWidth(243)
	donebutton:setText("Done")
	donebutton.onClick = function()
		local restultframe = loveframes.create("frame")
		restultframe:setSize(300, 100)
		restultframe:center()
		restultframe:setName("Input Form Values")
		local text = loveframes.create("text", restultframe)
		text:setPosition(5, 30)
		text:setText({"Username: " ..textinput1:getValue(), " \n E-mail: " ..textinput2:getValue(), " \n Password: " ..textinput3:getValue(), " \n Confirm Password: " ..textinput4:getValue()})
		text:setMaxWidth(290)
		restultframe:setHeight(35 + text:getHeight())
		restultframe:setModal(true)
		restultframe:centerWithinArea(unpack(centerarea))
	end

	local clearbutton = loveframes.create("button", frame)
	clearbutton:setPosition(252, 150)
	clearbutton:setWidth(243)
	clearbutton:setText("clear Form")
	clearbutton.onClick = function()
		textinput1:clear()
		textinput2:clear()
		textinput3:clear()
		textinput4:clear()
	end

end

return example
