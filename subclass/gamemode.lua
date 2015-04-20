-- Class
local class = require ( 'lib/middleclass' )
local Gamemode = class("Gamemode")

-- includes
local Card = require ("subclass/card")
local Fred = require ("subclass/fred")
local Monster = require ("subclass/monster")

--local letterlist_ = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' }
local stage_ = {}
stage_[1] = { scale = 0.4,
			 mode = 'plain',
			 chiper = {'H', 'E', 'L', 'L', 'O' },
			 damage = 10,
			 xoffset = 0,
			 yoffset = 30,
			}
stage_[2] = { scale = 0.4,
			 mode = 'cipher',							-- plain or cipher
			 chiper = {'D', 'E', 'S', 'T', 'R', 'O', 'Y' },	-- text to cipher or decipher
			 damage = 10,							-- damage for wrong answer
			 xoffset = 0,							-- x correction because of scaled cards
			 yoffset = 30,							-- y correction because of scaled cards
			}
stage_[3] = { scale = 0.4,
			 mode = 'plain',
			 chiper = {'P', 'E', 'A', 'C', 'E' },
			 damage = 10,
			 xoffset = 0,
			 yoffset = 30,
			}
stage_[4] = { scale = 0.4,
			 mode = 'cipher',							-- plain or cipher
			 chiper = {'F', 'I', 'G', 'H', 'T' },	-- text to cipher or decipher
			 damage = 10,							-- damage for wrong answer
			 xoffset = 0,							-- x correction because of scaled cards
			 yoffset = 30,							-- y correction because of scaled cards
			}
stage_[5] = { scale = 0.3,
			 mode = 'plain',							-- plain or cipher
			 chiper = {'P', 'L', 'E', 'A', 'S', 'E', 'N', 'O' },	-- text to cipher or decipher
			 damage = 10,							-- damage for wrong answer
			 xoffset = 0,							-- x correction because of scaled cards
			 yoffset = 50,							-- y correction because of scaled cards
			}
stage_[6] = { scale = 0.2,
			 mode = 'cipher',							-- plain or cipher
			 chiper = {'W', 'H', 'A', 'T', 'T', 'O', 'O', 'F', 'F', 'E', 'R' },	-- text to cipher or decipher
			 damage = 10,							-- damage for wrong answer
			 xoffset = 0,							-- x correction because of scaled cards
			 yoffset = 70,							-- y correction because of scaled cards
			}
stage_[7] = { scale = 0.4,
			 mode = 'plain',							-- plain or cipher
			 chiper = {'L', 'O', 'V', 'E' },	-- text to cipher or decipher
			 damage = 10,							-- damage for wrong answer
			 xoffset = 0,							-- x correction because of scaled cards
			 yoffset = 30,							-- y correction because of scaled cards
			}
stage_[8] = { scale = 0.2,
			 mode = 'plain',							-- plain or cipher
			 chiper = {'F', 'R', 'I', 'E', 'N', 'D', 'S', 'H', 'I', 'P' },	-- text to cipher or decipher
			 damage = 10,							-- damage for wrong answer
			 xoffset = 0,							-- x correction because of scaled cards
			 yoffset = 70,							-- y correction because of scaled cards
			}
stage_[9] = { scale = 0.3,
			 mode = 'cipher',							-- plain or cipher
			 chiper = {'O', 'K', 'F', 'R', 'I', 'E', 'N', 'D', 'S' },	-- text to cipher or decipher
			 damage = 10,							-- damage for wrong answer
			 xoffset = 0,							-- x correction because of scaled cards
			 yoffset = 50,							-- y correction because of scaled cards
			}

local start_stage_ = 1
local currentstage_ = start_stage_
local tutorialmode_ = false
local cronjob_ = nil
local winning_ = false

local cardlist_ = { }

function Gamemode:initialize()
	print('Gamemode:initialize')

	winning_ = false
	
	-- fred stays persistent over a gamesession
	self.fred = Fred:new( 580, 460 )
	
	-- new monster per stage
	self.monster = nil
	
	self:initstage( start_stage_ )
end


