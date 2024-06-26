-- Dev: Mike016
-- Date: Wednesday, June 26,2024

--[[
DataStore service (4MB filesize / key):
   Can only be accessed by game servers, 
   So you can only use DataStoreService within a Script or a ModuleScript that is USED BY a Script.
]]--

-- Access the DataStore service
local DataStoreService = game:GetService("DataStoreService")

-- Create datastore: GetDataStore(DataStoreName) stores data as key-value pairs similar to a dictionary
-- Previous code for coins:
-- local playerCoins = DataStoreService:GetDataStore("PlayerCoins") 
-- Accessed as playerCoins/Mike(key)

-- Improved version using SCOPES for better organization: Assume we have gems and coins
-- Structure examples:
-- PlayerInventory/Coins/Mike(key)
-- PlayerInventory/Gems/Mike(key)

-- Create a DataStore for player inventory
local PlayerInventory = DataStoreService:GetDataStore("PlayerInventory")

-- Create for coins and gems
local playerCoins = DataStoreService:GetDataStore("PlayerInventory" , "Coins" )
local playerGems = DataStoreService:GetDataStore("PlayerInventory" , "Gems")

----------------------------------------------------------------------------------------------------------

-- SetAsync() to save data
playerCoins:SetAsync("Mike", 10) -- key, value

-- IncrementAsync() changes the current value and saves it as the new value.
-- This method works only with numerical values, including integers and decimals.
-- We can also use with subtraction (-) , by default is addition

-- Increment the value associated with the key "Mike" by 5.
playerCoins:IncrementAsync("Mike", -5)
-- My BAD LOL **Be careful when using SetAsync("Mike", 10) Because it will reset the value to newValue.

-- GetAsync() retrieves data from the PlayerCoins datastore
-- If we have already set playerCoins:SetAsync("Mike", 10) and comment out line 27(playerCoins:SetAsync("Mike", 10)) 
-- and run again, the result of coins will be the same --> 10
local coinOfMike = playerCoins:GetAsync("Mike")
print(coinOfMike)

-- RemoveAsync(key) removes the key-value pair from the playerCoins datastore
playerCoins:RemoveAsync("Mike")

local coinOfMike = playerCoins:GetAsync("Mike")
print(coinOfMike) --> nil: key not found

-------------------------------------------------------------------------------------------------------------
-- Implement with pcall: Protect our code from errors. Skip errors and continue running our code
--[[ Case study: Assume we did not create playerCoins datastore:
playerCoins:SetAsync("Bas", 200)
print("Hello world") -- this line will not run because playerCoins:SetAsync() encountered an error
]]

-- success:boolean --> from pcall()
-- currentCoins:number --> from function return value inside pcall()
-- Get
local success, currentCoins = pcall(function()
	return playerCoins:GetAsync("Mike")
end)
if success then
	print("Player coins have been retrieved successfully!!")
	print(currentCoins)
end

-- Set
local success, errorMessage = pcall(function()
	playerCoins:SetAsync("Bas", 200)
end)
if not success then
	warn(errorMessage) --> Assume we did not create playerCoins datastore: ServerScriptService.DataStore:46: attempt to index nil with 'SetAsync'
end

---- Incrementing
local success, newCoinsValue = pcall(function()
	return playerCoins:IncrementAsync("Bas", -100)
end)
if success then
	print(newCoinsValue)
end

---- Remove
local success = pcall(function()
	playerCoins:RemoveAsync("Bas")
end)
if success then
	print("Removed successfully")
end

---- UpdateAsync: use a function to update the value with a callback function
-- Behavior is similar to IncrementAsync()
local function incrementValue(currentCoins)
	return currentCoins + 50
end

local success, updatedCoins = pcall(function()
	-- argument: UpdateAsync(key, transformFunction)
	return playerCoins:UpdateAsync("Bas", incrementValue)
end)
if success then
	print("Updated Coins to " .. updatedCoins)
end

-------------------------------------------------------------------------------------------------------------
-- USE CASE Example Code
-- When the player returns, their coins will increase by 10

-- Access the DataStore service
local DataStoreService = game:GetService("DataStoreService")

-- Create a DataStore for player inventory
local PlayerInventory = DataStoreService:GetDataStore("PlayerInventory")

-- Create a scoped DataStore within PlayerInventory for coins
local playerCoins = PlayerInventory:GetDataStore("Coins")

-- Connect to the PlayerAdded event to handle when a player joins the game
game.Players.PlayerAdded:Connect(function(player)
	-- Create a leaderstats folder to hold player statistics
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	-- Create an IntValue to store the player's coins
	local coins = Instance.new("IntValue")
	coins.Name = "coins"
	coins.Parent = leaderstats

	-- Attempt to retrieve the player's current coins from the DataStore
	local success, currentCoins = pcall(function()
		return playerCoins:GetAsync(player.UserId)
	end)

	-- If retrieval is successful, set the coins value to the retrieved amount
	if success and currentCoins then
		coins.Value = currentCoins
	else
		-- If retrieval fails, set the coins value to 0
		coins.Value = 0
	end

	-- Attempt to increment the player's coins by 10
	local success, updatedValue = pcall(function()
		return playerCoins:IncrementAsync(player.UserId, 10)
	end)

	-- If the increment is successful, update the coins value to the new amount
	if success then
		coins.Value = updatedValue
	end
end)
-------------------------------------------------------------------------------------------------------------

-- Trick: Use Table to store items
-- Access the DataStore service
local DataStoreService = game:GetService("DataStoreService")
local PlayerInventory = DataStoreService:GetDataStore("PlayerInventory")

-- Function to update player inventory
local function updatePlayerInventory(key, itemName, value)
	local success, currentInventory = pcall(function()
		return PlayerInventory:GetAsync(key)
	end)
	print(currentInventory) --[[ --> {
	 ["Coins"] = 10,
	 ["Gems"] = 5
	}
]]--
	if not success then
		warn("Failed to retrieve inventory for " .. key)
		return
	end

	if not currentInventory then
		currentInventory = {Coins = 0, Gems = 0}
	end

	currentInventory[itemName] = value

	local saveSuccess, errorMessage = pcall(function()
		PlayerInventory:SetAsync(key, currentInventory)
	end)

	if not saveSuccess then
		warn("Failed to save inventory for " .. key .. ": " .. errorMessage)
	end
end

-- Function to get player inventory
local function getPlayerInventory(key)
	local success, currentInventory = pcall(function()
		return PlayerInventory:GetAsync(key)
	end)

	if success and currentInventory then
		return currentInventory
	else
		warn("Failed to retrieve inventory for " .. key)
		return {Coins = 0, Gems = 0}
	end
end

-- Update player coins
updatePlayerInventory("Mike", "Coins", 10)
-- Update player gems
updatePlayerInventory("Mike", "Gems", 5)

-- Retrieve inventory (Table)
local inventory = getPlayerInventory("Mike")
print("Mike's Inventory: Coins = " .. inventory.Coins .. ", Gems = " .. inventory.Gems)








