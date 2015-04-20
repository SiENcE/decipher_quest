local Game = require 'game'
local Intro = Game:addState('Intro')

local alpha_ = { value = 0 }

function Intro:enteredState()
	self:log('Entering Intro')

	love.graphics.setColor( 255, 255, 255, 0 )
	flux.to(alpha_, 2, { value = 255 }):ease("quadin")
	
	-- set loading font
	love.graphics.setNewFont( 'media/fonts/Motorwerk.ttf', 30)
end

function Intro:exitedState()
	self:log('Exiting Intro')
	
	love.graphics.setColor( 255, 255, 255, 255 )
end

function Intro:update( dt )
end

local textwidth = 0
function Intro:draw()
	love.graphics.setColor( 255, 255, 255, alpha_.value )
	_ingame_.texture[ 'intro' ]:draw( 0, 0 )

--	textwidth = love.graphics.getFont():getWidth("Intro")
--	love.graphics.print("Intro", GetScreenwidth()/2-textwidth/2, 540)
end

function Intro:keypressed(key, code)
	if alpha_.value >= 250 then
		TEsound.play( _menu_.sound['click'], 'sfx')
		self:gotoState('InGame')
	end
end

function Intro:keyreleased(key, code)
end

function Intro:mousepressed(x, y, button)
	if alpha_.value >= 250 then
		TEsound.play( _menu_.sound['click'], 'sfx')
		self:gotoState('InGame')
	end
end

function Intro:mousereleased(x, y, button)
end

return Intro
