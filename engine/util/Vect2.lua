----------
--- 2D Vector (v)

--- Vector values
-- @tfield number x X value
-- @tfield number y Y value
local Vect2 = {
    n_x = nil,
    n_y = nil,
}

--- Constructor
-- @tparam number x X value
-- @tparam number y Y value
function Vect2:new(_n_x, _n_y)
    local tbl_o = { n_x = _n_x, n_y = _n_y }

    setmetatable(tbl_o, {
        __add = function(_vn_a, _vn_b) return self.add(_vn_a, _vn_b) end,
        __sub = function(_vn_a, _vn_b) return self.sub(_vn_a, _vn_b) end,
        __mul = function (_vn_a, _vn_b) return self.mul(_vn_a, _vn_b) end,
        __tostring = function(v_vect2) return self.toString(v_vect2) end,
    })
    self.__index = self

    return tbl_o
end

function Vect2.fromTable(_tbl_table)
    return Vect2:new(_tbl_table.x, _tbl_table.y)
end

--- Make the sum of two Vect2
-- @tparam @{engine.Vect2} a The first Vect2 to make the sum with.
-- @tparam @{engine.Vect2} b The second Vect2 to make the sum with.
-- @treturn @{engine.Vect2} A new Vect2 being the sum of a and b.
-- @usage
-- local a = Vect2:new(1,1)
-- local b = Vect2:new(2,2)
--
-- local c = a + b
-- print(c) -- Vect2(3,3)
--
-- -- It is also possible to add a number
-- local d = a + 3
-- print d -- Vect2(4,4)
function Vect2.add(_vn_a, _vn_b)
    -- Handle the case when we try to add a number
    if type(_vn_a) == 'number' or type(_vn_b) == 'number' then
        local v_vect = nil
        local i_num = nil
        if type(_vn_a) == 'number' then
            i_num = _vn_a
            v_vect = _vn_b
        else
            i_num = _vn_b
            v_vect = _vn_a
        end
        return Vect2:new(v_vect.n_x + i_num, v_vect.n_y + i_num)
    end

    return Vect2:new(_vn_a.n_x + _vn_b.n_x, _vn_a.n_y + _vn_b.n_y)
end

--- Make the substraction of two Vect2
-- @tparam @{engine.Vect2} a The first Vect2 to make the substraction with.
-- @tparam @{engine.Vect2} b The second Vect2 to make the substraction with.
-- @treturn @{engine.Vect2} A new Vect2 being the sum of a and b.
-- @usage
-- local a = Vect2:new(1,1)
-- local b = Vect2:new(2,2)
--
-- local c = a - b
-- print(c) -- Vect2(-1,-1)
--
-- -- It is also possible to substract a number
-- local d = b + 1
-- print d -- Vect2(1,1)
function Vect2.sub(_vn_a, _vn_b)
    -- Handle the case when we try to add a number
    if type(_vn_a) == 'number' or type(_vn_b) == 'number' then
        local v_vect = nil
        local n_num = nil
        if type(_vn_a) == 'number' then
            n_num = _vn_a
            v_vect = _vn_b
        else
            n_num = _vn_b
            v_vect = _vn_a
        end
        return Vect2:new(v_vect.n_x - n_num, v_vect.n_y - n_num)
    end

    return Vect2:new(_vn_a.n_x - _vn_b.n_x, _vn_a.n_y - _vn_b.n_y)
end

function Vect2.mul(_vn_a, _vn_b)
    -- Handle the case when we try to add a number
    if type(_vn_a) == 'number' or type(_vn_b) == 'number' then
        local v_vect = nil
        local n_num = nil
        if type(_vn_a) == 'number' then
            n_num = _vn_a
            v_vect = _vn_b
        else
            n_num = _vn_b
            v_vect = _vn_a
        end
        return Vect2:new(v_vect.n_x * n_num, v_vect.n_y * n_num)
    end

    return Vect2:new(_vn_a.n_x * _vn_b.n_x, _vn_a.n_y * _vn_b.n_y)
end

function Vect2.toString(_v_vect2)
    return 'Vect2('.. _v_vect2.n_x .. ',' .. _v_vect2.n_y .. ')'
end

return Vect2