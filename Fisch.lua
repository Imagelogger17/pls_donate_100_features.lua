-- Sound Setup
local SoundFolder = Instance.new("Folder")
SoundFolder.Name = "HubSounds"
SoundFolder.Parent = game:GetService("ReplicatedStorage")

local function createSound(name, id, volume)
    local sound = Instance.new("Sound")
    sound.Name = name
    sound.SoundId = id
    sound.Volume = volume or 0.5
    sound.Parent = SoundFolder
    return sound
end

-- Default Roblox click sounds
local ToggleSound = createSound("Toggle", "rbxassetid://12222005", 0.4) -- subtle click
local TabSound = createSound("TabSwitch", "rbxassetid://12222013", 0.4)
local MinMaxSound = createSound("MinMax", "rbxassetid://12222021", 0.4)

-- ========================
-- Example Integration
-- ========================

-- Toggle Button (reuse previous CreateToggle function)
local function CreateToggle(parent,text,callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,35)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7,0,1,0)
    label.BackgroundTransparency = 1
    label.Text=text
    label.TextColor3=Color3.fromRGB(255,255,255)
    label.TextXAlignment=Enum.TextXAlignment.Left
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0.25,0,0.7,0)
    toggle.Position = UDim2.new(0.72,0,0.15,0)
    toggle.BackgroundColor3=Color3.fromRGB(100,100,100)
    toggle.TextColor3=Color3.fromRGB(255,255,255)
    toggle.Text="OFF"
    toggle.Parent=frame
    local UICorner=Instance.new("UICorner")
    UICorner.CornerRadius=UDim.new(0,6)
    UICorner.Parent=toggle

    toggle.MouseButton1Click:Connect(function()
        ToggleSound:Play()
        local state=toggle.Text=="OFF"
        toggle.Text=state and "ON" or "OFF"
        if state then
            spawn(function()
                while toggle.Text=="ON" do
                    toggle.BackgroundColor3=Color3.fromHSV(rainbowHue,1,1)
                    wait(0.05)
                end
            end)
        else
            toggle.BackgroundColor3=Color3.fromRGB(100,100,100)
        end
        callback(state)
    end)
end

-- Tab Buttons
local function CreateTabButton(text, tabFrame)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0,80,1,-5)
    button.Position = UDim2.new(0,#TabBar:GetChildren()*85,0,5)
    button.BackgroundColor3 = Color3.fromRGB(60,60,60)
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.Text = text
    button.Parent = TabBar
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0,6)
    UICorner.Parent = button

    button.MouseEnter:Connect(function()
        TweenService:Create(button,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(90,90,90)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,60,60)}):Play()
    end)

    button.MouseButton1Click:Connect(function()
        TabSound:Play()
        for _, f in pairs(MainFrame:GetChildren()) do
            if f:IsA("Frame") and f~=TabBar then f.Visible=false end
        end
        tabFrame.Visible=true
    end)
end

-- Minimize/Maximize Button
MinButton.MouseButton1Click:Connect(function()
    MinMaxSound:Play()
    if isMinimized then
        TweenService:Create(MainFrame,TweenInfo.new(0.3),{Size=UDim2.new(0,450,0,500)}):Play()
    else
        TweenService:Create(MainFrame,TweenInfo.new(0.3),{Size=UDim2.new(0,200,0,40)}):Play()
    end
    isMinimized = not isMinimized
end)
