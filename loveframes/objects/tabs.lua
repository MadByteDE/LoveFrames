--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- tabs object
local newobject = loveframes.newObject("tabs", "loveframes_object_tabs", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()

	self.type = "tabs"
	self.width = 100
	self.height = 50
	self.clickx = 0
	self.clicky = 0
	self.offsetx = 0
	self.tab = 1
	self.tabnumber = 1
	self.padding = 5
	self.tabheight = 25
	self.previoustabheight = 25
	self.buttonscrollamount = 200
	self.mousewheelscrollamount = 1500
	self.buttonareax = 0
	self.buttonareawidth = self.width
	self.autosize = true
	self.autobuttonareawidth = true
	self.dtscrolling = true
	self.internal = false
	self.tooltipfont = loveframes.basicfontsmall
	self.internals = {}
	self.children = {}

	self:addScrollButtons()
	self:setDrawFunc()
end

--[[---------------------------------------------------------
	- func: update(deltatime)
	- desc: updates the element
--]]---------------------------------------------------------
function newobject:_update(dt)

	local state = loveframes.state
	local selfstate = self.state

	if state ~= selfstate then
		return
	end

	local visible = self.visible
	local alwaysupdate = self.alwaysupdate

	if not visible then
		if not alwaysupdate then
			return
		end
	end

	local x, y = love.mouse.getPosition()
	local tabheight = self.tabheight
	local padding = self.padding
	local autosize = self.autosize
	local autobuttonareawidth = self.autobuttonareawidth
	local padding = self.padding
	local children = self.children
	local numchildren = #children
	local internals = self.internals
	local tab = self.tab
	local parent = self.parent
	local base = loveframes.base
	local update = self.update

	-- move to parent if there is a parent
	if parent ~= base then
		self.x = self.parent.x + self.staticx
		self.y = self.parent.y + self.staticy
	end

	self:checkHover()

	if numchildren > 0 and tab == 0 then
		self.tab = 1
	end

	if autobuttonareawidth then
		local width = self.width
		self.buttonareawidth = width
	end

	local pos = 0

	for k, v in ipairs(internals) do
		v:_update(dt)
		if v.type == "tabbutton" then
			v.x = (v.parent.x + v.staticx) + pos + self.offsetx + self.buttonareax
			v.y = (v.parent.y + v.staticy)
			pos = pos + v.width - 1
		end
	end

	if #self.children > 0 then
		self.children[self.tab]:_update(dt)
		self.children[self.tab]:setPosition(padding, tabheight + padding)
	end

	if update then
		update(self, dt)
	end

end

--[[---------------------------------------------------------
	- func: draw()
	- desc: draws the object
--]]---------------------------------------------------------
function newobject:_draw()
	if loveframes.state ~= self.state then
		return
	end

	if not self.visible then
		return
	end

	local x = self.x
	local y = self.y
	local width = self.width
	local height = self.height
	local tabheight = self:getHeightOfButtons()
	local stencilfunc = function() love.graphics.rectangle("fill", x + self.buttonareax, y, self.buttonareawidth, height) end

	self:setDrawOrder()

	local drawfunc = self.draw or self.drawfunc
	if drawfunc then
		drawfunc(self)
	end

	love.graphics.stencil(stencilfunc)
	love.graphics.setStencilTest("greater", 0)

	local internals = self.internals
	if internals then
		for k, v in ipairs(internals) do
			local col = loveframes.boundingBox(x + self.buttonareax, v.x, self.y, v.y, self.buttonareawidth, v.width, tabheight, v.height)
			if col or v.type == "scrollbutton" then
				v:_draw()
			end
		end
	end

	love.graphics.setStencilTest()

	local children = self.children
	if #children > 0 then
		children[self.tab]:_draw()
	end

	drawfunc = self.drawOver or self.drawoverfunc
	if drawfunc then
		drawfunc(self)
	end
end

--[[---------------------------------------------------------
	- func: mousepressed(x, y, button)
	- desc: called when the player presses a mouse button
--]]---------------------------------------------------------
function newobject:mousepressed(x, y, button)

	local state = loveframes.state
	local selfstate = self.state

	if state ~= selfstate then
		return
	end

	local visible = self.visible

	if not visible then
		return
	end

	local children = self.children
	local internals = self.internals
	local numchildren = #children
	local numinternals = #internals
	local tab = self.tab
	local hover = self.hover

	if hover and button == 1 then
		local baseparent = self:getBaseParent()
		if baseparent and baseparent.type == "frame" then
			baseparent:makeTop()
		end
	end

	for k, v in ipairs(internals) do
		v:mousepressed(x, y, button)
	end

	if numchildren > 0 then
		children[tab]:mousepressed(x, y, button)
	end

end

--[[---------------------------------------------------------
	- func: mousereleased(x, y, button)
	- desc: called when the player releases a mouse button
--]]---------------------------------------------------------
function newobject:mousereleased(x, y, button)

	local state = loveframes.state
	local selfstate = self.state

	if state ~= selfstate then
		return
	end

	local visible = self.visible
	local children = self.children
	local numchildren = #children
	local tab = self.tab
	local internals = self.internals

	if not visible then
		return
	end

	for k, v in ipairs(internals) do
		v:mousereleased(x, y, button)
	end

	if numchildren > 0 then
		children[tab]:mousereleased(x, y, button)
	end

end

--[[---------------------------------------------------------
	- func: wheelmoved(x, y)
	- desc: called when the player moves a mouse wheel
--]]---------------------------------------------------------
function newobject:wheelmoved(x, y)

	local internals = self.internals
	local numinternals = #internals

	if y < 0 then
		local buttonheight = self:getHeightOfButtons()
		local col = loveframes.boundingBox(self.x, x, self.y, y, self.width, 1, buttonheight, 1)
		local visible = internals[numinternals - 1]:getVisible()
		if col and visible then
			local scrollamount = -y * self.mousewheelscrollamount
			local dtscrolling = self.dtscrolling
			if dtscrolling then
				local dt = love.timer.getDelta()
				self.offsetx = self.offsetx + scrollamount * dt
			else
				self.offsetx = self.offsetx + scrollamount
			end
			if self.offsetx > 0 then
				self.offsetx = 0
			end
		end
	elseif y > 0 then
		local buttonheight = self:getHeightOfButtons()
		local col = loveframes.boundingBox(self.x, x, self.y, y, self.width, 1, buttonheight, 1)
		local visible = internals[numinternals]:getVisible()
		if col and visible then
			local bwidth = self:getWidthOfButtons()
			local scrollamount = y * self.mousewheelscrollamount
			local dtscrolling = self.dtscrolling
			if dtscrolling then
				local dt = love.timer.getDelta()
				self.offsetx = self.offsetx - scrollamount * dt
			else
				self.offsetx = self.offsetx - scrollamount
			end
			if ((self.offsetx + bwidth) + self.width) < self.width then
				self.offsetx = -(bwidth + 10)
			end
		end
	end

end

--[[---------------------------------------------------------
	- func: addTab(name, object, tip, image)
	- desc: adds a new tab to the tab panel
--]]---------------------------------------------------------
function newobject:addTab(name, object, tip, image, onopened, onclosed)

	local padding = self.padding
	local autosize = self.autosize
	local retainsize = self.retainsize
	local tabnumber = self.tabnumber
	local tabheight = self.tabheight
	local internals = self.internals
	local state = self.state

	object:remove()
	object.parent = self
	object:setState(state)
	object.staticx = 0
	object.staticy = 0

	if tabnumber ~= 1 then
		object.visible = false
	end

	local tab = loveframes.objects["tabbutton"]:new(self, name, tabnumber, tip, image, onopened, onclosed)

	table.insert(self.children, object)
	table.insert(self.internals, #self.internals - 1, tab)
	self.tabnumber = tabnumber + 1

	if autosize and not retainsize then
		object:setSize(self.width - padding * 2, (self.height - tabheight) - padding * 2)
	end

	return tab

end

--[[---------------------------------------------------------
	- func: addScrollButtons()
	- desc: creates scroll buttons fot the tab panel
	- note: for internal use only
--]]---------------------------------------------------------
function newobject:addScrollButtons()

	local internals = self.internals
	local state = self.state

	for k, v in ipairs(internals) do
		if v.type == "scrollbutton" then
			table.remove(internals, k)
		end
	end

	local leftbutton = loveframes.objects["scrollbutton"]:new("left")
	leftbutton.parent = self
	leftbutton:setPosition(0, 0)
	leftbutton:setSize(15, 25)
	leftbutton:setAlwaysUpdate(true)
	leftbutton.update = function(object, dt)
		object.staticx = 0
		object.staticy = 0
		if self.offsetx ~= 0 then
			object.visible = true
		else
			object.visible = false
			object.down = false
			object.hover = false
		end
		if object.down then
			if self.offsetx > 0 then
				self.offsetx = 0
			elseif self.offsetx ~= 0 then
				local scrollamount = self.buttonscrollamount
				local dtscrolling = self.dtscrolling
				if dtscrolling then
					local dt = love.timer.getDelta()
					self.offsetx = self.offsetx + scrollamount * dt
				else
					self.offsetx = self.offsetx + scrollamount
				end
			end
		end
	end

	local rightbutton = loveframes.objects["scrollbutton"]:new("right")
	rightbutton.parent = self
	rightbutton:setPosition(self.width - 15, 0)
	rightbutton:setSize(15, 25)
	rightbutton:setAlwaysUpdate(true)
	rightbutton.update = function(object, dt)
		object.staticx = self.width - object.width
		object.staticy = 0
		local bwidth = self:getWidthOfButtons()
		if (self.offsetx + bwidth) - (self.buttonareax * 2 - 1) > self.width then
			object.visible = true
		else
			object.visible = false
			object.down = false
			object.hover = false
		end
		if object.down then
			if ((self.x + self.offsetx) + bwidth) ~= (self.x + self.width) then
				local scrollamount = self.buttonscrollamount
				local dtscrolling = self.dtscrolling
				if dtscrolling then
					local dt = love.timer.getDelta()
					self.offsetx = self.offsetx - scrollamount * dt
				else
					self.offsetx = self.offsetx - scrollamount
				end
			end
		end
	end

	leftbutton.state = state
	rightbutton.state = state

	table.insert(internals, leftbutton)
	table.insert(internals, rightbutton)

end

--[[---------------------------------------------------------
	- func: getWidthOfButtons()
	- desc: gets the total width of all of the tab buttons
--]]---------------------------------------------------------
function newobject:getWidthOfButtons()

	local width = 0
	local internals = self.internals

	for k, v in ipairs(internals) do
		if v.type == "tabbutton" then
			width = width + v.width
		end
	end

	return width

end

--[[---------------------------------------------------------
	- func: getHeightOfButtons()
	- desc: gets the height of one tab button
--]]---------------------------------------------------------
function newobject:getHeightOfButtons()

	return self.tabheight

end

--[[---------------------------------------------------------
	- func: switchToTab(tabnumber)
	- desc: makes the specified tab the active tab
--]]---------------------------------------------------------
function newobject:switchToTab(tabnumber)

	local children = self.children

	for k, v in ipairs(children) do
		v.visible = false
	end

	self.tab = tabnumber
	self.children[tabnumber].visible = true

	return self

end

--[[---------------------------------------------------------
	- func: setScrollButtonSize(width, height)
	- desc: sets the size of the scroll buttons
--]]---------------------------------------------------------
function newobject:setScrollButtonSize(width, height)

	local internals = self.internals

	for k, v in ipairs(internals) do
		if v.type == "scrollbutton" then
			v:setSize(width, height)
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: setPadding(paddint)
	- desc: sets the padding for the tab panel
--]]---------------------------------------------------------
function newobject:setPadding(padding)

	self.padding = padding
	return self

