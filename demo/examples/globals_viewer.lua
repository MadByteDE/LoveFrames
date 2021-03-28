local example = {}
example.title = "Globals Viewer"
example.category = "Example Implementations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Globals Viewer")
	frame:setSize(500, 300)
	frame:centerWithinArea(unpack(centerarea))
	
	local glist = loveframes.create("columnlist", frame)
	glist:setPosition(5, 30)
	glist:setSize(490, 265)
	glist:addColumn("Key")
	glist:addColumn("Value")
	
	for k, v in pairs(_G) do
		local value_str = ""
		glist:addRow(k, tostring(v))
	end
	
end

return example