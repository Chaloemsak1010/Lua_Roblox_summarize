-- Dev: Mike016
-- Concurrency concepts:

-- task is library (It's heavier than a coroutine. But it's have an advantage.)
-- task 01
print("I am task 01")

--Example: task wait
-- task.wait(5) -- wait 5 second before execute next line

-- task 03
local taskDelay = task.delay( 1 , function() -- task delay: skip to execute next line and wait 1 second and comback to execute this function
	print("I am task 03")
end)

-------------------------------------------------------------------
-- Example: task cancel
local rdNumber = math.random(1,2)
if rdNumber == 2 then
	task.cancel(taskDelay) -- task03 will not working when random Number == 2
	print("Random number = 2")
end

-- task 02
print("I am task 02")

-------------------------------------------------------------------
--Exaple: Task spawn 
-- task 1
print("start")
--task 2
local isTrue = true
task.spawn(function()
	while isTrue do
		print("From spawn  Task 2")
		task.wait() -- small time unit for waiting another task
	end
end)

-- task 3
for i = 1 , 10 do
	print("From task 3")
	task.wait()
end
isTrue = false -- stop while loop in task 2

-- task 4
print("end")

-------------------------------------------------------------------
-- Example for task defer : skip to another line and comeback again
-- task 1
print("Start")
-- task 2
task.defer(function() print("From task 2 Defer") end)
-- task 3
for i = 1 , 5 do
	print("From task 3  I = ".. i)
end 
-- task 4
print("End")

--[[ Output:
  16:14:35.135  Start
  16:14:35.136  From task 3  I = 1
  16:14:35.136  From task 3  I = 2
  16:14:35.136  From task 3  I = 3
  16:14:35.136  From task 3  I = 4
  16:14:35.136  From task 3  I = 5
  16:14:35.136  End
  16:14:35.136  From task 2 Defer
]]--

----------------------------------------------------------------------
-- Example of using task.desynchronize() and task.synchronize() in Roblox Lua

-- A function to simulate heavy computation
local function performHeavyComputation()
	local result = 0
	for i = 1, 1e7 do
		result = result + math.sqrt(i)
	end
	return result
end

-- Function to update the game state
local function updateGameState(result)
	print("Computation result: " .. result)
	-- Here you would update the game state, e.g., setting a value in the GUI
end

-- Main function to demonstrate desynchronization and synchronization
local function main()
	print("Starting heavy computation...")

	-- Desynchronize to perform heavy computation in a separate thread : run in parallel
	task.desynchronize() 

	local computationResult = performHeavyComputation()

	-- Synchronize to update the game state in the main thread : comeback to run in serial
	task.synchronize()

	updateGameState(computationResult)

	print("Finished updating game state.")
end

-- Run the main function
main()




