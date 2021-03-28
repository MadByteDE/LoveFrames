--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- skin table
local skin = {}

-- skin info (you always need this in a skin)
skin.name = "Blue"
skin.author = "Nikolai Resokav"
skin.version = "1.0"

local bordercolor = {0.56, 0.56, 0.56, 1}

-- add skin directives to this table
skin.directives = {}

-- controls 
skin.controls = {}
skin.controls.smallfont = love.graphics.newFont(11)
skin.controls.imagebuttonfont = love.graphics.newFont(15)

-- frame
skin.controls.frame_body_color                      = {0.91, 0.91, 0.91, 1}
skin.controls.frame_name_color                      = {1, 1, 1, 1}
skin.controls.frame_name_font                       = skin.controls.smallfont

-- button
skin.controls.button_text_down_color                = {1, 1, 1, 1}
skin.controls.button_text_nohover_color             = {0, 0, 0, 0.78}
skin.controls.button_text_hover_color               = {1, 1, 1, 1}
skin.controls.button_text_nonclickable_color        = {0, 0, 0, 0.39}
skin.controls.button_text_font                      = skin.controls.smallfont

-- imagebutton
skin.controls.imagebutton_text_down_color           = {1, 1, 1, 1}
skin.controls.imagebutton_text_nohover_color        = {1, 1, 1, 0.78}
skin.controls.imagebutton_text_hover_color          = {1, 1, 1, 1}
skin.controls.imagebutton_text_font                 = skin.controls.imagebuttonfont

-- closebutton
skin.controls.closebutton_body_down_color           = {1, 1, 1, 1}
skin.controls.closebutton_body_nohover_color        = {1, 1, 1, 1}
skin.controls.closebutton_body_hover_color          = {1, 1, 1, 1}

-- progressbar
skin.controls.progressbar_body_color                = {1, 1, 1, 1}
skin.controls.progressbar_text_color                = {0, 0, 0, 1}
skin.controls.progressbar_text_font                 = skin.controls.smallfont

-- list
skin.controls.list_body_color                       = {0.91, 0.91, 0.91, 1}

-- scrollarea
skin.controls.scrollarea_body_color                 = {0.86, 0.86, 0.86, 1}

-- scrollbody
skin.controls.scrollbody_body_color                 = {0, 0, 0, 0}

-- panel
skin.controls.panel_body_color                      = {0.91, 0.91, 0.91, 1}

-- tabpanel
skin.controls.tabpanel_body_color                   = {0.91, 0.91, 0.91, 1}

-- tabbutton
skin.controls.tab_text_nohover_color                = {0, 0, 0, 0.78}
skin.controls.tab_text_hover_color                  = {1, 1, 1, 1}
skin.controls.tab_text_font                         = skin.controls.smallfont

-- multichoice
skin.controls.multichoice_body_color                = {0.94, 0.94, 0.94, 1}
skin.controls.multichoice_text_color                = {0, 0, 0, 1}
skin.controls.multichoice_text_font                 = skin.controls.smallfont

-- multichoicelist
skin.controls.multichoicelist_body_color            = {0.94, 0.94, 0.94, 0.78}

-- multichoicerow
skin.controls.multichoicerow_body_nohover_color     = {0.94, 0.94, 0.94, 1}
skin.controls.multichoicerow_body_hover_color       = {0.2, 0.8, 1, 1}
skin.controls.multichoicerow_text_nohover_color     = {0, 0, 0, 0.59}
skin.controls.multichoicerow_text_hover_color       = {1, 1, 1, 1}
skin.controls.multichoicerow_text_font              = skin.controls.smallfont

-- tooltip
skin.controls.tooltip_body_color                    = {1, 1, 1, 1}

-- textinput
skin.controls.textinput_body_color                  = {0.98, 0.98, 0.98, 1}
skin.controls.textinput_indicator_color             = {0, 0, 0, 1}
skin.controls.textinput_text_normal_color           = {0, 0, 0, 1}
skin.controls.textinput_text_placeholder_color      = {0.5, 0.5, 0.5, 1}
skin.controls.textinput_text_selected_color         = {1, 1, 1, 1}
skin.controls.textinput_highlight_bar_color         = {0.2, 0.8, 1, 1}

-- slider
skin.controls.slider_bar_outline_color              = {0.86, 0.86, 0.86, 1}

-- checkbox
skin.controls.checkbox_body_color                   = {1, 1, 1, 1}
skin.controls.checkbox_check_color                  = {0.5, 0.8, 1, 1}
skin.controls.checkbox_text_font                    = skin.controls.smallfont

-- radiobutton
skin.controls.radiobutton_body_color                = {1, 1, 1, 1}
skin.controls.radiobutton_check_color               = {0.5, 0.8, 1, 1}
skin.controls.radiobutton_inner_border_color        = {0.3, 0.72, 1, 1}
skin.controls.radiobutton_text_font                 = skin.controls.smallfont

-- collapsiblecategory
skin.controls.collapsiblecategory_text_color        = {1, 1, 1, 1}

-- columnlist
skin.controls.columnlist_body_color                 = {0.91, 0.91, 0.91, 1}

-- columlistarea
skin.controls.columnlistarea_body_color             = {0.91, 0.91, 0.91, 1}

-- columnlistheader
skin.controls.columnlistheader_text_down_color      = {1, 1, 1, 1}
skin.controls.columnlistheader_text_nohover_color   = {0, 0, 0, 0.78}
skin.controls.columnlistheader_text_hover_color     = {1, 1, 1, 1}
skin.controls.columnlistheader_text_font            = skin.controls.smallfont

-- columnlistrow
skin.controls.columnlistrow_body1_color             = {0.96, 0.96, 0.96, 1}
skin.controls.columnlistrow_body2_color             = {1, 1, 1, 1}
skin.controls.columnlistrow_body_selected_color     = {0.1, 0.78, 1, 1}
skin.controls.columnlistrow_body_hover_color        = {0.4, 0.85, 1, 1}
skin.controls.columnlistrow_text_color              = {0.39, 0.39, 0.39, 1}
skin.controls.columnlistrow_text_hover_color        = {1, 1, 1, 1}
skin.controls.columnlistrow_text_selected_color     = {1, 1, 1, 1}

-- modalbackground
skin.controls.modalbackground_body_color            = {1, 1, 1, 0.39}

-- linenumberspanel
skin.controls.linenumberspanel_text_color           = {0.67, 0.67, 0.67, 1}
skin.controls.linenumberspanel_body_color			= {0.92, 0.92, 0.92, 1}

-- grid
skin.controls.grid_body_color                       = {0.9, 0.9, 0.9, 1}

-- form
skin.controls.form_text_color                       = {0, 0, 0, 1}
skin.controls.form_text_font                        = skin.controls.smallfont

-- menu
skin.controls.menu_body_color                       = {1, 1, 1, 1}

-- menuoption
skin.controls.menuoption_body_hover_color           = {0.2, 0.8, 1, 1}
skin.controls.menuoption_text_hover_color           = {1, 1, 1, 1}
skin.controls.menuoption_text_color                 = {0.71, 0.71, 0.71, 1}

