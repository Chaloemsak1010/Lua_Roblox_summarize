-- Dev: Mike016
-- Date: Saturday , 22 June 2024

-- REMOTEFUNCTION: Object facilitates synchronous, two-way communication across the client-server boundary. 

-- ########## 1.Client ---> Server ---> Client ########## -------------------------------------------------------

-- ///////// Client Side ///////// --
local buyButtonRemoteFn = game.ReplicatedStorage.BuyButtonRomoteFn
local gui = script.Parent
local prompt = gui.Prompt
local button = gui.BuyButton
button.MouseButton1Click:Connect(function( )
	-- 1st argument automatically sends the player object
	-- 2nd argument is the parameter
	local statusPurchase = buyButtonRemoteFn:InvokeServer("Parameter00")
    -- statusPurchase is value return from server
	if statusPurchase then
	   prompt.Text = "Purchase successful"
	   prompt.BackgroundColor3 = Color3.fromRGB(0,255,0)
	else
		prompt.Text = "Failed to Purchase"
		prompt.BackgroundColor3 = Color3.fromRGB(255,0,0)
	end
	
end)

-- ///////// Server Side ///////// -- inside serverScriptService
game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder" , player)
	leaderstats.Name = "leaderstats" -- need to be leaderstats for show information inside this folder
	
	--                                      2nd: var obj in this scripts
	local coins = Instance.new("IntValue" , leaderstats )
	coins.Name = "Coins"
	coins.Value = 60
end)

local buyButtonRemoteFn = game.ReplicatedStorage.BuyButtonRomoteFn
--[[
    Events are used to notify multiple listeners about an occurrence, 
    while Callbacks are specific functions called after a task completes.
]]
-- It is call back not event
buyButtonRemoteFn.OnServerInvoke = function(player , parametorEtc	)
	print(player) --> Mike_LongDev
	print(parametorEtc) --> Parameter00
	
	local purchaseSuccessful = false
	local leaderstats = player.leaderstats
	local coins = leaderstats.Coins
	
	if coins.Value >= 20 then
		coins.Value -= 20
		purchaseSuccessful = true
		
	end
	-- if purchase success => true
	return  purchaseSuccessful
	
end


-- ########## 2.Server ---> Client ---> Server ( ***Dangerous to use this )########## ------------------------------------------
--[[
    The primary concern with this pattern is that clients can be compromised or manipulated. 
    If critical logic or sensitive data is sent to the client and then sent back to the server,
    a malicious user could tamper with the data or logic,leading to exploits or cheats.
]]

-- ///////// Server Side ///////// --
local remoteFn = game.ReplicatedStorage:WaitForChild("ForS-C-S")
-- Assuming 'player' is the player instance you're targeting.
local player = game.Players:WaitForChild("Mike_LongDev")

-- First parameter should be a Player instance
local sentBackFromClient = remoteFn:InvokeClient(player , "parametor01")
print("Data callBacks "..sentBackFromClient)

-- ///////// Client Side ///////// --
local remoteFn = game.ReplicatedStorage:WaitForChild("ForS-C-S")
-- player obj will not send back
remoteFn.OnClientInvoke = function (message)
	print("Parametor from server: "..message )
	return " Hello world from client"
end

--[[
Results:
OnClient: Parametor from server: parametor01
OnServer: Data callBacks Hello world from client
]]


