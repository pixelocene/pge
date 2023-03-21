local Vect2 = require "engine.util.Vect2"

describe('engine.util.Vect2', function()

    it('Can be constructed', function()
        local vect2 = Vect2:new(10, 30)

        assert.are.same(10, vect2.n_x)
        assert.are.same(30, vect2.n_y)

        vect2 = Vect2:new(-10, -30)

        assert.are.same(-10, vect2.n_x)
        assert.are.same(-30, vect2.n_y)
    end)

    it('Can be summed', function()
        local a = Vect2:new(1, 0)
        local b = Vect2:new(2, 1)
        local c = Vect2:new(-1, -2)

        assert.are.same(Vect2:new(3, 1), a + b)
        assert.are.same(Vect2:new(1, -1), b + c)
    end)

    it('Can be summed to a number', function()
        local a = Vect2:new(1, 1)

        assert.are.same(Vect2:new(3, 3), a + 2)
        assert.are.same(Vect2:new(3, 3), 2 + a)
    end)

end)