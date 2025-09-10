-- Fisch Auto-Farm Script with GUI

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.Name = "FischAutoFarmGUI"

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 300)
Frame.Position = UDim2.new(0, 10, 0, 10)

local AutoFishButton = Instance.new("TextButton")
AutoFishButton.Parent = Frame
AutoFishButton.Size = UDim2.new(0, 180, 0, 50)
AutoFishButton.Position = UDim2.new(0, 10, 0, 10)
AutoFishButton.Text = "Toggle Auto Fish"
AutoFishButton.MouseButton1Click:Connect(function()
    -- Toggle auto fishing logic here
end)

local AutoSellButton = Instance.new("TextButton")
AutoSellButton.Parent = Frame
AutoSellButton.Size = UDim2.new(0, 180, 0, 50)
AutoSellButton.Position = UDim2.new(0, 10, 0, 70)
AutoSellButton.Text = "Toggle Auto Sell"
AutoSellButton.MouseButton1Click:Connect(function()
    -- Toggle auto selling logic here
end)

-- Add more buttons and features as needed
