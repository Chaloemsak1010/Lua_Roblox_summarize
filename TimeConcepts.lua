-- Dev: Mike016
-- Get time(float) from server
local serverTime = workspace:GetServerTimeNow() -- servertimenow change in 1 second
print("Server Time: " .. serverTime)

math.randomseed(os.time()) -- os.time change in 1 second
local random = math.random(0,99)
--print("os.time: " ..random) 


local randomNano = Random.new() -- Change in nanosecond
local nanoseconds = randomNano:NextNumber(0, 999999999)
--print("Random Nano Second: " .. nanoseconds)
-- conclusion: workspace:GetServerTimeNow() and os.time() == Change in 1 second it not secure

-- tick(): time has elapsed, in seconds.Unix represented by the date January 1st, 1970.
print(tick())

-- Example about date
local dt = DateTime.now()
-- The "dddd" token is replaced with the full day of the week
print("Today is " .. dt:FormatLocalTime("dddd", "en-us"))

-- For the "en-us" locale, the "LL" token equals "MMMM D, YYYY"
print("The date is " .. dt:FormatLocalTime("LL", "en-us"))



