-- Lexball <3
-- A haxball clone in Lua and Love2d.

Player = {}

function Player:new()
    return setmetatable({

        -- center position
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

        -- mass
        m = 100,

        -- radius
        r = 16,

        -- color
        color = {
            r = 32,
            g = 128,
            b = 255
        }

    }, {__index = Player})
end

function Player:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    love.graphics.circle('fill', self.x, self.y, self.r)
end

function Player:update(dt)
    -- update velocity
    self.v.x = 10000 * dt * self.a.x + self.v.x
    self.v.y = 10000 * dt * self.a.y + self.v.y

    -- update position
    self.x = dt * self.v.x + self.x
    self.y = dt * self.v.y + self.y
end

function Player:friction(f)
    self.v.x = self.v.x - f * self.v.x
    self.v.y = self.v.y - f * self.v.y
end
