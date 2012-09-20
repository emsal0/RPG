dialogues = {}

dialogues.dialogueImage = love.graphics.newImage("images/dialoguebox.png")
dialogues.boxes = {}
local id = 1

function dialogues:load()
	dialoguefont = love.graphics.newFont("fonts/VeraMono.ttf")
	love.graphics.setFont(dialoguefont)
end

function dialogues:create(text,x,y,w,h)
--[[if not x then x = 64 end
	if not y then y = 192 end
	if not w then w = 256 end
	if not h then h = 128 end]]

	id = id + 1
	local textbox = {}
	textbox.text=text
	textbox.x=x
	textbox.y=y
	textbox.w=w
	textbox.h=h
	textbox.id = id
	table.insert(self.boxes, textbox)
	return self.boxes[id]
end



function dialogues:remove()
	self.boxes = {}
end

function dialogues:draw()
	for i,v in ipairs(self.boxes) do
		self:drawDialogueBox(v.x,v.y,v.w,v.h)
		self:rollText(v.text,v.x,v.y,v.w,v.h)
	end
end



function dialogues:drawDialogueBox(x,y,w,h)
--[[if not x then x = 64 end
	if not y then y = 192 end
	if not w then w = 256 end
	if not h then h = 128 end]]
	love.graphics.draw( self.dialogueImage, camera:getX()+x, camera:getY()+y, 0, w/320, h/320)
end

function dialogues:rollText(text, x,y,w,h)
	--[[
	Please note that words over 30 characters long are not supported. They will overshoot the line.
	]]
--[[if not x then x = 64 end
	if not y then y = 192 end
	if not w then w = 256 end
	if not h then h = 128 end]]
	
	local i = 0 --length of line
	local maxlinelength = ( w - 10 )/8
	local currentline = 0 --current line
	local line = "" --linestring
	local s = 0 --index of word
	for word in string.gmatch(text, "[^%s]*") do --matches any thing that has one or more repetitions of anything that's not a space.
		s = 0
		if i + string.len(word) <= maxlinelength then --checks if the word will overshoot the maximum line length
			i = i + string.len(word)+1
			
		else
			currentline = currentline + 1
			line = ""
			i = 0
		end
		while s < string.len(word) do
			s = s + 1

			love.graphics.print(string.sub(word,s,s), camera:getX() + ((x+5)+7*(string.len(line)+s)), camera:getY() + (y+15)+19*currentline )
			
		end
		line = line .. word .. " "

	end
end
