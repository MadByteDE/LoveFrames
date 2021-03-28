--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- columnlist object
local newobject = loveframes.newObject("columnlist", "loveframes_object_columnlist", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: intializes the element
--]]---------------------------------------------------------
function newobject:initialize()

	self.type = "columnlist"
	self.width = 300
	self.height = 100
	self.defaultcolumnwidth = 100
	self.columnheight = 16
	self.buttonscrollamount = 200
	self.mousewheelscrollamount = 1500
	self.autoscroll = false
	self.dtscrolling = true
	self.internal = false
	self.selectionenabled = true
	self.multiselect = false
	self.startadjustment = false
	self.canresizecolumns = true
	self.children = {}
	self.internals = {}
	self.resizecolumn = nil
	self.OnRowClicked = nil
	self.OnRowRightClicked = nil
	self.onRowSelected = nil
	self.onScroll = nil

	local list = loveframes.objects["columnlistarea"]:new(self)
	table.insert(self.internals, list)

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

	local parent = self.parent
	local base = loveframes.base
	local children = self.children
	local internals = self.internals
	local update = self.update

	self:checkHover()

	-- move to parent if there is a parent
	if parent ~= base then
		self.x = self.parent.x + self.staticx
		self.y = self.parent.y + self.staticy
	end

	for k, v in ipairs(internals) do
		v:_update(dt)
	end

	for k, v in ipairs(children) do
		v.columnid = k
		v:_update(dt)
	end

	self.startadjustment = false

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

	local vbody = self.internals[1]:getVerticalScrollBody()
	local hbody = self.internals[1]:getHorizontalScrollBody()
	local width = self.width
	local height = self.height

	if vbody then
		width = width - vbody.width
	end

	if hbody then
		height = height - hbody.height
	end

	local stencilfunc = function()
		love.graphics.rectangle("fill", self.x, self.y, width, height)
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
			v:_draw()
		end
	end

	love.graphics.stencil(stencilfunc)
	love.graphics.setStencilTest("greater", 0)

	local children = self.children
	if children then
		for k, v in ipairs(children) do
			v:_draw()
		end
	end

	local drawfunc = self.drawOver or self.drawoverfunc
	if drawfunc then
		drawfunc(self)
	end
	love.graphics.setStencilTest()

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

	local hover = self.hover
	local children  = self.children
	local internals = self.internals

	if hover and button == 1 then
		local baseparent = self:getBaseParent()
		if baseparent and baseparent.type == "frame" then
			baseparent:makeTop()
		end
	end

	for k, v in ipairs(internals) do
		v:mousepressed(x, y, button)
	end

	for k, v in ipairs(children) do
		v:mousepressed(x, y, button)
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

	local children = self.children
	local internals = self.internals

	for k, v in ipairs(internals) do
		v:mousereleased(x, y, button)
	end

	for k, v in ipairs(children) do
		v:mousereleased(x, y, button)
	end

end

--[[---------------------------------------------------------
	- func: positionColumns()
	- desc: positions the object's columns
--]]---------------------------------------------------------
function newobject:positionColumns()

	local x = 0

	for k, v in ipairs(self.children) do
		v:setPosition(x, 0)
		x = x + v.width
	end

	return self

end

--[[---------------------------------------------------------
	- func: addColumn(name)
	- desc: gives the object a new column with the specified
			name
--]]---------------------------------------------------------
function newobject:addColumn(name)

	local internals = self.internals
	local list = internals[1]
	local width = self.width
	local height = self.height

	loveframes.objects["columnlistheader"]:new(name, self)
	self:positionColumns()

	list:setSize(width, height)
	list:setPosition(0, 0)

	return self

end

--[[---------------------------------------------------------
	- func: addRow(...)
	- desc: adds a row of data to the object's list
--]]---------------------------------------------------------
function newobject:addRow(...)

	local arg = {...}
	local internals = self.internals
	local list = internals[1]

	list:addRow(arg)
	return self

end

--[[---------------------------------------------------------
	- func: getchildrenize()
	- desc: gets the size of the object's children
--]]---------------------------------------------------------
function newobject:getColumnSize()

	local children = self.children
	local numchildren = #self.children

	if numchildren > 0 then
		local column    = self.children[1]
		local colwidth  = column.width
		local colheight = column.height
		return colwidth, colheight
	else
		return 0, 0
	end

