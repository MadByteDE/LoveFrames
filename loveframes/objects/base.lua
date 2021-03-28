--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- base object
local newobject = loveframes.newObject("base", "loveframes_object_base")

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the element
--]]---------------------------------------------------------
function newobject:initialize()
	self.type = "base"
	self.width, self.height = love.graphics.getDimensions()
	self.internal = true
	self.children = {}
	self.internals = {}

end

--[[---------------------------------------------------------
	- func: update(deltatime)
	- desc: updates the object
--]]---------------------------------------------------------
function newobject:_update(dt)
	if loveframes.state ~= self.state then
		return
	end

	local width, height = love.graphics.getDimensions()

	if self.width ~= width then
		self.width = width
	end

	if self.height ~= height then
		self.height = height
	end

	local children = self.children
	if children then
		for k, v in ipairs(children) do
			v:_update(dt)
		end
	end

	local internals = self.internals
	if internals then
		for k, v in ipairs(internals) do
			v:_update(dt)
		end
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

	self:setDrawOrder()

	local drawfunc = self.draw or self.drawfunc
	if drawfunc then
		drawfunc(self)
	end

	local children = self.children
	if children then
		for k, v in ipairs(children) do
			v:_draw()
		end
	end

	local internals = self.internals
	if internals then
		for k, v in ipairs(internals) do
			v:_draw()
		end
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
	if loveframes.state ~= self.state then
		return
	end

	if not self.visible then
		return
	end

	local children = self.children
	if children then
		for k, v in ipairs(children) do
			v:mousepressed(x, y, button)
		end
	end

	local internals = self.internals
	if internals then
		for k, v in ipairs(internals) do
			v:mousepressed(x, y, button)
		end
	end
end

--[[---------------------------------------------------------
	- func: mousereleased(x, y, button)
	- desc: called when the player releases a mouse button
--]]---------------------------------------------------------
function newobject:mousereleased(x, y, button)
	if loveframes.state ~= self.state then
		return
	end

	if not self.visible then
		return
	end

	local children = self.children
	if children then
		for k, v in ipairs(children) do
			v:mousereleased(x, y, button)
		end
	end

	local internals = self.internals
	if internals then
		for k, v in ipairs(internals) do
			v:mousereleased(x, y, button)
		end
	end
end

--[[---------------------------------------------------------
	- func: wheelmoved(x, y)
	- desc: called when the player moves a mouse wheel
--]]---------------------------------------------------------
function newobject:wheelmoved(x, y)
	if loveframes.state ~= self.state then
		return
	end

	if not self.visible then
		return
	end

	local children = self.children
	if children then
		for k, v in ipairs(children) do
			v:wheelmoved(x, y)
		end
	end

	local internals = self.internals
	if internals then
		for k, v in ipairs(internals) do
			v:wheelmoved(x, y)
		end
	end
end

--[[---------------------------------------------------------
	- func: keypressed(key, isrepeat)
	- desc: called when the player presses a key
--]]---------------------------------------------------------
function newobject:keypressed(key, isrepeat)
	if loveframes.state ~= self.state then
		return
	end

	if not self.visible then
		return
	end

	local children = self.children
	if children then
		for k, v in ipairs(children) do
			v:keypressed(key, isrepeat)
		end
	end

	local internals = self.internals
	if internals then
		for k, v in ipairs(internals) do
			v:keypressed(key, isrepeat)
		end
	end
end

--[[---------------------------------------------------------
	- func: keyreleased(key)
	- desc: called when the player releases a key
--]]---------------------------------------------------------
function newobject:keyreleased(key)
	if loveframes.state ~= self.state then
		return
	end

	if not self.visible then
		return
	end

	local children = self.children
	if children then
		for k, v in ipairs(children) do
			v:keyreleased(key)
		end
	end

	local internals = self.internals
	if internals then
		for k, v in ipairs(internals) do
			v:keyreleased(key)
		end
	end
end


