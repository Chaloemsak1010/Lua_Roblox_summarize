-- Dev: Mike016

--[[
LocalScript = local scripts 
Script = server scripts

Execution Environment:
-- Local Script: Runs on the client side, meaning it operates on an individual player's device.
-- Server Script: Runs on the server side, affecting all players in the game.

Use Cases:
-- Local Script: Used for client-specific tasks like UI handling, player input, and local character movements.
-- Server Script: Used for game-wide tasks like managing game rules, NPC behavior, and server-wide events.

Security:
-- Local Script: Less secure for critical logic, as it can be manipulated by the client.
-- Server Script: More secure for important game logic, as the server controls the game state.

Use Local Scripts for client-specific tasks and
Server Scripts for tasks that need to be secure and affect the entire game.

]]--

-- Example code
-- Local Script Example:
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
-- This code runs on the client's machine

-- Server Script Example:
game.Players.PlayerAdded:Connect(function(player)
	print(player.Name .. " has joined the game!")
	-- This code runs on the server
end)


