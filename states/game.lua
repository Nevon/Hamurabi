Gamestate.game = Gamestate.new()
local state = Gamestate.game
local city = {}
local mousex, mousey = love.mouse.getPosition()
local messages = {}
music.flute1:setVolume(1.2)
local ambientsounds = love.audio.newSource(sounds.oldtown, "stream")

function state:enter(prev)
	--if prev == Gamestate.load then
	--end
	soundmanager:playMusic(music.flute1)
	ambientsounds:setLooping(true)
	love.audio.play(ambientsounds)
	city = City()
end

function state:update(dt)
	mousex, mousey = love.mouse.getPosition()
	soundmanager:update(dt)
end

function state:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(images.background, 0, 0)
	
	love.graphics.draw(images.advisor, 120, 38)
	love.graphics.draw(images.bubbletop, 248, 33)
	
	love.graphics.draw(images.panel, 41, 441)
	love.graphics.draw(images.population, 109, 504)
	love.graphics.draw(images.acres, 397, 517)
	love.graphics.draw(images.bushel, 666, 507)
	
	love.graphics.setColor(109, 109, 109)
	love.graphics.setFont(fonts.largenumbers)
	love.graphics.print(city.population, 241, 495)
	love.graphics.print(city.acres, 484, 495)
	love.graphics.print(city.bushels, 740, 495)
	
	if mousey >= 495 and mousey <= 582 then
		love.graphics.setFont(fonts.normal22)
		if mousex >= 144 and mousex <= 370 then
			love.graphics.print("Population", 214, 593)
		elseif mousex >= 397 and mousex <= 630 then
			love.graphics.print("Acres", 485, 593)
		elseif mousex >= 666 and mousex <= 940 then
			love.graphics.print("Bushels", 763, 593)
		end
	end
	
	love.graphics.setFont(fonts.normal28)
	love.graphics.setColor(91, 91, 91)
	love.graphics.print("My lord...", 321, 62)
end

function state:mousereleased(x,y, button)
	if x >= 335 and x <= 789 and 
	y >= 475 and y <= 504 then
		city:passYear()
	end
end

function state:keypressed(key, unicode)
	if key == "escape" then
		Gamestate.switch(Gamestate.menu)
	elseif key == "f11" then
		love.graphics.toggleFullscreen()
	end
end
