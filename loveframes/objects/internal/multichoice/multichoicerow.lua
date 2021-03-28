--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- multichoicerow class
local newobject = loveframes.newObject("multichoicerow", "loveframes_object_multichoicerow", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()
	
	self.type = "multichoicerow"
	self.text = ""
	self.width = 50
	self.height = 25
	self.hover = false
	self.internal = true
	self.down = false
	self.canclick = false
	
	-- apply template properties to the object
	loveframes.applyTemplatesToObject(self)
	self:setDrawFunc()
end

--[[---------------------------------------------------------
	- func: update(deltatime)
	- desc: updates the object
--]]---------------------------------------------------------
function newobject:_update(dt)
	
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
	
	if not self.hover then
		self.down = false
	else
		if loveframes.downobject == self then
			self.down = true
		end
	end
	
	if not self.down and loveframes.downobject == self then
		self.hover = true
	end
	
	-- move to parent if there is a parent
	if parent ~= base then
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
	
	local visible = self.visible
	
	if not visible then
		return
	end
	
	local hover = self.hover
	
	if hover and button == 1 then
		self.down = true
		loveframes.downobject = self
	end

end

--[[---------------------------------------------------------
	- func: mousereleased(x, y, button)
	- desc: called when the player releases a mouse button
--]]---------------------------------------------------------
function newobject:mousereleased(x, y, button)
	
	local visible = self.visible
	
	if not visible then
		return
	end
	
	local text = self.text
	
	if self.hover and self.down and self.canclick and button == 1 then
		self.parent.list:selectChoice(text)
	end
	
	self.down = false
	self.canclick = true

end

--[[---------------------------------------------------------
	- func: keypressed(key, isrepeat)
	- desc: called when the player presses a key
--]]---------------------------------------------------------
function newobject:keypressed(key, isrepeat)

	local text = self.text
	local selectedobject = loveframes.selectedobject
	
	if key == "return" and selectedobject == self then
		self.parent.list:selectChoice(text)
	end

end
	
--[[---------------------------------------------------------
	- func: setText(text)
	- desc: sets the object's text
--]]---------------------------------------------------------
function newobject:setText(text)

	self.text = text
	
end

--[[---------------------------------------------------------
	- func: getText()
	- desc: gets the object's text
--]]---------------------------------------------------------
function newobject:getText()

	return self.text
	
end

---------- module end ----------
end