--[[---------------------------------------------------------
	- func: textinput(text)
	- desc: called when the user inputs text
--]]---------------------------------------------------------
function newobject:textinput(text)
	if loveframes.state ~= self.state then
		return
	end

	if not self.visible then
		return
	end

	local children = self.children
	if children then
		for k, v in ipairs(children) do
			v:textinput(text)
		end
	end

	local internals = self.internals
	if internals then
		for k, v in ipairs(internals) do
			v:textinput(text)
		end
	end
end


--[[---------------------------------------------------------
	- func: setPosition(x, y, center)
	- desc: sets the object's position
--]]---------------------------------------------------------
function newobject:setPosition(x, y, center)

	local base = loveframes.base
	local parent = self.parent

	if center then
		local width = self.width
		local height = self.height
		x = x - width/2
		y = y - height/2
	end

	if parent == base then
		self.x = x
		self.y = y
	else
		self.staticx = x
		self.staticy = y
	end

	return self

end

--[[---------------------------------------------------------
	- func: setX(x, center)
	- desc: sets the object's x position
--]]---------------------------------------------------------
function newobject:setX(x, center)

	local base = loveframes.base
	local parent = self.parent

	if center then
		local width = self.width
		x = x - width/2
	end

	if parent == base then
		self.x = x
	else
		self.staticx = x
	end

	return self

end

--[[---------------------------------------------------------
	- func: setY(y, center)
	- desc: sets the object's y position
--]]---------------------------------------------------------
function newobject:setY(y, center)

	local base = loveframes.base
	local parent = self.parent

	if center then
		local height = self.height
		y = y - height/2
	end

	if parent == base then
		self.y = y
	else
		self.staticy = y
	end

	return self

end

--[[---------------------------------------------------------
	- func: getPosition()
	- desc: gets the object's position
--]]---------------------------------------------------------
function newobject:getPosition()

	return self.x, self.y

end

--[[---------------------------------------------------------
	- func: getX()
	- desc: gets the object's x position
--]]---------------------------------------------------------
function newobject:getX()

	return self.x

end

--[[---------------------------------------------------------
	- func: getY()
	- desc: gets the object's y position
--]]---------------------------------------------------------
function newobject:getY()

	return self.y

end

--[[---------------------------------------------------------
	- func: getStaticPosition()
	- desc: gets the object's static position
--]]---------------------------------------------------------
function newobject:getStaticPosition()

	return self.staticx, self.staticy

end

--[[---------------------------------------------------------
	- func: getStaticX()
	- desc: gets the object's static x position
--]]---------------------------------------------------------
function newobject:getStaticX()

	return self.staticx

end

--[[---------------------------------------------------------
	- func: getStaticY()
	- desc: gets the object's static y position
--]]---------------------------------------------------------
function newobject:getStaticY()

	return self.staticy

end

--[[---------------------------------------------------------
	- func: center()
	- desc: centers the object in the game window or in
			its parent if it has one
--]]---------------------------------------------------------
function newobject:center()

	local base = loveframes.base
	local parent = self.parent

	if parent == base then
		local width = love.graphics.getWidth()
		local height = love.graphics.getHeight()
		self.x = width/2 - self.width * (self.scalex or 1)/2
		self.y = height/2 - self.height * (self.scaley or 1)/2
	else
		local width = parent.width
		local height = parent.height
		self.staticx = width/2 - self.width * (self.scalex or 1)/2
		self.staticy = height/2 - self.height * (self.scaley or 1)/2
	end

	return self

end

--[[---------------------------------------------------------
	- func: centerX()
	- desc: centers the object by its x value
--]]---------------------------------------------------------
function newobject:centerX()

	local base = loveframes.base
	local parent = self.parent

	if parent == base then
		local width = love.graphics.getWidth()
		self.x = width/2 - self.width * (self.scalex or 1)/2
	else
		local width = parent.width
		self.staticx = width/2 - self.width * (self.scalex or 1)/2
	end

	return self

end

