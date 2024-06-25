-- Dev: Mike016
-- Date: Tuesday, 25 June, 2024

-- Collection Service: manages groups (collections) of instances with tags. 
-- VIEW --> Tag Editor
local CollectionService = game:GetService("CollectionService")

--------------------------------------------------------------------------------
-- Get all objects tagged with "EnemyBox"
local killBoxes = CollectionService:GetTagged("EnemyBox") -- Returns a table of tagged objects

-- Loop through all "EnemyBox" tagged objects
for _, killBox in pairs(killBoxes) do
	killBox.Touched:Connect(function(hit)
		local humanoid = hit.Parent:FindFirstChild("Humanoid")

		if humanoid then
			humanoid.Health = 0 -- Instantly kill the humanoid on touch
		end
	end)
end

--------------------------------------------------------------------------------
-- Get tags assigned to a specific object
local tags = CollectionService:GetTags(game.Workspace.Part1)
print(#tags) -- Output the number of tags, e.g., 2

for _, tag in pairs(tags) do
	print(tag) -- Output each tag, e.g., "EnemyBox", "NewTag"
end

--------------------------------------------------------------------------------
-- Get all tags used in the game
local allTags = CollectionService:GetAllTags()
print(#allTags) -- Output the total number of tags, e.g., 4

for _, tag in pairs(allTags) do
	print(tag)
	--[[ Outputs:
		NewTag
		NewTag2
		EnemyBox
		TagEditorTagContainer (don't worry about this tag; it wasn't created by us)
	]]--
end

--------------------------------------------------------------------------------
-- Events for when tags are added or removed: create actions for adding and removing specific tags
CollectionService:GetInstanceAddedSignal("EnemyBox"):Connect(function()
	print("EnemyBox tag has been added to the collection")
end)

CollectionService:GetInstanceRemovedSignal("EnemyBox"):Connect(function()
	warn("EnemyBox tag has been removed from the collection!!!")
end)

--------------------------------------------------------------------------------
-- Add, Remove Tags and check for the presence of a tag

-- Get the part with no initial tags
local newPart = game.Workspace:WaitForChild("NewPart")
task.wait(5)
-- Add "EnemyBox" tag to the new part
CollectionService:AddTag(newPart, "EnemyBox")

-- Check if the new part has the "EnemyBox" tag
if CollectionService:HasTag(newPart, "EnemyBox") then
	print("New part has 'EnemyBox' tag")
end

task.wait(5)

-- Remove "EnemyBox" tag from the new part
CollectionService:RemoveTag(newPart, "EnemyBox")

-- Check if the new part still has the "EnemyBox" tag (should be false)
if CollectionService:HasTag(newPart, "EnemyBox") then
	print("New part has 'EnemyBox' tag") -- This won't be printed as the tag was removed
end
