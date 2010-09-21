require("lib/gamestate")
require("lib/soundmanager")
require("lib/utils")
require("lib/class")
require("city.lua")
require("lib/AnAL.lua")

function love.load()
	love.graphics.setBackgroundColor(241, 230, 211)
	
	--get us a randomseed before generating random data
	math.randomseed(love.timer.getMicroTime()*1000000)

	--load the images
	images = {}
	loadfromdir(images, "gfx", "png", love.graphics.newImage)
	--load the sound (effects)
	sounds = {}
	loadfromdir(sounds, "snd/sfx", "ogg", love.sound.newSoundData)

	--and the music
	music = {}
	loadfromdir(music, "snd/music", "ogg", love.audio.newSource)

	--load fonts
	fonts = {
		menu = love.graphics.newFont("gfx/fonts/DarkAge.TTF", 40),
		largenumbers = love.graphics.newFont("gfx/fonts/PrViking.TTF", 56),
		smallnumbers = love.graphics.newFont("gfx/fonts/PrViking.TTF", 18),
		normal18 = love.graphics.newFont("gfx/fonts/DarkAge.TTF", 18),
		normal22 = love.graphics.newFont("gfx/fonts/DarkAge.TTF", 22),
		normal24 = love.graphics.newFont("gfx/fonts/DarkAge.TTF", 24),
		normal28 = love.graphics.newFont("gfx/fonts/DarkAge.TTF", 28)
		
	}
	
	--Move trophies if needed
	--[[local lfs = love.filesystem
	local trophytable = lfs.enumerate("gfx/trophies/")
	if not lfs.exists("trophies") then
		lfs.mkdir("trophies")
	end
	
	for i,v in ipairs(trophytable) do
		local name = string.gsub(v, "[ -]", "_")
		local name = string.lower(name)
		local src = "gfx/trophies/"..v
		local dest = "trophies/"..name
		if not lfs.exists(dest) then
			print(dest.." doesn't seem to exist")
			if lfs.write(dest, lfs.read(src)) then
				print("Writing to "..dest.." worked!")
			else
				print("Writing to "..dest.." failed.")
			end
		end
	end
	
	counter = {}
	--Load stats
	if not lfs.exists("counter") then
		counter = {
			cleared=0,
			helpers=0,
			tricksters=0,
			score=0,
			played=0,
		}
		lfs.write("counter", TSerialize(counter))
	else
		counter = loadstring(lfs.read("counter"))()
	end ]]--
	
	for i,v in ipairs(love.filesystem.enumerate("states")) do
		require("states/"..v)
	end
	
	require("lib/achievements")
	Gamestate.registerEvents()
	Gamestate.switch(Gamestate.menu)
end

function love.update(dt)
	
end
