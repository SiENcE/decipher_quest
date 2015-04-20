local res = {}
res.image = {
--[[
	{'A', 'media/images/A.png' },
	{'A_', 'media/images/A_.png' },

	{'H', 'media/images/H.png' },
	{'H_', 'media/images/H_.png' },

	{'E', 'media/images/E.png' },
	{'E_', 'media/images/E_.png' },

	{'L', 'media/images/L.png' },
	{'L_', 'media/images/L_.png' },

	{'O', 'media/images/O.png' },
	{'O_', 'media/images/O_.png' },
]]--
	{'atlas_letters1', 'media/images/atlas_letters1.png',
		quad = {
			['A']={ 774, 774, 256, 256, 2048, 2048 },
			['A_']={ 1548, 1290, 256, 256, 2048, 2048 },
			['B']={ 1548, 1032, 256, 256, 2048, 2048 },
			['B_']={ 1548, 774, 256, 256, 2048, 2048 },
			['C']={ 1548, 516, 256, 256, 2048, 2048 },
			['C_']={ 1548, 258, 256, 256, 2048, 2048 },
			['D']={ 1548, 0, 256, 256, 2048, 2048 },
			['D_']={ 1290, 1548, 256, 256, 2048, 2048 },
			['E']={ 1290, 1290, 256, 256, 2048, 2048 },
			['E_']={ 1290, 1032, 256, 256, 2048, 2048 },
			['F']={ 1290, 774, 256, 256, 2048, 2048 },
			['F_']={ 1290, 516, 256, 256, 2048, 2048 },
			['G']={ 1290, 258, 256, 256, 2048, 2048 },
			['G_']={ 1290, 0, 256, 256, 2048, 2048 },
			['H']={ 1032, 1548, 256, 256, 2048, 2048 },
			['H_']={ 1032, 1290, 256, 256, 2048, 2048 },
			['I']={ 1032, 1032, 256, 256, 2048, 2048 },
			['I_']={ 1032, 774, 256, 256, 2048, 2048 },
			['J']={ 1032, 516, 256, 256, 2048, 2048 },
			['J_']={ 1032, 258, 256, 256, 2048, 2048 },
			['K']={ 1032, 0, 256, 256, 2048, 2048 },
			['K_']={ 774, 1548, 256, 256, 2048, 2048 },
			['L']={ 774, 1290, 256, 256, 2048, 2048 },
			['L_']={ 774, 1032, 256, 256, 2048, 2048 },
			['M']={ 1548, 1548, 256, 256, 2048, 2048 },
			['M_']={ 774, 516, 256, 256, 2048, 2048 },
			['N']={ 774, 258, 256, 256, 2048, 2048 },
			['N_']={ 774, 0, 256, 256, 2048, 2048 },
			['O']={ 516, 1548, 256, 256, 2048, 2048 },
			['O_']={ 516, 1290, 256, 256, 2048, 2048 },
			['P']={ 516, 1032, 256, 256, 2048, 2048 },
			['P_']={ 516, 774, 256, 256, 2048, 2048 },
			['Q']={ 516, 516, 256, 256, 2048, 2048 },
			['Q_']={ 516, 258, 256, 256, 2048, 2048 },
			['R']={ 516, 0, 256, 256, 2048, 2048 },
			['R_']={ 258, 1548, 256, 256, 2048, 2048 },
			['S']={ 258, 1290, 256, 256, 2048, 2048 },
			['S_']={ 258, 1032, 256, 256, 2048, 2048 },
			['T']={ 258, 774, 256, 256, 2048, 2048 },
			['T_']={ 258, 516, 256, 256, 2048, 2048 },
			['U']={ 258, 258, 256, 256, 2048, 2048 },
			['U_']={ 258, 0, 256, 256, 2048, 2048 },
			['V']={ 0, 1548, 256, 256, 2048, 2048 },
			['V_']={ 0, 1290, 256, 256, 2048, 2048 },
			['W']={ 0, 1032, 256, 256, 2048, 2048 },
			['W_']={ 0, 774, 256, 256, 2048, 2048 },
			['X']={ 0, 516, 256, 256, 2048, 2048 },
			['X_']={ 0, 258, 256, 256, 2048, 2048 },
			['Y']={ 0, 0, 256, 256, 2048, 2048 }
		},
	},
	{'atlas_letters2', 'media/images/atlas_letters2.png',
		quad = {
			['Y_']={ 0, 516, 256, 256, 512, 1024 },
			['Z']={ 0, 258, 256, 256, 512, 1024 },
			['Z_']={ 0, 0, 256, 256, 512, 1024 }
		},
	},
	
	{'fred_idle', 'media/images/fred_idle.png' },	-- idle
	{'fred_up_1', 'media/images/fred_up_1.png' },	-- arms up
	{'fred_up_2', 'media/images/fred_up_2.png' },	-- arms up
	
	{'fred_damage_1', 'media/images/fred_damage_1.png' },
	{'fred_damage_2', 'media/images/fred_damage_2.png' },
	{'fred_damage_3', 'media/images/fred_damage_3.png' },
	{'fred_damage_4', 'media/images/fred_damage_4.png' },
	{'fred_damage_5', 'media/images/fred_damage_5.png' },
	{'fred_damage_6', 'media/images/fred_damage_6.png' },
	{'fred_damage_7', 'media/images/fred_damage_7.png' },
	{'fred_damage_8', 'media/images/fred_damage_8.png' },
	{'fred_damage_9', 'media/images/fred_damage_9.png' },
	{'fred_damage_10', 'media/images/fred_damage_10.png' },

	
	{'background_alien_1', 'media/images/background_alien_1.png' },
	{'background_devider', 'media/images/background_devider.png' },

	{'gameover', 'media/images/gameover.png' },
	{'winning', 'media/images/winning.png' },
	{'intro', 'media/images/intro.png' },
}
res.imagedata = {
}
--Creates a new Source from a filepath, File, Decoder (steam/static) or SoundData.
res.source = {
}
--Contains raw audio samples. You can not play SoundData back directly. You must wrap a 'Source' object around it.
-- Sounddata -> Source -> play() -- soundata is automatically converted into source by TESound (mod. by me)
res.sounddata = {
	{'card_drop',       	'media/sounds/card_drop.wav'},
	{'card_drop_card',       	'media/sounds/card_drop_card.wav'},
	{'card_drop_solved',	'media/sounds/card_drop_solved.wav'},
	{'card_grab',	'media/sounds/card_grab.wav'},
	{'laser_shoot',	'media/sounds/laser_shoot.wav'},
	{'explosion',	'media/sounds/explosion.wav'},
	{'success',	'media/sounds/success.wav'},
	{'hit',	'media/sounds/hit.wav'},
}

return res
