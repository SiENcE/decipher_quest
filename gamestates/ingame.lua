local Game = require 'game'
local InGame = Game:addState('InGame')

-- includes
--local Gamemode = nil

local alpha_ = { value = 0 }
local tween_ = nil

-- gamemodes: tutorial, 1,2,3,4,5,...
function InGame:enteredState( gamemode )
	self:log('Entering InGame')
	local Gamemode = require("subclass/gamemode")	-- .. gamemode
	
	alpha_.value = 0
	
	self.gamemode = Gamemode:new()

	-- set loading font
	love.graphics.setNewFont( 'media/fonts/Motorwerk.ttf', 30)
	
	TEsound.playLooping( _menu_.sound['ANThology'], 'music', nil, 1.0)
end

function InGame:exitedState()
	self:log('Exiting InGame')
--	tween_:stop()
--	tween_ = nil
	self.gamemode:quit()
	self.gamemode = nil
	Gamemode = nil
end

function InGame:update( dt )
	self.gamemode:update( dt )
	
	if not self.gamemode.fred:isalive() then
--		flux.to(alpha_, 1, { value = 255 }):ease("quadout"):delay(1):oncomplete( function() self:gotoState('GameOver'); end )
		self:gotoState('GameOver');
	elseif self.gamemode:iswinning() then
		self:gotoState('Winning');
	end
end

function InGame:draw()
	_ingame_.texture['background_devider']:draw(0,0)

	-- seperate class to draw gamemode, parameters are needed here !!!!!!!!!
	self.gamemode:draw( 0, 0, 0, 1, 1)
	
	love.graphics.print( "fps: " .. GetFPS(), GetScreenwidth()-love.graphics.getFont():getWidth( "fps: " .. GetFPS() )-6, 0 )
	
	-- only for debug
--	love.graphics.print( "sounds: " .. tostring(TEsound.currentlyPlayingSources), GetScreenwidth()-love.graphics.getFont():getWidth( "sounds: " .. tostring(TEsound.currentlyPlayingSources) )-6, love.graphics.getFont():getHeight() )

	-- TODO: DELETE!!
	-- obsolete code when alpha_ is not defined!!!!!
	if alpha_.value > 0 then
		love.graphics.setColor( 0, 0, 0, alpha_.value )
		love.graphics.rectangle("fill", 0, 0, GetScreenwidth(), GetScreenheight())
	end
end

function InGame:keypressed(key, code)
	if key == 'escape' or key == 'p' then
		self:pushState('PauseMenu')
	end
end

function InGame:mousepressed(x,y,button)
	self.gamemode:mousepressed(x,y,button)
end

function InGame:mousereleased(x,y,button)
	self.gamemode:mousereleased(x,y,button)
end

return InGame
