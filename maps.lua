--[[

Map loader file. 

Has an easy system for loading maps from .lua files. 
Also has map-related functions:
	- portals
	- interactions
	- occupied tiles


]]

-- Load some variables.
maps = {} --Our main thing.
tiles = { t1 = love.graphics.newImage("images/tile1.png"), t2 = love.graphics.newImage("images/tile2.png") }
--items = { rock = love.graphics.newImage("images/rock.png") }
maps.invalidtiles = {"non"}
maps.currentmap = nil 
maps.tilesize = 32
maps.mapname = nil
db = {}



function maps:register(mapFile) -- register a map into the database.
	db[mapFile] = love.filesystem.load("maps/" .. mapFile .. ".lua")()
end

function maps:setCurrentMap(name) -- set the current map. 
	if maps.currentmap ~= nil then
		love.graphics.clear()
	end
	self.currentmap = db[name]
	self:setOccupiedTiles()
	self.mapname = name
end 

function maps:drawTiles() -- Draws the tiles.
	for i,v in pairs(self.currentmap.tilemap) do
		for k,x in pairs(v) do 
			if tiles[x] then
				love.graphics.draw(tiles[x], k*self.tilesize, i*self.tilesize)
			end
		end
	end
end


function maps:drawItems() -- Draws items.
	for i,v in ipairs(self.currentmap.items) do
		if v.image then
			love.graphics.draw(v.image, v.x*self.tilesize, v.y*self.tilesize)
		end
	end
end

function maps:draw() -- Putting them together.
	maps:drawTiles()
	maps:drawItems()
end

function maps:setOccupiedTiles() -- Setting occupied tiles based on items.
	for i,v in pairs(self.currentmap.items) do
		if v.occupying == true then
			table.insert(self.currentmap.occupiedTiles, {x = v.x, y = v.y})
		end
	end
end

function maps:checkSteps() --Sets portals that go to other maps.
--[[for i, v in pairs(self.currentmap.portals) do
		local tt = {}
		for w in string.gmatch(v, "%w+") do
			table.insert(tt, w)
		end
		if #tt == 5 then 
			if tostring(hero.xpos) == tt[1] and tostring(hero.ypos) == tt[2] then
				self:setCurrentMap(tt[3])
				hero:setPos(tt[4], tt[5])
			end
			
		end
		--for j,k in pairs(tt) do print(k) end
	end]]
	for i,v in pairs(self.currentmap.items) do
		if v.step then
			if hero.xpos/self.tilesize == v.x and hero.ypos/self.tilesize == v.y then
				v:step()
			end
		end
	end

end

function maps:canStep(x, y) --Bool. Returns whether the hero can step onto a tile.
	local xpos = x/self.tilesize
	local ypos = y/self.tilesize
	if 	ypos <= 0 or ypos > #self.currentmap.tilemap then
		return false
	end 
	if xpos <= 0 or xpos > #self.currentmap.tilemap[ypos] then
		return false
	end

	local invalid = table.contains(self.invalidtiles, self.currentmap.tilemap[ypos][xpos])
	
	for i,v in ipairs(self.currentmap.occupiedTiles) do
		
		if v.x == xpos and v.y == ypos then 
			occupied = true
			break
		else
			occupied = false
		end
	end
	if not (invalid or occupied) then 
		return true
	end
	return false
end

function maps:interact(x,y)
	print(x,y)
	local _x = x
	local _y = y 
	for i,v in pairs (self.currentmap.items) do
		if v.x == _x and v.y == y then
			v:interact()
		end
	end
end


maps:register("map0")
maps:register("map1")
