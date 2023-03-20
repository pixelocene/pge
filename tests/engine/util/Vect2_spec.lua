local Vect2 = require "engine.util.Vect2"

describe('Vect2', function()

    it('can be constructed', function()
        local vect2 = Vect2:new(10, 30)

        assert.are.same(vect2.n_x, 10)
        assert.are.same(vect2.n_y, 30)

        vect2 = Vect2:new(-10, -30)

        assert.are.same(vect2.n_x, -10)
        assert.are.same(vect2.n_y, -30)
    end)

    it('two Vect2 can be added', function()
        local a = Vect2:new(1, 0)
        local b = Vect2:new(2, 1)
        local c = Vect2:new(-1, -2)

        assert.are.same(a + b, Vect2:new(3, 1))
        assert.are.same(b + c, Vect2:new(1, -1))
    end)

    it('a number can be added to a Vect2', function()
        local a = Vect2:new(1, 1)

        assert.are.same(a + 2, Vect2:new(3, 3))
        assert.are.same(2 + a, Vect2:new(3, 3))
    end)

end)