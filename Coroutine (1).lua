-- Dev:Mike016 Friday, June 7, 2024.
-- A COROUTINE is used to perform multiple tasks at the same time from within the same script
-- To solve problems, assume we have two while loops where the condition is always true.
--                    Generally, the second while loop will not execute.

-- Example for basic coroutine
local task02  = coroutine.create(function(parametor01)
	print(parametor01)
	
	coroutine.yield()
	
	for i = 1 , 5 do
		print(i)
		
		task.wait()
		
	end
end)

-- we can also pass parametors to coroutine
coroutine.resume(task02 , "Mike")
coroutine.resume(task02)

for i = 1 , 5 do
	print("I am another task")
	task.wait()
end

--[[ results
  15:41:34.747  Mike
  15:41:34.748  1
  15:41:34.748  I am another task
  15:41:34.846  2
  15:41:34.846  I am another task
  15:41:34.862  3
  15:41:34.863  I am another task
  15:41:34.872  4
  15:41:34.872  I am another task
  15:41:34.884  5
  15:41:34.884  I am another task
]]--

---------------------------------------------------------------------------------------------------
-- Example for coroutine.yield() : pause and  it saves its current state, including all local variables and the current position in the code
local task01 = coroutine.create(function()
	local i = 1
	while true do
		print(i)
		i += 1
		coroutine.yield() -- coroutine.yield() Stop execute and wait for statement coroutine.resume(task01) then execute it again!!!
	end
end)
--print(typeof(task01)) -- thread: 0x4923ec9950d7b44c
coroutine.resume(task01)
print("Ending")
coroutine.resume(task01)
--[[ results
  15:06:37.793  1
  15:06:37.793  Ending
  15:06:37.793  2
]]--

---------------------------------------------------------------------------------------------------

-- Example for coroutine.wrap() look like coroutine.resume()
function myCoroutine1()
	for i = 1, 3 do
		print("Coroutine iteration: " .. i)
		coroutine.yield(i)
	end
end

wrapped = coroutine.wrap(myCoroutine1)

print(wrapped()) -- Coroutine iteration: 1, prints 1
print(wrapped()) -- Coroutine iteration: 2, prints 2
print(wrapped()) -- Coroutine iteration: 3, prints 3
print(wrapped()) -- Prints nil (end of coroutine)
--[[ Key Differences wrap and resume
Return Value Handling:
coroutine.wrap() returns a function that behaves like a regular Lua function.
coroutine.resume() returns a boolean and the values yielded or an error message.

Error Handling:
coroutine.wrap() automatically propagates errors to the caller.
coroutine.resume() requires explicit handling of errors using the returned boolean status.

Usage:
coroutine.wrap() is simpler for straightforward coroutine use cases where error handling can be managed by standard Lua mechanisms.
coroutine.resume() is more flexible and provides detailed control over coroutine execution and error handling.
]]--

---------------------------------------------------------------------------------------------------
-- Example running function : Returns the running coroutine.
local task03 = coroutine.create(function()
	print("I am task 03")
	while true do
		task.wait()
	end
end)
coroutine.resume(task03)
print(coroutine.running()) -- thread: 0xf6b63be8ad66b936

---------------------------------------------------------------------------------------------------

-- Exaple for close and status functions

-- Function to be used in the coroutine
function myCoroutine2()
	print("Coroutine started")
	for i = 1, 5 do
		print("Coroutine iteration: " .. i)
		coroutine.yield()
	end
	print("Coroutine finished")
end

-- Create the coroutine
co = coroutine.create(myCoroutine2)

-- Resume the coroutine a few times
print(coroutine.status(co)) -- suspended
coroutine.resume(co) -- Coroutine started, Coroutine iteration: 1
coroutine.resume(co) -- Coroutine iteration: 2
coroutine.resume(co) -- Coroutine iteration: 3

print(coroutine.status(co)) -- suspended

-- Close the coroutine
coroutine.close(co)

-- Check the status of the coroutine after closing it
print(coroutine.status(co)) -- dead

--[[ Meaning results of status:
"running"
This status indicates that the coroutine is currently executing.
It is the state a coroutine is in when it is resumed and actively running.

"suspended"
This status indicates that the coroutine is currently paused,
The coroutine is waiting to be resumed. Coroutines begin in this state and enter it when their function calls coroutine.yield().

"normal"
This status indicates that the coroutine is active but not currently running.
This occurs when the coroutine has called a function, and that function is currently executing.
Essentially, the coroutine is waiting for the called function to return.

"dead"
This status indicates that the coroutine has finished its execution, 
either because it returned normally or because it encountered an error. 
Once a coroutine is dead, it cannot be resumed again.

]]--

---------------------------------------------------------------------------------------------------

-- Example: coroutine.isyieldable(): Checks if yielding is safe at a specific point in a coroutine.

function myCoroutine3()
    print("Coroutine started")
    
    -- Normal yield check
    if coroutine.isyieldable() then
        print("Coroutine can yield")
        coroutine.yield(1) -- Yield control and return 1
    else
        print("Coroutine cannot yield")
    end

    -- Protected call preventing yield
    local function protectedFunction()
        print("Inside protected function")
        if coroutine.isyieldable() then
            print("Coroutine can yield inside protected function")
            coroutine.yield(2) -- Attempt to yield
        else
            print("Coroutine cannot yield inside protected function")
        end
    end

    print("Calling protected function")
    local success, err = pcall(protectedFunction)
    if not success then
        print("Error:", err)
    end

    print("Coroutine resumed after protected call")
    return 3
end

-- Create the coroutine
co = coroutine.create(myCoroutine3)

-- Resume the coroutine for the first time
status, value = coroutine.resume(co)
print(status, value) -- true, 1

-- Resume the coroutine for the second time
status, value = coroutine.resume(co)
print(status, value) -- true, 2

-- Check the status of the coroutine after the second resume
print(coroutine.status(co)) -- suspended

-- Resume the coroutine for the third time
status, value = coroutine.resume(co)
print(status, value) -- true, 3

-- Check the final status of the coroutine
print(coroutine.status(co)) -- dead

--[[Results:
Coroutine started
Coroutine can yield
true 1
Calling protected function
Inside protected function
Coroutine can yield inside protected function
true 2
suspended
true 3
dead

]]--

