--[[
Unnamed RPG
Current progress:
	Engine
		-	Loaded and drew sprites. 
		- 	Basic keyboard input
		-	Maps can be loaded from files.
		-	Player cannot step on invalid or occupied tiles.
		-	Player can move between maps.
		

]]

function love.load()		

	require("camera")
	require("hero")
	require("dialogueV2")
	require("items")
	require("maps")
	
--	items:startup()

	maps:setCurrentMap("map0")


	hero:setPos(320,320)
	dialogues:load()

	camera:setX(32)
	camera:setY(32)			
end

function love.draw()
	camera:set()
	
	maps:draw()

	hero:draw()

	dialogues:draw()
	love.graphics.print(tostring(hero.xpos) .. ", " .. tostring(hero.ypos), camera:getX()+200, camera:getY()+10)
	--&d RPG - Copy (6) - Copy - Copy - Copy

	camera:unset()
end

function love.update(dt)
	for i,v in ipairs(dialogues.boxes) do
		print(v)
	end
	hero:update(dt)
	maps:checkSteps()
--	print(hero.facing)
end

function love.keypressed(key)
	hero:keypressed(key)
	

end  

function table.contains(t, term)
	for i,v in ipairs(t) do 
		if v == term then 
			return true
		end
	end
	return false
	
end


