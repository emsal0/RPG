dialogues = {}
dialogues.running = false
dialogues.currentText = "" 
dialogues.dialoguescreen = love.graphics.newImage("images/dialoguebox.png")
dialogues.maxlinelength = 30

dialogues.boxes = {}

dialogues.menu = {}
dialogues.menu.options = {}
dialogues.menu.q = ""
dialogues.menu.currentlyselected = 1
dialogues.menu.currentlydisplaying = {}
dialogues.menu.tbase = 1
dialogues.menurunning = false
dialogues.menu.output = nil

dialogues.currentline = 0 

function dialogues:load()
	dialoguefont = love.graphics.newFont("fonts/VeraMono.ttf")
end

function dialogues:openDialogue(text, x,y,w,h)
	if not x then x = 64 end
	if not y then y = 192 end
	if not w then w = 256 end
	if not h then h = 128 end
	table.insert(dialogues.boxes, {text=text, x=x, y=y, w=w, h=h})
--		self.menurunning = false
	self:drawDialogueBox(x,y,w,h)	
	self:rollText(text, x,y,w,h)
	
end

function dialogues:draw()
	
end

function dialogues:drawDialogueBox(x,y,w,h)
--[[if not x then x = 64 end
	if not y then y = 192 end
	if not w then w = 256 end
	if not h then h = 128 end]]
	love.graphics.draw( self.dialoguescreen, camera:getX()+x, camera:getY()+y, w/320, h/320)
end

--[[function dialogues:drawMenu()

	if self.menurunning == true then
--		self.running = false
		self.currentText = ""
		if self.menu.q then
			self:rollText(self.menu.q)
		end
		local amountoflines = 320-((192+15+19*(self.currentline))/19)
		for i = 0, amountoflines-1 do
			if self.menu.options[self.menu.tbase+i] then
				table.insert(self.menu.currentlydisplaying, self.menu.options[self.menu.tbase+i])
			else
				break
			end
		end
		for i,v in pairs(self.menu.currentlydisplaying) do
			love.graphics.print(v, camera:getX() + 64+12+7, camera:getY() + (192+15)+19*(self.currentline+i))
		end


	end
	

end

function dialogues:keypressed(key)

	if self.menurunning then
		if key == "up" then
			if self.menu.currentlyselected == 1 and self.menu.tbase ~= 1 then
				self.menu.tbase = self.menu.tbase - 1
			elseif self.menu.currentlyselected ~= 1 then
				self.menu.currentlyselected = self.menu.currentlyselected - 1
			end
		end
		if key == "down" then
			if self.menu.currentlyselected == #self.menu.currentlydisplaying and #self.menu.currentlydisplaying ~= #self.menu.options then
				self.menu.tbase = self.menu.tbase + 1
			elseif self.menu.currentlyselected ~=  #self.menu.currentlydisplaying then
				self.menu.currentlyselected = self.menu.currentlyselected + 1
			end
		end
		if key == "x" then
			self.menu.output = self.menu.options[self.menu.tbase + self.menu.currentlyselected - 1]
		end
	end
end]]

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

			love.graphics.print(string.sub(word,s,s), camera:getX() + ((x+5)+7*(string.len(line)+s)), camera:getY() + (y+15)+19*self.currentline )
			
		end
		line = line .. word .. " "

	end
end

