--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- image object
local newobject = loveframes.newObject("image", "loveframes_object_image", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()

	self.type = "image"
	self.width = 0
	self.height = 0
	self.orientation = 0
	self.scalex = 1
	self.scaley = 1
	self.offsetx = 0
	self.offsety = 0
	self.shearx = 0
	self.sheary = 0
	self.internal = false
	self.image = nil
	self.imagecolor = {1, 1, 1, 1}
	
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
	local update = self.update
	
	self:checkHover()
	
	-- move to parent if there is a parent
	if parent ~= base then
		self.x = self.parent.x + self.staticx
		self.y = self.parent.y + self.staticy
	end
	
	if update then
		update(self, dt)
	end
	
end

--[[---------------------------------------------------------
	- func: setImage(image)
	- desc: sets the object's image
--]]---------------------------------------------------------
function newobject:setImage(image)

	if type(image) == "string" then
		self.image = love.graphics.newImage(image)
		self.image:setFilter("nearest", "nearest")
	else
		self.image = image
	end
	
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	
	return self
	
end

--[[---------------------------------------------------------
	- func: getImage()
	- desc: gets the object's image
--]]---------------------------------------------------------
function newobject:getImage()

	return self.image
	
end

--[[---------------------------------------------------------
	- func: setColor(r, g, b, a)
	- desc: sets the object's color 
--]]---------------------------------------------------------
function newobject:setColor(r, g, b, a)

	self.imagecolor = {r, g, b, a}
	return self
	
end

--[[---------------------------------------------------------
	- func: getColor()
	- desc: gets the object's color 
--]]---------------------------------------------------------
function newobject:getColor()

	return unpack(self.imagecolor)
	
end

--[[---------------------------------------------------------
	- func: setOrientation(orientation)
	- desc: sets the object's orientation
--]]---------------------------------------------------------
function newobject:setOrientation(orientation)

	self.orientation = orientation
	return self
	
end

--[[---------------------------------------------------------
	- func: getOrientation()
	- desc: gets the object's orientation
--]]---------------------------------------------------------
function newobject:getOrientation()

	return self.orientation
	
end

--[[---------------------------------------------------------
	- func: setScaleX(scalex)
	- desc: sets the object's x scale
--]]---------------------------------------------------------
function newobject:setScaleX(scalex)

	self.scalex = scalex
	return self
	
end

--[[---------------------------------------------------------
	- func: getScaleX()
	- desc: gets the object's x scale
--]]---------------------------------------------------------
function newobject:getScaleX()

	return self.scalex
	
end

--[[---------------------------------------------------------
	- func: setScaleY(scaley)
	- desc: sets the object's y scale
--]]---------------------------------------------------------
function newobject:setScaleY(scaley)

	self.scaley = scaley
	return self
	
end

--[[---------------------------------------------------------
	- func: getScaleY()
	- desc: gets the object's y scale
--]]---------------------------------------------------------
function newobject:getScaleY()

	return self.scaley
	
end

--[[---------------------------------------------------------
	- func: setScale(scalex, scaley)
	- desc: sets the object's x and y scale
--]]---------------------------------------------------------
function newobject:setScale(scalex, scaley)

	self.scalex = scalex
	self.scaley = scaley
	
	return self
	
end

--[[---------------------------------------------------------
	- func: getScale()
	- desc: gets the object's x and y scale
--]]---------------------------------------------------------
function newobject:getScale()

	return self.scalex, self.scaley
	
end

--[[---------------------------------------------------------
	- func: setOffsetX(x)
	- desc: sets the object's x offset
--]]---------------------------------------------------------
function newobject:setOffsetX(x)

	self.offsetx = x
	return self
	
end

--[[---------------------------------------------------------
	- func: getOffsetX()
	- desc: gets the object's x offset
--]]---------------------------------------------------------
function newobject:getOffsetX()

	return self.offsetx
	
end

--[[---------------------------------------------------------
	- func: setOffsetY(y)
	- desc: sets the object's y offset
--]]---------------------------------------------------------
function newobject:setOffsetY(y)

	self.offsety = y
	return self
	
end

--[[---------------------------------------------------------
	- func: getOffsetY()
	- desc: gets the object's y offset
--]]---------------------------------------------------------
function newobject:getOffsetY()

	return self.offsety
	
end

--[[---------------------------------------------------------
	- func: setOffset(x, y)
	- desc: sets the object's x and y offset
--]]---------------------------------------------------------
function newobject:setOffset(x, y)

	self.offsetx = x
	self.offsety = y
	
	return self
	
end

--[[---------------------------------------------------------
	- func: getOffset()
	- desc: gets the object's x and y offset
--]]---------------------------------------------------------
function newobject:getOffset()

	return self.offsetx, self.offsety
	
end

--[[---------------------------------------------------------
	- func: setShearX(shearx)
	- desc: sets the object's x shear
--]]---------------------------------------------------------
function newobject:setShearX(shearx)

	self.shearx = shearx
	return self
	
end

--[[---------------------------------------------------------
	- func: getShearX()
	- desc: gets the object's x shear
--]]---------------------------------------------------------
function newobject:getShearX()

	return self.shearx
	
end

--[[---------------------------------------------------------
	- func: setShearY(sheary)
	- desc: sets the object's y shear
--]]---------------------------------------------------------
function newobject:setShearY(sheary)

	self.sheary = sheary
	return self
	
end

--[[---------------------------------------------------------
	- func: getShearY()
	- desc: gets the object's y shear
--]]---------------------------------------------------------
function newobject:getShearY()

	return self.sheary
	
end

--[[---------------------------------------------------------
	- func: setShear(shearx, sheary)
	- desc: sets the object's x and y shear
--]]---------------------------------------------------------
function newobject:setShear(shearx, sheary)

	self.shearx = shearx
	self.sheary = sheary
	
	return self
	
end

--[[---------------------------------------------------------
	- func: getShear()
	- desc: gets the object's x and y shear
--]]---------------------------------------------------------
function newobject:getShear()

	return self.shearx, self.sheary
	
end

--[[---------------------------------------------------------
	- func: getImageSize()
	- desc: gets the size of the object's image
--]]---------------------------------------------------------
function newobject:getImageSize()

	local image = self.image
	
	if image then
		return image:getWidth(), image:getHeight()
	end
	
end

--[[---------------------------------------------------------
	- func: getImageWidth()
	- desc: gets the width of the object's image
--]]---------------------------------------------------------
function newobject:getImageWidth()

	local image = self.image
	
	if image then
		return image:getWidth()
	end
	
end

--[[---------------------------------------------------------
	- func: getImageWidth()
	- desc: gets the height of the object's image
--]]---------------------------------------------------------
function newobject:getImageHeight()

	local image = self.image
	
	if image then
		return image:getHeight()
	end
	
end

---------- module end ----------
end
