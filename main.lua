-- game & gamestate requires
local Game = require 'game'

-- global game states
require 'gamestates.loading'
require 'gamestates.main_menu'
require 'gamestates.pause_menu'
require 'gamestates.options_menu'
require 'gamestates.options_sound'
require 'gamestates.options_keyboard'
require 'gamestates.ingame'
require 'gamestates.gameover'
require 'gamestates.winning'
require 'gamestates.intro'

-- game instance
local ld32_game = nil	-- main game object

-------------------------------------------------------------------------
-- basic LÖVE callbacks used on this game; add more as needed
-------------------------------------------------------------------------
function love.load()
	ld32_game = Game:new() -- initialize game
end

function love.update(dt)
	ld32_game:baseUpdate(dt)
end

function love.draw()
	ld32_game:baseDraw()
end

function love.keypressed(key, code)
	ld32_game:baseKeypressed(key, code)
end

function love.keyreleased(key, code)
	ld32_game:baseKeyreleased(key, code)
end

function love.mousepressed(x,y,button)
	ld32_game:baseMousepressed(x,y,button)
end

function love.mousereleased(x,y,button)
	ld32_game:baseMousereleased(x,y,button)
end

function love.focus(f)
	ld32_game:baseFocus(f)
end

function love.quit()
	ld32_game:baseQuit()
end
