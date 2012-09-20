items = {}

items.itemdb = 
	{
	rock = love.filesystem.load("items/rock.lua"),
	portal = love.filesystem.load("items/portal.lua")

	}

items.imagedb = {}
items.interactionsdb = {}
items.objects = {}
local id = 1

--[[function items:startup()
	self.itemdb["rock"] = love.filesystem.load("items/rock.lua")
end]]

function items:derive(name)
	return love.filesystem.load("items/" .. name .. ".lua")()
end

function items:create(name, values)

	if self.itemdb[name] then
		id = id + 1
		local item = self.itemdb[name]()
		for i,v in pairs(values) do
			item[i] = v
		end
		item:load()
		item.type = name
		item.id = id
		self.objects[id] = item
		return self.objects[id]
	else
		print("Error: Entity " .. name .. " does not exist!")
		return false;
	end
end

function items:destroy(id)
	if self.objects[id] then
		if self.objects[id].Die then
			self.objects[id]:Die()
		end
		self.objects[id] = nil
	end
end
