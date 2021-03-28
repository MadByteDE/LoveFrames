local example = {}
example.title = "Tabs"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Tabs")
	frame:setSize(500, 300)
	frame:centerWithinArea(unpack(centerarea))
		
	local tabs = loveframes.create("tabs", frame)
	tabs:setPosition(5, 30)
	tabs:setSize(490, 265)
		
	local imagelist = loveframes.getDirectoryContents("resources/food/")
	local images = {}
	for i, v in ipairs(imagelist) do
		if v.extension == "png" then table.insert(images, v.fullpath) end
	end
	
	for i=1, 20 do
		local image = images[math.random(1, #images)]
		local panel = loveframes.create("panel")
		panel.draw = function()
		end
		local text = loveframes.create("text", panel)
		text:setText("Tab " ..i)
		text:setAlwaysUpdate(true)
		text.update = function(object, dt)
			object:center()
		end
		tabs:addTab("Tab " ..i, panel, "Tab " ..i, image)
	end
	
end

return example