local class = require ( 'lib/middleclass' )
local Stateful = require ( 'lib/stateful' )
local Game = class('Game'):include(Stateful)

-- includes
flux	 = require "lib.flux"
cron     = require 'lib.cron'
require 'subclass/utils'
require 'lib/TEsound'

--debug music
TEsound.sound=true
TEsound.music=true

-- global Ressources
_menu_ = { image = {}, texture = {}, sound = {} }
_ingame_ = { image = {}, texture = {}, sound = {} }

local fps_ = 0
--local paused_ = false
local screenwidth, screenheight = 1280,720

local score_ = 0

--------------------------------------------------------------------------------
-- global Functions
--------------------------------------------------------------------------------
function GetFPS()
	return fps_
end
--[[
-- Pause Options
function GetPaused()
	return paused_
end

function Pause()
	print('Pause!!!!!!!!!!!!!')
	paused_ = true
end

function UnPause()
	print('UnPause!!!!!!!!!!!!!')
	paused_ = false
end
]]--
-- Screen Options
function GetScreenwidth()
	return screenwidth
end

function GetScreenheight()
	return screenheight
end

function SetScore( score )
	score_ = score
end

function GetScore()
	return score_
end

-- manage debug print outs (disable __print to disable print outs!)
local __print = print --old function
function print( ... )
--	__print ( ... )
end

----------------------------------------------------------------
-- Also include "default safe" methods for the callbacks
-- This way we don't have to define "mousepressed" on the states that don't need it
----------------------------------------------------------------
function Game:update(dt)
end
function Game:draw()
end
function Game:keypressed(key,unicode)
end
function Game:keyreleased(key,unicode)
end
function Game:mousepressed(x, y, button)
end
function Game:mousereleased(x, y, button)
end
function Game:focus()
end
function Game:quit()
end

--------------------------------------------------------------------------------
-- main functions
--------------------------------------------------------------------------------
function Game:initialize()
	local success = love.window.setMode( screenwidth, screenheight )
	love.graphics.setDefaultFilter( 'nearest', 'nearest' )

	-- menu ressources
	self:gotoState('Loading', 'MainMenu', require( 'subclass/menuressources' ), _menu_ )
end

function Game:baseUpdate(dt)
	fps_ = love.timer.getFPS()
	
	screenwidth, screenheight = love.graphics.getWidth(), love.graphics.getHeight()
	
	-- update music/sound
	TEsound.cleanup()
	
	cron.update(dt)
	flux.update(dt)
	
	-- call standard
	self:update(dt)
end

function Game:baseDraw()
	-- draw game
	self:draw()
end

-- by default, exit when pressing 'escape'
function Game:baseKeypressed(key, code)
	print( 'Game:baseKeypressed', key )
	-- call standard
	self:keypressed(key,unicode)
end

function Game:baseKeyreleased(key, code)
	-- call standard
	self:keyreleased(key,unicode)
end

function Game:baseMousepressed(x,y,button)
	-- call standard
	self:mousepressed(x, y, button)
end

function Game:baseMousereleased(x,y,button)
	-- call standard
	self:mousereleased(x, y, button)
end

function Game:baseFocus(f)
end

function Game:baseQuit()
	-- call standard
	self:quit()
end

-- Include the methods available in all states here

-- prints output in the console
-- If you are on windows you will need to activate it first, see
--   https://love2d.org/wiki/Config_Files
-- for details (you have to set t.console to true)
function Game:log(...)
  print(...)
end

function Game:exit()
  self:log("Goodbye!")
  love.event.push('quit')
end

return Game
