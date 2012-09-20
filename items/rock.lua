local item = items:derive("base")

item.image = love.graphics.newImage("images/rock.png")

function item:setPos(x,y)
	self.x = x
	self.y = y
end

function item:interact()
	
	if not self.box then
		dialogues:create(self.text, 64,192,256,128)
		self.box = true
	else
		dialogues:remove()
		self.box = nil
	end

end



return item;
