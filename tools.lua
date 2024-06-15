-- Dev: Mike016
-- Date: Saturday , June 15,2024
--[[
   -- Tools are objects that a Humanoid object can equip
   -- need to set part name = "Handle" --> for appearing in hand of player
   -- click Backspace for droped tool 
]]--
local tool = script.Parent
local sound = tool.sound
local partHandle = tool:FindFirstChild("Handle") 
local isHolding = false
local userName
local WAIT_TIME = 0.2

-- Create events for the tool
-- Equipped: When the tool is equipped
tool.Equipped:Connect(function()
	print("This tool has been equipped!")
	--tool:Activate() --> automatically activated when tool equipped
--[[ Behavior properties:
	ManualActivationOnly = true --> only works when tool is activated by a script
	                                (can not activated by left click(it will work on Deactivated events))
	RequiresHandle = true --> if true, the tool can not be equipped if the handle is missing
	CanBeDropped = true --> if true, the tool can be dropped by the player
]]--
	userName = tool.Parent.Name --> set username for clicks score
	sound:Play() --> play sound when player equipped tool
end)

-- Unequipped: When the tool is unequipped
tool.Unequipped:Connect(function()
	print("This tool has been unequipped!")
end)

-- Activated: When the left mouse button is pressed (using this tool to perform an action)
tool.Activated:Connect(function()
	warn("This tool has been activated!")
	isHolding = true
	tool:ScaleTo(2)
	while isHolding do
		partHandle.Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
		task.wait(WAIT_TIME)
	end
	game.Players:FindFirstChild(userName).leaderstats.Clicks.Value += 1
end)

-- Deactivated: When stopping the use of the tool
tool.Deactivated:Connect(function()
	warn("This tool has been deactivated!")
	isHolding = false
	tool:ScaleTo(1)
end)

-----------------------------------------------------------------------------------------------------------
-- inside server script service --> create sample ui for clicking
-- event for when player come to game
game.Players.PlayerAdded:Connect(function(plr)
	local leaderstats = Instance.new("Folder")
	leaderstats.Parent = plr
	leaderstats.Name = "leaderstats"

	local clicks = Instance.new("IntValue")
	clicks.Parent = leaderstats
	clicks.Name = "Clicks"
	clicks.Value = 0

end)


