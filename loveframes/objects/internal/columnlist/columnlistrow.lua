--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- columnlistrow class
local newobject = loveframes.newObject("columnlistrow", "loveframes_object_columnlistrow", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: intializes the element
--]]---------------------------------------------------------
function newobject:initialize(parent, data)

	self.type = "columnlistrow"
	self.parent = parent
	self.state = parent.state
	self.colorindex = self.parent.rowcolorindex
	self.font = loveframes.basicfontsmall
	self.width = 80
	self.height = 25
	self.textx = 5
	self.texty = 5
	self.selected = false
	self.internal = true
	self.columndata = {}
	
	for k, v in ipairs(data) do
		self.columndata[k] = tostring(v)
	end
	
	-- apply template properties to the object
	loveframes.applyTemplatesToObject(self)
	self:setDrawFunc()
end

--[[---------------------------------------------------------
	- func: update(deltatime)
	- desc: updates the object
--]]---------------------------------------------------------
function newobject:_update(dt)
	
	if not self.visible then
		if not self.alwaysupdate then
			return
		end
	end
	
	local parent = self.parent
	local update = self.update
	
	self:checkHover()
	
	-- move to parent if there is a parent
	if parent ~= loveframes.base then
		self.x = parent.x + self.staticx
		self.y = parent.y + self.staticy
	end
	
	if update then
		update(self, dt)
	end

end

--[[---------------------------------------------------------
	- func: mousepressed(x, y, button)
	- desc: called when the player presses a mouse button
--]]---------------------------------------------------------
function newobject:mousepressed(x, y, button)

	if not self.visible then
		return
	end
	
	if self.hover and button == 1 then
		local baseparent = self:getBaseParent()
		if baseparent and baseparent.type == "frame" then
			baseparent:makeTop()
		end
		self:getParent():getParent():selectRow(self, loveframes.IsCtrlDown())
	end

end

--[[---------------------------------------------------------
	- func: mousereleased(x, y, button)
	- desc: called when the player releases a mouse button
--]]---------------------------------------------------------
function newobject:mousereleased(x, y, button)

	if not self.visible then
		return
	end
	
	if self.hover then
		local parent = self:getParent():getParent()
		if button == 1 then
			local onrowclicked = parent.OnRowClicked
			if onrowclicked then
				onrowclicked(parent, self, self.columndata)
			end
		elseif button == 2 then
			local onrowrightclicked = parent.OnRowRightClicked
			if onrowrightclicked then
				onrowrightclicked(parent, self, self.columndata)
			end
		end
	end
	
end

--[[---------------------------------------------------------
	- func: setTextPosition(x, y)
	- desc: sets the positions of the object's text
--]]---------------------------------------------------------
function newobject:setTextPosition(x, y)

	self.textx = x
	self.texty = y

end

--[[---------------------------------------------------------
	- func: getTextX()
	- desc: gets the object's text x position
--]]---------------------------------------------------------
function newobject:getTextX()

	return self.textx

end

--[[---------------------------------------------------------
	- func: getTextY()
	- desc: gets the object's text y position
--]]---------------------------------------------------------
function newobject:getTextY()

	return self.texty

end

--[[---------------------------------------------------------
	- func: setFont(font)
	- desc: sets the object's font
--]]---------------------------------------------------------
function newobject:setFont(font)

	self.font = font

end

--[[---------------------------------------------------------
	- func: getFont()
	- desc: gets the object's font
--]]---------------------------------------------------------
function newobject:getFont()

	return self.font

end

--[[---------------------------------------------------------
	- func: getColorIndex()
	- desc: gets the object's color index
--]]---------------------------------------------------------
function newobject:getColorIndex()

	return self.colorindex

end

--[[---------------------------------------------------------
	- func: setColumnData(data)
	- desc: sets the object's column data
--]]---------------------------------------------------------
function newobject:setColumnData(data)

	self.columndata = data
	
end

--[[---------------------------------------------------------
	- func: getColumnData()
	- desc: gets the object's column data
--]]---------------------------------------------------------
function newobject:getColumnData()

	return self.columndata
	
end

--[[---------------------------------------------------------
	- func: setSelected(selected)
	- desc: sets whether or not the object is selected
--]]---------------------------------------------------------
function newobject:setSelected(selected)

	self.selected = true

end

--[[---------------------------------------------------------
	- func: getSelected()
	- desc: gets whether or not the object is selected
--]]---------------------------------------------------------
function newobject:getSelected()

	return self.selected
	
end

---------- module end ----------
end
