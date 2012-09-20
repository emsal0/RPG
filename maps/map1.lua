local map = {}
map.tilemap = {} 
map.occupiedTiles = {}
map.items = {
	items:create("portal", {x=1, y=1, occupying=false, map_to = "map0", x_to = 1, y_to = 1})
}
map.portals = {}
map.interactions = {}

for i = 1,20 do 
	local row = {}
	for j = 1,20 do 
		table.insert(row,"t2")
	end
	table.insert(map.tilemap,row)
end



return map;