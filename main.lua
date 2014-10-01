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

    -- load map object
    map = require 'map'

    -- load player object
    player = require 'player'
    player.x = map.w / 2
    player.y = map.h / 2

    -- load ball object
    ball = require 'ball'
    ball.x = map.w / 3
    ball.y = map.h /2
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

    -- collision detection player vs ball
    if sqdist(player, ball) < (player.r + ball.r) ^ 2 then
        -- null the accelerations
        player.a.x = 0
        player.a.y = 0
        ball.a.x = 0
        ball.a.y = 0

        -- calculate the velocities after elastic collision
        player.v.x = (player.v.x * (player.m - ball.m) + 2 * ball.m * ball.v.x) / (player.m + ball.m)
        player.v.y = (player.v.y * (player.m - ball.m) + 2 * ball.m * ball.v.y) / (player.m + ball.m)
        ball.v.x = (ball.v.x * (ball.m - player.m) + 2 * player.m * player.v.x) / (ball.m + player.m)
        ball.v.y = (ball.v.y * (ball.m - player.m) + 2 * player.m * player.v.y) / (ball.m + player.m)
    end

    -- update objects
    ball.update(dt)
    player.update(dt)
end

function love.draw()
    ball.draw()
    player.draw()

    -- debug
    --print('Player (' .. player.x .. ', ' .. player.y .. ')')
    --print('Ball (' .. ball.x .. ', ' .. ball.y .. ')')
end

function sqdist(a, b)
    return (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2
end

function dist(a, b)
    return math.sqrt(sqdist(a, b))
end
