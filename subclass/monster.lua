-- Class
local class = require ( 'lib/middleclass' )
local Monster = class("Monster")

local Laser = require ("subclass/laser")

local mode = { idle='background_alien_1', up = 'monster_angry' }

local alpha_ = { value = 0 }
local speed_ = 2
local cronjob_ = nil

function Monster:initialize(x,y, func)
	print('Monster:initialize')
	-- do some flux
	flux.to(alpha_, 1, { value = 255 }):ease("sineinout"):delay(1):oncomplete( func )
	self.startx = x
	self.starty = y
	self.x = x
	self.y = y
	self.mode = mode.idle
	self.width = _ingame_.texture[ self.mode ]:getWidth()
	self.height = _ingame_.texture[ self.mode ]:getHeight()
	self.center = { x=0, y=0}
	self.center.x = self.width/2
	self.center.y = self.height/2
	self.offset = { x = 0, y = 0 }
	
	self.laser = nil
end

function Monster:update( dt )
	if self.laser then
		self.laser:update( dt )
		if self.laser:isdone() then self.laser = nil end
	end
end

function Monster:draw( x, y, ...)
	love.graphics.setColor( 255, 255, 255, alpha_.value )
	_ingame_.texture[ self.mode ]:draw(self.x + x, self.y + y, ...)
	love.graphics.setColor( 255, 255, 255, 255 )
	
	if self.laser then self.laser:draw() end
end

function Monster:flyaway()
end

function Monster:attack()
	print('Monster is active')
	TEsound.play( _ingame_.sound['laser_shoot'], 'sfx', 1, 1, function() TEsound.play( _ingame_.sound['hit'], 'sfx') end )

	self.laser = Laser:new(320, 150 )
--	self.mode = mode.up
end

function Monster:quit()
	print('Fred:quit')
	-- reset the flux
	alpha_.value = 0
end

return Monster