end

--[[---------------------------------------------------------
	- func: setSize(width, height, r1, r2)
	- desc: sets the object's size
--]]---------------------------------------------------------
function newobject:setSize(width, height, r1, r2)

	local internals = self.internals
	local list = internals[1]

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

	self:positionColumns()

	list:setSize(width, height)
	list:setPosition(0, 0)
	list:calculateSize()
	list:redoLayout()

	return self

end

--[[---------------------------------------------------------
	- func: setWidth(width, relative)
	- desc: sets the object's width
--]]---------------------------------------------------------
function newobject:setWidth(width, relative)

	local internals = self.internals
	local list = internals[1]

	if relative then
		self.width = self.parent.width * width
	else
		self.width = width
	end

	self:positionColumns()

	list:setSize(width)
	list:setPosition(0, 0)
	list:calculateSize()
	list:redoLayout()

	return self

end

--[[---------------------------------------------------------
	- func: setHeight(height, relative)
	- desc: sets the object's height
--]]---------------------------------------------------------
function newobject:setHeight(height, relative)

	local internals = self.internals
	local list = internals[1]

	if relative then
		self.height = self.parent.height * height
	else
		self.height = height
	end

	self:positionColumns()

	list:setSize(height)
	list:setPosition(0, 0)
	list:calculateSize()
	list:redoLayout()

	return self

end

--[[---------------------------------------------------------
	- func: setMaxColorIndex(num)
	- desc: sets the object's max color index for
			alternating row colors
--]]---------------------------------------------------------
function newobject:setMaxColorIndex(num)

	local internals = self.internals
	local list = internals[1]

	list.colorindexmax = num
	return self

end

--[[---------------------------------------------------------
	- func: clear()
	- desc: removes all items from the object's list
--]]---------------------------------------------------------
function newobject:clear()

	local internals = self.internals
	local list = internals[1]

	list:clear()
	return self

end

--[[---------------------------------------------------------
	- func: setAutoScroll(bool)
	- desc: sets whether or not the list's scrollbar should
			auto scroll to the bottom when a new object is
			added to the list
--]]---------------------------------------------------------
function newobject:setAutoScroll(bool)

	local internals = self.internals
	local list = internals[1]
	local scrollbar = list:getScrollBar()

	self.autoscroll = bool

	if list then
		if scrollbar then
			scrollbar.autoscroll = bool
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: setButtonScrollAmount(speed)
	- desc: sets the scroll amount of the object's scrollbar
			buttons
--]]---------------------------------------------------------
function newobject:setButtonScrollAmount(amount)

	self.buttonscrollamount = amount
	self.internals[1].buttonscrollamount = amount
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
	self.internals[1].mousewheelscrollamount = amount
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
	- func: setColumnHeight(height)
	- desc: sets the height of the object's columns
--]]---------------------------------------------------------
function newobject:setColumnHeight(height)

	local children = self.children
	local internals = self.internals
	local list = internals[1]

	self.columnheight = height

	for k, v in ipairs(children) do
		v:setHeight(height)
	end

	list:calculateSize()
	list:redoLayout()
	return self

end

--[[---------------------------------------------------------
	- func: setDTScrolling(bool)
	- desc: sets whether or not the object should use delta
			time when scrolling
--]]---------------------------------------------------------
function newobject:setDTScrolling(bool)

	self.dtscrolling = bool
	self.internals[1].dtscrolling = bool
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
	- func: selectRow(row, ctrl)
	- desc: selects the specfied row in the object's list
			of rows
--]]---------------------------------------------------------
function newobject:selectRow(row, ctrl)

	local selectionenabled = self.selectionenabled

	if not selectionenabled then
		return
	end

	local list = self.internals[1]
	local children = list.children
	local multiselect = self.multiselect
	local onrowselected = self.onRowSelected

	for k, v in ipairs(children) do
		if v == row then
			if v.selected and ctrl then
				v.selected = false
			else
				v.selected = true
				if onrowselected then
					onrowselected(self, row, row:getColumnData())
				end
			end
		elseif v ~= row then
			if not (multiselect and ctrl) then
				v.selected = false
			end
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: deselectRow(row)
	- desc: deselects the specfied row in the object's list
			of rows
