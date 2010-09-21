Gamestate.game = Gamestate.new()
local state = Gamestate.game
local city = City()
local mousex, mousey = love.mouse.getPosition()
local messages = {}
music.flute1:setVolume(1.2)
local ambientsounds = love.audio.newSource(sounds.oldtown, "stream")
local timer = 0

function state:enter(prev)
	soundmanager:playMusic(music.flute1)
	ambientsounds:setLooping(true)
	love.audio.play(ambientsounds)
	timer = 0
	images.advisor:play()
end

function state:update(dt)
	mousex, mousey = love.mouse.getPosition()
	soundmanager:update(dt)
	
	--Update the advisor animation if necessary
	if timer < 5 then
		images.advisor:update(dt)
		timer = timer+dt
	else
		images.advisor:seek(2)
		images.advisor:update(dt)
		images.advisor:stop()
	end
end

function state:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(images.background, 0, 0)
	
	images.advisor:draw(120, 38)
	love.graphics.draw(images.bubbletop, 248, 33)
	love.graphics.draw(images.bubblemiddle, 248, 153)
	love.graphics.draw(images.bubblebottom, 248, 169)
	
	--Lower portion
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
	
	--The advisor text
	love.graphics.setFont(fonts.normal28)
	love.graphics.setColor(91, 91, 91)
	love.graphics.print("My lord...", 321, 45)
	love.graphics.setFont(fonts.normal18)
	
	local toprint = "In year "
	for i=1, #tostring(city.year) do
		toprint = toprint.." "
	end
	toprint = toprint..", "
	for i=1, #tostring(city.starved) do
		toprint = toprint.." "
	end
	toprint = toprint.." died."
	love.graphics.print(toprint, 321, 80)
	
	toprint = ""
	for i=1, #tostring(city.migrated) do
		toprint = toprint.." "
	end
	toprint = toprint.." people came to the city."
	love.graphics.print(toprint, 321, 100)
	
	toprint = "You harvested "
	for i=1, #tostring(city.yield) do
		toprint = toprint.." "
	end
	toprint = toprint.." bushels per acre."
	love.graphics.print(toprint, 321, 120)
	
	toprint = "Rats ate "
	for i=1, #tostring(city.pests) do
		toprint = toprint.." "
	end
	toprint = toprint.." bushels."
	love.graphics.print(toprint, 321, 140)
	
	toprint = "Land is currently trading at "
	for i=1, #tostring(city.tradeValue) do
		toprint = toprint.." "
	end
	toprint = toprint.." bushels per acre."
	love.graphics.print(toprint, 321, 160)
	
	love.graphics.setFont(fonts.smallnumbers)
	love.graphics.print(city.year, 399, 75)
	love.graphics.print(city.starved, 426, 75)
	love.graphics.print(city.migrated, 321, 95)
	love.graphics.print(city.yield, 468, 115)
	love.graphics.print(city.pests, 408, 135)
	love.graphics.print(city.tradeValue, 605, 155)
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
