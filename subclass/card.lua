-- Class
local class = require ( 'lib/middleclass' )
local Card = class("Card")

local alpha = { value = 0 }
local cardsize = 256

function Card:initialize( letter, scale, startpos, ease_type, delay )
	print('Card:initialize', letter)
	self.letter = letter
	self.scale = scale or 1
	self.startpos = startpos
	self.x = 0
	self.y = 0
	
	-- debug letter fix
--	if not _ingame_.texture[self.letter] then
--		self.letter = 'A'
--	end
	
	self.width = cardsize*self.scale
	self.height = cardsize*self.scale
	self.center = { x=0, y=0}
	self.center.x = self.width/2
	self.center.y = self.height/2
	self.drag =  {
					active = false,
					solved = false,
					diffX = 0,
					diffY = 0
				}

	-- do some flux
	flux.to(alpha, 1, { value = 255 }):ease("linear"):delay(delay or 0.5) -- :oncomplete( function() start game timer end )
--	flux.to(self.startpos, 1, { y = startpos.x }):ease( ease_type or "linear"):delay(0.5)
	self.x = self.startpos.x
	flux.to(self, 1, { y = startpos.y }):ease( ease_type or "linear"):delay(delay or 0.5)
end

function Card:update( dt )
end

function Card:draw( x, y, r, sx, sy, ...)
	love.graphics.setColor( 255, 255, 255, alpha.value )
	if _ingame_.texture[ self.letter ] then
		_ingame_.texture[ self.letter ]:draw( self.x+x, self.y+y, r, self.scale*sx, self.scale*sy, ... )
	end
	love.graphics.setColor( 255, 255, 255, 255 )
end

function Card:quit()
	print('Card:quit', self.letter)
	-- reset the flux
	alpha.value = 0
end

return Card