--]]---------------------------------------------------------
function newobject:deselectRow(row)

	row.selected = false
	return self

end

--[[---------------------------------------------------------
	- func: getSelectedRows()
	- desc: gets the object's selected rows
--]]---------------------------------------------------------
function newobject:getSelectedRows()

	local rows = {}
	local list = self.internals[1]
	local children = list.children

	for k, v in ipairs(children) do
		if v.selected then
			table.insert(rows, v)
		end
	end

	return rows

end

--[[---------------------------------------------------------
	- func: setSelectionEnabled(bool)
	- desc: sets whether or not the object's rows can be
			selected
--]]---------------------------------------------------------
function newobject:setSelectionEnabled(bool)

	self.selectionenabled = bool
	return self

end

--[[---------------------------------------------------------
	- func: getSelectionEnabled()
	- desc: gets whether or not the object's rows can be
			selected
--]]---------------------------------------------------------
function newobject:getSelectionEnabled()

	return self.selectionenabled

end

--[[---------------------------------------------------------
	- func: setMultiselectEnabled(bool)
	- desc: sets whether or not the object can have more
			than one row selected
--]]---------------------------------------------------------
function newobject:setMultiselectEnabled(bool)

	self.multiselect = bool
	return self

end

--[[---------------------------------------------------------
	- func: getMultiselectEnabled()
	- desc: gets whether or not the object can have more
			than one row selected
--]]---------------------------------------------------------
function newobject:getMultiselectEnabled()

	return self.multiselect

end

--[[---------------------------------------------------------
	- func: removeColumn(id)
	- desc: removes a column
--]]---------------------------------------------------------
function newobject:removeColumn(id)

	local children = self.children

	for k, v in ipairs(children) do
		if k == id then
			v:remove()
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: setColumnName(id, name)
	- desc: sets a column's name
--]]---------------------------------------------------------
function newobject:setColumnName(id, name)

	local children = self.children

	for k, v in ipairs(children) do
		if k == id then
			v.name = name
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: getColumnName(id)
	- desc: gets a column's name
--]]---------------------------------------------------------
function newobject:getColumnName(id)

	local children = self.children

	for k, v in ipairs(children) do
		if k == id then
			return v.name
		end
	end

	return false

end

--[[---------------------------------------------------------
	- func: sizeToChildren(max)
	- desc: sizes the object to match the combined height
			of its children
	- note: Credit to retupmoc258, the original author of
			this method. This version has a few slight
			modifications.
--]]---------------------------------------------------------
function newobject:sizeToChildren(max)

	local oldheight = self.height
	local list = self.internals[1]
	local listchildren = list.children
	local children = self.children
	local width = self.width
	local buf = children[1].height
	local h = listchildren[1].height
	local c = #listchildren
	local height = buf + h*c

	if max then
		height = math.min(max, oldheight)
	end

	self:setSize(width, height)
	self:positionColumns()
	return self

end

--[[---------------------------------------------------------
	- func: removeRow(id)
	- desc: removes a row from the object's list
--]]---------------------------------------------------------
function newobject:removeRow(id)

	local list = self.internals[1]
	local listchildren = list.children
	local row = listchildren[id]

	if row then
		row:remove()
	end

	list:calculateSize()
	list:redoLayout()
	return self

end

--[[---------------------------------------------------------
	- func: setCellText(text, rowid, columnid)
	- desc: sets a cell's text
--]]---------------------------------------------------------
function newobject:setCellText(text, rowid, columnid)

	local list = self.internals[1]
	local listchildren = list.children
	local row = listchildren[rowid]

	if row and row.columndata[columnid]then
		row.columndata[columnid] = text
	end

	return self

end

--[[---------------------------------------------------------
	- func: getCellText(rowid, columnid)
	- desc: gets a cell's text
--]]---------------------------------------------------------
function newobject:getCellText(rowid, columnid)

	local row = self.internals[1].children[rowid]

	if row and row.columndata[columnid] then
		return row.columndata[columnid]
	else
		return false
	end

end

