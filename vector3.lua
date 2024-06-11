-- Dev: Mike016
-- Date: Tuesday, June 11,2024

-- The Vector3 is data type represents a vector in 3D space
-- x Red
-- y Green (up and down)
-- z Blue

--[[
Benefits of `Vector3` in Roblox:
--1. **Positioning Objects**:
--	- `part.Position = Vector3.new(x, y, z)`

--2. **Size of Objects**:
--	- `part.Size = Vector3.new(x, y, z)`

--3. **Velocity**:
--	- `part.Velocity = Vector3.new(x, y, z)`

--4. **Rotation** (using in conjunction with `CFrame`):
--	- `part.CFrame = CFrame.new(Vector3.new(x, y, z)) * CFrame.Angles(math.rad(angleX), math.rad(angleY), math.rad(angleZ))`

--5. **Scale in Meshes**:
--	- `meshPart.MeshSize = Vector3.new(x, y, z)`

--6. **Force and Torque**:
--	- `bodyForce.Force = Vector3.new(x, y, z)`
--- `bodyTorque.Torque = Vector3.new(x, y, z)`
]]--

------------------------------------------------------------------------------------------------------------------
-- Properties specials constant value in Vecter3
print(Vector3.zero) --> 0, 0, 0	
print(Vector3.one)  --> 1, 1, 1
print(Vector3.xAxis)  --> 1, 0, 0
print(Vector3.yAxis)  --> 0, 1, 0
print(Vector3.zAxis)  --> 0, 0, 1

------------------------------------------------------------------------------------------------------------------
-- Magnitude(used to define a distance between two points):  Euclidean distance formula --> math.sqrt(vector.X^2 + vector.Y^2 + vector.Z^2) 
-- return number The distance of the Vector3 from 0,0,0.
print(Vector3.new(5,5,5).Magnitude)
-- More use case , Assume we want to find the distance between two point
local partA = workspace.PartA
local partB = workspace.PartB
-- Calculate and print the distance between partA and partB
local distance = (partB.Position - partA.Position).Magnitude
print("Distance between PartA and PartB: ", distance)

------------------------------------------------------------------------------------------------------------------
-- Unit is A normalized copy of the Vector3 - same direction as the original but a magnitude of 1.
-- It's like pulling  direction,    1 manitude of that vector prototype.
-- Use case: Directional Movement , Applying Force  etc.
print(Vector3.new(5,5,5).Unit)
--  Outputs: 0.5773501992225647, 0.5773501992225647, 0.5773501992225647
print(Vector3.new( 0.5773501992225647, 0.5773501992225647, 0.5773501992225647).Magnitude)
--  0.9999998807907104 almost equal to 1



------------------------------------------------------------------------------------------------------------------
-- Math Operations
local part = script.Parent
task.wait(3)

print("+ sum ")
task.wait(1)
for i = 0, 2 do
	part.Position = part.Position + Vector3.new(0, 0, 5)
	--[[ Description
	                   x  y  z
	       Vector3.new(0, 0, 5)
	                    + +  +
	                    1, 1, 1 ** part.Position is also vector3
	     So new positiions = old position + new position
	]]--
	task.wait(1)
end

print("- difference")
task.wait(1)
for i = 0, 2 do
	part.Position = part.Position - Vector3.new(0, 0, 5)
	task.wait(1)
end

--[[
Vector Multiplication and Division: In Roblox, Vector3 objects do not support direct multiplication and division. 
Instead, you should use the Vector3 constructor to directly assign the new positions.

]]

print("*  product")
task.wait(1)
for i = 0, 2 do
	part.Position = Vector3.new(part.Position.X, part.Position.Y * 5, part.Position.Z)
	task.wait(1)
end

print("/ quotient")
task.wait(1)
for i = 0, 2 do
	part.Position = Vector3.new(part.Position.X, part.Position.Y / 5, part.Position.Z)
	task.wait(1)
end

-- More Exaple use number for * , /  ***Can't use with + , - 
local position = Vector3.new(4, 5, 6)
-- Basic arithmetic operations
local multipliedPosition = position * 2 --> 8 10 12
local dividedPosition = position / 2 --> 2 2.5 3


------------------------------------------------------------------------------------------------------------------
-- Vector3 methods example in Roblox Lua
local v1 = Vector3.new(3.6, -2.4, 0.8)
local v2 = Vector3.new(1, 2, 3)

-- Abs: Returns a Vector3 with the absolute values of each component
local absVector = v1:Abs()
-- Output: Abs: 3.6 2.4 0.8
print("Abs:", absVector.X, absVector.Y, absVector.Z)

-- Ceil: Returns a Vector3 with each component rounded up to the nearest integer
local ceilVector = v1:Ceil()
-- Output: Ceil: 4  -2  1
print("Ceil:", ceilVector.X, ceilVector.Y, ceilVector.Z)

-- Floor: Returns a Vector3 with each component rounded down to the nearest integer
local floorVector = v1:Floor()
-- Output: Floor: 3  -3  0
print("Floor:", floorVector.X, floorVector.Y, floorVector.Z)

-- Sign: Returns a Vector3 with the sign of each component (-1, 0, or 1)
local signVector = v1:Sign()
-- Output: Sign: 1  -1  1
print("Sign:", signVector.X, signVector.Y, signVector.Z)

-- Cross: Returns the cross product of two Vector3 objects
local crossVector = v1:Cross(v2)
-- Output: Cross: -8.4  10  8.4
print("Cross:", crossVector.X, crossVector.Y, crossVector.Z)

-- Angle: Returns the angle between two Vector3 objects in radians
local angle = v1:Angle(v2)
-- Output: Angle: 1.146 radians (approximately)
print("Angle:", angle)

-- Dot: Returns a scalar dot product of the two vectors.
local dotProduct = v1:Dot(v2)
-- Output: Dot: 0.8
print("Dot:", dotProduct)

-- FuzzyEq: Returns true if two Vector3 objects are approximately equal
local fuzzyEq = v1:FuzzyEq(v2)
-- Output: FuzzyEq: false
print("FuzzyEq:", fuzzyEq)

-- Lerp: Linearly interpolates between two Vector3 objects
local lerpVector = v1:Lerp(v2, 0.5)
-- Output: Lerp: 2.3  -0.2  1.9
-- Example use Lerp for create sample animation ** don't need to focus on parts
local objBegin = game.Workspace:WaitForChild("Obj")
local ending = game.Workspace:WaitForChild("End")
-- begin point
local beginPosition = objBegin.Position
task.wait(3)
for i = 0.1,1,0.1 do
	objBegin.Position = beginPosition:Lerp(ending.Position , i)
	print(i)
	task.wait(1)
end


-- Max: Returns a Vector3 with the maximum values of each component from two Vector3 objects
local maxVector = v1:Max(v2)
-- Output: Max: 3.6  2  3
print("Max:", maxVector.X, maxVector.Y, maxVector.Z)

-- Min: Returns a Vector3 with the minimum values of each component from two Vector3 objects
local minVector = v1:Min(v2)
-- Output: Min: 1  -2.4  0.8
print("Min:", minVector.X, minVector.Y, minVector.Z)


-------------------------------------------------------------------------------------------------------
-- Example code using Vector3 with teleport players

local part = game.Workspace:WaitForChild("Teleport")

game.Players.PlayerAdded:Connect(function(player)
	task.wait(8)
	local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
	humanoidRootPart.Position = game.Workspace.Teleport.Position + Vector3.new(0,5,0)
	print("player teleport!!!")	
end)