local function parseHeaderText(str, hx, hwidth, tx)
	
	local font = love.graphics.getFont()
	local twidth = love.graphics.getFont():getWidth(str)
	
	if (tx + twidth) - hwidth/2 > hx + hwidth then
		if #str > 1 then
			return parseHeaderText(loveframes.utf8.sub(str, 1, #str - 1), hx, hwidth, tx, twidth)
		else
			return str
		end
	else
		return str
	end
	
end

local function parseRowText(str, rx, rwidth, tx1, tx2)

	local twidth = love.graphics.getFont():getWidth(str)
	
	if (tx1 + tx2) + twidth > rx + rwidth then
		if #str > 1 then
			return parseRowText(loveframes.utf8.sub(str, 1, #str - 1), rx, rwidth, tx1, tx2)
		else
			return str
		end
	else
		return str
	end
	
end

function skin.printText(text, x, y)
	love.graphics.print(text, math.floor(x + 0.5), math.floor(y + 0.5))
end

--[[
local function DrawColumnHeaderText(text, hx, hwidth, tx, twidth)

	local new = ""
	if tx + width > hx + hwidth then
--]]

--[[---------------------------------------------------------
	- func: outlinedRectangle(x, y, width, height, ovt, ovb, ovl, ovr)
	- desc: creates and outlined rectangle
--]]---------------------------------------------------------
function skin.outlinedRectangle(x, y, width, height, ovt, ovb, ovl, ovr)

	local ovt = ovt or false
	local ovb = ovb or false
	local ovl = ovl or false
	local ovr = ovr or false
	
	-- top
	if not ovt then
		love.graphics.rectangle("fill", x, y, width, 1)
	end
	
	-- bottom
	if not ovb then
		love.graphics.rectangle("fill", x, y + height - 1, width, 1)
	end
	
	-- left
	if not ovl then
		love.graphics.rectangle("fill", x, y, 1, height)
	end
	
	-- right
	if not ovr then
		love.graphics.rectangle("fill", x + width - 1, y, 1, height)
	end
	
end

--[[---------------------------------------------------------
	- func: DrawFrame(object)
	- desc: draws the frame object
--]]---------------------------------------------------------
function skin.frame(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local hover = object:getHover()
	local name = object:getName()
	local icon = object:getIcon()
	local bodycolor = skin.controls.frame_body_color
	local topcolor = skin.controls.frame_top_color
	local namecolor = skin.controls.frame_name_color
	local font = skin.controls.frame_name_font
	local topbarimage = skin.images["frame-topbar.png"]
	local topbarimage_width = topbarimage:getWidth()
	local topbarimage_height = topbarimage:getHeight()
	local topbarimage_scalex = width/topbarimage_width
	local topbarimage_scaley = 25/topbarimage_height
	local bodyimage = skin.images["frame-body.png"]
	local bodyimage_width = bodyimage:getWidth()
	local bodyimage_height = bodyimage:getHeight()
	local bodyimage_scalex = width/bodyimage_width
	local bodyimage_scaley = height/bodyimage_height
		
	-- frame body
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(bodyimage, x, y, 0, bodyimage_scalex, bodyimage_scaley)
	
	-- frame top bar
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(topbarimage, x, y, 0, topbarimage_scalex, topbarimage_scaley)
	
	-- frame name section
	love.graphics.setFont(font)
	
	if icon then
		local iconwidth = icon:getWidth()
		local iconheight = icon:getHeight()
		icon:setFilter("nearest", "nearest")
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(icon, x + 5, y + 5)
		love.graphics.setColor(namecolor)
		skin.printText(name, x + iconwidth + 10, y + 5)
	else
		love.graphics.setColor(namecolor)
		skin.printText(name, x + 5, y + 5)
	end
	
	-- frame border
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
	love.graphics.setColor(1, 1, 1, 0.27)
	skin.outlinedRectangle(x + 1, y + 1, width - 2, 24)
	
	love.graphics.setColor(0.86, 0.86, 0.86, 1)
	skin.outlinedRectangle(x + 1, y + 25, width - 2, height - 26)
	
end

--[[---------------------------------------------------------
	- func: DrawButton(object)
	- desc: draws the button object
--]]---------------------------------------------------------
function skin.button(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local hover = object:getHover()
	local text = object:getText()
	local font = object:getFont() or skin.controls.button_text_font
	local twidth = font:getWidth(object.text)
	local theight = font:getHeight(object.text)
	local down = object:getDown()
	local checked = object.checked
	local enabled = object:getEnabled()
	local clickable = object:getClickable()
	local textdowncolor = skin.controls.button_text_down_color
	local texthovercolor = skin.controls.button_text_hover_color
	local textnohovercolor = skin.controls.button_text_nohover_color
	local textnonclickablecolor = skin.controls.button_text_nonclickable_color
	local image_hover = skin.images["button-hover.png"]
	local scaley = height/image_hover:getHeight()
	
	if not enabled or not clickable then
		-- button body
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(skin.images["button-unclickable.png"], x, y, 0, width, scaley)
		-- button text
		love.graphics.setFont(font)
		love.graphics.setColor(textnonclickablecolor)
		skin.printText(text, x + width/2 - twidth/2, y + height/2 - theight/2)
		-- button border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
		return
	end
	
	if object.toggleable then
		if hover then
			if down then
				-- button body
				love.graphics.setColor(1, 1, 1, 1)
				love.graphics.draw(skin.images["button-down.png"], x, y, 0, width, scaley)
				-- button text
				love.graphics.setFont(font)
				love.graphics.setColor(textdowncolor)
				skin.printText(text, x + width/2 - twidth/2, y + height/2 - theight/2)
				-- button border
				love.graphics.setColor(bordercolor)
				skin.outlinedRectangle(x, y, width, height)
			else
				-- button body
				love.graphics.setColor(1, 1, 1, 1)
				love.graphics.draw(image_hover, x, y, 0, width, scaley)
				-- button text
				love.graphics.setFont(font)
				love.graphics.setColor(texthovercolor)
				skin.printText(text, x + width/2 - twidth/2, y + height/2 - theight/2)
				-- button border
				love.graphics.setColor(bordercolor)
				skin.outlinedRectangle(x, y, width, height)
			end
		else
			if object.toggle then
				-- button body
				love.graphics.setColor(1, 1, 1, 1)
				love.graphics.draw(skin.images["button-down.png"], x, y, 0, width, scaley)
				-- button text
				love.graphics.setFont(font)
				love.graphics.setColor(textdowncolor)
				skin.printText(text, x + width/2 - twidth/2, y + height/2 - theight/2)
				-- button border
				love.graphics.setColor(bordercolor)
				skin.outlinedRectangle(x, y, width, height)
			else
				-- button body
				love.graphics.setColor(1, 1, 1, 1)
				love.graphics.draw(skin.images["button-nohover.png"], x, y, 0, width, scaley)
				-- button text
				love.graphics.setFont(font)
				love.graphics.setColor(textnohovercolor)
				skin.printText(text, x + width/2 - twidth/2, y + height/2 - theight/2)
				-- button border
				love.graphics.setColor(bordercolor)
				skin.outlinedRectangle(x, y, width, height)
			end
		end
	else	
		if down or checked then
			-- button body
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.draw(skin.images["button-down.png"], x, y, 0, width, scaley)
			-- button text
			love.graphics.setFont(font)
			if object.image then
				love.graphics.setColor(1, 1, 1)
				love.graphics.draw(object.image, x + 2,  y + height/2 - object.image:getHeight()/2)
				love.graphics.setColor(textdowncolor)
				local text = object.text
				local font = skin.controls.button_text_font
				while font:getWidth(text) > width - object.image:getWidth() - 10 do
					text =loveframes.utf8.sub(text, 2)
					while text:byte(1, 1) > 127 do text = loveframes.utf8.sub(text, 2) end
				end
				skin.printText(text, x + object.image:getWidth() + 4, y + height/2 - theight/2)
			else
				love.graphics.setColor(textdowncolor)
				skin.printText(text, x + width/2 - twidth/2, y + height/2 - theight/2)
			end
			-- button border
			love.graphics.setColor(bordercolor)
			skin.outlinedRectangle(x, y, width, height)
		elseif hover then
			-- button body
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.draw(image_hover, x, y, 0, width, scaley)
			-- button text
			love.graphics.setFont(font)
			if object.image then
				love.graphics.setColor(1, 1, 1)
				love.graphics.draw(object.image, x + 2,  y + height/2 - object.image:getHeight()/2)
				love.graphics.setColor(texthovercolor)
				local text = object.text
				local font = skin.controls.button_text_font
				while font:getWidth(text) > width - object.image:getWidth() - 10 do
					text =loveframes.utf8.sub(text, 2)
					while text:byte(1, 1) > 127 do text = loveframes.utf8.sub(text, 2) end
				end
				skin.printText(text, x + object.image:getWidth() + 4, y + height/2 - theight/2)
			else
				love.graphics.setColor(texthovercolor)
				skin.printText(text, x + width/2 - twidth/2, y + height/2 - theight/2)
			end
			-- button border
			love.graphics.setColor(bordercolor)
			skin.outlinedRectangle(x, y, width, height)
		else
			-- button body
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.draw(skin.images["button-nohover.png"], x, y, 0, width, scaley)
			-- button text
			love.graphics.setFont(font)
			if object.image then
				love.graphics.setColor(1, 1, 1)
				love.graphics.draw(object.image, object:getX() + 2,  object:getY() + object:getHeight()/2 - object.image:getHeight()/2)
				love.graphics.setColor(textnohovercolor)
				local text = object.text
				local font = skin.controls.button_text_font
				while font:getWidth(text) > width - object.image:getWidth() - 10 do
					text =loveframes.utf8.sub(text, 2)
					while text:byte(1, 1) > 127 do text = loveframes.utf8.sub(text, 2) end
				end
				skin.printText(text, x + object.image:getWidth() + 4, y + height/2 - theight/2)
			else
				love.graphics.setColor(textnohovercolor)
				skin.printText(text, x + width/2 - twidth/2, y + height/2 - theight/2)
			end
			-- button border
			love.graphics.setColor(bordercolor)
			skin.outlinedRectangle(x, y, width, height)
		end
	end
	
	love.graphics.setColor(1, 1, 1, 0.59)
	skin.outlinedRectangle(x + 1, y + 1, width - 2, height - 2)

end

--[[---------------------------------------------------------
	- func: DrawCloseButton(object)
	- desc: draws the close button object
--]]---------------------------------------------------------
function skin.closebutton(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local parent = object.parent
	local parentwidth = parent:getWidth()
	local hover = object:getHover()
	local down = object.down
	local image = skin.images["close.png"]
	local bodydowncolor = skin.controls.closebutton_body_down_color
	local bodyhovercolor = skin.controls.closebutton_body_hover_color
	local bodynohovercolor = skin.controls.closebutton_body_nohover_color
	
	image:setFilter("nearest", "nearest")
	
	if down then
		-- button body
		love.graphics.setColor(bodydowncolor)
		love.graphics.draw(image, x, y)
	elseif hover then
		-- button body
		love.graphics.setColor(bodyhovercolor)
		love.graphics.draw(image, x, y)
	else
		-- button body
		love.graphics.setColor(bodynohovercolor)
		love.graphics.draw(image, x, y)
	end
	
end

--[[---------------------------------------------------------
	- func: DrawImage(object)
	- desc: draws the image object
--]]---------------------------------------------------------
function skin.image(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local orientation = object:getOrientation()
	local scalex = object:getScaleX()
	local scaley = object:getScaleY()
	local offsetx = object:getOffsetX()
	local offsety = object:getOffsetY()
	local shearx = object:getShearX()
	local sheary = object:getShearY()
	local image = object.image
	local color = object.imagecolor
	local stretch = object.stretch
	
	if stretch then
		scalex, scaley = object:getWidth() / image:getWidth(), object:getHeight() / image:getHeight()
	end

	if color then
		love.graphics.setColor(color)
		love.graphics.draw(image, x, y, orientation, scalex, scaley, offsetx, offsety, shearx, sheary)
	else
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, orientation, scalex, scaley, offsetx, offsety, shearx, sheary)
	end
	
end

--[[---------------------------------------------------------
	- func: DrawImageButton(object)
	- desc: draws the image button object
--]]---------------------------------------------------------
function skin.imagebutton(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local text = object:getText()
	local hover = object:getHover()
	local image = object:getImage()
	local imagecolor = object.imagecolor or {1, 1, 1, 1}
	local down = object.down
	local font = object:getFont() or skin.controls.imagebutton_text_font
	local twidth = font:getWidth(object.text)
	local theight = font:getHeight(object.text)
	local textdowncolor = skin.controls.imagebutton_text_down_color
	local texthovercolor = skin.controls.imagebutton_text_hover_color
	local textnohovercolor = skin.controls.imagebutton_text_nohover_color
	local checked = object.checked

	if down then
		if image then
			love.graphics.setColor(imagecolor)
			love.graphics.draw(image, x + 1, y + 1)
		end
		love.graphics.setFont(font)
		love.graphics.setColor(0, 0, 0, 1)
		skin.printText(text, x + width/2 - twidth/2 + 1, y + height - theight - 5 + 1)
		love.graphics.setColor(textdowncolor)
		skin.printText(text, x + width/2 - twidth/2 + 1, y + height - theight - 6 + 1)
	elseif hover then
		if image then
			love.graphics.setColor(imagecolor)
			love.graphics.draw(image, x, y)
		end
		love.graphics.setFont(font)
		love.graphics.setColor(0, 0, 0, 1)
		skin.printText(text, x + width/2 - twidth/2, y + height - theight - 5)
		love.graphics.setColor(texthovercolor)
		skin.printText(text, x + width/2 - twidth/2, y + height - theight - 6)
	else
		if image then
			love.graphics.setColor(imagecolor)
			love.graphics.draw(image, x, y)
		end
		love.graphics.setFont(font)
		love.graphics.setColor(0, 0, 0, 1)
		skin.printText(text, x + width/2 - twidth/2, y + height - theight - 5)
		love.graphics.setColor(textnohovercolor)
		skin.printText(text, x + width/2 - twidth/2, y + height - theight - 6)
	end
	if checked == true then
		love.graphics.setColor(bordercolor)
		love.graphics.setLineWidth(3)
		love.graphics.setLineStyle("smooth")
		love.graphics.rectangle("line", x+1, y+1, width-2, height-2)
	end

end

--[[---------------------------------------------------------
	- func: DrawProgressBar(object)
	- desc: draws the progress bar object
--]]---------------------------------------------------------
function skin.progressbar(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local value = object:getValue()
	local max = object:getMax()
	local text = object:getText()
	local barwidth = object:getBarWidth()
	local font = skin.controls.progressbar_text_font
	local twidth = font:getWidth(text)
	local theight = font:getHeight("a")
	local bodycolor = skin.controls.progressbar_body_color
	local barcolor = skin.controls.progressbar_bar_color
	local textcolor = skin.controls.progressbar_text_color
	local image = skin.images["progressbar.png"]
	local imageheight = image:getHeight()
	local scaley = height/imageheight
		
	-- progress bar body
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(image, x, y, 0, barwidth, scaley)
	love.graphics.setFont(font)
	love.graphics.setColor(textcolor)
	skin.printText(text, x + width/2 - twidth/2, y + height/2 - theight/2)
	
	-- progress bar border
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
	object:setText(value .. "/" ..max)
	
end

--[[---------------------------------------------------------
	- func: DrawScrollArea(object)
	- desc: draws the scroll area object
--]]---------------------------------------------------------
function skin.scrollarea(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local bartype = object:getBarType()
	local bodycolor = skin.controls.scrollarea_body_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	love.graphics.setColor(bordercolor)
	
	if bartype == "vertical" then
		--skin.outlinedRectangle(x, y, width, height, true, true)
	elseif bartype == "horizontal" then
		--skin.outlinedRectangle(x, y, width, height, false, false, true, true)
	end
	
end

--[[---------------------------------------------------------
	- func: DrawScrollBar(object)
	- desc: draws the scroll bar object
--]]---------------------------------------------------------
function skin.scrollbar(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local dragging = object:IsDragging()
	local hover = object:getHover()
	local bartype = object:getBarType()
	local bodydowncolor = skin.controls.scrollbar_body_down_color
	local bodyhovercolor = skin.controls.scrollbar_body_hover_color
	local bodynohvercolor = skin.controls.scrollbar_body_nohover_color

	if dragging then
		local image = skin.images["button-down.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
	elseif hover then
		local image = skin.images["button-hover.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
	else
		local image = skin.images["button-nohover.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
	end
	
end

--[[---------------------------------------------------------
	- func: DrawScrollBody(object)
	- desc: draws the scroll body object
--]]---------------------------------------------------------
function skin.scrollbody(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local bodycolor = skin.controls.scrollbody_body_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)

end

--[[---------------------------------------------------------
	- func: DrawPanel(object)
	- desc: draws the panel object
--]]---------------------------------------------------------
function skin.panel(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local bodycolor = skin.controls.panel_body_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	
	love.graphics.setColor(1, 1, 1, 0.78)
	skin.outlinedRectangle(x + 1, y + 1, width - 2, height - 2)
	
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
end

--[[---------------------------------------------------------
	- func: DrawList(object)
	- desc: draws the list object
--]]---------------------------------------------------------
function skin.list(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local bodycolor = skin.controls.list_body_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
		
end

--[[---------------------------------------------------------
	- func: DrawList(object)
	- desc: used to draw over the object and its children
--]]---------------------------------------------------------
function skin.list_over(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
end

--[[---------------------------------------------------------
	- func: DrawTabPanel(object)
	- desc: draws the tab panel object
--]]---------------------------------------------------------
function skin.tabpanel(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local buttonheight = object:getHeightOfButtons()
	local bodycolor = skin.controls.tabpanel_body_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y + buttonheight, width, height - buttonheight)
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y + buttonheight - 1, width, height - buttonheight + 2)
	
	object:setScrollButtonSize(15, buttonheight)

end

--[[---------------------------------------------------------
	- func: DrawOverTabPanel(object)
	- desc: draws over the tab panel object
--]]---------------------------------------------------------
function skin.tabpanel_over(object)

end

--[[---------------------------------------------------------
	- func: DrawTabButton(object)
	- desc: draws the tab button object
--]]---------------------------------------------------------
function skin.tabbutton(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local hover = object:getHover()
	local text = object:getText()
	local image = object:getImage()
	local tabnumber = object:getTabNumber()
	local parent = object:getParent()
	local ptabnumber = parent:getTabNumber()
	local font = skin.controls.tab_text_font
	local twidth = font:getWidth(object.text)
	local theight = font:getHeight(object.text)
	local imagewidth = 0
	local imageheight = 0
	local texthovercolor = skin.controls.button_text_hover_color
	local textnohovercolor = skin.controls.button_text_nohover_color
	
	if image then
		image:setFilter("nearest", "nearest")
		imagewidth = image:getWidth()
		imageheight = image:getHeight()
		object.width = imagewidth + 15 + twidth
		if imageheight > theight then
			parent:setTabHeight(imageheight + 5)
			object.height = imageheight + 5
		else
			object.height = parent.tabheight
		end
	else
		object.width = 10 + twidth
		object.height = parent.tabheight
	end
	
	local width  = object:getWidth()
	local height = object:getHeight()
	
	if tabnumber == ptabnumber then
		-- button body
		local gradient = skin.images["button-hover.png"]
		local gradientheight = gradient:getHeight()
		local scaley = height/gradientheight
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(gradient, x, y, 0, width, scaley)
		-- button border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)	
		if image then
			-- button image
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.draw(image, x + 5, y + height/2 - imageheight/2)
			-- button text
			love.graphics.setFont(font)
			love.graphics.setColor(texthovercolor)
			skin.printText(text, x + imagewidth + 10, y + height/2 - theight/2)
		else
			-- button text
			love.graphics.setFont(font)
			love.graphics.setColor(texthovercolor)
			skin.printText(text, x + 5, y + height/2 - theight/2)
		end	
	else
		-- button body
		local gradient = skin.images["button-nohover.png"]
		local gradientheight = gradient:getHeight()
		local scaley = height/gradientheight
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(gradient, x, y, 0, width, scaley)
		-- button border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
		if image then
			-- button image
			love.graphics.setColor(1, 1, 1, 0.59)
			love.graphics.draw(image, x + 5, y + height/2 - imageheight/2)
			-- button text
			love.graphics.setFont(font)
			love.graphics.setColor(textnohovercolor)
			skin.printText(text, x + imagewidth + 10, y + height/2 - theight/2)
		else
			-- button text
			love.graphics.setFont(font)
			love.graphics.setColor(textnohovercolor)
			skin.printText(text, x + 5, y + height/2 - theight/2)
		end
	end

end

--[[---------------------------------------------------------
	- func: DrawMultiChoice(object)
	- desc: draws the multi choice object
--]]---------------------------------------------------------
function skin.multichoice(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local text = object:getText()
	local choice = object:getChoice()
	local image = skin.images["multichoice-arrow.png"]
	local font = skin.controls.multichoice_text_font
	local theight = font:getHeight("a")
	local bodycolor = skin.controls.multichoice_body_color
	local textcolor = skin.controls.multichoice_text_color
	
	image:setFilter("nearest", "nearest")
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x + 1, y + 1, width - 2, height - 2)
	
	love.graphics.setColor(textcolor)
	love.graphics.setFont(font)
	
	if choice == "" then
		skin.printText(text, x + 5, y + height/2 - theight/2)
	else
		skin.printText(choice, x + 5, y + height/2 - theight/2)
	end
	
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(image, x + width - 20, y + 5)
	
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
end

--[[---------------------------------------------------------
	- func: DrawMultiChoiceList(object)
	- desc: draws the multi choice list object
--]]---------------------------------------------------------
function skin.multichoicelist(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local bodycolor = skin.controls.multichoicelist_body_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	
end

--[[---------------------------------------------------------
	- func: DrawOverMultiChoiceList(object)
	- desc: draws over the multi choice list object
--]]---------------------------------------------------------
function skin.multichoicelist_over(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y - 1, width, height + 1)
	
end

--[[---------------------------------------------------------
	- func: DrawMultiChoiceRow(object)
	- desc: draws the multi choice row object
--]]---------------------------------------------------------
function skin.multichoicerow(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local text = object:getText()
	local font = skin.controls.multichoicerow_text_font
	local bodyhovecolor = skin.controls.multichoicerow_body_hover_color
	local texthovercolor = skin.controls.multichoicerow_text_hover_color
	local bodynohovercolor = skin.controls.multichoicerow_body_nohover_color
	local textnohovercolor = skin.controls.multichoicerow_text_nohover_color
	
	love.graphics.setFont(font)
	
	if object.hover then
		love.graphics.setColor(bodyhovecolor)
		love.graphics.rectangle("fill", x, y, width, height)
		love.graphics.setColor(texthovercolor)
		skin.printText(text, x + 5, y + 5)
	else
		love.graphics.setColor(bodynohovercolor)
		love.graphics.rectangle("fill", x, y, width, height)
		love.graphics.setColor(textnohovercolor)
		skin.printText(text, x + 5, y + 5)
	end
	
end

--[[---------------------------------------------------------
	- func: DrawToolTip(object)
	- desc: draws the tool tip object
--]]---------------------------------------------------------
function skin.tooltip(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local bodycolor = skin.controls.tooltip_body_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
end

--[[---------------------------------------------------------
	- func: drawText(object)
	- desc: draws the text object
--]]---------------------------------------------------------
function skin.text(object)
	local textdata = object.formattedtext
	local x = object.x
	local y = object.y
	local shadow = object.shadow
	local shadowxoffset = object.shadowxoffset
	local shadowyoffset = object.shadowyoffset
	local shadowcolor = object.shadowcolor
	local inlist, list = object:isInList()
	local printfunc = function(text, x, y)
		love.graphics.print(text, math.floor(x + 0.5), math.floor(y + 0.5))
	end
	
	for k, v in ipairs(textdata) do
		local textx = v.x
		local texty = v.y
		local text = v.text
		local color = v.color
		local font = v.font
		local link = v.link
		local theight = font:getHeight("a")
		if inlist then
			local listy = list.y
			local listhieght = list.height
			if (y + texty) <= (listy + listhieght) and y + ((texty + theight)) >= listy then
				love.graphics.setFont(font)
				if shadow then
					love.graphics.setColor(unpack(shadowcolor))
					printfunc(text, x + textx + shadowxoffset, y + texty + shadowyoffset)
				end
				if link then
					local linkcolor = v.linkcolor
					local linkhovercolor = v.linkhovercolor
					local hover = v.hover
					if hover then
						love.graphics.setColor(linkhovercolor)
					else
						love.graphics.setColor(linkcolor)
					end
				else
					love.graphics.setColor(unpack(color))
				end
				printfunc(text, x + textx, y + texty)
			end
		else
			love.graphics.setFont(font)
			if shadow then
				love.graphics.setColor(unpack(shadowcolor))
				printfunc(text, x + textx + shadowxoffset, y + texty + shadowyoffset)
			end
			if link then
				local linkcolor = v.linkcolor
				local linkhovercolor = v.linkhovercolor
				local hover = v.hover
				if hover then
					love.graphics.setColor(linkhovercolor)
				else
					love.graphics.setColor(linkcolor)
				end
			else
				love.graphics.setColor(unpack(color))
			end
			printfunc(text, x + textx, y + texty)
		end
	end
end

--[[---------------------------------------------------------
	- func: DrawTextInput(object)
	- desc: draws the text input object
--]]---------------------------------------------------------
function skin.textinput(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local font = object:getFont()
	local focus = object:getFocus()
	local showindicator = object:getIndicatorVisibility()
	local alltextselected = object:isAllTextSelected()
	local textx = object:getTextX()
	local texty = object:getTextY()
	local text = object:getText()
	local multiline = object:getMultiLine()
	local lines = object:getLines()
	local placeholder = object:getPlaceholderText()
	local offsetx = object:getOffsetX()
	local offsety = object:getOffsetY()
	local indicatorx = object:getIndicatorX()
	local indicatory = object:getIndicatorY()
	local vbar = object:hasVerticalScrollBar()
	local hbar = object:hasHorizontalScrollBar()
	local linenumbers = object:getLineNumbersEnabled()
	local itemwidth = object:getItemWidth()
	local masked = object:getMasked()
	local theight = font:getHeight("a")
	local bodycolor = skin.controls.textinput_body_color
	local textnormalcolor = skin.controls.textinput_text_normal_color
	local textplaceholdercolor = skin.controls.textinput_text_placeholder_color
	local textselectedcolor = skin.controls.textinput_text_selected_color
	local highlightbarcolor = skin.controls.textinput_highlight_bar_color
	local indicatorcolor = skin.controls.textinput_indicator_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	
	if alltextselected then
		local bary = 0
		if multiline then
			for i=1, #lines do
				local str = lines[i]
				if masked then
					str = loveframes.utf8.gsub(str, ".", "*")
				end
				local twidth = font:getWidth(str)
				if twidth == 0 then
					twidth = 5
				end
				love.graphics.setColor(highlightbarcolor)
				love.graphics.rectangle("fill", textx, texty + bary, twidth, theight)
				bary = bary + theight
			end
		else
			local twidth = 0
			if masked then
				local maskchar = object:getMaskChar()
				twidth = font:getWidth(loveframes.utf8.gsub(text, ".", maskchar))
			else
				twidth = font:getWidth(text)
			end
			love.graphics.setColor(highlightbarcolor)
			love.graphics.rectangle("fill", textx, texty, twidth, theight)
		end
	end
	
	if showindicator and focus then
		love.graphics.setColor(indicatorcolor)
		love.graphics.rectangle("fill", indicatorx, indicatory, 1, theight)
	end
	
	if not multiline then
		object:setTextOffsetY(height/2 - theight/2)
		if offsetx ~= 0 then
			object:setTextOffsetX(0)
		else
			object:setTextOffsetX(5)
		end
	else
		if vbar then
			if offsety ~= 0 then
				if hbar then
					object:setTextOffsetY(5)
				else
					object:setTextOffsetY(-5)
				end
			else
				object:setTextOffsetY(5)
			end
		else
			object:setTextOffsetY(5)
		end
		
		if hbar then
			if offsety ~= 0 then
				if linenumbers then
					local panel = object:getLineNumbersPanel()
					if vbar then
						object:setTextOffsetX(5)
					else
						object:setTextOffsetX(-5)
					end
				else
					if vbar then
						object:setTextOffsetX(5)
					else
						object:setTextOffsetX(-5)
					end
				end
			else
				object:setTextOffsetX(5)
			end
		else
			object:setTextOffsetX(5)
		end
		
	end
	
	textx = object:getTextX()
	texty = object:getTextY()
	
	love.graphics.setFont(font)
	
	if alltextselected then
		love.graphics.setColor(textselectedcolor)
	elseif #lines == 1 and lines[1] == "" then
		love.graphics.setColor(textplaceholdercolor)
	else
		love.graphics.setColor(textnormalcolor)
	end
	
	local str = ""
	if multiline then
		for i=1, #lines do
			str = lines[i]
			if masked then
				local maskchar = object:getMaskChar()
				str = loveframes.utf8.gsub(str, ".", maskchar)
			end
			skin.printText(#str > 0 and str or (#lines == 1 and placeholder or ""), textx, texty + theight * i - theight)
		end
	else
		str = lines[1]
		if masked then
			local maskchar = object:getMaskChar()
			str = loveframes.utf8.gsub(str, ".", maskchar)
		end
		skin.printText(#str > 0 and str or placeholder, textx, texty)
	end
	
	love.graphics.setColor(0.9, 0.9, 0.9, 1)
	skin.outlinedRectangle(x + 1, y + 1, width - 2, height - 2)
	
end

--[[---------------------------------------------------------
	- func: DrawOverTextInput(object)
	- desc: draws over the text input object
--]]---------------------------------------------------------
function skin.textinput_over(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
end

--[[---------------------------------------------------------
	- func: DrawScrollButton(object)
	- desc: draws the scroll button object
--]]---------------------------------------------------------
function skin.scrollbutton(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local hover = object:getHover()
	local scrolltype = object:getScrollType()
	local down = object.down
	local bodydowncolor = skin.controls.button_body_down_color
	local bodyhovercolor = skin.controls.button_body_hover_color
	local bodynohovercolor = skin.controls.button_body_nohover_color
	
	if down then
		-- button body
		local image = skin.images["button-down.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		-- button border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
		
	elseif hover then
		-- button body
		local image = skin.images["button-hover.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		-- button border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
	else
		-- button body
		local image = skin.images["button-nohover.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		-- button border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
	end
	
	if scrolltype == "up" then
		local image = skin.images["arrow-up.png"]
		local imagewidth = image:getWidth()
		local imageheight = image:getHeight()
		image:setFilter("nearest", "nearest")
		if hover then
			love.graphics.setColor(1, 1, 1, 1)
		else
			love.graphics.setColor(1, 1, 1, 0.59)
		end
		love.graphics.draw(image, x + width/2 - imagewidth/2, y + height/2 - imageheight/2)
	elseif scrolltype == "down" then
		local image = skin.images["arrow-down.png"]
		local imagewidth = image:getWidth()
		local imageheight = image:getHeight()
		image:setFilter("nearest", "nearest")
		if hover then
			love.graphics.setColor(1, 1, 1, 1)
		else
			love.graphics.setColor(1, 1, 1, 0.59)
		end
		love.graphics.draw(image, x + width/2 - imagewidth/2, y + height/2 - imageheight/2)
	elseif scrolltype == "left" then
		local image = skin.images["arrow-left.png"]
		local imagewidth = image:getWidth()
		local imageheight = image:getHeight()
		image:setFilter("nearest", "nearest")
		if hover then
			love.graphics.setColor(1, 1, 1, 1)
		else
			love.graphics.setColor(1, 1, 1, 0.59)
		end
		love.graphics.draw(image, x + width/2 - imagewidth/2, y + height/2 - imageheight/2)
	elseif scrolltype == "right" then
		local image = skin.images["arrow-right.png"]
		local imagewidth = image:getWidth()
		local imageheight = image:getHeight()
		image:setFilter("nearest", "nearest")
		if hover then
			love.graphics.setColor(1, 1, 1, 1)
		else
			love.graphics.setColor(1, 1, 1, 0.59)
		end
		love.graphics.draw(image, x + width/2 - imagewidth/2, y + height/2 - imageheight/2)
	end
	
end

--[[---------------------------------------------------------
	- func: skin.DrawSlider(object)
	- desc: draws the slider object
--]]---------------------------------------------------------
function skin.slider(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local slidtype = object:getSlideType()
	local baroutlinecolor = skin.controls.slider_bar_outline_color
	
	if slidtype == "horizontal" then
		love.graphics.setColor(baroutlinecolor)
		love.graphics.rectangle("fill", x, y + height/2 - 5, width, 10)
		love.graphics.setColor(bordercolor)
		love.graphics.rectangle("fill", x + 5, y + height/2, width - 10, 1)
	elseif slidtype == "vertical" then
		love.graphics.setColor(baroutlinecolor)
		love.graphics.rectangle("fill", x + width/2 - 5, y, 10, height)
		love.graphics.setColor(bordercolor)
		love.graphics.rectangle("fill", x + width/2, y + 5, 1, height - 10)
	end
	
end

--[[---------------------------------------------------------
	- func: skin.DrawSliderButton(object)
	- desc: draws the slider button object
--]]---------------------------------------------------------
function skin.sliderbutton(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local hover = object:getHover()
	local down = object.down
	local parent = object:getParent()
	local enabled = parent:getEnabled()
	local bodydowncolor = skin.controls.button_body_down_color
	local bodyhovercolor = skin.controls.button_body_hover_color
	local bodynohvercolor = skin.controls.button_body_nohover_color
	
	if not enabled then
		local image = skin.images["button-unclickable.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		-- button body
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		-- button border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
		return
	end
	
	if down then
		-- button body
		local image = skin.images["button-down.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		-- button border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
	elseif hover then
		-- button body
		local image = skin.images["button-hover.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		-- button border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
	else
		-- button body
		local image = skin.images["button-nohover.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		-- button border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
	end
	
end

--[[---------------------------------------------------------
	- func: skin.DrawCheckBox(object)
	- desc: draws the check box object
--]]---------------------------------------------------------
function skin.checkbox(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getBoxWidth()
	local height = object:getBoxHeight()
	local checked = object:getChecked()
	local hover = object:getHover()
	local bodycolor = skin.controls.checkbox_body_color
	local checkcolor = skin.controls.checkbox_check_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
	if checked then
		love.graphics.setColor(checkcolor)
		love.graphics.rectangle("fill", x + 4, y + 4, width - 8, height - 8)
	end
	
	if hover then
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x + 4, y + 4, width - 8, height - 8)
	end
	
end

--[[---------------------------------------------------------
	- func: skin.DrawCheckBox(object)
	- desc: draws the radio button object
--]]---------------------------------------------------------
function skin.radiobutton(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getBoxWidth()
	local height = object:getBoxHeight()
	local checked = object:getChecked()
	local hover = object:getHover()
	local bodycolor = skin.controls.radiobutton_body_color
	local checkcolor = skin.controls.radiobutton_check_color
	local inner_border = skin.controls.radiobutton_inner_border_color
	
	love.graphics.setColor(bordercolor)
	love.graphics.setLineStyle("smooth")
	love.graphics.setLineWidth(1)
	love.graphics.circle("line", x + 10, y + 10, 8, 15)
	
	if checked then
		love.graphics.setColor(checkcolor)
		love.graphics.circle("fill", x + 10, y + 10, 5, 360)
		love.graphics.setColor(inner_border)
		love.graphics.circle("line", x + 10, y + 10, 5, 360)
	end
	
	if hover then
		love.graphics.setColor(bordercolor)
		love.graphics.circle("line", x + 10, y + 10, 5, 360)
	end
	
end

--[[---------------------------------------------------------
	- func: skin.DrawCollapsibleCategory(object)
	- desc: draws the collapsible category object
--]]---------------------------------------------------------
function skin.collapsiblecategory(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local text = object:getText()
	local open = object:getOpen()
	local textcolor = skin.controls.collapsiblecategory_text_color
	local font = skin.controls.smallfont
	local image = skin.images["button-nohover.png"]
	local topbarimage = skin.images["frame-topbar.png"]
	local topbarimage_width = topbarimage:getWidth()
	local topbarimage_height = topbarimage:getHeight()
	local topbarimage_scalex = width/topbarimage_width
	local topbarimage_scaley = 25/topbarimage_height
	local imageheight = image:getHeight()
	local scaley = height/imageheight
	
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(image, x, y, 0, width, scaley)
	
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(topbarimage, x, y, 0, topbarimage_scalex, topbarimage_scaley)
	
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
	love.graphics.setColor(1, 1, 1, 1)
	if open then
		local icon = skin.images["collapse.png"]
		icon:setFilter("nearest", "nearest")
		love.graphics.draw(icon, x + width - 21, y + 5)
		love.graphics.setColor(1, 1, 1, 0.27)
		skin.outlinedRectangle(x + 1, y + 1, width - 2, 24)
	else
		local icon = skin.images["expand.png"]
		icon:setFilter("nearest", "nearest")
		love.graphics.draw(icon, x + width - 21, y + 5)
		love.graphics.setColor(1, 1, 1, 0.27)
		skin.outlinedRectangle(x + 1, y + 1, width - 2, 23)
	end
	
	love.graphics.setFont(font)
	love.graphics.setColor(textcolor)
	skin.printText(text, x + 5, y + 5)
	
end

--[[---------------------------------------------------------
	- func: skin.DrawColumnList(object)
	- desc: draws the column list object
--]]---------------------------------------------------------
function skin.columnlist(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local bodycolor = skin.controls.columnlist_body_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	
end

--[[---------------------------------------------------------
	- func: skin.DrawColumnListHeader(object)
	- desc: draws the column list header object
--]]---------------------------------------------------------
function skin.columnlistheader(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local hover = object:getHover()
	local down = object.down
	local font = skin.controls.columnlistheader_text_font
	local theight = font:getHeight(object.name)
	local bodydowncolor = skin.controls.columnlistheader_body_down_color
	local textdowncolor = skin.controls.columnlistheader_text_down_color
	local bodyhovercolor = skin.controls.columnlistheader_body_hover_color
	local textdowncolor = skin.controls.columnlistheader_text_hover_color
	local nohovercolor = skin.controls.columnlistheader_body_nohover_color
	local textnohovercolor = skin.controls.columnlistheader_text_nohover_color
	
	local name = parseHeaderText(object:getName(), x, width, x + width/2, twidth)
	local twidth = font:getWidth(name)
		
	if down then
		local image = skin.images["button-down.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		-- header body
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		-- header name
		love.graphics.setFont(font)
		love.graphics.setColor(textdowncolor)
		skin.printText(name, x + width/2 - twidth/2, y + height/2 - theight/2)
		-- header border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
	elseif hover then
		local image = skin.images["button-hover.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		-- header body
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		-- header name
		love.graphics.setFont(font)
		love.graphics.setColor(textdowncolor)
		skin.printText(name, x + width/2 - twidth/2, y + height/2 - theight/2)
		-- header border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
	else
		local image = skin.images["button-nohover.png"]
		local imageheight = image:getHeight()
		local scaley = height/imageheight
		-- header body
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(image, x, y, 0, width, scaley)
		-- header name
		love.graphics.setFont(font)
		love.graphics.setColor(textnohovercolor)
		skin.printText(name, x + width/2 - twidth/2, y + height/2 - theight/2)
		-- header border
		love.graphics.setColor(bordercolor)
		skin.outlinedRectangle(x, y, width, height)
	end
	
end

--[[---------------------------------------------------------
	- func: skin.DrawColumnListArea(object)
	- desc: draws the column list area object
--]]---------------------------------------------------------
function skin.columnlistarea(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local bodycolor = skin.controls.columnlistarea_body_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	
	local cheight = 0
	local columns = object:getParent():getChildren()
	if #columns > 0 then
		cheight = columns[1]:getHeight()
	end
	
	local image = skin.images["button-nohover.png"]
	local scaley = cheight/image:getHeight()
	
	-- header body
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(image, x, y, 0, width, scaley)
	
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, cheight, true, false, true, true)
	
end

--[[---------------------------------------------------------
	- func: skin.DrawOverColumnListArea(object)
	- desc: draws over the column list area object
--]]---------------------------------------------------------
function skin.columnlistarea_over(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
end

--[[---------------------------------------------------------
	- func: skin.DrawColumnListRow(object)
	- desc: draws the column list row object
--]]---------------------------------------------------------
function skin.columnlistrow(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local colorindex = object:getColorIndex()
	local font = object:getFont()
	local columndata = object:getColumnData()
	local textx = object:getTextX()
	local texty = object:getTextY()
	local parent = object:getParent()
	local theight = font:getHeight("a")
	local hover = object:getHover()
	local selected = object:getSelected()
	local body1color = skin.controls.columnlistrow_body1_color
	local body2color = skin.controls.columnlistrow_body2_color
	local bodyhovercolor = skin.controls.columnlistrow_body_hover_color
	local bodyselectedcolor = skin.controls.columnlistrow_body_selected_color
	local textcolor = skin.controls.columnlistrow_text_color
	local texthovercolor = skin.controls.columnlistrow_text_hover_color
	local textselectedcolor = skin.controls.columnlistrow_text_selected_color
	
	object:setTextPosition(5, height/2 - theight/2)
	
	if selected then
		love.graphics.setColor(bodyselectedcolor)
		love.graphics.rectangle("fill", x, y, width, height)
	elseif hover then
		love.graphics.setColor(bodyhovercolor)
		love.graphics.rectangle("fill", x, y, width, height)
	elseif colorindex == 1 then
		love.graphics.setColor(body1color)
		love.graphics.rectangle("fill", x, y, width, height)
	else
		love.graphics.setColor(body2color)
		love.graphics.rectangle("fill", x, y, width, height)
	end
	
	love.graphics.setFont(font)
	if selected then
		love.graphics.setColor(textselectedcolor)
	elseif hover then
		love.graphics.setColor(texthovercolor)
	else
		love.graphics.setColor(textcolor)
	end
	for k, v in ipairs(columndata) do
		local rwidth = parent.parent:getColumnWidth(k)
		if rwidth then
			local text = parseRowText(v, x, rwidth, x, textx)
			skin.printText(text, x + textx, y + texty)
			x = x + parent.parent.children[k]:getWidth()
		else
			break
		end
	end
	
end

--[[---------------------------------------------------------
	- func: skin.DrawModalBackground(object)
	- desc: draws the modal background object
--]]---------------------------------------------------------
function skin.modalbackground(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local bodycolor = skin.controls.modalbackground_body_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	
end

--[[---------------------------------------------------------
	- func: skin.DrawLineNumbersPanel(object)
	- desc: draws the line numbers panel object
--]]---------------------------------------------------------
function skin.linenumberspanel(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local offsety = object:getOffsetY()
	local parent = object:getParent()
	local lines = parent:getLines()
	local font = parent:getFont()
	local theight = font:getHeight("a")
	local textcolor = skin.controls.linenumberspanel_text_color
	local bodycolor = skin.controls.linenumberspanel_body_color
	
	object:setWidth(10 + font:getWidth(#lines))
	love.graphics.setFont(font)
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	
	love.graphics.setColor(bordercolor)
	--skin.outlinedRectangle(x, y, width, height, true, true, true, false)
	
	local startline = math.ceil(offsety / theight)
	if startline < 1 then
		startline = 1
	end
	local endline = math.ceil(startline + (height / theight)) + 1
	if endline > #lines then
		endline = #lines
	end
	
	for i=startline, endline do
		love.graphics.setColor(textcolor)
		skin.printText(i, x + 5, (y + (theight * (i - 1))) - offsety)
	end
	
end

--[[---------------------------------------------------------
	- func: skin.DrawNumberBox(object)
	- desc: draws the numberbox object
--]]---------------------------------------------------------
function skin.numberbox(object)

end

--[[---------------------------------------------------------
	- func: skin.DrawGrid(object)
	- desc: draws the grid object
--]]---------------------------------------------------------
function skin.grid(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local bodycolor = skin.controls.grid_body_color
	
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
	local cx = x
	local cy = y
	local cw = object.cellwidth + (object.cellpadding * 2)
	local ch = object.cellheight + (object.cellpadding * 2)
	
	for i=1, object.rows do
		for n=1, object.columns do
			local ovt = false
			local ovl = false
			if i > 1 then
				ovt = true
			end
			if n > 1 then	
				ovl = true
			end
			love.graphics.setColor(bodycolor)
			love.graphics.rectangle("fill", cx, cy, cw, ch)
			love.graphics.setColor(bordercolor)
			skin.outlinedRectangle(cx, cy, cw, ch, ovt, false, ovl, false)
			cx = cx + cw
		end
		cx = x
		cy = cy + ch
	end

end

--[[---------------------------------------------------------
	- func: skin.DrawForm(object)
	- desc: draws the form object
--]]---------------------------------------------------------
function skin.form(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local topmargin = object.topmargin
	local name = object.name
	local font = skin.controls.form_text_font
	local textcolor = skin.controls.form_text_color
	local twidth = font:getWidth(name)
	
	love.graphics.setFont(font)
	love.graphics.setColor(textcolor)
	skin.printText(name, x + 7, y)
	
	love.graphics.setColor(bordercolor)
	love.graphics.rectangle("fill", x, y + 7, 5, 1)
	love.graphics.rectangle("fill", x + twidth + 9, y + 7, width - (twidth + 9), 1)
	love.graphics.rectangle("fill", x, y + height, width, 1)
	love.graphics.rectangle("fill", x, y + 7, 1, height - 7)
	love.graphics.rectangle("fill", x + width - 1, y + 7, 1, height - 7)
	
end

--[[---------------------------------------------------------
	- func: skin.DrawMenu(object)
	- desc: draws the menu object
--]]---------------------------------------------------------
function skin.menu(object)
	
	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local bodycolor = skin.controls.menu_body_color
	
	love.graphics.setColor(bodycolor)
	love.graphics.rectangle("fill", x, y, width, height)
	
	love.graphics.setColor(bordercolor)
	skin.outlinedRectangle(x, y, width, height)
	
end

--[[---------------------------------------------------------
	- func: skin.DrawMenuOption(object)
	- desc: draws the menuoption object
--]]---------------------------------------------------------
function skin.menuoption(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	local hover = object:getHover()
	local text = object:getText()
	local icon = object:getIcon()
	local option_type = object.option_type
	local body_hover_color = skin.controls.menuoption_body_hover_color
	local text_hover_color = skin.controls.menuoption_text_hover_color
	local text_color = skin.controls.menuoption_text_color
	local twidth = skin.controls.smallfont:getWidth(text)
	
	
	if option_type == "divider" then
		love.graphics.setColor(0.78, 0.78, 0.78, 1)
		love.graphics.rectangle("fill", x + 4, y + 2, width - 8, 1)
		object.contentheight = 10
	else
		love.graphics.setFont(skin.controls.smallfont)
		if hover then
			love.graphics.setColor(body_hover_color)
			love.graphics.rectangle("fill", x + 2, y + 2, width - 4, height - 4)
			love.graphics.setColor(text_hover_color)
			skin.printText(text, x + 26, y + 5)
		else
			love.graphics.setColor(text_color)
			skin.printText(text, x + 26, y + 5)
		end
		if icon then
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.draw(icon, x + 5, y + 5)
		end
		object.contentwidth = twidth + 31
		object.contentheight = 25
	end
	
end

function skin.tree(object)

	local skin = object:getSkin()
	local x = object:getX()
	local y = object:getY()
	local width = object:getWidth()
	local height = object:getHeight()
	
	love.graphics.setColor(0.78, 0.78, 0.78, 1)
	love.graphics.rectangle("fill", x, y, width, height)
	
end

function skin.treenode(object)

	local icon = object.icon
	local buttonimage = skin.images["tree-node-button-open.png"]
	local width = 0
	local x = object.x
	local leftpadding = 15 * object.level
	
	if object.level > 0 then
		leftpadding = leftpadding + buttonimage:getWidth() + 5
	else
		leftpadding = buttonimage:getWidth() + 5
	end
	
	local iconwidth
	if icon then
		iconwidth = icon:getWidth()
	end
	
	local twidth = loveframes.basicfont:getWidth(object.text)
	local theight = loveframes.basicfont:getHeight(object.text)
	
	if object.tree.selectednode == object then
		love.graphics.setColor(0.4, 0.55, 1, 1)
		love.graphics.rectangle("fill", x + leftpadding + 2 + iconwidth, object.y + 2, twidth, theight)
	end

	width = width + iconwidth + loveframes.basicfont:getWidth(object.text) + leftpadding
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(icon, x + leftpadding, object.y)
	love.graphics.setFont(loveframes.basicfont)
	love.graphics.setColor(0, 0, 0, 1)
	skin.printText(object.text, x + leftpadding + 2 + iconwidth, object.y + 2)
	
	object:setWidth(width + 5)
	
end

function skin.treenodebutton(object)
	
	local leftpadding = 15 * object.parent.level
	local image
	
	if object.parent.open then
		image = skin.images["tree-node-button-close.png"]
	else
		image = skin.images["tree-node-button-open.png"]
	end
	
	image:setFilter("nearest", "nearest")
	
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(image, object.x, object.y)
	
	object:setPosition(2 + leftpadding, 3)
	object:setSize(image:getWidth(), image:getHeight())
	
end

-- register the skin
loveframes.registerSkin(skin)

---------- module end ----------
end
