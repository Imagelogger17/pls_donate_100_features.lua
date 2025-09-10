-- Pls Donate — 100 Features (Safe)
-- Author: You
-- Note: This is a SAFE client-side script. It does NOT give Robux.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Screen GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PD_100Features"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 400, 0, 500)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Pls Donate - 100 Features (Safe)"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -10, 1, -40)
scroll.Position = UDim2.new(0, 5, 0, 35)
scroll.CanvasSize = UDim2.new(0, 0, 0, 2000)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local uiList = Instance.new("UIListLayout", scroll)
uiList.Padding = UDim.new(0, 6)

-- Utility for toggles
local function makeToggle(name, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Text = name .. " [OFF]"
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.new(1,1,1)
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. (state and " [ON]" or " [OFF]")
        callback(state)
    end)
end

-- ✅ Example features (1–20)
makeToggle("1. AFK Wiggle", function(state)
    if state then
        spawn(function()
            while state do
                humanoid:Move(Vector3.new(0,0,0), true)
                wait(30)
            end
        end)
    end
end)

makeToggle("2. Infinite Jump", function(state)
    if state then
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if state then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

makeToggle("3. Rainbow Booth Sign (local)", function(state)
    if state then
        spawn(function()
            local t = 0
            while state do
                t = t + RunService.Heartbeat:Wait()
                local c = Color3.fromHSV((t*0.25)%1, 1, 1)
                frame.BackgroundColor3 = c -- example visual
            end
        end)
    else
        frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    end
end)

makeToggle("4. Auto Booth Messages (local)", function(state)
    if state then
        spawn(function()
            while state do
                StarterGui:SetCore("ChatMakeSystemMessage", {
                    Text = "Donate if you like cookies 🍪!"
                })
                wait(15)
            end
        end)
    end
end)

-- (Features 5–20 you can add similar, ex: speed slider, jump power slider, name glow, etc.)
