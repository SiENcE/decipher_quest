-- Class
local class = require ( 'lib/middleclass' )
local Fred = class("Fred")

local mode = { idle='fred_idle', up = 'fred_up_1' }

local alpha_ = { value = 0 }
local speed_ = 1.2
local cronjob_ = nil

function Fred:initialize(x,y)
	print('Fred:initialize')
	-- do some flux
	flux.to(alpha_, 0.6, { value = 255 }):ease("circin")
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
	self.health = 100
end

function Fred:update( dt )
end

function Fred:draw( x, y, ...)
	love.graphics.setColor( 255, 255, 255, alpha_.value )
	_ingame_.texture[ self.mode ]:draw( self.x + x, self.y + y, ... )

	if self.health <= 9 then
		_ingame_.texture[ 'fred_damage_10' ]:draw( self.x + x, self.y + y, ... )
	elseif self.health <= 19 then
		_ingame_.texture[ 'fred_damage_9' ]:draw( self.x + x, self.y + y, ... )
	elseif self.health <= 29 then
		_ingame_.texture[ 'fred_damage_8' ]:draw( self.x + x, self.y + y, ... )
	elseif self.health <= 39 then
		_ingame_.texture[ 'fred_damage_7' ]:draw( self.x + x, self.y + y, ... )
	elseif self.health <= 49 then
		_ingame_.texture[ 'fred_damage_6' ]:draw( self.x + x, self.y + y, ... )
	elseif self.health <= 59 then
		_ingame_.texture[ 'fred_damage_5' ]:draw( self.x + x, self.y + y, ... )
	elseif self.health <= 69 then
		_ingame_.texture[ 'fred_damage_4' ]:draw( self.x + x, self.y + y, ... )
	elseif self.health <= 79 then
		_ingame_.texture[ 'fred_damage_3' ]:draw( self.x + x, self.y + y, ... )
	elseif self.health <= 89 then
		_ingame_.texture[ 'fred_damage_2' ]:draw( self.x + x, self.y + y, ... )
	elseif self.health < 100 then
		_ingame_.texture[ 'fred_damage_1' ]:draw( self.x + x, self.y + y, ... )
	end

	love.graphics.setColor( 255, 255, 255, 255 )
end

function Fred:die()
	-- explode
	-- game ends !!
--	self:pushState('Game Ending') -- than to -> MainMenu
	TEsound.play( _ingame_.sound['explosion'], 'sfx_fred' )
end

function Fred:gethealth()
	return self.health
end

function Fred:isalive()
	return self.health > 0
end

function Fred:dodamage( damage )
	print('Fred:dodamage', damage)

	self.health = self.health - damage
	if self.health <= 0 then
		self.health = 0
		self:die()
	end
	print('Health', self.health)
end

function Fred:activate()
	print('Fred:activate')
	if self.health <= 0 then print('Fred is already dead!') return end
	
	flux.to(      self, speed_*0.5, { x = self.x+300 }):delay(0.05):ease( "cubicout"):
			after(self, speed_*  1, { x = self.x-300 }):delay(0.02):ease( "cubicinout"):
			after(self, speed_*0.5, { x = self.startx }):delay(0.02):ease( "cubicin")
			:oncomplete( function() self.mode = mode.idle; cron.cancel(cronjob_); TEsound:stop('sfx_fred', true) end)

	self.mode = mode.up

	cronjob_ = cron.every(0.2, function()
										if self.mode == 'fred_up_1' then
											self.mode = 'fred_up_2'
										else
											self.mode = 'fred_up_1'
										end
									end
									)
	TEsound.play( _ingame_.sound['success'], 'sfx_fred', 0.4)
end

function Fred:quit()
	print('Fred:quit')
	-- reset the flux
	alpha_.value = 0
end

return Fred
