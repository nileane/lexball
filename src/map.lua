-- Lexball <3
-- A haxball clone in Lua and Love2d.

Map = {}

function Map:new()
    return setmetatable({

        w = 800,
        h = 600,

        -- friction, float value between 0 and 1
        -- (0 means no friction at all, like in space)
        friction = 0.005,

        goals = {
            top = 280,
            bottom = 320
        },

        ground = love.graphics.newImage('assets/grass.png')

    }, {__index = Map})
end

function Map:draw()
    love.graphics.setColor(255, 255, 255, 255)
    x = 0
    while (x < self.w) do
        y = 0
        while (y < self.h) do
            love.graphics.draw(self.ground, x, y)
            y = y + 64
        end
        x = x + 64
    end
end
