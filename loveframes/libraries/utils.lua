--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- util library
--local util = {}

--[[---------------------------------------------------------
	- func: setState(name)
	- desc: sets the current state
--]]---------------------------------------------------------
function loveframes.setState(name)

	loveframes.state = name
	loveframes.base.state = name

end

--[[---------------------------------------------------------
	- func: getState()
	- desc: gets the current state
--]]---------------------------------------------------------
function loveframes.getState()

	return loveframes.state

end

--[[---------------------------------------------------------
	- func: setActiveSkin(name)
	- desc: sets the active skin
--]]---------------------------------------------------------
function loveframes.setActiveSkin(name)
	local skin = name and loveframes.skins[name]
	if not skin then print("setActiveSkin: no such skin") return end

	loveframes.config["ACTIVESKIN"] = name
	local object = loveframes.base
	object:setSkin(name)
end

--[[---------------------------------------------------------
	- func: getActiveSkin()
	- desc: gets the active skin
--]]---------------------------------------------------------
function loveframes.getActiveSkin()
	local index = loveframes.config["ACTIVESKIN"]
	return loveframes.skins[index]
end

--[[---------------------------------------------------------
	- func: boundingBox(x1, x2, y1, y2, w1, w2, h1, h2)
	- desc: checks for a collision between two boxes
	- note: I take no credit for this function
--]]---------------------------------------------------------
function loveframes.boundingBox(x1, x2, y1, y2, w1, w2, h1, h2)
	if x1 > x2 + w2 - 1 or y1 > y2 + h2 - 1 or x2 > x1 + w1 - 1 or y2 > y1 + h1 - 1 then
		return false
	else
		return true
	end
end

--[[---------------------------------------------------------
	- func: getCollisions(object, table)
	- desc: gets all objects colliding with the mouse
--]]---------------------------------------------------------
function loveframes.getCollisions(object, t)
	local x, y = love.mouse.getPosition()
	local curstate = loveframes.state
	local object = object or loveframes.base
	local visible = object.visible
	local children = object.children
	local internals = object.internals
	local objectstate = object.state
	local t = t or {}

	if objectstate == curstate and visible then
		local objectx = object.x
		local objecty = object.y
		local objectwidth = object.width
		local objectheight = object.height
		local col = loveframes.boundingBox(x, objectx, y, objecty, 1, objectwidth, 1, objectheight)
		local collide = object.collide
		if col and collide then
			local clickbounds = object.clickbounds
			if clickbounds then
				local cx = clickbounds.x
				local cy = clickbounds.y
				local cwidth = clickbounds.width
				local cheight = clickbounds.height
				local clickcol = loveframes.boundingBox(x, cx, y, cy, 1, cwidth, 1, cheight)
				if clickcol then
					table.insert(t, object)
				end
			else
				table.insert(t, object)
			end
		end
		if children then
			for k, v in ipairs(children) do
				loveframes.getCollisions(v, t)
			end
		end
		if internals then
			for k, v in ipairs(internals) do
				local type = v.type
				if type ~= "tooltip" then
					loveframes.getCollisions(v, t)
				end
			end
		end
	end

	return t
end

--[[---------------------------------------------------------
	- func: getAllObjects(object, table)
	- desc: gets all active objects
--]]---------------------------------------------------------
function loveframes.getAllObjects(object, t)
	local object = object or loveframes.base
	local internals = object.internals
	local children = object.children
	local t = t or {}

	table.insert(t, object)

	if internals then
		for k, v in ipairs(internals) do
			loveframes.getAllObjects(v, t)
		end
	end

	if children then
		for k, v in ipairs(children) do
			loveframes.getAllObjects(v, t)
		end
	end

	return t

end

