-- Dev: Mike016
-- Date: Sunday , June 16,2024

--[[
--  LOOKUP TABLE Technique (LOT) : precomputed values , optimization method used to improve the efficiency of code
Benefits of Lookup Tables
    Speed: Lookup tables allow for constant time complexity O(1) for retrieval operations, which can be significantly faster than recalculating values.

Considerations
    Memory Usage: Lookup tables consume memory proportional to the number of precomputed values stored. 

]]--

-- Create an empty table for factorials
local factorials = {}

-- Precompute the factorials of numbers from 0 to 10
factorials[0] = 1
for i = 1, 10 do
	factorials[i] = factorials[i - 1] * i
end

-- Function to get the factorial of a number using the lookup table
local function getFactorial(n)
	return factorials[n]
end

-- Example usage
print(getFactorial(5)) -- Output: 120
print(getFactorial(10)) -- Output: 3628800
