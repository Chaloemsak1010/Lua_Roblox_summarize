-- Dev: Mike016
-- Table for init
Person = {
    name = "",
    age = 0
}
-- obj inherit person method
Person.__index = Person

-- constructor method
function Person:new( name , age )
    local obj = {} --  table for return
    obj.name = name
    obj.age = age
    setmetatable(obj , self) -- self is instance of Person
    
    --print(obj) --Output: { ["age"] = 21 , ["name"] = "Mike" }
    -- index out of bound it will use metatable = functions of Person
    --print(obj.__index) -- this is metamethod 
--[[ 
Output: {
    ["__index"] = "*** cycle table reference detected ***",
    ["age"] = 0,
    ["hello"] = "function",

    ["name"] = "",
    ["new"] = "function"
} ]]--
    return obj
end

function Person:hello()
    print("Hello, my name is " .. self.name .. " and I'm " .. self.age .. " years old.")
end

-- test
local mikeObj = Person:new("Mike" , 21) -- : = { self , "Mike" , 21 }
mikeObj:hello() -- don't have hello variable(key) so it will use meta method, function use : because it will also send self(instance of Person)
print(mikeObj.name) -- variables use . don't need to use metatable



