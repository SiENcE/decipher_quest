local Game = require 'game'
local PauseMenu = Game:addState('PauseMenu')

--local pausestate = false

function PauseMenu:enteredState()
	self:log('Entering PauseMenu')
	
	----------------------------------------------------------------------------------------------------------------------------------
	-- HINT: Every variable has to be local or use a different name than all other state, otherwise they are overwritten!!!!!!!!!!!!!!
	--		 Thats why it's usefull to use the statename in your variables!!!!
	----------------------------------------------------------------------------------------------------------------------------------
	self.pausemenu_screenshot = love.graphics.newImage(love.graphics.newScreenshot())

	TEsound.play( _menu_.sound['open_pausemenu'], 'gui_sfx')
end

function PauseMenu:exitedState()
	self:log('Exiting PauseMenu')
	
	love.graphics.setColor( 255, 255, 255, 255 )

	self.pausemenu_screenshot = nil
end

function PauseMenu:update( dt )
end

local textwidth = 0
function PauseMenu:draw()
	love.graphics.setColor( 128, 128, 128, 255 )
	love.graphics.draw(self.pausemenu_screenshot,0,0)
	love.graphics.setColor( 255, 255, 255, 255 )
	
	textwidth = love.graphics.getFont():getWidth("How to play?")
	love.graphics.print("How to play?", GetScreenwidth()/2-textwidth/2, GetScreenheight()/2-280)
	textwidth = love.graphics.getFont():getWidth("Drag the highlighted card letters onto the darker ones.")
	love.graphics.print("Drag the highlighted card letters onto the darker ones.", GetScreenwidth()/2-textwidth/2, GetScreenheight()/2-280+love.graphics.getFont():getHeight()+2)
	textwidth = love.graphics.getFont():getWidth("You have to find equivalent characters to form a useful word.")
	love.graphics.print("You have to find equivalent characters to form a useful word.", GetScreenwidth()/2-textwidth/2, GetScreenheight()/2-280+love.graphics.getFont():getHeight()*2+2)
	textwidth = love.graphics.getFont():getWidth("Press Fred the roboter to read or send a decoded message.")
	love.graphics.print("Press Fred the roboter to read or send a decoded message.", GetScreenwidth()/2-textwidth/2, GetScreenheight()/2-280+love.graphics.getFont():getHeight()*3+2)
	textwidth = love.graphics.getFont():getWidth("Beware: If you decipher wrong,")
	love.graphics.print("Beware: If you decipher wrong,", GetScreenwidth()/2-textwidth/2, GetScreenheight()/2-280+love.graphics.getFont():getHeight()*4+2)
	textwidth = love.graphics.getFont():getWidth("your planet gets damaged from the Space Blobs laserbeam !!!")
	love.graphics.print("your planet gets damaged from the Space Blobs laserbeam !!!", GetScreenwidth()/2-textwidth/2, GetScreenheight()/2-280+love.graphics.getFont():getHeight()*5+2)


	textwidth = love.graphics.getFont():getWidth("Press 'ESC' to continue the game.")
	love.graphics.print("Press 'ESC' to continue the game.", GetScreenwidth()/2-textwidth/2, GetScreenheight()/2)
	textwidth = love.graphics.getFont():getWidth("Press 'q' to go to MainMenu!")
	love.graphics.print("Press 'q' to go to MainMenu!", GetScreenwidth()/2-textwidth/2, GetScreenheight()/2-love.graphics.getFont():getHeight()+2)
end

function PauseMenu:keypressed(key, code)
	TEsound.play( _menu_.sound['click'], 'sfx')
	if key == 'q' then
		self:gotoState('MainMenu')
	end
	if key == 'escape' or key == 'p' then
		self:popState()
	end
end

function PauseMenu:keyreleased(key, code)
end

function PauseMenu:mousepressed(x, y, button)
end

function PauseMenu:mousereleased(x, y, button)
end

return PauseMenu
