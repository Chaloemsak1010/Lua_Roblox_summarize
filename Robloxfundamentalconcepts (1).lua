-- Dev: Mike016
-- Roblox fundamental concepts:

-- Parent and Child relationship 
local parent  = script.Parent -- In this case workspace is parent of this scripts

-- FindFirstChild()
local a  = game.Workspace:FindFirstChild('A') -- return nil when part A is not define
if a == nil then
	print("Part A is not define Or Already destroy!!")
end

-- WaitForChild()
local b = game.Workspace:WaitForChild('B') -- seem we put wait() in front of this method wil not return nil

-- GetChildren()
local children = game.Workspace:FindFirstChild("PracticeGetChild"):GetChildren() -- Scope: Retrieves only the immediate children of the instance.
for _ ,	v in ipairs(children) do
	print(v)
end
-- Output  Part Part Part Model

--GetDescendants() : Scope: Retrieves all descendants of the instance, including children, grandchildren, and so on.
local modal = game.Workspace:FindFirstChild("PracticeGetChild"):GetDescendants()
for _ , v in ipairs(modal) do
	print(v)
end
-- return all part and all child inside model  -->   Part Part Part Model Part Part
-- trick: we can use obj:IsA("Part") to check

--Clone() Example code: when we touch enemy part it will clone itself
local enemy = script.Parent

-- Function to handle touch events
local function onTouch(hit)
	-- for stop duplicate when it alreadly have new_enemy part
	local check = game.Workspace:FindFirstChild("new_enemy")
	if check ~= nil then
		print("Already duplicate!!!")
		return
	end

	print('Touched')
	-- Clone the enemy part
	local enemyClone = enemy:Clone()
	-- Set the position of the clone to be the same as the original enemy
	enemyClone.CFrame = enemy.CFrame * CFrame.new(0,3,0)
	-- Parent new enemy to the same parent as the original enemy
	enemyClone.Parent = enemy.Parent
	enemyClone.Name = "new_enemy"
	-- destroy script in new enemy part
	enemyClone.Script:Destroy()
	wait(3)
end

-- Connect the touch event
enemy.Touched:Connect(onTouch)

--Destroy() use for destroy obj or part

