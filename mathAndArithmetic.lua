-- Dev: Mike016
-- --- Arithmetic Basic ---
local a = 10
local b = 5
print("a + b =", a + b)  -- Addition
print("a - b =", a - b)  -- Subtraction
print("a * b =", a * b)  -- Multiplication
print("a / b =", a / b)  -- Division
print("a ^ b =", a ^ b)  -- Exponentiation
print("a % b =",a % b) --mod : หารเอาเศษ
--[[ result =
    a + b = 15
    a - b = 5
    a * b = 50
    a / b = 2.0
    a ^ b = 100000.0
    a % b = 0
]]--

-- --- Math built-in methods ---
-- Trigonometric Functions
print("math.sin(math.pi/2) =", math.sin(math.pi/2))  -- Sine
print("math.cos(math.pi) =", math.cos(math.pi))      -- Cosine
-- Exponential and Logarithmic Functions
print("exp(2) =", math.exp(2))
print("log(10) =", math.log(10))
-- Other Functions
print("math.sqrt(25) =", math.sqrt(25))      -- Square root
print("math.abs(-10) =", math.abs(-10))      -- Absolute value
-- Rounding and Floor/Ceiling Functions
print("math.floor(10.8) =", math.floor(10.8))        -- Floor ปัดลง
print("math.ceil(10.2) =", math.ceil(10.2))          -- Ceiling ปัดขึ้น
print("max(10, 20, 30) =", math.max(10, 20, 30))
print("min(10, 20, 30) =", math.min(10, 20, 30))

-- Random Number Generation
math.randomseed(os.time()) --[[ Initialize random seed using current time 
    This ensures that the sequence of random numbers generated by math.random() 
    varies each time the program is executed, making the randomness less predictable.  
]]--
print("Random float between 0 and 1:", math.random())
print("Random integer between 1 and 100:", math.random(1, 100))

-- custom math method Ex. round function : number <= 0.4 use floor and number >= 0.5
local function round(number)
    return math.floor(number + 0.5)
end

-- Test the round function
print(round(3.4))  -- Output: 3
print(round(3.5))  -- Output: 4
print(round(3.6))  -- Output: 4