--[[---------------------------------------------------------
	- func: centerY()
	- desc: centers the object by its y value
--]]---------------------------------------------------------
function newobject:centerY()

	local base = loveframes.base
	local parent = self.parent

	if parent == base then
		local height = love.graphics.getHeight()
		self.y = height/2 - self.height * (self.scaley or 1)/2
	else
		local height = parent.height
		self.staticy = height/2 - self.height * (self.scaley or 1)/2
	end

	return self

end

--[[---------------------------------------------------------
	- func: centerWithinArea()
	- desc: centers the object within the given area
--]]---------------------------------------------------------
function newobject:centerWithinArea(x, y, width, height)

	local selfwidth = self.width
	local selfheight = self.height

	self.x = x + width/2 - selfwidth/2
	self.y = y + height/2 - selfheight/2

	return self

end

--[[---------------------------------------------------------
	- func: setSize(width, height, r1, r2)
	- desc: sets the object's size
--]]---------------------------------------------------------
function newobject:setSize(width, height, r1, r2)

	if r1 then
		self.width = self.parent.width * width
	else
		self.width = width
	end

	if r2 then
		self.height = self.parent.height * height
	else
		self.height = height
	end

	return self

end

--[[---------------------------------------------------------
	- func: setWidth(width, relative)
	- desc: sets the object's width
--]]---------------------------------------------------------
function newobject:setWidth(width, relative)

	if relative then
		self.width = self.parent.width * width
	else
		self.width = width
	end

	return self

end

--[[---------------------------------------------------------
	- func: setHeight(height, relative)
	- desc: sets the object's height
--]]---------------------------------------------------------
function newobject:setHeight(height, relative)

	if relative then
		self.height = self.parent.height * height
	else
		self.height = height
	end

	return self

end

--[[---------------------------------------------------------
	- func: getSize()
	- desc: gets the object's size
--]]---------------------------------------------------------
function newobject:getSize()

	return self.width, self.height

end

--[[---------------------------------------------------------
	- func: getWidth()
	- desc: gets the object's width
--]]---------------------------------------------------------
function newobject:getWidth()

	return self.width

end

--[[---------------------------------------------------------
	- func: getHeight()
	- desc: gets the object's height
--]]---------------------------------------------------------
function newobject:getHeight()

	return self.height

end

--[[---------------------------------------------------------
	- func: setVisible(bool)
	- desc: sets the object's visibility
--]]---------------------------------------------------------
function newobject:setVisible(bool)

	local children = self.children
	local internals = self.internals

	self.visible = bool

	if children then
		for k, v in ipairs(children) do
			v:setVisible(bool)
		end
	end

	if internals then
		for k, v in ipairs(internals) do
			v:setVisible(bool)
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: getVisible()
	- desc: gets the object's visibility
--]]---------------------------------------------------------
function newobject:getVisible()

	return self.visible

end

--[[---------------------------------------------------------
	- func: setParent(parent)
	- desc: sets the object's parent
--]]---------------------------------------------------------
function newobject:setParent(parent)

	local tparent = parent
	local cparent = self.parent
	local ptype = tparent.type
	local stype = self.type

	if ptype ~= "frame" and ptype ~= "panel" and ptype ~= "list" then
		return
	end

	self:remove()
	self.parent = tparent
	self:setState(tparent.state)

	table.insert(tparent.children, self)
	return self

end

--[[---------------------------------------------------------
	- func: getParent()
	- desc: gets the object's parent
--]]---------------------------------------------------------
function newobject:getParent()

	local parent = self.parent
	return parent

end

--[[---------------------------------------------------------
	- func: remove()
	- desc: removes the object
--]]---------------------------------------------------------
function newobject:remove()

	local pinternals = self.parent.internals
	local pchildren = self.parent.children

	if pinternals then
		for k, v in ipairs(pinternals) do
			if v == self then
				table.remove(pinternals, k)
			end
		end
	end

	if pchildren then
		for k, v in ipairs(pchildren) do
			if v == self then
				table.remove(pchildren, k)
			end
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: setClickBounds(x, y, width, height)
	- desc: sets a boundary box for the object's collision
			detection
