local map = {}
map.tilemap = {}
map.items = 
	{	
	items:create("rock", {x=13, y=13, text="I'm a rock. Don't hurt me! Thanks.", occupying=true}) ,
	items:create("portal", {x=2, y=2, occupying=false, map_to = "map1", x_to = 2, y_to = 2})
	}
map.occupiedTiles = {}
map.portals = {}
map.turn = 1
map.interactions = 	{}


for i = 1,15 do
	local row = {}
	if i ~= 7 then 
		for j = 1,15 do
			if j == 8 then
				table.insert(row, "non")
			else 
				table.insert(row, "t1")
			end
		end
	else
		for j = 1,15 do
			table.insert(row,"t1")
		end
	end
	table.insert(map.tilemap,row)
end


return map;
