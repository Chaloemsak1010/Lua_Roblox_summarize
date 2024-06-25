-- Dev: Mike016
-- Date: Tuesday, 25 June, 2024

-- Module script
local module = {
	name = "Mike"  -- Initialize the module table with a name field
}

function module.hello()
	print("hello world")
	-- print(self.name) --> Can't access 'self' in this case because we use . So self will not automatically be parametor 
end

function module:hello2()  -- Using ':' allows the method to access 'self' of the module
	-- Access the 'name' field of the module
	print("hello 2"..self.name)
end

print("Module script has been activated!!")

return module
--------------------------------------------------------------------------------------------------
-- In another script
local module = require(game.Workspace.ModuleScript)  -- When we require the module, it will execute all lines in the module script

module:hello2()  -- Call the hello2 method, which can access 'self'
