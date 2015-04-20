local Game = require 'game'
local MainMenu = require 'gamestates.main_menu'

local KeyboardMenu = Game:addState('KeyboardMenu', MainMenu)

-- local includes
local Menu     = require 'lib.menu'

function KeyboardMenu:enteredState()
  self:log('Entering KeyboardMenu')

  self.keymenu = Menu:new({
    { 'toggle Fullscreen', function() love.window.setFullscreen( not love.window.getFullscreen() ) end },
    { 'Back', function() self:popState() end },
  })
end

function KeyboardMenu:exitedState()
  self.keymenu = nil
  self:log('Exiting KeyboardMenu')
end

function KeyboardMenu:draw()
	_menu_.texture[ 'mainmenu' ]:draw( 0, 0 )
	self.keymenu:draw()
end

function KeyboardMenu:keypressed(key, code)
  if key == 'escape' then
	self:popState()
  end
end

function KeyboardMenu:mousepressed(x,y,button)
	TEsound.play( _menu_.sound['click'], 'gui_sfx')
	
	self.keymenu:mousepressed(x,y,button)
end

return KeyboardMenu