function Gamemode:initstage(stagenumber)
	currentstage_ = stagenumber
	local counter = 0
	local cardsize = 256/2*stage_[stagenumber].scale
	local startposx = 0 + stage_[stagenumber].xoffset
	local startposy = 160 + cardsize + stage_[stagenumber].yoffset
	local randomized_startposx_list = {}
	local startposx_list = {}

	math.randomseed(os.time())
	math.random(); math.random(); math.random()

	for key,letter in pairs(stage_[stagenumber].chiper) do
		table.insert( randomized_startposx_list, key, (GetScreenwidth()/tablelength(stage_[stagenumber].chiper) )*counter + cardsize )
		table.insert( startposx_list, key, (GetScreenwidth()/tablelength(stage_[stagenumber].chiper) )*counter + cardsize )
		counter = counter + 1
	end
	-- randomize one startposition array (regardless which)
	shuffleTable(randomized_startposx_list)
	shuffleTable(randomized_startposx_list)

	counter = 0
	-- monster
	self.monster = Monster:new( 0, 0,
		-- init card after monster is there !!!
		function()
			for key,letter in pairs(stage_[stagenumber].chiper) do
				counter = counter + 0.1
				card = {}
				if stage_[currentstage_].mode == 'plain' then
					card.plain=Card:new(      letter, stage_[stagenumber].scale, { x=randomized_startposx_list[key], y=startposy+140}, 'circin', counter )
					card.cipher=Card:new(letter..'_', stage_[stagenumber].scale, { x=startposx_list[key],            y=startposy	 }, 'cubicin', counter )
				else
					card.plain=Card:new(	  letter, stage_[stagenumber].scale, { x=startposx_list[key],            y=startposy+140}, 'circin', counter )
					card.cipher=Card:new(letter..'_', stage_[stagenumber].scale, { x=randomized_startposx_list[key], y=startposy	 }, 'cubicin', counter )
				end

				table.insert( cardlist_, card )
			end
		end
	)
end

local function getRawCard( card )
	if stage_[currentstage_].mode == 'plain' then
		rawcard = card.plain
	else
		rawcard = card.cipher
	end
	return rawcard
end

function Gamemode:update( dt )
	-- mouse drag
	for _,card in ipairs(cardlist_) do
		local v = getRawCard( card )
		if v.drag.active and v.drag.solved and tutorialmode_ then
			-- if tutorialmode_ and solved, not moveable !!!!!!!!
		elseif v.drag.active then
			print(v.letter)
			v.x = love.mouse.getX() - v.drag.diffX
			v.y = love.mouse.getY() - v.drag.diffY
		end
	end
	
	self.fred:update( dt )
	if self.monster then self.monster:update( dt ) end
end

function Gamemode:draw( x, y, ...)
	if stage_[currentstage_].mode == 'plain' then
		love.graphics.setBlendMode( 'multiplicative' )
		for _,card in pairs(cardlist_) do
			if not card.cipher.drag.active then
				card.cipher:draw( x, y, ... )
			end
		end
		love.graphics.setBlendMode( 'alpha' )
		for _,card in pairs(cardlist_) do
			if not card.plain.drag.active then
				card.plain:draw( x, y, ... )
			end
		end
		for _,card in pairs(cardlist_) do
			if card.plain.drag.active then
				card.plain:draw( x, y, ... )
			end
		end
	else
		love.graphics.setBlendMode( 'multiplicative' )
		for _,card in pairs(cardlist_) do
			if not card.plain.drag.active then
				card.plain:draw( x, y, ...)
			end
		end
		love.graphics.setBlendMode( 'alpha' )
		for _,card in pairs(cardlist_) do
			if not card.cipher.drag.active then
				card.cipher:draw( x, y, ... )
			end
		end
		for _,card in pairs(cardlist_) do
			if card.cipher.drag.active then
				card.cipher:draw( x, y, ... )
			end
		end
	end

	self.fred:draw( x, y, ... )
	
	if self.monster then self.monster:draw( x,y, ... ) end
end

