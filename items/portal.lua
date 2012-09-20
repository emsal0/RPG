local item = items:derive("base")

if not item.map_to then item.map_to = "map0" end
if not item.x_to then item.x_to = 1 end
if not item.y_to then item.y_to = 1 end



function item:step()
	maps:setCurrentMap(item.map_to)
	hero:setPos(item.x_to*maps.tilesize, item.y_to*maps.tilesize)
end


return item;