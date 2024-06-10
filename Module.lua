-- Dev: Mike016
-- -- Module Script --
local rewardManager = {} -- we can store functions in this table
-- name this table should be the same the file name 

local rewardCoin = 50

local rageOfCoins = {
	easy = 0.5,
	normal = 1,
	hard = 2,
}

function rewardManager.getCoinReward(...) -- don't put local in front of functions 

	-- : case  local _,diff = ... -- _ = table(Obj) , diff = 'easy' or called parametor
	--print(_) -- Output: {["getCoinReward"] = "function"}
    local getCoin = rageOfCoins[...] * rewardCoin
	return getCoin
end

return rewardManager

-- -- Other Script --
-- get instead of ServerStorage
local ServerStorage = game:GetService('ServerStorage')

-- load module script from server storage filename = rewardManager
local rewardManager = require(ServerStorage.rewardManager)

print(rewardManager.getCoinReward('easy'))
-- : meaning it will send rewardManeger obj(table) to be first parametor 
--   and second parametor wil be 'easy' both will combine to be tuple for argument of that function
--   otherwise we can use . and don't need to seperate tuple
