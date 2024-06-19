-- Developer: Mike016
-- Date: Wednesday, 19 June 2024

-- RemoteEvent: Facilitates asynchronous, one-way communication across the client-server boundary.
--              Create the RemoteEvent in ReplicatedStorage. In some cases, it's appropriate to store it in Workspace or inside a Tool.

-- ########## 1. Client --> Server ########## --
-- Client:	RemoteEvent:FireServer(args)
-- Server:	RemoteEvent.OnServerEvent:Connect(function(player, args))

-- ///////// Client Side ///////// --
local gui = script.Parent
local buyButton = gui.TextButton

-- Instance of RemoteEvent (in ReplicatedStorage)
local buyEvent = game.ReplicatedStorage:WaitForChild("BuyEvent")

buyButton.MouseButton1Click:Connect(function()
	-- Send request to server
	local price = 20
	-- Note: The player is automatically the first argument in RemoteEvent calls
	-- Send price as the second argument
	buyEvent:FireServer(price)
end)

game.Players.PlayerAdded:Connect(function(player)
	-- Create leaderstats folder when the player joins the game
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	-- Create a coin counter and set it to be a child of the leaderstats folder
	local coins = Instance.new("IntValue", leaderstats)
	coins.Name = "coins"
	coins.Value = 50
end)

-- ///////// Server Side ///////// --
-- Instance of RemoteEvent (in ReplicatedStorage)
local buyEvent = game.ReplicatedStorage:WaitForChild("BuyEvent")

-- Player is always the first parameter
buyEvent.OnServerEvent:Connect(function(player, price)
	-- Access the leaderstats folder of the player and modify the value of coins
	local leaderstats = player:WaitForChild("leaderstats")
	local coins = leaderstats:WaitForChild("coins")
	coins.Value -= price
end)

--------------------------------------------------------------------------------------------

-- ########## 2. Server --> Client ########## --
-- Server:	RemoteEvent:FireClient(player, args)
-- Client:	RemoteEvent.OnClientEvent:Connect(function(args))

-- ///////// Server Side ///////// --
-- Be careful: Don't access the RemoteEvent before the PlayerAdded event
local helloRemoteEvent

game.Players.PlayerAdded:Connect(function(player)
	-- Create an instance of RemoteEvent
	helloRemoteEvent = game.ReplicatedStorage:WaitForChild("HelloRemote")

	-- Fire the RemoteEvent to the client: Send a message to the client
	-- First argument is the target client, the second argument is the message to send
	helloRemoteEvent:FireClient(player, "Hello " .. player.Name)
end)

-- ///////// Client Side ///////// --
local gui = script.Parent
local text = gui.Text

-- Instance of the RemoteEvent
local helloRemoteEvent = game.ReplicatedStorage:WaitForChild("HelloRemote")

helloRemoteEvent.OnClientEvent:Connect(function(message)
	print("Message received...")
	text.Text = "Hello from server: " .. message
end)

--------------------------------------------------------------------------------------------

-- ########## 3. Server --> All Clients ########## --
-- Server:	RemoteEvent:FireAllClients(args)
-- Client:	RemoteEvent.OnClientEvent:Connect(function(args))

-- ///////// Server Side ///////// --
local announcementRemoteEvent = game.ReplicatedStorage:WaitForChild("Announcement")

-- Delay the announcement to ensure all clients are connected
task.wait(5)

-- Fire the announcement to all clients
announcementRemoteEvent:FireAllClients()

-- ///////// Client Side ///////// --
local gui = script.Parent
local announcementLabel = gui.board

-- Instance of the RemoteEvent
local announcementRemoteEvent = game.ReplicatedStorage:WaitForChild("Announcement")

announcementRemoteEvent.OnClientEvent:Connect(function()
	announcementLabel.Visible = true
	announcementLabel.Text = "Hello, connection successful"
end)

