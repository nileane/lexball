-- Lexball <3
-- A haxball clone in Lua and Love2d.

Ball = {}

function Ball:new()
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
        m = 50,

        -- radius
        r = 11,

        -- color
        color = {
            r = 255,
            g = 255,
            b = 255
        },

        ball = love.graphics.newImage('assets/ball.png')

    }, {__index = Ball})
end

function Ball:draw()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    --love.graphics.circle('fill', self.x, self.y, self.r)
    love.graphics.draw(self.ball, self.x, self.y, 0, 1, 1, self.r, self.r)
end

function Ball:update(dt)
    -- update velocity
    self.v.x = 100 * dt * self.a.x + self.v.x
    self.v.y = 100 * dt * self.a.y + self.v.y

    -- update position
    self.x = dt * self.v.x + self.x
    self.y = dt * self.v.y + self.y
end

function Ball:friction(f)
    self.v.x = self.v.x - f * self.v.x
    self.v.y = self.v.y - f * self.v.y
end
