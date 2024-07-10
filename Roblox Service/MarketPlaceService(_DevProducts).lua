-- Dev: Mike016
-- Date: Wednesday, July 10, 2024

-- Developer Product: Users can purchase more than once, such as in-experience currency, ammo, or potions.
--[[
ProductPurchaseDecisionEnum is used to work with MarketplaceService and the sale of developer products.
Name                   Value  Summary
NotProcessedYet        0      The purchase request has been sent but not yet processed.
PurchaseGranted        1      The purchase has been processed and granted to the user who initiated the purchase request.
]]

--[[
ProcessReceipt: A callback to process receipts of developer product purchases.
                This callback should be set once and only once by a single script. 
                If you're selling multiple products in your experience,
                this callback should handle receipts for all of them.
]]

-- Server-side --
local MarketplaceService = game:GetService("MarketplaceService")
local PlayersService = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local purchaseHistoryStore = DataStoreService:GetDataStore("PurchaseHistory")
local devProductId = 1869775621

-- Table Functions for handling developer products
local productFunctions = {}

-- Create a function that can be used by productFunctions[key]
productFunctions[devProductId] = function(receiptInfo, player)
	local character = player.Character
	print(player)
	print(character)
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.WalkSpeed += 50
		print("Increased walk speed")
		return true --> result in pcall
	end
	-- If humanoid not found
	return false
end

--[[
-- Example of Table Functions
local fns = {}

fns[1] = function()
    print("I am a function accessed by key 1")
end

fns[2] = function()
    print("I am a function accessed by key 2")
end

fns[2]() --> I am a function accessed by key 2
local success, errMsg = pcall(fns[1]) --> I am a function accessed by key 1
]]

local function processReceipt(receiptInfo)
--[[
*** The receiptInfo table passed to this callback will contain the following data:
    PurchaseId   A unique identifier for the specific purchase.
    PlayerId   The user ID of the player who made the purchase.
    ProductId   The ID of the purchased product.
    PlaceIdWherePurchased   The place ID where the purchase was made; not necessarily the same as the current place's ID.
    CurrencySpent   The amount of currency spent in the transaction.
    CurrencyType   The type of currency spent in the purchase; always Enum.CurrencyType.Robux.
]]
	local userId = receiptInfo.PlayerId
	local productId = receiptInfo.ProductId
	local keyTransaction = userId .. "_" .. receiptInfo.PurchaseId --> for tracking purchase
	-- Check if purchase has already been processed
	local purchased = false
	local success, errMsg = pcall(function()
		purchased = purchaseHistoryStore:GetAsync(keyTransaction)
	end)
	-- If purchase was recorded, the product was already granted
	if success and purchased then
		return Enum.ProductPurchaseDecision.PurchaseGranted --> transaction already recorded
	elseif not success then
		error(errMsg) --> not yet exit from this function
	end

	local success, isPurchaseRecorded = pcall(function()
		return purchaseHistoryStore:UpdateAsync(keyTransaction, function(alreadyPurchased)
                        --*** UpdateAsync: if key is not defined by default it will auto create it when used it.
			if alreadyPurchased then
				return true --> if old value == true then return true
			end

			-- Find the player who made the purchase on the server
			local player = PlayersService:GetPlayerByUserId(receiptInfo.PlayerId)
			if not player then
				-- The player probably left the game
				-- If they come back, the callback will be called again
				return nil
			end

			local handlerFn = productFunctions[productId]

			local success, result = pcall(handlerFn, receiptInfo, player)
			if not success or not result then
				error("Failed to process a product purchase for ProductId: " .. tostring(receiptInfo.ProductId) .. " Player: " .. tostring(player))
				return nil
			end
			-- Record the transaction in purchaseHistoryStore
			return true --> new value of that key
		end)
	end)
	if not success then
		error("Failed to process receipt due to data store error.")
		return Enum.ProductPurchaseDecision.NotProcessedYet
	elseif isPurchaseRecorded == nil then
		-- Didn't update the value in the data store
		return Enum.ProductPurchaseDecision.NotProcessedYet
	else
		-- IMPORTANT: Tell Roblox that the game successfully handled the purchase
		return Enum.ProductPurchaseDecision.PurchaseGranted        
	end
--[[*** Note
    When Enum.ProductPurchaseDecision.NotProcessedYet is returned, 
    it means that the purchase was not fully processed and recorded.
    Roblox will attempt to re-run the processReceipt function again the next time the player returns to the game.

    print(Enum.ProductPurchaseDecision.PurchaseGranted.Value) --> 1
    print(Enum.ProductPurchaseDecision.NotProcessedYet.Value) --> 0
]]
end

-- Set callback to processReceipt function
MarketplaceService.ProcessReceipt = processReceipt

-----------------------------------------------------------------------------------------------

-- Client side --
local MarketPlaceService = game:GetService("MarketplaceService")
local player = game.Players.LocalPlayer
local devProductId = 1869775621

task.wait(3)
MarketPlaceService:PromptProductPurchase(player , devProductId)