end

--[[---------------------------------------------------------
	- func: setPadding(paddint)
	- desc: gets the padding of the tab panel
--]]---------------------------------------------------------
function newobject:getPadding()

	return self.padding

end

--[[---------------------------------------------------------
	- func: setTabHeight(height)
	- desc: sets the height of the tab buttons
--]]---------------------------------------------------------
function newobject:setTabHeight(height)

	local autosize = self.autosize
	local padding = self.padding
	local previoustabheight = self.previoustabheight
	local children = self.children
	local internals = self.internals

	self.tabheight = height

	local tabheight = self.tabheight

	if tabheight ~= previoustabheight then
		for k, v in ipairs(children) do
			local retainsize = v.retainsize
			if autosize and not retainsize then
				v:setSize(self.width - padding*2, (self.height - tabheight) - padding*2)
			end
		end
		self.previoustabheight = tabheight
	end

	for k, v in ipairs(internals) do
		if v.type == "tabbutton" then
			v:setHeight(self.tabheight)
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: setToolTipFont(font)
	- desc: sets the height of the tab buttons
--]]---------------------------------------------------------
function newobject:setToolTipFont(font)

	local internals = self.internals

	for k, v in ipairs(internals) do
		if v.type == "tabbutton" and v.tooltip then
			v.tooltip:setFont(font)
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: getTabNumber()
	- desc: gets the object's tab number
