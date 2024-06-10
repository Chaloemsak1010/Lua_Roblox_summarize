-- Dev: Mike016
-- CONVERTING DATA TYPEs
--1. tostring() is a Lua built-in , convert a value to a string. It accepts one argument
local number = 42
local boolean = true
local table = {1, 2, 3}

print(tostring(number))  -- Output: "42"
print(tostring(boolean)) -- Output: "true"
print(tostring(table))   -- Output: "table: <address>"

--2. tonumber() Lua built-in string to a number. It accepts one or two arguments and returns the string.
local str_number = "42"
local str_float = "3.14"
local str_invalid = "Hello"

local number = tonumber(str_number)
local float = tonumber(str_float)
local invalid = tonumber(str_invalid) --!!!cannot be converted to a number, so tonumber() returns nil but no error!!!

print(number)  -- Output: 42
print(float)   -- Output: 3.14
print(invalid) -- Output: nil (since "Hello" cannot be converted to a number)