--]]---------------------------------------------------------
function newobject:setClickBounds(x, y, width, height)

	local internals = self.internals
	local children = self.children

	self.clickbounds = {x = x, y = y, width = width, height = height}

	if internals then
		for k, v in ipairs(internals) do
			v:setClickBounds(x, y, width, height)
		end
	end

	if children then
		for k, v in ipairs(children) do
			v:setClickBounds(x, y, width, height)
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: getClickBounds()
	- desc: gets the boundary box for the object's collision
			detection
--]]---------------------------------------------------------
function newobject:getClickBounds()

	return self.clickbounds

end

--[[---------------------------------------------------------
	- func: removeClickBounds()
	- desc: removes the collision detection boundary for the
			object
--]]---------------------------------------------------------
function newobject:removeClickBounds()

	local internals = self.internals
	local children = self.children

	self.clickbounds = nil

	if internals then
		for k, v in ipairs(internals) do
			v:removeClickBounds()
		end
	end

	if children then
		for k, v in ipairs(children) do
			v:removeClickBounds()
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: inClickBounds()
	- desc: checks if the mouse is inside the object's
			collision detection boundaries
--]]---------------------------------------------------------
function newobject:inClickBounds()

	local x, y = love.mouse.getPosition()
	local bounds = self.clickbounds

	if bounds then
		local col = loveframes.boundingBox(x, bounds.x, y, bounds.y, 1, bounds.width, 1, bounds.height)
		return col
	else
		return false
	end

	return self

end

