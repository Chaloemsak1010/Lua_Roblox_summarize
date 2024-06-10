-- Dev: Mike016
-- Date: Monday, June 10,2024

local part = script.Parent


-- Remove(): Similar to Destroy(), but it is deprecated and should be avoided.
-- set parent to nill
 --part:Remove() -- same this command: part.Parent = nil
 
-- task.wait(3)
-- Destroy(): Permanently removes the instance from the game. It cannot be recovered.
-- Disconnects all connections and call destroy on all children
-- part:Destroy()



-- Debris Service: Used to schedule automatic removal of objects after a specified time 
-- , Helpful for temporary objects like explosions or effects.
--              instance , lifetime 
game.Debris:AddItem(part , 3)

-----------------------------------------------------------------------------------------
-- Example why we need debris : just focus on while loop and spawnCoin() function

-- Recovery of the CoinZone and the model yellow coin
local CoinZone = game.Workspace.CoinZone
local coinModel = game.ReplicatedStorage.Coin

-- Function that creates a new clone of the model part
local function spawnCoin()
	-- Creating a clone of the model part
	local newCoin = coinModel:Clone()
	-- Random positioning of the clone in the CoinZone
	newCoin.Position = CoinZone.Position + Vector3.new(math.random(-10,10),0,math.random(-10,10))
	-- Adding the clone to the scene
	newCoin.Parent = game.Workspace
	-- Setting up the rotation of the workspace
	newCoin.RotVelocity = Vector3.new(0,50,0)

	newCoin.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") then
			script.Arpeggio:Play()
			newCoin:Destroy()
		end
	end)
    -- *** if we use destroy it will wait 5 second before go back to while loop and create another coin
	-- task.wait(5)
	-- newCoin:Destroy()
	-- so this case we need to use game.Debris:AddItem(newCoin,5)
	game.Debris:AddItem(newCoin,5)
end

-- Calling the spawnCoin function every second
while true do
	spawnCoin()
	wait(1)
end


