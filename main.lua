-- Lexball <3
-- A haxball clone in Lua and Love2d.

function love.load()
    -- version info
    version = 'Lexball 1.0 (20141001)'
    print(version)

    -- window
    window = {
        w = 800,
        h = 600
    }
    love.window.setTitle(version)
    love.window.setMode(window.w, window.h)

    -- load player object
    player = require('player')
    player.x = window.w / 2
    player.y = window.h / 2
end

function love.update(dt)
    -- handle keyboard events
    if love.keyboard.isDown('up') then
        player.move.up()
    elseif love.keyboard.isDown('down') then
        player.move.down()
    else
        player.move.novertical()
    end
    if love.keyboard.isDown('left') then
        player.move.left()
    elseif love.keyboard.isDown('right') then
        player.move.right()
    else
        player.move.nohorizontal()
    end

    player.update(dt)
end

function love.draw()
    player.draw()
end
