local example = {}
example.title = "Menu"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)
	
	local frame = loveframes.create("frame")
	frame:setName("Menu")
	frame:centerWithinArea(unpack(centerarea))
	
	local text = loveframes.create("text", frame)
	text:setText("Right click this frame to see an \n example of the menu object")
	text:center()
	
	
	local submenu3 = loveframes.create("menu")
	submenu3:addOption("Option 1", false, function() end)
	submenu3:addOption("Option 2", false, function() end)
		
	local submenu2 = loveframes.create("menu")
	submenu2:addOption("Option 1", "resources/food/FishFillet.png", function() end)
	submenu2:addOption("Option 2", "resources/food/FishSteak.png", function() end)
	submenu2:addOption("Option 3", "resources/food/Shrimp.png", function() end)
	submenu2:addOption("Option 4", "resources/food/Sushi.png", function() end)
		
	local submenu1 = loveframes.create("menu")
	submenu1:addSubMenu("Option 1", "resources/food/Cookie.png", submenu3)
	submenu1:addSubMenu("Option 2", "resources/food/Fish.png", submenu2)
		
	local menu = loveframes.create("menu")
	menu:addOption("Option A", "resources/food/Eggplant.png", function() end)
	menu:addOption("Option B", "resources/food/Eggs.png", function() end)
	menu:addDivider()
	menu:addOption("Option C", "resources/food/Cherry.png", function() end)
	menu:addOption("Option D", "resources/food/Honey.png", function() end)
	menu:addDivider()
	menu:addSubMenu("Option E", false, submenu1)
	menu:setVisible(false)
	
	frame.menu_example = menu
	text.menu_example = menu
	
end

return example
