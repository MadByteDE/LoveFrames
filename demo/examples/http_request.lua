local example = {}
example.title = "HTTP request"
example.category = "Example Implementations"

function example.func(loveframes, centerarea)
	
	local headers = {}
	
	local frame = loveframes.create("frame")
	frame:setName("HTTP Request")
	frame:setSize(500, 365)
	frame:centerWithinArea(unpack(centerarea))
	
	local resultpanel = loveframes.create("panel", frame)
	resultpanel:setPosition(5, 30)
	resultpanel:setSize(490, 25)
	
	local headersbutton = loveframes.create("button", resultpanel)
	headersbutton:setPosition(390, 0)
	headersbutton:setSize(100, 25)
	headersbutton:setText("View Headers")
	headersbutton:setVisible(false)
	headersbutton.onClick = function(object)
		local headersframe = loveframes.create("frame")
		headersframe:setName("Headers")
		headersframe:setSize(400, 200)
		headersframe:centerWithinArea(unpack(centerarea))
		local headerslist = loveframes.create("columnlist", headersframe)
		headerslist:setPosition(5, 30)
		headerslist:setSize(390, 165)
		headerslist:addColumn("Name")
		headerslist:addColumn("Value")
		for k, v in pairs(headers) do
			headerslist:addRow(k, v)
		end
	end
	
	local resulttext = loveframes.create("text", resultpanel)
	resulttext:setPosition(5, 5)
	
	local resultinput = loveframes.create("textinput", frame)
	resultinput:setPosition(5, 60)
	resultinput:setWidth(490)
	resultinput:setMultiline(true)
	resultinput:setHeight(270)
	resultinput:setEditable(false)
	
	local urlinput = loveframes.create("textinput", frame)
	urlinput:setSize(387, 25)
	urlinput:setPosition(5, 335)
	urlinput:setText("http://love2d.org")
	
	local httpbutton = loveframes.create("button", frame)
	httpbutton:setSize(100, 25)
	httpbutton:setPosition(frame:getWidth() - 105, 335)
	httpbutton:setText("Send Request")
	httpbutton.onClick = function()
		local url = urlinput:getValue()
		local http = require("socket.http")
		local b, c, h = http.request(url)
		if b then
			resulttext:setText("Response code: " ..c)
			resulttext:centerY()
			resultinput:setText(b)
			resultinput:setFocus(true)
			headersbutton:setVisible(true)
			headers = h
		else
			resultinput:setText("Error: HTTP request returned a nil value.")
		end
	end
	
end

return example