-- Dev: Mike016
-- _G: global environment table, which contains all global variables. that can accessed across scripts.
--  same directory and need to run at the same compiler and environment otherwise it will be nil
-- Define a global variable directly
globalVariable = "I am a global variable"

-- Access the global variable using _G
print(_G.globalVariable)  -- Output: I am a global variable

-- Create a new global variable using _G
_G.newGlobalVariable = "I am another global variable"

-- Access the newly created global variable directly
print(newGlobalVariable)  -- Output: I am another global variable

-- Define a global variable using _G
_G.sharedVariable = "I am shared across scripts"

--[[ Example

in Script 1 
-- Define a global variable using _G
_G.sharedVariable = "I am shared across scripts"

in Script 2
-- Access the shared variable defined in script1.lua
print(_G.sharedVariable)  -- Output: I am shared across scripts

]]--
