-- Lexball <3
-- A haxball clone in Lua and Love2d.

local player = {
    -- position
    x = 0,
    y = 0,

    -- velocity
    v = {
        x = 0,
        y = 0
    },

    -- acceleration
    a = {
        x = 0,
        y = 0
    },

    -- radius
    r = 16,

    -- color
    color = {
        r = 32,
        g = 128,
        b = 255
    },

    draw = function()
        love.graphics.setColor(player.color.r, player.color.g, player.color.b)
        love.graphics.circle('fill', player.x, player.y, player.r)
    end,

    update = function(dt)
        -- update velocity
        player.v.x = 100 * dt * player.a.x + player.v.x
        player.v.y = 100 * dt * player.a.y + player.v.y

        -- update position
        player.x = dt * player.v.x + player.x
        player.y = dt * player.v.y + player.y
    end,

    move = {
        up = function()
            player.a.y = -1
        end,

        down = function()
            player.a.y = 1
        end,

        left = function()
            player.a.x = -1
        end,

        right = function()
            player.a.x = 1
        end,

        novertical = function()
            player.a.y = 0
        end,

        nohorizontal = function()
            player.a.x = 0
        end
    }
}

return player
