-- Lexball <3
-- A haxball clone in Lua and Love2d.

function love.load()
    -- version info
    version = 'Version 1.0 (20141002)'
    ascii = [[
 _              _           _ _
| |    _____  _| |__   __ _| | |
| |   / _ \ \/ / '_ \ / _` | | |
| |__|  __/>  <| |_) | (_| | | |
|_____\___/_/\_\_.__/ \__,_|_|_|
    ]]

    print(ascii)
    print(version)

    -- window
    window = {
        w = 800,
        h = 600
    }
    love.window.setTitle(version)
    love.window.setMode(window.w, window.h)

    -- load map object
    map = require 'src/map'

    -- load player object
    player = require 'src/player'
    player.x = map.w / 2
    player.y = map.h / 2

    -- load ball object
    ball = require 'src/ball'
    ball.x = map.w / 3
    ball.y = map.h /2
end

function love.update(dt)
    -- handle keyboard events
    if love.keyboard.isDown('up') then
        player.a.y = -1
    elseif love.keyboard.isDown('down') then
        player.a.y = 1
    else
        player.a.y = 0
    end
    if love.keyboard.isDown('left') then
        player.a.x = -1
    elseif love.keyboard.isDown('right') then
        player.a.x = 1
    else
        player.a.x = 0
    end

    -- collision detection player vs ball
    local collision = sqdist(player, ball) < (player.r + ball.r) ^ 2
    -- radii vector player-ball
    local radii = {
        x = (ball.x - player.x),
        y = (ball.y - player.y)
    }
    -- make sure the 2 objects are moving towards each other
    local convergent = dot({ x = ball.v.x - player.v.x, y = ball.v.y - player.v.y }, radii) < 0
    if collision and convergent then
        -- normal collision vector
        local normal = normalize(radii)

        -- decompose velocity vectors into collision and remaining parts using dot product projection
        local dot_player = dot(player.v, normal)
        local dot_ball = dot(ball.v, normal)

        -- calculate collision velocity
        local vcoll_player = {
            x = dot_player * normal.x,
            y = dot_player * normal.y
        }
        local vcoll_ball= {
            x = dot_ball * normal.x,
            y = dot_ball * normal.y
        }

        -- calculate remaining velocity
        local vrem_player = {
            x = player.v.x - vcoll_player.x,
            y = player.v.y - vcoll_player.y
        }
        local vrem_ball= {
            x = ball.v.x - vcoll_ball.x,
            y = ball.v.y - vcoll_ball.y
        }

        -- apply elastic collision with conservation of momentum using the collision part only
        local vref_player = {
            x = ((player.m - ball.m) * vcoll_player.x + 2 * ball.m * vcoll_ball.x) / (player.m + ball.m),
            y = ((player.m - ball.m) * vcoll_player.y + 2 * ball.m * vcoll_ball.y) / (player.m + ball.m)
        }
        local vref_ball = {
            x = ((ball.m - player.m) * vcoll_ball.x + 2 * player.m * vcoll_player.x) / (ball.m + player.m),
            y = ((ball.m - player.m) * vcoll_ball.y + 2 * player.m * vcoll_player.y) / (ball.m + player.m)
        }

        -- put everything back into the total velocity vectors
        player.v.x = vref_player.x + vrem_player.x
        player.v.y = vref_player.y + vrem_player.y
        ball.v.x = vref_ball.x + vrem_ball.x
        ball.v.y = vref_ball.y + vrem_ball.y
    end

    -- update actual objects
    player.update(dt)
    ball.update(dt)
end

function love.draw()
    map.draw()
    ball.draw()
    player.draw()
end

function sqdist(a, b)
    return (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2
end

function dist(a, b)
    return math.sqrt(sqdist(a, b))
end

function normalize(v)
    norm = math.sqrt(v.x ^ 2 + v.y ^ 2)
    v.x = v.x / norm
    v.y = v.y / norm
    return v
end

function dot(u, v)
    return (u.x * v.x + u.y * v.y)
end
