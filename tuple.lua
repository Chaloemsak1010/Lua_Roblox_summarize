-- Dev: Mike016
-- tuple : different types , immutable , to group multiple values together , faster than array or table for accessing
-- Create a tuple using table.pack()
local tuple = table.pack("apple", 10, true)

-- Unpack the tuple using table.unpack()
local fruit, quantity, isAvailable  = table.unpack(tuple)

-- Print the unpacked values
print("Fruit:", fruit)
print("Quantity:", quantity)
print("Is Available:", isAvailable)

-- Modify the tuple (tuples are immutable in Lua)
-- tuple[2] = 20  -- This will cause an error

-- Create a table with some values
local myTable = {1, 2, 3}

-- Unpack the table using table.unpack()
local a, b, c = table.unpack(myTable)

-- Print the unpacked values
print("a:", a)
print("b:", b)
print("c:", c)

-- Create a tuple using table.pack() with variable arguments
local function createTuple(...)
    return table.pack(...)
end

-- Unpack the tuple created by createTuple()
local t1, t2, t3 = table.unpack(createTuple("hello", 42, false))

-- Print the unpacked values
print("t1:", t1)
print("t2:", t2)
print("t3:", t3)


-- Function returning multiple values (this is tuple)
local tuple2 = table.pack("apple", 10, true)
local function getTuple()
    return tuple2
end

-- Using a loop to access tuple values don't need to unpack because we use return from function getTuple()
print("\nAccessing Tuple Values Using a Loop:")
local tuple = getTuple()
for i = 1, #tuple do
    print("Element ".. i .. ":", tuple[i])
end