--]]---------------------------------------------------------
function newobject:getTabNumber()

	return self.tab

end

--[[---------------------------------------------------------
	- func: removeTab(id)
	- desc: removes a tab from the object
--]]---------------------------------------------------------
function newobject:removeTab(id)

	local children = self.children
	local internals = self.internals
	local tab = children[id]

	if tab then
		tab:remove()
	end

	for k, v in ipairs(internals) do
		if v.type == "tabbutton" then
			if v.tabnumber == id then
				v:remove()
			end
		end
	end

	local tabnumber = 1

	for k, v in ipairs(internals) do
		if v.type == "tabbutton" then
			v.tabnumber = tabnumber
			tabnumber = tabnumber + 1
		end
	end

	self.tabnumber = tabnumber
	return self

end

--[[---------------------------------------------------------
	- func: setButtonScrollAmount(speed)
	- desc: sets the scroll amount of the object's scrollbar
			buttons
--]]---------------------------------------------------------
function newobject:setButtonScrollAmount(amount)

	self.buttonscrollamount = amount
	return self

end

--[[---------------------------------------------------------
	- func: getButtonScrollAmount()
	- desc: gets the scroll amount of the object's scrollbar
			buttons
--]]---------------------------------------------------------
function newobject:getButtonScrollAmount()

	return self.buttonscrollamount