--[[---------------------------------------------------------
	- func: getBaseParent(object, t)
	- desc: finds the object's base parent
--]]---------------------------------------------------------
function newobject:getBaseParent(t)

	local t = t or {}
	local base = loveframes.base
	local parent = self.parent

	if parent ~= base then
		table.insert(t, parent)
		parent:getBaseParent(t)
	end

	return t[#t]

end

--[[---------------------------------------------------------
	- func: checkHover()
	- desc: checks to see if the object should be in a
			hover state
--]]---------------------------------------------------------
function newobject:checkHover()

	local x = self.x
	local y = self.y
	local width = self.width
	local height = self.height
	local mx, my = love.mouse.getPosition()
	local selfcol = loveframes.boundingBox(mx, x, my, y, 1, width, 1, height)
	local collisioncount = loveframes.collisioncount
	local curstate = loveframes.state
	local state = self.state
	local visible = self.visible
	local type = self.type
	local hoverobject = loveframes.hoverobject

	-- check if the mouse is colliding with the object
	if state == curstate and visible then
		local collide = self.collide
		if selfcol and collide then
			loveframes.collisioncount = collisioncount + 1
			local clickbounds = self.clickbounds
			if clickbounds then
				local cx = clickbounds.x
				local cy = clickbounds.y
				local cwidth = clickbounds.width
				local cheight = clickbounds.height
				local clickcol = loveframes.boundingBox(mx, cx, my, cy, 1, cwidth, 1, cheight)
				if clickcol then
					table.insert(loveframes.collisions, self)
				end
			else
				table.insert(loveframes.collisions, self)
			end
		end
	end

	-- check if the object is being hovered
	if hoverobject == self and type ~= "base" then
		self.hover = true
	else
		self.hover = false
	end

	local hover = self.hover
	local calledmousefunc = self.calledmousefunc

	-- check for mouse enter and exit events
	if hover then
		loveframes.hover = true
		if not calledmousefunc then
			local on_mouse_enter = self.onMouseEnter
			if on_mouse_enter then
				on_mouse_enter(self)
				self.calledmousefunc = true
			else
				self.calledmousefunc = true
			end
		end
	else
		if calledmousefunc then
			local on_mouse_exit = self.onMouseExit
			if on_mouse_exit then
				on_mouse_exit(self)
				self.calledmousefunc = false
			else
				self.calledmousefunc = false
			end
		end
	end

end

--[[---------------------------------------------------------
	- func: getHover()
	- desc: return if the object is in a hover state or not
--]]---------------------------------------------------------
function newobject:getHover()

	return self.hover

end

--[[---------------------------------------------------------
	- func: getChildren()
	- desc: returns the object's children
--]]---------------------------------------------------------
function newobject:getChildren()

	local children = self.children

	if children then
		return children
	end

end

--[[---------------------------------------------------------
	- func: getInternals()
	- desc: returns the object's internals
--]]---------------------------------------------------------
function newobject:getInternals()

	local internals = self.internals

	if internals then
		return internals
	end

end


--[[---------------------------------------------------------
	- func: isTopList()
	- desc: returns true if the object is the top most list
			object or false if not
--]]---------------------------------------------------------
function newobject:isTopList()

	local cols = loveframes.getCollisions()
	local children = self:getChildren()
	local order = self.draworder
	local top = true
	local found = false

	local function isChild(object)
		local parents = object:getParents()
		for k, v in ipairs(parents) do
			if v == self then
				return true
			end
		end
		return false
	end

	for k, v in ipairs(cols) do
		if v == self then
			found = true
		else
			if v.draworder > order then
				if isChild(v) ~= true then
					top = false
					break
				end
			end
		end
	end

	if found == false then
		top = false
	end

	return top

end

--[[---------------------------------------------------------
	- func: isTopChild()
	- desc: returns true if the object is the top most child
			in its parent's children table or false if not
--]]---------------------------------------------------------
function newobject:isTopChild()

	local children = self.parent.children
	local num = #children

	if children[num] == self then
		return true
	else
		return false
	end

end

--[[---------------------------------------------------------
	- func: moveToTop()
	- desc: moves the object to the top of its parent's
			children table
--]]---------------------------------------------------------
function newobject:moveToTop()

	local pchildren = self.parent.children
	local pinternals = self.parent.internals

	local internal = false

	if pinternals then
		for k, v in ipairs(pinternals) do
			if v == self then
				internal = true
			end
		end
	end

	self:remove()

	if internal then
		table.insert(pinternals, self)
	else
		table.insert(pchildren, self)
	end

	return self

end

--[[---------------------------------------------------------
	- func: setDrawFunc()
	- desc: sets the objects skin based draw function
--]]---------------------------------------------------------
function newobject:setDrawFunc()
	local skins = loveframes.skins
	local activeskin  = skins[loveframes.config["ACTIVESKIN"]]
	--local defaultskin = skins[loveframes.config["DEFAULTSKIN"]]

	local funcname = self.type
	self.drawfunc = activeskin[funcname] -- or defaultskin[funcname]

	funcname = self.type .. "_over"
	self.drawoverfunc = activeskin[funcname] -- or defaultskin[funcname]
end

--[[---------------------------------------------------------
	- func: setSkin(name)
	- desc: sets the object's skin
--]]---------------------------------------------------------
function newobject:setSkin(name)

	local children = self.children
	local internals = self.internals

	self.skin = name

	local selfskin = loveframes.skins[name]

	local funcname = self.type

	self.drawfunc = selfskin[funcname]
	self.drawoverfunc = selfskin[funcname.."_over"]

	if children then
		for k, v in ipairs(children) do
			v:setSkin(name)
		end
	end

	if internals then
		for k, v in ipairs(internals) do
			v:setSkin(name)
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: getSkin()
	- desc: gets the object's skin
--]]---------------------------------------------------------
function newobject:getSkin()

	local skins = loveframes.skins
	local skinindex = loveframes.config["ACTIVESKIN"]
	local defaultskin = loveframes.config["DEFAULTSKIN"]
	local selfskin = self.skin
	local skin = skins[selfskin] or skins[skinindex]

	return skin

end

--[[---------------------------------------------------------
	- func: getSkinName()
	- desc: gets the name of the object's skin
--]]---------------------------------------------------------
function newobject:getSkinName()

	return self.skin

end

--[[---------------------------------------------------------
	- func: setAlwaysUpdate(bool)
	- desc: sets the object's skin
--]]---------------------------------------------------------
function newobject:setAlwaysUpdate(bool)

	self.alwaysupdate = bool
	return self

end

