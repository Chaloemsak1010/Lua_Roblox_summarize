-- Dev: Mike016
local v = 10 --Local its scope is limited with the functions inside their scope
global = 20 --Global variable

--Basic
print(type("Hello world")) --> string
print(type(10.4 * 3))      --> number
print(type(print))         --> function
print(type(type))          --> function
print(type(true))          --> boolean  => true or false
print(type(nil))           --> nil Lua uses nil as a kind of non-value
print(type(type(A)))       --> string because is upperCase
print(type(a))             --> nil
print(not a)               --> not nil = true, nil in boolean = false

--consider false and nil as false and anything else as true
--b = nil => false
local ab = 10 -- true
if ab then
    print("a can be true in condition")
end

--Number = can be both int and float
print(type(0.23)) --> NUMBER
print(0.4e1) --> 4
print(5e6) --> 5,000,000
print(0.3e12) -->300000000000.0
print(10) --> 10

--String: sequence of characters
-- \a	bell
-- \b	back space
-- \f	form feed
-- \n	newline
-- \r	carriage return
-- \t	horizontal tab
-- \v	vertical tab
-- \\	backslash
-- \"	double quote
-- \'	single quote
-- \[	left square bracket
-- \]	right square bracket
local myName = "Chaloemsak\f"
print(#myName) --> # represent length of string
print(myName) --> Chaloemsak
--You can concatenate strings using the .. operator.
local result = "Hello" .. " " .. "Lua!"
print(string.byte(myName,1,3)) -->Cha in byte  = 67      104     97
print(result) --> "Hello Lua!"

-- how to comment in Lua
-- this is 1 line comment
--[[]
  this is manny line comments
]]--

-- Tables: Lua's primary data structure, supporting various use cases
myFirstTable = {} -- Type Table difine avalaible table
myFirstTable.b = 20 -- key = b and value = 20 type number
print(myFirstTable.b) -- way to access b inside Table myData

-- Tables with inial elements
local myTable = {name = "John", age = 30, hobbies = {"reading", "coding"}}
print(myTable.name)  --> "John"
print(myTable.hobbies[1])  --> "reading"

-- Functions: First-class values in Lua, supporting anonymous functions
local function greet(name)
    print("Hello, " .. name .. "!")
end
greet("Alice")  --> "Hello, Alice!"


--  --- Metatables and Metamethods: Customizing behavior for tables ---
local mt = {
    __add = function(a, b)  -- Define metamethod for addition
        return a.value + b.value
    end
}
local t1 = {value = 10}
local t2 = {value = 20}
setmetatable(t1, mt)
setmetatable(t2, mt)
print(t1 + t2)  --> 30

-- Define metatable with metamethods
local mt = {
    __index = function(tbl, key)
        print("Accessing key:", key)
        return tbl[key]
    end,

    __newindex = function(tbl, key, value)
        print("Assigning key:", key, "with value:", value)
        rawset(tbl, key, value)
    end,

    __add = function(tbl1, tbl2)
        print("Performing addition operation")
        local result = {}
        for k, v in pairs(tbl1) do
            result[k] = v
        end
        for k, v in pairs(tbl2) do
            result[k] = (result[k] or 0) + v
        end
        return result
    end,

    __sub = function(tbl1, tbl2)
        print("Performing subtraction operation")
        local result = {}
        for k, v in pairs(tbl1) do
            result[k] = v
        end
        for k, v in pairs(tbl2) do
            result[k] = (result[k] or 0) - v
        end
        return result
    end,

    __mul = function(tbl1, tbl2)
        print("Performing multiplication operation")
        local result = {}
        for k, v in pairs(tbl1) do
            result[k] = v * tbl2
        end
        return result
    end,

    __div = function(tbl1, tbl2)
        print("Performing division operation")
        local result = {}
        for k, v in pairs(tbl1) do
            result[k] = v / tbl2
        end
        return result
    end,

    __mod = function(tbl1, tbl2)
        print("Performing modulo operation")
        local result = {}
        for k, v in pairs(tbl1) do
            result[k] = v % tbl2
        end
        return result
    end,

    __pow = function(tbl1, tbl2)
        print("Performing exponentiation operation")
        local result = {}
        for k, v in pairs(tbl1) do
            result[k] = v ^ tbl2
        end
        return result
    end,

    __unm = function(tbl)
        print("Performing unary minus operation")
        local result = {}
        for k, v in pairs(tbl) do
            result[k] = -v
        end
        return result
    end,

    __concat = function(tbl1, tbl2)
        print("Performing concatenation operation")
        local result = {}
        for k, v in pairs(tbl1) do
            result[k] = v
        end
        for k, v in pairs(tbl2) do
            result[k] = v
        end
        return result
    end,
    -- have errors
    -- __eq = function(tbl1, tbl2)
    --     print("Performing equality comparison")
    --     for k, v in pairs(tbl1) do
    --         if v ~= tbl2[k] then
    --             return false
    --         end
    --     end
    --     for k, v in pairs(tbl2) do
    --         if v ~= tbl1[k] then
    --             return false
    --         end
    --     end
    --     return true
    -- end,

    -- __lt = function(tbl1, tbl2)
    --     print("Performing less-than comparison")
    --     for k, v in pairs(tbl1) do
    --         if v >= (tbl2[k] or 0) then
    --             return false
    --         end
    --     end
        
    --     return true
    -- end,

    -- __le = function(tbl1, tbl2)
    --     print("Performing less-than-or-equal-to comparison")
    --     for k, v in pairs(tbl1) do
    --         if v > (tbl2[k] or 0) then
    --             return false
    --         end
    --     end
    --     return true
    -- end,

    __tostring = function(tbl)
        print("Converting table to string")
        local str = "{"
        for k, v in pairs(tbl) do
            str = str .. tostring(k) .. "=" .. tostring(v) .. ", "
        end
        str = str:sub(1, #str - 2) .. "}"  -- Remove trailing comma and space
        return str
    end
}

-- Create tables and set metatable
local table1 = {a = 10, b = 20}
local table2 = {a = 5, c = 15}
setmetatable(table1, mt)
setmetatable(table2, mt)

-- Test metamethods
print(table1.a)  -- Accessing key: a
table1.d = 30  -- Assigning key: d with value: 30
local additionResult = table1 + table2  -- Performing addition operation
local subtractionResult = table1 - table2  -- Performing subtraction operation
local multiplicationResult = table1 * 2  -- Performing multiplication operation
local divisionResult = table1 / 2  -- Performing division operation
local moduloResult = table1 % 3  -- Performing modulo operation
local exponentiationResult = table1 ^ 2  -- Performing exponentiation operation
local negationResult = -table1  -- Performing unary minus operation
local concatenationResult = table1..table2  -- Performing concatenation operation : Merge two tables together
-- Print the result of concatenation k = key v = value 
for k, v in pairs(concatenationResult) do
    print(k, v)
end
-- have errors
-- local equalityComparison = table1 == table2  -- Performing equality comparison
-- local lessThanComparison = table1 < table2  -- Performing less-than comparison
-- local lessThanOrEqualComparison = table1 <= table2  -- Performing less-than-or-equal-to comparison
-- Convert table to string
print(tostring(table1))  -- Converting table to string


-- Modules: Organizing code into reusable modules
local myModule = {}
function myModule.sayHello(name)
    print("Hello from myModule! "..name)
end
myModule.sayHello('mike')
myModule.sayHello("bass")



