-- Developer: Mike016
-- Date: Monday, July 8, 2024

-- Game Passes allow you to charge a one-time Robux fee.
-- Cover photo for game pass: 512×512 pixels in .jpg, .png, or .bmp format.
-- By default, in dev mode, the game pass is already added to our inventory.
-- If we want to test buying it, we need to remove it from the inventory first(roblox.com).

-- Server side --
local MarketplaceService = game:GetService("MarketplaceService")
local idGamePass1 = 852529225 -- test1
local idGamePass2 = 852394674 -- test2

game.Players.PlayerAdded:Connect(function(player)
	-- Check if the player already has the game pass using arguments: userId, game pass id.
	-- Returns a boolean value.
	local hasGamePass1 = MarketplaceService:UserOwnsGamePassAsync(player.UserId, idGamePass1)

	if not hasGamePass1 then
		print(player.Name .. " doesn't have game pass 1 upon joining.")
	end

	-- Test: I have not removed this game pass from my inventory.
	local hasGamePass2 = MarketplaceService:UserOwnsGamePassAsync(player.UserId, idGamePass2)
	if hasGamePass2 then
		print(player.Name .. " already has game pass 2.") -- This line will execute.
	end
end)

-- Event listener for game pass purchase.
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, id, purchaseSuccessful)
	-- purchaseSuccessful = true when player buys it.
	if purchaseSuccessful and id == idGamePass1 then
		print(player.Name .. " has bought game pass 1 successfully.")
	end
end)

-- Client side --
local MarketplaceService = game:GetService("MarketplaceService")
local gamePassId = 852529225
local player = game.Players.LocalPlayer

-- Test mode: Game pass isn't added to inventory because I already removed it.
-- Prompt the player to purchase the game pass: Arguments --> Instance of player, game pass id.
MarketplaceService:PromptGamePassPurchase(player, gamePassId)

--------------------------------------------------------------------------------------------------------------

-- Implement with pcall concept
-- Server side --
local MarketplaceService = game:GetService("MarketplaceService")
local idGamePass1 = 852529225 -- test1
local idGamePass2 = 852394674 -- test2

game.Players.PlayerAdded:Connect(function(player)
	local hasGamePass1 = false
	local success, errorMessage = pcall(function()
		hasGamePass1 = MarketplaceService:UserOwnsGamePassAsync(player.UserId, idGamePass1)
	end)
	-- Check for errors because sometimes there are network issues.
	if not success then
		warn(errorMessage)
		return -- Exit the function.
	end

	if hasGamePass1 then
		print(player.Name .. " has game pass 1.")
	else
		print(player.Name .. " doesn't have game pass 1.")
	end
end)

--------------------------------------------------------------------------------------------------------------
-- Example
-- Server-side Script --
local MarketplaceService = game:GetService("MarketplaceService")
local swordGamePassId = 852483535

-- Function to give a sword to the player
function giveSword(player)
	local Sword = game.ServerStorage:FindFirstChild("Sword")
	if Sword then
		-- Clone the sword and add it to the player's Backpack
		local cloneSword = Sword:Clone()
		cloneSword.Parent = player.Backpack

		-- Check if the player's StarterGear already contains the sword
		if not player.StarterGear:FindFirstChild(Sword.Name) then
			-- Clone the sword and add it to the player's StarterGear
			local cloneSword = Sword:Clone()
			cloneSword.Parent = player.StarterGear
		end
	end
end

-- Event triggered when a player joins the game
game.Players.PlayerAdded:Connect(function(player)
	local hasSword = false
	local success, errorMessage = pcall(function()
		hasSword = MarketplaceService:UserOwnsGamePassAsync(player.UserId, swordGamePassId)
	end)

	-- Check for errors due to potential network issues
	if not success then
		warn(errorMessage)
		return -- Exit the function if there is an error
	end

	-- Give the sword to the player if they own the game pass
	if hasSword then
		giveSword(player)
	else
		print(player.Name .. " doesn't have the Sword!!!")
	end
end)

-- Event triggered when a game pass purchase is completed
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, id, purchaseSuccessful)
	if id == swordGamePassId and purchaseSuccessful then
		giveSword(player)
	else
		warn("Failed to purchase")
	end
end)

-- Client-side Script --
local MarketplaceService = game:GetService("MarketplaceService")
local player = game.Players.LocalPlayer
local swordGamePassId = 852483535

-- Check if the player already has the sword in their StarterGear
if player.StarterGear:FindFirstChild("Sword") then
	print("Player already has the sword")
else
	print("Player doesn't have the sword")
	-- Prompt the player to purchase the sword game pass
	MarketplaceService:PromptGamePassPurchase(player, swordGamePassId)
end

-------------------------------------------------------------------------------------------------------------
--[[
***All these below are vulnerabilities, if you use the function minus the Signal, please be careful!

SignalAssetTypePurchased
SignalClientPurchaseSuccess 
SignalMockPurchasePremium 
SignalPromptBundlePurchaseFinished 
SignalPromptGamePassPurchaseFinished 
SignalPromptPremiumPurchaseFinished 
SignalPromptProductPurchaseFinished 
SignalPromptPurchaseFinished 
SignalPromptSubscriptionPurchaseFinished 
SignalPromptSubscriptionCancellationFinished
]]

