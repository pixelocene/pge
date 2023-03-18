----------
--- 2D Vector

local tablex = require('pl.tablex')

--- Vector values
-- @tfield number x X value
-- @tfield number y Y value
local Vect2 = {
    x = nil,
    y = nil,
}

--- Constructor
-- @tparam number x X value
-- @tparam number y Y value
function Vect2:new(x, y)
    local o = { x = x, y = y }

    setmetatable(o, {
        __add = function(a, b) return self.add(a, b) end,
        __sub = function(a, b) return self.sub(a, b) end,
        __tostring = function(vect2) return self.toString(vect2) end,
    })
    self.__index = self

    return o
end

function Vect2.fromTable(table)
    return Vect2:new(table.x, table.y)
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
function Vect2.add(a, b)
    -- Handle the case when we try to add a number
    if type(a) == 'number' or type(b) == 'number' then
        local vect = nil
        local num = nil
        if type(a) == 'number' then
            num = a
            vect = b
        else
            num = b
            vect = a
        end
        return Vect2:new(vect.x + num, vect.y + num)
    end

    return Vect2:new(a.x + b.x, a.y + b.y)
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
function Vect2.sub(a, b)
    -- Handle the case when we try to add a number
    if type(a) == 'number' or type(b) == 'number' then
        local vect = nil
        local num = nil
        if type(a) == 'number' then
            num = a
            vect = b
        else
            num = b
            vect = a
        end
        return Vect2:new(vect.x - num, vect.y - num)
    end

    return Vect2:new(a.x - b.x, a.y - b.y)
end

function Vect2.toString(vect2)
    return 'Vect2('.. vect2.x .. ',' .. vect2.y .. ')'
end

return Vect2