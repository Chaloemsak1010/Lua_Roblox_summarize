-- Dev: Mike016
-- Date: Friday , 28 June,2024

--[[
BAGES: A special award you can gift players when they meet a goal within your experience, 
       such as completing a difficult objective or playing for a certain amount of time.
       As soon as a player receives a badge,it displays within the Badges category of their inventory.
       *** Use a template of 512×512 pixels.
 3 Useful method:
  - Awarding Badges: --> BadgeService:AwardBadge(player.UserId, badgeId)
  - Checking Earned Badges: --> BadgeService:UserHasBadgeAsync(player.UserId, BADGE_ID) => boolean
  - Getting Badge Info: --> BadgeService:GetBadgeInfoAsync(BADGE_ID) => table
]]--

-- Version as use with Pcall
local BadgeService = game:GetService("BadgeService")
local BADGE_ID = 2494384223493261

game.Players.PlayerAdded:Connect(function(player)
	task.wait(5)
	-- Fetch badge info
	local success , badgeInfo = pcall(BadgeService.GetBadgeInfoAsync , BadgeService , BADGE_ID )
	if not success then
		warn("Fail to fetch informations")
	end
	-- Check player have or doesn't have this badge.
	local success , hasBadge = pcall(BadgeService.UserHasBadgeAsync , BadgeService , player.UserId , BADGE_ID )
	print(hasBadge)
	if not hasBadge and badgeInfo.IsEnabled then
		-- If player doesn't have this badge AND badge is enabled(Actived),
		-- Then award the player this badge.
	    local success , errorMsg = pcall(BadgeService.AwardBadge , BadgeService , player.UserId , BADGE_ID)
	    if not success then
	       print(errorMsg)
	    end
	else
		print(player.Name .. " already has bage!")
	end
end)
--[[
Mike_LongDev already has bage!
]]--

-------------------------------------------------------------------------------------------------------------
--[=[ 
-- Version Basic
local BadgeService = game:GetService("BadgeService")

local badgeId = 2494384223493261

game.Players.PlayerAdded:Connect(function(player)
	task.wait(5)
	-- return true when player already has this bage, Otherwise false when player doesn't have this bage
	local hasBadge = BadgeService:UserHasBadgeAsync(player.UserId , badgeId )
	
	if not hasBadge then
		-- if player doesn't have this badge, then award the player this badge
		BadgeService:AwardBadge(player.UserId , badgeId)
	else
		print(player.Name .. " already has bage!")
	end
	
	-- get info badge: return table
	local badgeInfo = BadgeService:GetBadgeInfoAsync(badgeId)
--[[ print(badgeInfo)
  {
    ["Description"] = "so coolllllllllllllllllllllllllllllllllll",
    ["IconImageId"] = 18241682204,
    ["IsEnabled"] = true,
    ["Name"] = "golden"
  }
]]--
	
	for _ , v in pairs(badgeInfo) do
		print(v)
		--[[
		 true
         18241682204
         golden
         so coolllllllllllllllllllllllllllllllllll
		]]--
	end
	
end)

------------------------------------------------------------------------------------------------------------
-- 
--[[ Pcall Structure: local success:bool , ...returnFromFn = pcall(f : function(prms), ...args)
local success , errorMessage = pcall(function(number1)
	print(number1) --> 100
end , 100)
]]--

local BadgeService = game:GetService("BadgeService")

local badgeId = 2494384223493261
--[[Pcall arguments:
   1ST: Method name we want to use( use . instead of : CUZ we're not trying to call)
   2ND: Instance of service
   Other arguments: Arguments for the function
]]--
-- Fetch badge information
local success , data = pcall(BadgeService.GetBadgeInfoAsync ,BadgeService , badgeId)	


]=]--


