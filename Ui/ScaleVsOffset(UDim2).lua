-- Dev: Mike016
-- Date: Sunday , 23 June,2024
--[[
 UDim2: Data type represents a two-dimensional value where each dimension is composed of a relative scale and an absolute offset.
        It is a combination of two UDim representing the X and Y dimensions.
        The most common usages of UDim2 objects are setting the Size and Position of GuiObjects.
]]--

-- GUI in Roblox is 2D, with x and y coordinates.
--    Scale: Ratio between 0-1, representing a percentage of the parent container's size
--    Offset: Pixel value, representing an absolute number of pixels ***Not automatically when size of device change
-- *** Note: Using offset means the size will not automatically adjust when the size of the device changes

-- The position starts at the top-left corner by default: x{0,0}, y{0,0}
local textLabel = script.Parent

-- Wait for 5 seconds before executing the next code
task.wait(5)

-- Print the current position of the textLabel
-- print(textLabel.Position) --> {0, 0}, {0, 0}

-- Change the position to a specific location on the screen
-- Position consists of two components: scale and offset
-- Scale determines the relative position based on the parent container's size (0 to 1)
-- Offset determines the absolute position in pixels

-- Example:
-- x: 0.5 scale (50% of the parent container's width) + 0 offset (0 pixels)
-- y: 0.2 scale (20% of the parent container's height) + 0 offset (0 pixels)
--                   new(xScale : number,xOffset : number,yScale : number,yOffset : number)
textLabel.Position = UDim2.new(0.5, 0, 0.2, 0)

-- We can also change the size of the GUI element
-- Size consists of two components: scale and offset
-- Scale determines the relative size based on the parent container's size (0 to 1)
-- Offset determines the absolute size in pixels

-- Example using offset:
-- Width: 0 scale (0% of the parent container's width) + 600 offset (600 pixels)
-- Height: 0 scale (0% of the parent container's height) + 200 offset (200 pixels)
textLabel.Size = UDim2.new(0, 600, 0, 200)