--[[---------------------------------------------------------
	- func: getAlwaysUpdate()
	- desc: gets whether or not the object will always update
--]]---------------------------------------------------------
function newobject:getAlwaysUpdate()

	return self.alwaysupdate

end

--[[---------------------------------------------------------
	- func: setRetainSize(bool)
	- desc: sets whether or not the object should retain its
			size when another object tries to resize it
--]]---------------------------------------------------------
function newobject:setRetainSize(bool)

	self.retainsize = bool
	return self

end

--[[---------------------------------------------------------
	- func: getRetainSize()
	- desc: gets whether or not the object should retain its
			size when another object tries to resize it
--]]---------------------------------------------------------
function newobject:getRetainSize()

	return self.retainsize

end

--[[---------------------------------------------------------
	- func: isActive()
	- desc: gets whether or not the object is active within
			its parent's child table
--]]---------------------------------------------------------
function newobject:isActive()

	local parent = self.parent
	local pchildren = parent.children
	local valid = false

	for k, v in ipairs(pchildren) do
		if v == self then
			valid = true
		end
	end

	return valid

end

--[[---------------------------------------------------------
	- func: getParents()
	- desc: returns a table of the object's parents and its
			sub-parents
--]]---------------------------------------------------------
function newobject:getParents()

	local function getParents(object, t)
		local t = t or {}
		local type = object.type
		local parent = object.parent
		if type ~= "base" then
			table.insert(t, parent)
			getParents(parent, t)
		end
		return t
	end

	local parents = getParents(self)
	return parents

end

--[[---------------------------------------------------------
	- func: isTopInternal()
	- desc: returns true if the object is the top most
			internal in its parent's internals table or
			false if not
--]]---------------------------------------------------------
function newobject:isTopInternal()

	local parent = self.parent
	local internals = parent.internals
	local topitem = internals[#internals]

	if topitem ~= self then
		return false
	else
		return true
	end

end

--[[---------------------------------------------------------
	- func: isInternal()
	- desc: returns true if the object is internal or
			false if not
--]]---------------------------------------------------------
function newobject:isInternal()

	return self.internal

end

--[[---------------------------------------------------------
	- func: getType()
	- desc: gets the type of the object
--]]---------------------------------------------------------
function newobject:getType()

	return self.type

end

--[[---------------------------------------------------------
	- func: setDrawOrder()
	- desc: sets the object's draw order
--]]---------------------------------------------------------
function newobject:setDrawOrder()

	loveframes.drawcount = loveframes.drawcount + 1
	self.draworder = loveframes.drawcount
	return self

end

--[[---------------------------------------------------------
	- func: getDrawOrder()
	- desc: sets the object's draw order
--]]---------------------------------------------------------
function newobject:getDrawOrder()

	return self.draworder

end

--[[---------------------------------------------------------
	- func: setProperty(name, value)
	- desc: sets a property on the object
--]]---------------------------------------------------------
function newobject:setProperty(name, value)

	self[name] = value
	return self

end

--[[---------------------------------------------------------
	- func: getProperty(name)
	- desc: gets the value of an object's property
--]]---------------------------------------------------------
function newobject:getProperty(name)

	return self[name]

end

--[[---------------------------------------------------------
	- func: isInList()
	- desc: checks to see if an object is in a list
--]]---------------------------------------------------------
function newobject:isInList()

	local parents = self:getParents()

	for k, v in ipairs(parents) do
		if v.type == "list" then
			return true, v
		end
	end

	return false, false

end

--[[---------------------------------------------------------
	- func: setState(name)
	- desc: sets the object's state
--]]---------------------------------------------------------
function newobject:setState(name)

	local children = self.children
	local internals = self.internals

	self.state = name

	if children then
		for k, v in ipairs(children) do
			v:setState(name)
		end
	end

	if internals then
		for k, v in ipairs(internals) do
			v:setState(name)
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: getState()
	- desc: gets the object's state
--]]---------------------------------------------------------
function newobject:getState()

	return self.state

end

---------- module end ----------
end
