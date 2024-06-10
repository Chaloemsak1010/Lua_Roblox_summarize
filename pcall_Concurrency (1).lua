-- Dev: Mike016
------------------------------------------------------------------
--[[
   pcall (protected call) is used to call a function in protected mode.
   This means that if an error occurs within the function, 
   it won't stop the execution of the script; instead,
   it returns a status and the error message.
]]--

local success , errorMsg = pcall(function()
	local part = game.Workspace:FindFirstChild("error part")
	part.BrickColor = BrickColor.Random()
end)

if success then
	print("Success")
else
	warn(errorMsg)
end

print("END")

-- look like try catch in another languages
--[[
Output : 17:04:42.048  Host:4: attempt to index nil with 'BrickColor'
         17:04:42.048  END
]]--




