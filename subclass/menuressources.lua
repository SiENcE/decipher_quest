local res = {}
res.image = {
	{'mainmenu', 'media/images/mainmenu.png' },
}
res.imagedata = {
}
--Creates a new Source from a filepath, File, Decoder (steam/static) or SoundData.
res.source = {
	{'ANThology', 'media/music/001_SiENcE_-_ANThology.ogg', 'stream'},
}
--Contains raw audio samples. You can not play SoundData back directly. You must wrap a 'Source' object around it.
-- Sounddata -> Source -> play() -- soundata is automatically converted into source by TESound (mod. by me)
res.sounddata = {
	{'click',       	'media/sounds/click.ogg'},
	{'open_pausemenu',	'media/sounds/open_pausemenu.wav'},
	{'winning',	'media/sounds/winning.wav'},
}

return res
