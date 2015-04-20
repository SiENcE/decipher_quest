local Game = require 'game'
local Winning = Game:addState('Winning')

local alpha_ = { value = 0 }

function Winning:enteredState()
	self:log('Entering Winning')
	
	love.graphics.setColor( 255, 255, 255, 0 )
	flux.to(alpha_, 2, { value = 255 }):ease("quadin")
	
	TEsound.stop("music", false)
	TEsound.play( _menu_.sound['winning'], 'sfx')
end

function Winning:exitedState()
	self:log('Exiting Winning')
	
	love.graphics.setColor( 255, 255, 255, 255 )
end

function Winning:update( dt )
end

local textwidth = 0
local score = 0
function Winning:draw()
	love.graphics.setColor( 255, 255, 255, alpha_.value )
	_ingame_.texture[ 'winning' ]:draw( 0, 0 )

	score = GetScore()
	if score then
		textwidth = love.graphics.getFont():getWidth( "Score: " .. tostring(score) )
		love.graphics.print( "Score: " .. tostring(score) , 1078-textwidth/2, 616)
	else
		textwidth = love.graphics.getFont():getWidth( "Score: 0" )
		love.graphics.print( "Score: 0" , 1078-textwidth/2, 616)
	end
end

function Winning:keypressed(key, code)
	if alpha_.value >= 250 then
		TEsound.play( _menu_.sound['click'], 'sfx')
		self:gotoState('MainMenu')
	end
end

function Winning:keyreleased(key, code)
end

function Winning:mousepressed(x, y, button)
	if alpha_.value >= 250 then
		TEsound.play( _menu_.sound['click'], 'sfx')
		self:gotoState('MainMenu')
	end
end

function Winning:mousereleased(x, y, button)
end

return Winning
