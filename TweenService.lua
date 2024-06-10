-- Dev: Mike016 
-- Date: Monday , June 10,2024
-- Tween Service: create smooth animations, transitions, and effects.
--                It facilitates the interpolation of values over time, 
--                enabling objects to smoothly transition from one state to another.

local tweenService = game:GetService("TweenService")
local part = script.Parent

local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) -- Parameters : Time:10 DelayTime:0 RepeatCount:0 Reverses:False EasingDirection:Out EasingStyle:Quad
--[[ Parameters of tweenInfo :
 Time: 10 seconds (duration of the tween)
 DelayTime: 0 seconds (no delay before starting the tween)
 RepeatCount: 0 (no repetition)
 Reverses: false (does not reverse direction after finishing)
 EasingDirection: Out (slows down towards the end) link video : https://youtu.be/VrcrA42VPk4?si=Q_zWw-o534yVXvyZ
    Enum.EasingDirection.In, -- Animation starts slowly and accelerates towards the end
    Enum.EasingDirection.Out, -- Animation starts quickly and decelerates towards the end (slows down towards the end)
    Enum.EasingDirection.InOut -- Animation combines both In and Out directions: starts slowly, accelerates in the middle, 
                                  and then decelerates towards the end
 EasingStyle: Quad (defualt) link video : https://youtube.com/shorts/MHLCZch4KDY?si=3i0DBAgfVZtiTv8O
    Enum.EasingStyle.Linear, -- Constant speed
    Enum.EasingStyle.Sine, -- Smooth start and end, like a sine wave
    Enum.EasingStyle.Back, -- Slight reverse start and overshoot end
    Enum.EasingStyle.Bounce, -- Bounces at the end
    Enum.EasingStyle.Elastic, -- Stretches and recoils at the start and end
    Enum.EasingStyle.Quad, -- Smooth acceleration and deceleration (quadratic)
    Enum.EasingStyle.Quart, -- More pronounced than Quad
    Enum.EasingStyle.Quint, -- Even sharper easing than Quart
    Enum.EasingStyle.Expo, -- Exponential acceleration
    Enum.EasingStyle.Circ, -- Circular pattern, more pronounced than Sine
    Enum.EasingStyle.Cubic -- Between Quad and Quart in terms of sharpness
]]--

-- Define the goal properties for the tween ( can change all properties of part )
local goal = {
	-- Property names are case-sensitive and must start with an uppercase letter
	-- The order of properties does not matter
	Position = Vector3.new(30, 1.5, -21), -- goal position
	Size = Vector3.new(10,10,10) , -- new size
	Transparency = 0.5 , -- new transparency() ?????????? 1 == invisible
	Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255)) ,
    --Orientation = Vector3.new(math.random(0,180) , math.random(0,180) ,math.random(0,180))	
}

-- Create the tween object with the target instance, tweenInfo, and goal properties
--                          instance , tweenInfo  , goal
tween = tweenService:Create(part , tweenInfo , goal)

-- Wait for 2 seconds before starting the tween
task.wait(2)
tween:Play() -- play animation
task.wait(1)

-- tween:Pause() -- Pause: stops the animation and saves its current state; can resume from this point later
-- tween:Cancel() -- Cancel: stops the animation and resets the object's properties to their initial states 
--                           ,But retains the tween object

-- Wait until the tween is completed
-- tween.Completed:Wait()
-- print("Tween has been completed")

-- Or we can add an event listener for when the tween completes
tween.Completed:Connect(function()
	-- Additional commands to run when the animation is completed
	print("Tween has been completed!!!")
end)

-- Destroy the tween object to free memory
tween:Destroy()


