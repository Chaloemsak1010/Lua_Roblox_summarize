-- Dev: Mike016
-- Three Types of Statement(if-elseif-else) Structures in Lua
-- 1. if Statement
if condition then
    -- Code to execute if condition is true
end

-- 2. if ... else Statement
if condition then
    -- Code to execute if condition is true
else
    -- Code to execute if condition is false
end
-- short-hand version if-else Ex.
-- local x = 10
-- local result = x > 0 and "Positive" or "Non-positive"
-- print(result)  -- Output: Positive

-- 3. if ... elseif ... else
if condition1 then
    -- Code to execute if condition1 is true
elseif condition2 then
    -- Code to execute if condition2 is true
else
    -- Code to execute if none of the conditions are true
end

-- Relational Operators: All operators will return true or false
local a = 10
local b = 5
-- Equality Operator (==)
print(a == b)  -- Output: false
-- Not equa
print(a ~= b)  -- Output: true
-- Greater Than Operator (>)
print(a > b) -- Output: true
-- Less Than Operator (<)
print(a < b) -- Output: false
-- Greater Than or Equal To Operator (>=)
print(a >= b)  -- Output: true
--Less Than or Equal To Operator (<=)
print(a <= b)  -- Output: false

--Logic Operators
local c = true
local d = false
-- 1. Logical AND (and)
print(c and d)  -- Output: false
-- 2. Logical OR (or)
print(c or d)   -- Output: true
-- 3. Logical NOT (not)
print(not c)    -- Output: false
print(not d)    -- Output: true



