local Game = require 'game'
local MainMenu = require 'gamestates.main_menu'

local SoundMenu = Game:addState('SoundMenu', MainMenu)

-- local includes
local Menu     = require 'lib.menu'

function SoundMenu:enteredState()
  self:log('Entering SoundMenu')

  self.sndmenu = Menu:new({
    { 'toggle Music', function()
					if TEsound.music then
						TEsound.music = false
						TEsound.stop("music", false)
					else
						TEsound.music = true
						TEsound.playLooping( _menu_.sound['ANThology'], 'music', nil, 1.0)
					end
					end },
    { 'Back', function() self:popState() end },
  })
end

function SoundMenu:exitedState()
  self.sndmenu = nil
  self:log('Exiting SoundMenu')
end

function SoundMenu:draw()
	_menu_.texture[ 'mainmenu' ]:draw( 0, 0 )
	self.sndmenu:draw()
end

function SoundMenu:keypressed(key, code)
  if key == 'escape' then
    self:popState()
  end
end

function SoundMenu:mousepressed(x,y,button)
	TEsound.play( _menu_.sound['click'], 'gui_sfx')
	
	self.sndmenu:mousepressed(x,y,button)
end

return SoundMenu