--[[---------------------------------------------------------
	- func: setRowColumnData(rowid, columndata)
	- desc: sets the columndata of the specified row
--]]---------------------------------------------------------
function newobject:setRowColumnData(rowid, columndata)

	local list = self.internals[1]
	local listchildren = list.children
	local row = listchildren[rowid]

	if row then
		for k, v in ipairs(columndata) do
			row.columndata[k] = tostring(v)
		end
	end

	return self

end

--[[---------------------------------------------------------
	- func: getTotalColumnWidth()
	- desc: gets the combined width of the object's columns
--]]---------------------------------------------------------
function newobject:getTotalColumnWidth()

	local width = 0

	for k, v in ipairs(self.children) do
		width = width + v.width
	end

	return width

end

--[[---------------------------------------------------------
	- func: setColumnWidth(id, width)
	- desc: sets the width of the specified column
--]]---------------------------------------------------------
function newobject:setColumnWidth(id, width)

	local column = self.children[id]
	if column then
		column.width = width
		local x = 0
		for k, v in ipairs(self.children) do
			v:setPosition(x)
			x = x + v.width
		end
		self.internals[1]:calculateSize()
		self.internals[1]:redoLayout()
	end

	return self

end

--[[---------------------------------------------------------
	- func: getColumnWidth(id)
	- desc: gets the width of the specified column
--]]---------------------------------------------------------
function newobject:getColumnWidth(id)

	local column = self.children[id]
	if column then
		return column.width
	end

	return false

end

--[[---------------------------------------------------------
	- func: resizeColumns()
	- desc: resizes the object's columns to fit within the
	        width of the object's list area
--]]---------------------------------------------------------
function newobject:resizeColumns()

	local children = self.children
	local width = 0
	local vbody = self.internals[1]:getVerticalScrollBody()

	if vbody then
		width = (self:getWidth() - vbody:getWidth())/#children
	else
		width = self:getWidth()/#children
	end

	for k, v in ipairs(children) do
		v:setWidth(width)
		self:positionColumns()
		self.internals[1]:calculateSize()
		self.internals[1]:redoLayout()
	end

	return self

end

--[[---------------------------------------------------------
	- func: setDefaultColumnWidth(width)
	- desc: sets the object's default column width
--]]---------------------------------------------------------
function newobject:setDefaultColumnWidth(width)

	self.defaultcolumnwidth = width
	return self

end

--[[---------------------------------------------------------
	- func: getDefaultColumnWidth()
	- desc: gets the object's default column width
--]]---------------------------------------------------------
function newobject:getDefaultColumnWidth()

	return self.defaultcolumnwidth

end

--[[---------------------------------------------------------
	- func: setColumnResizeEnabled(bool)
	- desc: sets whether or not the object's columns can
			be resized
--]]---------------------------------------------------------
function newobject:setColumnResizeEnabled(bool)

	self.canresizecolumns = bool
	return self

end

--[[---------------------------------------------------------
	- func: getColumnResizeEnabled()
	- desc: gets whether or not the object's columns can
			be resized
--]]---------------------------------------------------------
function newobject:getColumnResizeEnabled()

	return self.canresizecolumns

end

--[[---------------------------------------------------------
	- func: sizeColumnToData(columnid)
	- desc: sizes a column to the width of its largest data
			string
--]]---------------------------------------------------------
function newobject:sizeColumnToData(columnid)

	local column = self.children[columnid]
	local list = self.internals[1]
	local largest = 0

	for k, v in ipairs(list.children) do
		local width = v:getFont():getWidth(self:getCellText(k, columnid))
		if width > largest then
			largest = width + v.textx
		end
	end

	if largest <= 0 then
		largest = 10
	end

	self:setColumnWidth(columnid, largest)
	return self

end

--[[---------------------------------------------------------
	- func: setColumnOrder(curid, newid)
	- desc: sets the order of the specified column
--]]---------------------------------------------------------
function newobject:setColumnOrder(curid, newid)

	local column = self.children[curid]
	local totalcolumns = #self.children

	if column and totalcolumns > 1 and newid <= totalcolumns and newid >= 1 then
		column:remove()
		table.insert(self.children, newid, column)
		self:positionColumns()
	end

	return self

end

---------- module end ----------
end
