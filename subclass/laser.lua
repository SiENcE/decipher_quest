-- Class
local class = require ( 'lib/middleclass' )
local Laser = class("Laser")

function Laser:initialize(x,y, func)
	print('Laser:initialize')
	-- do some flux
	self.x = x
	self.y = y
	self.done = false

	flux.to(self, 0.5, { y = self.y+180 }):ease("cubicin"):oncomplete( function() self.done = true end )
end

function Laser:isdone()
	return self.done
end

function Laser:update( dt )
end

function Laser:draw()
	love.graphics.setColor( 192, 57, 43, 255 )
	love.graphics.rectangle("fill", self.x, self.y, self.x+360, self.y+100)

	love.graphics.setColor( 231, 76, 60, 255 )
	love.graphics.rectangle("fill", self.x+60, self.y, self.x+360-60*2, self.y+100)

	love.graphics.setColor( 230, 126, 34, 255 )
	love.graphics.rectangle("fill", self.x+120, self.y, self.x+360-120*2, self.y+100)

	love.graphics.setColor( 243, 156, 18, 255 )
	love.graphics.rectangle("fill", self.x+160, self.y, self.x+360-160*2, self.y+100)

	love.graphics.setColor( 236, 240, 241, 255 )
	love.graphics.rectangle("fill", self.x+200, self.y, self.x+360-200*2, self.y+100)

	love.graphics.setColor( 255, 255, 255, 255 )
end

return Laser