--[[---------------------------------------------------------
	- func: getDirectoryContents(directory, table)
	- desc: gets the contents of a directory and all of
			its subdirectories
--]]---------------------------------------------------------
function loveframes.getDirectoryContents(dir, t)
	local dir = dir
	local t = t or {}
	local dirs = {}
	local files = love.filesystem.getDirectoryItems(dir)

	for k, v in ipairs(files) do
		local isdir = love.filesystem.getInfo(dir.. "/" ..v) ~= nil and love.filesystem.getInfo(dir.. "/" ..v)["type"] == "directory" --love.filesystem.isDirectory(dir.. "/" ..v)
		if isdir == true then
			table.insert(dirs, dir.. "/" ..v)
		else
			local parts = loveframes.splitString(v, "([.])")
			local extension = #parts > 1 and parts[#parts]
			if #parts > 1 then
				parts[#parts] = nil
			end
			local name = table.concat(parts, ".")
			table.insert(t, {
				path = dir,
				fullpath = dir.. "/" ..v,
				requirepath = loveframes.utf8.gsub(dir, "/", ".") .. "." ..name,
				name = name,
				extension = extension
			})
		end
	end

	for k, v in ipairs(dirs) do
		t = loveframes.getDirectoryContents(v, t)
	end

	return t
end


--[[---------------------------------------------------------
	- func: round(num, idp)
	- desc: rounds a number based on the decimal limit
	- note: I take no credit for this function
--]]---------------------------------------------------------
function loveframes.round(num, idp)
	local mult = 10^(idp or 0)

    if num >= 0 then
		return math.floor(num * mult + 0.5) / mult
    else
		return math.ceil(num * mult - 0.5) / mult
	end
end

--[[---------------------------------------------------------
	- func: splitString(string, pattern)
	- desc: splits a string into a table based on a given pattern
	- note: I take no credit for this function
--]]---------------------------------------------------------
function loveframes.splitString(str, pat)
	local t = {}  -- NOTE: use {n = 0} in Lua-5.0

	if pat == " " then
		local fpat = "(.-)" .. pat
		local last_end = 1
		local s, e, cap = loveframes.utf8.find(str, fpat, 1)
		while s do
			if s ~= #str then
				cap = cap .. " "
			end
			if s ~= 1 or cap ~= "" then
				table.insert(t,cap)
			end
			last_end = e+1
			s, e, cap = loveframes.utf8.find(str, fpat, last_end)
		end
		if last_end <= #str then
			cap = loveframes.utf8.sub(str, last_end)
			table.insert(t, cap)
		end
	else
		local fpat = "(.-)" .. pat
		local last_end = 1
		local s, e, cap = loveframes.utf8.find(str, fpat, 1)
		while s do
			if s ~= 1 or cap ~= "" then
				table.insert(t,cap)
			end
			last_end = e+1
			s, e, cap = loveframes.utf8.find(str, fpat, last_end)
		end
		if last_end <= #str then
			cap = loveframes.utf8.sub(str, last_end)
			table.insert(t, cap)
		end
	end

	return t
end

--[[---------------------------------------------------------
	- func: removeAll()
	- desc: removes all gui elements
--]]---------------------------------------------------------
function loveframes.removeAll()
	loveframes.base.children = {}
	loveframes.base.internals = {}

	loveframes.hoverobject = false
	loveframes.downobject = false
	loveframes.modalobject = false
	loveframes.inputobject = false
	loveframes.hover = false
end

--[[---------------------------------------------------------
	- func: tableHasValue(table, value)
	- desc: checks to see if a table has a specific value
--]]---------------------------------------------------------
function loveframes.tableHasValue(table, value)
	for k, v in pairs(table) do
		if v == value then
			return true
		end
	end

	return false
end

--[[---------------------------------------------------------
	- func: tableHasKey(table, key)
	- desc: checks to see if a table has a specific key
--]]---------------------------------------------------------
function loveframes.tableHasKey(table, key)
	return table[key] ~= nil

end

--[[---------------------------------------------------------
	- func: error(message)
	- desc: displays a formatted error message
--]]---------------------------------------------------------
function loveframes.error(message)
	error("[Love Frames] " ..message)
end

--[[---------------------------------------------------------
	- func: getCollisionCount()
	- desc: gets the total number of objects colliding with
			the mouse
--]]---------------------------------------------------------
function loveframes.getCollisionCount()
	return loveframes.collisioncount
end

--[[---------------------------------------------------------
	- func: getHover()
	- desc: returns loveframes.hover, can be used to check
			if the mouse is colliding with a visible
			Love Frames object
--]]---------------------------------------------------------
function loveframes.getHover()
	return loveframes.hover
end

--[[---------------------------------------------------------
	- func: rectangleCollisionCheck(rect1, rect2)
	- desc: checks for a collision between two rectangles
			based on two tables containing rectangle sizes
			and positions
--]]---------------------------------------------------------
function loveframes.rectangleCollisionCheck(rect1, rect2)
	return loveframes.boundingBox(rect1.x, rect2.x, rect1.y, rect2.y, rect1.width, rect2.width, rect1.height, rect2.height)
end

--[[---------------------------------------------------------
	- func: deepCopy(orig)
	- desc: copies a table
	- note: I take not credit for this function
--]]---------------------------------------------------------
function loveframes.deepCopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[loveframes.deepCopy(orig_key)] = loveframes.deepCopy(orig_value)
		end
		setmetatable(copy, loveframes.deepCopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

--[[---------------------------------------------------------
	- func: getHoverObject()
	- desc: returns loveframes.hoverobject
--]]---------------------------------------------------------
function loveframes.getHoverObject()

	return loveframes.hoverobject

end

--[[---------------------------------------------------------
	- func: IsCtrlDown()
	- desc: checks for ctrl, for use with multiselect, copy,
			paste, and such. On OS X it actually looks for cmd.
--]]---------------------------------------------------------
function loveframes.IsCtrlDown()
	if love._os == "OS X" then
		return love.keyboard.isDown("lgui") or love.keyboard.isDown("rgui")
	end
	return love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")
end

function loveframes.Color(s, a)
	local r, g, b = string.match(s, '#?(%x%x)(%x%x)(%x%x)')
	if r == nil then return end
	return tonumber(r, 16) / 0xFF, tonumber(g, 16) / 0xFF, tonumber(b, 16) / 0xFF, a or 1
end

--[[---------------------------------------------------------
	- func: draw()
	- desc: draws debug information
--]]---------------------------------------------------------
function loveframes.debugDraw()
	local infox = 5
	local infoy = 40
	local topcol = {type = "None", children = {}, x = 0, y = 0, width = 0, height = 0}
	local hoverobject = loveframes.hoverobject
	--local objects = loveframes.getAllObjects()
	local version = loveframes.version
	local stage = loveframes.stage
	local basedir = loveframes.config["DIRECTORY"]
	local loveversion = love._version
	local fps = love.timer.getFPS()
	local deltatime = love.timer.getDelta()
	local font = loveframes.basicfontsmall

	if hoverobject then
		topcol = hoverobject
	end

	-- show frame docking zones
	if topcol.type == "frame" then
		for k, v in pairs(topcol.dockzones) do
			love.graphics.setLineWidth(1)
			love.graphics.setColor(255/255, 0, 0, 100/255)
			love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
			love.graphics.setColor(255/255, 0, 0, 255/255)
			love.graphics.rectangle("line", v.x, v.y, v.width, v.height)
		end
	end

	-- outline the object that the mouse is hovering over
	love.graphics.setColor(255/255, 204/255, 51/255, 255/255)
	love.graphics.setLineWidth(2)
	love.graphics.rectangle("line", topcol.x - 1, topcol.y - 1, topcol.width + 2, topcol.height + 2)

	-- draw main debug box
	love.graphics.setFont(font)
	love.graphics.setColor(0, 0, 0, 200/255)
	love.graphics.rectangle("fill", infox, infoy, 200, 70)
	love.graphics.setColor(255/255, 0, 0, 255/255)
	love.graphics.print("Love Frames - Debug (" ..version.. " - " ..stage.. ")", infox + 5, infoy + 5)
	love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
	love.graphics.print("LOVE Version: " ..loveversion, infox + 10, infoy + 20)
	love.graphics.print("FPS: " ..fps, infox + 10, infoy + 30)
	love.graphics.print("Delta Time: " ..deltatime, infox + 10, infoy + 40)
	love.graphics.print("Total Objects: " ..loveframes.objectcount, infox + 10, infoy + 50)

	-- draw object information if needed
	if topcol.type ~= "base" then
		love.graphics.setColor(0, 0, 0, 200/255)
		love.graphics.rectangle("fill", infox, infoy + 75, 200, 100)
		love.graphics.setColor(255/255, 0, 0, 255/255)
		love.graphics.print("Object Information", infox + 5, infoy + 80)
		love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
		love.graphics.print("Type: " ..topcol.type, infox + 10, infoy + 95)
		if topcol.children then
			love.graphics.print("# of children: " .. #topcol.children, infox + 10, infoy + 105)
		else
			love.graphics.print("# of children: 0", infox + 10, infoy + 105)
		end
		if topcol.internals then
			love.graphics.print("# of internals: " .. #topcol.internals, infox + 10, infoy + 115)
		else
			love.graphics.print("# of internals: 0", infox + 10, infoy + 115)
		end
		love.graphics.print("X: " ..topcol.x, infox + 10, infoy + 125)
		love.graphics.print("Y: " ..topcol.y, infox + 10, infoy + 135)
		love.graphics.print("Width: " ..topcol.width, infox + 10, infoy + 145)
		love.graphics.print("Height: " ..topcol.height, infox + 10, infoy + 155)
	end
end

--return util

---------- module end ----------
end
