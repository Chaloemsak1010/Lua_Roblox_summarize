-- Example: Create Shop to sell tools
-- ########## 1.Client ---> Server ---> Client ########## -------------------------------------------------------
-- ///////// Client Side ///////// --
local buyButtonRemoteFn = game.ReplicatedStorage.BuyButtonRomoteFn
local gui = script.Parent
local prompt = gui.Prompt

local buyAxe = gui.Axe
local buySword = gui.Sword
local buyFlash = gui.Flash
local tools = { buyAxe , buySword , buyFlash }

for i = 1 , #tools do
	tools[i].MouseButton1Click:Connect(function()
		local statusPurchase = buyButtonRemoteFn:InvokeServer(tools[i].Name , 20)
		if statusPurchase then
			prompt.Text = "Purchase successful"
			prompt.BackgroundColor3 = Color3.fromRGB(0,255,0)
		else
			prompt.Text = "Failed to Purchase"
			prompt.BackgroundColor3 = Color3.fromRGB(255,0,0)
		end
	end)
end

-- ///////// Server Side ///////// 
game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder" , player)
	leaderstats.Name = "leaderstats" 

	local coins = Instance.new("IntValue" , leaderstats )
	coins.Name = "Coins"
	coins.Value = 60
end)

local buyButtonRemoteFn = game.ReplicatedStorage.BuyButtonRomoteFn
buyButtonRemoteFn.OnServerInvoke = function(player , toolName , price	)

	local purchaseSuccessful = false
	local leaderstats = player.leaderstats
	local coins = leaderstats.Coins

	if coins.Value >= 20 then
		coins.Value -= price
		local tool = game.ServerStorage:FindFirstChild(toolName)
		tool:Clone().Parent = player.Backpack
		purchaseSuccessful = true
	end
	-- if purchase success => true
	return  purchaseSuccessful

end