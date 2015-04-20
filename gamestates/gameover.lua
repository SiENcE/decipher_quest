local Game = require 'game'
local GameOver = Game:addState('GameOver')

local alpha_ = { value = 0 }

function GameOver:enteredState()
	self:log('Entering GameOver')
	love.graphics.setColor( 255, 255, 255, 0 )
	flux.to(alpha_, 2, { value = 255 }):ease("quadin")
	
	TEsound.stop("music", false)
end

function GameOver:exitedState()
	self:log('Exiting GameOver')
	
	love.graphics.setColor( 255, 255, 255, 255 )
end

function GameOver:update( dt )
end

local textwidth = 0
function GameOver:draw()
	love.graphics.setColor( 255, 255, 255, alpha_.value )
	_ingame_.texture[ 'gameover' ]:draw( 0, 0 )

	-- no highscore when gameover
--[[
	score = GetScore()
	if score then
		textwidth = love.graphics.getFont():getWidth( "Score: " .. tostring(score) )
		love.graphics.print( "Score: " .. tostring(score) , 1078-textwidth/2, 616)
	else
		textwidth = love.graphics.getFont():getWidth( "Score: 0" )
		love.graphics.print( "Score: 0" , 1078-textwidth/2, 616)
	end
]]--
end

function GameOver:keypressed(key, code)
	if alpha_.value >= 250 then
		TEsound.play( _menu_.sound['click'], 'sfx')
		self:gotoState('MainMenu')
	end
end

function GameOver:keyreleased(key, code)
end

function GameOver:mousepressed(x, y, button)
	if alpha_.value >= 250 then
		TEsound.play( _menu_.sound['click'], 'sfx')
		self:gotoState('MainMenu')
	end
end

function GameOver:mousereleased(x, y, button)
end

return GameOver
