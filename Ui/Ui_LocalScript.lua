-- Dev: Mike016
-- Date: Sunday, June 16,2024
--[[
Structure of folder and files is as follows:
												- **StarterGui**
												  - **ScreenGui**
												    - **LocalScript**
												    - **Frame**
												      - **yesButton**
												      - **noButton**
												      - **TextLabel**

]]--

-- Reference to the ScreenGui parent object
local screenGui = script.Parent
-- References to UI elements within the ScreenGui
local frame = screenGui.Frame
local text = frame.TextLabel
local yesButton = frame.yesButton
local noButton = frame.noButton

yesButton.MouseButton1Click:Connect(function()
	text.BackgroundColor3 = Color3.fromRGB(0,math.random(0,255),math.random(0,255))
	text.Text = "Yay! I'm glad you like Roblox as well :)"
end)

noButton.MouseButton1Click:Connect(function()
	text.BackgroundColor3 = Color3.fromRGB(255,0,0)
	text.Text = "Aww! I'm sorry to hear that... :)"
end)

---- Example for all events for button(soem event inherited)
---- Function to connect all events for a given button
--local function connectButtonEvents(button, buttonName)
--	-- Mouse events
--	button.MouseEnter:Connect(function()
--		print(buttonName .. " - Mouse entered the button.")
--	end)

--	button.MouseLeave:Connect(function()
--		print(buttonName .. " - Mouse left the button.")
--	end)

--	button.MouseButton1Click:Connect(function()
--		print(buttonName .. " - Left mouse button clicked on the button.")
--	end)

--	button.MouseButton1Down:Connect(function()
--		print(buttonName .. " - Left mouse button pressed down on the button.")
--	end)

--	button.MouseButton1Up:Connect(function()
--		print(buttonName .. " - Left mouse button released on the button.")
--	end)
--	-- Note: This event cannot be used with mobile devices
--	button.MouseButton2Click:Connect(function()
--		print(buttonName .. " - Right mouse button clicked on the button.")
--	end)

--	button.MouseButton2Down:Connect(function()
--		print(buttonName .. " - Right mouse button pressed down on the button.")
--	end)

--	button.MouseButton2Up:Connect(function()
--		print(buttonName .. " - Right mouse button released on the button.")
--	end)

--	button.Activated:Connect(function()
--		print(buttonName .. " - Button activated.")
--	end)

--	-- Touch events
--	button.TouchTap:Connect(function()
--		print(buttonName .. " - Button tapped on a touch-enabled device.")
--	end)

--	-- Input events
--	button.InputBegan:Connect(function(input)
--		print(buttonName .. " - Input began: " .. input.UserInputType.Name)
--	end)

--	button.InputChanged:Connect(function(input)
--		print(buttonName .. " - Input changed: " .. input.UserInputType.Name)
--	end)

--	button.InputEnded:Connect(function(input)
--		print(buttonName .. " - Input ended: " .. input.UserInputType.Name)
--	end)
--end

---- Connect events for yesButton
--connectButtonEvents(yesButton, "YesButton")

---- Connect events for noButton (if needed)
--connectButtonEvents(noButton, "NoButton")
