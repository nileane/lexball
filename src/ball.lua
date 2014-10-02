-- Lexball <3
-- A haxball clone in Lua and Love2d.

local ball = {
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
    r = 10,

    -- color
    color = {
        r = 196,
        g = 255,
        b = 86
    },

    draw = function()
        love.graphics.setColor(ball.color.r, ball.color.g, ball.color.b)
        love.graphics.circle('fill', ball.x, ball.y, ball.r)
    end,

    update = function(dt)
        -- update velocity
        ball.v.x = 100 * dt * ball.a.x + ball.v.x
        ball.v.y = 100 * dt * ball.a.y + ball.v.y

        -- update position
        ball.x = dt * ball.v.x + ball.x
        ball.y = dt * ball.v.y + ball.y
    end
}

return ball
