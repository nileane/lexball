-- Lexball <3
-- A haxball clone in Lua and Love2d.

local map = {
    w = 800,
    h = 600,

    goals = {
        top = 280,
        bottom = 320
    },

    ground = love.graphics.newImage('assets/rpgTile019.png'),

    draw = function()
        love.graphics.setColor(255, 255, 255, 255)
        x = 0
        while (x < map.w) do
            y = 0
            while (y < map.h) do
                love.graphics.draw(map.ground, x, y)
                y = y + 32
            end
            x = x + 32
        end
    end
}

return map