end

--[[---------------------------------------------------------
	- func: setMouseWheelScrollAmount(amount)
	- desc: sets the scroll amount of the mouse wheel
--]]---------------------------------------------------------
function newobject:setMouseWheelScrollAmount(amount)

	self.mousewheelscrollamount = amount
	return self

end

--[[---------------------------------------------------------
	- func: getMouseWheelScrollAmount()
	- desc: gets the scroll amount of the mouse wheel
--]]---------------------------------------------------------
function newobject:getButtonScrollAmount()

	return self.mousewheelscrollamount

end

--[[---------------------------------------------------------
	- func: setDTScrolling(bool)
	- desc: sets whether or not the object should use delta
			time when scrolling
--]]---------------------------------------------------------
function newobject:setDTScrolling(bool)

	self.dtscrolling = bool
	return self

end

--[[---------------------------------------------------------
	- func: getDTScrolling()
	- desc: gets whether or not the object should use delta
			time when scrolling
--]]---------------------------------------------------------
function newobject:getDTScrolling()

	return self.dtscrolling

end

--[[---------------------------------------------------------
	- func: setTabObject(id, object)
	- desc: sets the object of a tab
--]]---------------------------------------------------------
function newobject:setTabObject(id, object)

	local children = self.children
	local internals = self.internals
	local tab = children[id]
	local state = self.state

	if tab then
		tab:remove()
		object:remove()
		object.parent = self
		object:setState(state)
		object.staticx = 0
		object.staticy = 0
		children[id] = object
	end

	return self

end

--[[---------------------------------------------------------
	- func: setButtonAreaX(x)
	- desc: sets the x position of the object's button area
--]]---------------------------------------------------------
function newobject:setButtonAreaX(x)

	self.buttonareax = x
	return self

end

--[[---------------------------------------------------------
	- func: getButtonAreaX()
	- desc: gets the x position of the object's button area
--]]---------------------------------------------------------
function newobject:getButtonAreaX()

	return self.buttonareax

end

--[[---------------------------------------------------------
	- func: setButtonAreaWidth(width)
	- desc: sets the width of the object's button area
--]]---------------------------------------------------------
function newobject:setButtonAreaWidth(width)

	self.buttonareawidth = width
	return self

end

--[[---------------------------------------------------------
	- func: getButtonAreaWidth()
	- desc: gets the width of the object's button area
--]]---------------------------------------------------------
function newobject:getButtonAreaWidth()

	return self.buttonareawidth

end

--[[---------------------------------------------------------
	- func: setAutoButtonAreaWidth(bool)
	- desc: sets whether or not the width of the object's
			button area should be adjusted automatically
--]]---------------------------------------------------------
function newobject:setAutoButtonAreaWidth(bool)

	self.autobuttonareawidth = bool
	return self

end

--[[---------------------------------------------------------
	- func: getAutoButtonAreaWidth()
	- desc: gets whether or not the width of the object's
			button area should be adjusted automatically
--]]---------------------------------------------------------
function newobject:getAutoButtonAreaWidth()

	return self.autobuttonareawidth

end

---------- module end ----------
end
