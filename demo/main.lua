
local loveframes
local tween
local demo = {}

function demo.createToolbar()
	local width = love.graphics.getWidth()
	local version = loveframes.version
	local stage = loveframes.stage

	local toolbar = loveframes.create("panel")
	toolbar:setSize(width, 35)
	toolbar:setPosition(0, 0)

	local info = loveframes.create("text", toolbar)
	info:setPosition(5, 3)
	info:setText({
		{color = {0, 0, 0, 1}},
		"Love Frames (",
		{color = {.5, .25, 1, 1}}, "version " ..version.. " - " ..stage,
		{color = {0,  0, 0, 1}}, ")\n",
		{color = {1, .4, 0, 1}}, "F1",
		{color = {0,  0, 0, 1}}, ": Toggle debug mode - ",
		{color = {1, .4, 0, 1}}, "F2",
		{color = {0,  0, 0, 1}}, ": remove all objects"
	})

	demo.examplesbutton = loveframes.create("button", toolbar)
	demo.examplesbutton:setPosition(toolbar:getWidth() - 105, 5)
	demo.examplesbutton:setSize(100, 25)
	demo.examplesbutton:setText("Hide Examples")
	demo.examplesbutton.onClick = function()
		demo.toggleExamplesList()
	end

	local skinslist = loveframes.create("multichoice", toolbar)
	skinslist:setPosition(toolbar:getWidth() - 250, 5)
	skinslist:setWidth(140)
	skinslist:setChoice("Choose a skin")
	skinslist.onChoiceSelected = function(object, choice)
		loveframes.setActiveSkin(choice)
	end

	local skins = loveframes.skins
	for k, v in pairs(skins) do
		skinslist:addChoice(v.name)
	end
	skinslist:sort()
end

function demo.registerExample(example)
	local examples = demo.examples
	local category = example.category

	for k, v in ipairs(examples) do
		if v.category_title == category then
			table.insert(examples[k].registered, example)
		end
	end
end

function demo.createExamplesList()
	local examples = demo.examples
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()

	demo.exampleslist = loveframes.create("list")
	demo.exampleslist:setPosition(width - 250, 35)
	demo.exampleslist:setSize(250, height - 35)
	demo.exampleslist:setPadding(5)
	demo.exampleslist:setSpacing(5)
	demo.exampleslist.toggled = true

	demo.tween_open  = tween.new(1, demo.exampleslist, {x = (width - 250)}, "outBounce")
	demo.tween_close = tween.new(1, demo.exampleslist, {x = (width - 5)}, "outBounce")

	for k, v in ipairs(examples) do
		local panelheight = 0
		local category = loveframes.create("collapsiblecategory")
		category:setText(v.category_title)
		local panel = loveframes.create("panel")
		panel.draw = function() end
		demo.exampleslist:addItem(category)
		for key, value in ipairs(v.registered) do
			local button = loveframes.create("button", panel)
			button:setWidth(210)
			button:setPosition(0, panelheight)
			button:setText(value.title)
			button.onClick = function()
				value.func(loveframes, demo.centerarea)
				demo.current = value
			end
			panelheight = panelheight + 30
		end
		panel:setHeight(panelheight)
		category:setObject(panel)
		category:setOpen(true)
	end
end

function demo.toggleExamplesList()

	local toggled = demo.exampleslist.toggled

	if not toggled then
		demo.exampleslist.toggled = true
		demo.tween = demo.tween_open
		demo.examplesbutton:setText("Hide Examples")
	else
		demo.exampleslist.toggled = false
		demo.tween = demo.tween_close
		demo.examplesbutton:setText("Show Examples")
	end

	demo.tween:reset()
end


function love.load()
	local font = love.graphics.newFont(12)
	love.graphics.setFont(font)

	loveframes = require("loveframes")
	tween = require("tween")

	-- Change fonts on all registered skins
	for _, skin in pairs(loveframes.skins) do
		skin.controls.smallfont = love.graphics.newFont( "resources/FreeSans-LrmZ.ttf", 12)
		skin.controls.imagebuttonfont = love.graphics.newFont( "resources/FreeSans-LrmZ.ttf", 15)
	end

	-- table to store available examples
	demo.examples = {}
	demo.examples[1] = {category_title = "Object Demonstrations", registered = {}}
	demo.examples[2] = {category_title = "Example Implementations", registered = {}}

	demo.exampleslist = nil
	demo.examplesbutton = nil
	demo.tween = nil
	demo.centerarea = {5, 40, 540, 555}

	local files = loveframes.getDirectoryContents("examples")
	local example
	for k, v in ipairs(files) do
		if v.extension == "lua" then
			example = require(v.requirepath)
			print(example.title)
			demo.registerExample(example)
		end
	end

	local image = love.graphics.newImage("resources/background.png")
	image:setWrap("repeat", "repeat")
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	demo.bgquad = love.graphics.newQuad(0, 0, width, height, image:getWidth(), image:getHeight())
	demo.bgimage = image

	-- create demo gui
	demo.createToolbar()
	demo.createExamplesList()
end

function love.update(dt)

	loveframes.update(dt)
	if demo.tween then
		if demo.tween:update(dt) then demo.tween = nil end
	end
end

function love.draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(demo.bgimage, demo.bgquad, 0, 0)
	loveframes.draw()

end

function love.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)
	local menu = loveframes.hoverobject and loveframes.hoverobject.menu_example
	if menu and button == 2 then
		menu:setPosition(x, y)
		menu:setVisible(true)
		menu:moveToTop()
	end
end

function love.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end

function love.wheelmoved(x, y)
	loveframes.wheelmoved(x, y)
end

function love.keypressed(key, isrepeat)
	loveframes.keypressed(key, isrepeat)

	if key == "f1" then
		local debug = loveframes.config["DEBUG"]
		loveframes.config["DEBUG"] = not debug
	elseif key == "f2" then
		loveframes.removeAll()
		demo.createToolbar()
		demo.createExamplesList()
		--demo.toggleExamplesList()
	end
end

function love.keyreleased(key)
	loveframes.keyreleased(key)
end

function love.textinput(text)
	loveframes.textinput(text)
end