function Gamemode:mousepressed(x, y, button)
	-- make dragging
	for _,card in ipairs(cardlist_) do
		local v = getRawCard( card )
		if button == "l"
			and x > v.x and x < v.x+v.width
			and y > v.y and y < v.y+v.height
		then
			v.drag.active = true
			v.drag.solved = false
			v.drag.diffX = x - v.x
			v.drag.diffY = y - v.y
			TEsound.play( _ingame_.sound['card_grab'], 'sfx', 0.5)
			break
		end
	end
end

function Gamemode:mousereleased(x, y, button)
	-- stop dragging
	for key,card in ipairs(cardlist_) do
		local v = getRawCard( card )

		-- when released check matching card position
		for keytemp,tempcard in ipairs(cardlist_) do
			local matchcard = nil
			if stage_[currentstage_].mode == 'plain' then
				matchcard = tempcard.cipher
			else
				matchcard = tempcard.plain
			end

			-- snap in and mark as solved
			if v.drag.active and not v.drag.solved then
				if isCollidingWith(v,matchcard) then
					if stage_[currentstage_].mode == 'plain' then
						if v.letter .. '_' == matchcard.letter then
							print(key, v.letter .. '_', keytemp, matchcard.letter,true)
							v.drag.solved = true

							if tutorialmode_ then
								TEsound.play( _ingame_.sound['card_drop_solved'], 'sfx')
							else
								TEsound.play( _ingame_.sound['card_drop_card'], 'sfx')
							end
						else
							print(key, v.letter .. '_', keytemp, matchcard.letter, false)
							TEsound.play( _ingame_.sound['card_drop_card'], 'sfx')
						end
						v.x = matchcard.x
						v.y = matchcard.y
					else
						if v.letter == matchcard.letter .. '_' then
							print(key, v.letter .. '_', keytemp, matchcard.letter,true)
							v.drag.solved = true
							
							if tutorialmode_ then
								TEsound.play( _ingame_.sound['card_drop_solved'], 'sfx')
							else
								TEsound.play( _ingame_.sound['card_drop_card'], 'sfx')
							end
						else
							print(key, v.letter .. '_', keytemp, matchcard.letter, false)
							TEsound.play( _ingame_.sound['card_drop_card'], 'sfx')
						end
						v.x = matchcard.x
						v.y = matchcard.y
					end
				else
					TEsound.play( _ingame_.sound['card_drop'], 'sfx')
				end
			end
		end
		
		if button == "l" then
			v.drag.active = false
		end
	end
	
	if self.fred:isalive() and tablelength(cardlist_) >= 1 then
		if button == "l" then
			if rectbound(x,y, self.fred.x, self.fred.y, self.fred.width, self.fred.height) then
				-- check winning condition, not one without a matchcard!!!!!!!
				local stage_solved = true
				for _,card in ipairs(cardlist_) do
					if stage_[currentstage_].mode == 'plain' and not card.plain.drag.solved then
						print('1',card.plain.letter, card.plain.drag.solved)
						stage_solved = false
						break
					elseif stage_[currentstage_].mode == 'cipher' and not card.cipher.drag.solved then
						print('2',card.plain.letter, card.plain.drag.solved)
						stage_solved = false
						break
					end
				end

				if stage_solved then
					self.fred:activate()
					
					if tablelength(stage_) >= currentstage_ + 1 then
						cronjob_ = cron.after( 2,
										function()
											self:cleanstage()
											currentstage_ = currentstage_ + 1
											self:initstage( currentstage_ )
										end
								)
					else
						SetScore( self.fred:gethealth() )
						winning_ = true
					end
				else
					self.monster:attack()
					self.fred:dodamage( stage_[currentstage_].damage )
				end
			end
		end
	end
end

function Gamemode:iswinning()
	return winning_
end

function Gamemode:cleanstage()
	if cronjob_ then
		cron.cancel(cronjob_)
		cronjob_ = nil
	end
	
	for key,card in ipairs(cardlist_) do
		card.plain:quit()
		card.cipher:quit()
		cardlist_[key] = nil
	end
end

function Gamemode:quit()
	print('Gamemode:quit')
	self:cleanstage()
	
	self.fred:quit()
	self.fred = nil
	
	self.monster:quit()
	self.monster = nil
end

return Gamemode
