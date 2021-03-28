--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- button object
local newobject = loveframes.newObject("treenode", "loveframes_object_treenode", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()

	self.type = "treenode"
	self.text = "Node"
	self.width = 250
	self.height = 16
	self.level = 0
	self.leftpadding = 0
	self.lastclick = 0
	self.open = false
	self.internal = true
	self.internals = {}
	self.icon = nil
	self.onOpen = nil
	self.onClose = nil

	self:setDrawFunc()
end

--[[---------------------------------------------------------
	- func: update(deltatime)
	- desc: updates the object
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

	self:checkHover()

	local parent = self.parent
	local base = loveframes.base
	local update = self.update

	local tree = self.tree
	self:setClickBounds(tree.x, tree.y, tree.width, tree.height)

	for k, v in ipairs(self.internals) do
		if v.type == "treenode" then
			if self.open then
				v.x = v.tree.x - v.tree.offsetx
				v.y = (v.tree.y + self.tree.itemheight) - v.tree.offsety
				if v.width > self.tree.itemwidth then
					self.tree.itemwidth = v.width
				end
				self.tree.itemheight = self.tree.itemheight + v.height
				v:_update(dt)
			end
		else
			v:_update(dt)
		end
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

	-- set the object's draw order
	self:setDrawOrder()

	local drawfunc = self.draw or self.drawfunc
	if drawfunc then
		drawfunc(self)
	end

	local internals = self.internals
	if internals then
		for k, v in ipairs(internals) do
			if v.type == "treenode" then
				if self.open then
					v:_draw()
				end
			else
				v:_draw()
			end
		end
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

	for k, v in ipairs(self.internals) do
		v:mousepressed(x, y, button)
	end

	if self.hover and button == 1 then
		local time = os.time()
		if self.lastclick + 0.40 > time then
			self.open = not self.open
		end
		self.lastclick = time
		local onselectnode = self.tree.onSelectNode
		self.tree.selectednode = self
		if onselectnode then
			onselectnode(self.parent, self)
		end
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

	if not visible then
		return
	end

	for k, v in ipairs(self.internals) do
		v:mousereleased(x, y, button)
	end

end

--[[---------------------------------------------------------
	- func: setIcon(icon)
	- desc: sets the object's icon
--]]---------------------------------------------------------
function newobject:setIcon(icon)

	if type(icon) == "string" then
		self.icon = love.graphics.newImage(icon)
		self.icon:setFilter("nearest", "nearest")
	else
		self.icon = icon
	end

	return self

end

--[[---------------------------------------------------------
	- func: getIcon()
	- desc: gets the object's icon
--]]---------------------------------------------------------
function newobject:getIcon()

	return self.icon

end

--[[---------------------------------------------------------
	- func: setText(text)
	- desc: sets the object's text
--]]---------------------------------------------------------
function newobject:setText(text)

	self.text = text
	return self

end

--[[---------------------------------------------------------
	- func: getText()
	- desc: gets the object's text
--]]---------------------------------------------------------
function newobject:getText()

	return self.text

end

--[[---------------------------------------------------------
	- func: addNode(text)
	- desc: adds a new node to the object
--]]---------------------------------------------------------
function newobject:addNode(text)

	if not self.internals[1] then
		local openbutton = loveframes.objects["treenodebutton"]:new()
		openbutton.parent = self
		openbutton.staticx = 2
		openbutton.staticy = 2
		table.insert(self.internals, openbutton)
	end

	local node = loveframes.objects["treenode"]:new()
	node.parent = self
	node.tree = self.tree
	node.text = text
	node.level = self.level + 1
	table.insert(self.internals, node)
	return node

end

--[[---------------------------------------------------------
	- func: removeNode(id)
	- desc: removes a node from the object
--]]---------------------------------------------------------
function newobject:removeNode(id)

	id = id + 1
	for k, v in ipairs(self.internals) do
		if k == id then
			v:remove()
			break
		end
	end

end

--[[---------------------------------------------------------
	- func: setOpen(bool)
	- desc: sets whether or not the object is open
--]]---------------------------------------------------------
function newobject:setOpen(bool)

	self.open = bool
	return self

end

--[[---------------------------------------------------------
	- func: getOpen()
	- desc: gets whether or not the object is open
--]]---------------------------------------------------------
function newobject:getOpen()

	return self.open

end

---------- module end ----------
end
