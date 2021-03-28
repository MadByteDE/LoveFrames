local example = {}
example.title = "Textinput"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Text Input")
	frame:setSize(500, 90)
	frame:centerWithinArea(unpack(centerarea))
	
	local textinput = loveframes.create("textinput", frame)
	textinput:setPosition(5, 30)
	textinput:setWidth(490)
	textinput.OnEnter = function(object)
		if not textinput.multiline then
			object:clear()
		end
	end
	textinput:setFont(love.graphics.newFont( "resources/FreeSans-LrmZ.ttf", 12))
	
	local togglebutton = loveframes.create("button", frame)
	togglebutton:setPosition(5, 60)
	togglebutton:setWidth(490)
	togglebutton:setText("Toggle Multiline")
	togglebutton.onClick = function(object)
		if textinput.multiline then
			frame:setHeight(90)
			frame:center()
			togglebutton:setPosition(5, 60)
			textinput:setMultiline(false)
			textinput:setHeight(25)
			textinput:setText("")
			frame:centerWithinArea(unpack(centerarea))
		else
			frame:setHeight(365)
			frame:center()
			togglebutton:setPosition(5, 335)
			textinput:setMultiline(true)
			textinput:setHeight(300)
			textinput:setText("")
			frame:centerWithinArea(unpack(centerarea))
		end
	end
	
end

return example
