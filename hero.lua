hero = {} 
hero.spritelist = {test = love.graphics.newImage("images/hero.png")}
hero.currentsprite = "test"
hero.facing = "up"
hero.xpos = nil
hero.ypos = nil

function hero:setCurrentSprite(sprite)
	if hero.spritelist.sprite then
		hero.currentsprite = hero.spritelist.sprite
	else
		print("Error!")
		return
	end
end

function hero:setPos(x,y)
	self.xpos = x  
	self.ypos = y  
end 
 
function hero:draw() 
	love.graphics.draw(self.spritelist[self.currentsprite], self.xpos, self.ypos) 
end 

function hero:interact()
	if self.facing == "up" then
		maps:interact(self.xpos/maps.tilesize, (self.ypos - maps.tilesize)/maps.tilesize)
	elseif self.facing == "down" then
		maps:interact(self.xpos/maps.tilesize, (self.ypos + maps.tilesize)/maps.tilesize)
	elseif self.facing == "left" then
		maps:interact((self.xpos - maps.tilesize)/maps.tilesize, self.ypos/maps.tilesize)
	elseif self.facing == "right" then
		maps:interact((self.xpos + maps.tilesize)/maps.tilesize, self.ypos/maps.tilesize)

	end
end
 
 
function hero:update(dt) 
	if hero.xpos*1 < camera:getX() + 64 then
		camera:setX(camera:getX() - maps.tilesize)
	
	elseif hero.xpos*1 > camera:getX() + 256 then
		camera:setX(camera:getX() + maps.tilesize)
	
	elseif hero.ypos*1 < camera:getY() + 64 then
		camera:setY(camera:getY() - maps.tilesize) 
	
	elseif hero.ypos*1 > camera:getY() + 256 then
		camera:setY(camera:getY() + maps.tilesize)
	end
end 
 
function hero:keypressed(key) 
	if key == "up" then 
		
		self.facing = "up"
		
		if maps:canStep(self.xpos, self.ypos - maps.tilesize) then 
			self.ypos = self.ypos - maps.tilesize 
		end 
	end 
	if key == "down" then 
		
		self.facing = "down"
		
		if maps:canStep(self.xpos, self.ypos + maps.tilesize) then 
			self.ypos = self.ypos + maps.tilesize 
		end
	end
	if key == "left" then
		
		self.facing = "left"
		
		if maps:canStep(self.xpos - maps.tilesize, self.ypos) then
			self.xpos = self.xpos - maps.tilesize
		end
	end
	if key == "right" then
		
		self.facing = "right"
		
		if maps:canStep(self.xpos + maps.tilesize, self.ypos) then
			self.xpos = self.xpos + maps.tilesize
		end
	end

	if key == "a" then
		self:interact()
	end
--[[	if key == " " then
		if maps.mapname ~= "map1" then
			maps:setCurrentMap("map1")
		else
			maps:setCurrentMap("map0")
		end
	end]]
end
