Gamestate.menu = Gamestate.new()
local state = Gamestate.menu
local mousex, mousey = love.mouse.getPosition()
local selected = 0
local prevselected = 0
local options = {"Start new kingdom", "Retire"}
local optionwidths = {}
for i,v in ipairs(options) do
	table.insert(optionwidths, {h=0,w=0})
	optionwidths[i].w = fonts.menu:getWidth(v)
	optionwidths[i].h = fonts.menu:getHeight(v)
end
local bushel = newAnimation(images.bushels, 72, 256, 0.1, 16)
bushel:setMode("bounce")

function state:enter()
	prevselected = 0
	selected = 0
	love.graphics.setFont(fonts.menu)
	soundmanager:playMusic(music.flute2)
	soundmanager:play(sounds.wind, true)
end

function state:update(dt)
	soundmanager:update(dt)
	bushel:update(dt)
	mousex, mousey = love.mouse.getPosition()
	selected = 0
	
	for i,v in ipairs(optionwidths) do
		if mousex > 512-v.w/2 and mousex < 512+v.w/2 then
			if mousey > 298+(i-1)*59 and mousey < 370+(i-1)*59+v.h then
				selected = i
			end
		end
	end
	
	if selected ~= prevselected and selected ~= 0 then
		soundmanager:play(sounds.gonga)
	end
	
	prevselected = selected
end

function state:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(images.background, 0, 0)
	love.graphics.draw(images.titletext, 273, 122)
	bushel:draw(145, 443)
	
	for i,v in ipairs(options) do
		if selected == i then
			love.graphics.setColor(20,20,20)
		else
			love.graphics.setColor(78,78,78)
		end
		love.graphics.printf(v, 0, 298+(i-1)*59, 1024, "center")
	end
end

function state:keypressed(key, unicode)
	if key == "escape" then
		love.event.push('q')
	end
end

function state:mousereleased(x,y,button)
	if selected == 1 then
		love.audio.play(love.audio.newSource(sounds.conga, "static"))
		Gamestate.switch(Gamestate.game)
	elseif selected == 2 then
		love.event.push('q')
	end
end
