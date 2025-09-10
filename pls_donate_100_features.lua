-- Pls Donate — Fully Functional Rayfield GUI with Key System
-- Author: You
-- Safe / Cosmetic Only

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Create Window with Key System
local Window = Rayfield:CreateWindow({
    Name = "Pls Donate GUI",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Safe Features",
    ConfigurationSaving = {Enabled=false},

    -- Key System
    KeySystem = true,
    KeySettings = {
        Title = "Pls Donate Key",
        Subtitle = "Enter your key to access the GUI",
        Note = "Get the key from the creator",
        FileName = "PD_Key",
        SaveKey = true,
        GrabKeyFromSite = false, -- set true if you want online validation
        Key = "faggot" -- The correct key
    }
})

-- Tabs
local MovementTab = Window:CreateTab("Movement")
local BoothTab = Window:CreateTab("Booth/Sign")
local VisualsTab = Window:CreateTab("Visuals")
local FunTab = Window:CreateTab("Fun")

-- References
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local cam = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

-- Runtime
local runtime = {}

-- =====================
-- Movement Features
-- =====================
MovementTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        runtime.infJump = Value
        if Value then
            UIS.JumpRequest:Connect(function()
                if runtime.infJump then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end
})

MovementTab:CreateSlider({
    Name = "WalkSpeed",
    CurrentValue = humanoid.WalkSpeed,
    Min = 16,
    Max = 200,
    Callback = function(Value)
        humanoid.WalkSpeed = Value
    end
})

MovementTab:CreateSlider({
    Name = "JumpPower",
    CurrentValue = humanoid.JumpPower,
    Min = 50,
    Max = 300,
    Callback = function(Value)
        humanoid.JumpPower = Value
    end
})

MovementTab:CreateToggle({
    Name = "AFK Wiggle",
    CurrentValue = false,
    Callback = function(Value)
        runtime.afk = Value
        if Value then
            spawn(function()
                while runtime.afk do
                    humanoid:Move(Vector3.new(0,0,0), true)
                    wait(25)
                end
            end)
        end
    end
})

-- Teleport Buttons
for i=1,3 do
    MovementTab:CreateButton({
        Name = "Teleport "..i,
        Callback = function()
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = CFrame.new(Vector3.new(math.random(-50,50),10,math.random(-50,50)))
            end
        end
    })
end

-- Bunny Hop
MovementTab:CreateToggle({
    Name = "Bunny Hop",
    CurrentValue = false,
    Callback = function(Value)
        runtime.bhop = Value
        if Value then
            spawn(function()
                while runtime.bhop do
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    wait(0.5)
                end
            end)
        end
    end
})

-- Speed/Jump Presets
for _,v in pairs({50,100,150,200}) do
    MovementTab:CreateButton({Name="Speed "..v, Callback=function() humanoid.WalkSpeed=v end})
end
for _,v in pairs({100,150,200,250}) do
    MovementTab:CreateButton({Name="Jump "..v, Callback=function() humanoid.JumpPower=v end})
end

-- =====================
-- Booth/Sign Features
-- =====================
BoothTab:CreateToggle({
    Name = "Auto Booth Messages",
    CurrentValue = false,
    Callback = function(Value)
        runtime.boothMsg = Value
        if Value then
            spawn(function()
                local messages={"Donate if you like cookies!","Thanks for visiting!","Support me!","Small donation = big smile"}
                while runtime.boothMsg do
                    StarterGui:SetCore("ChatMakeSystemMessage",{Text=messages[math.random(1,#messages)]})
                    wait(15)
                end
            end)
        end
    end
})

BoothTab:CreateToggle({
    Name = "Rainbow Booth Sign",
    CurrentValue = false,
    Callback = function(Value)
        runtime.rainbowBooth = Value
        if Value then
            spawn(function()
                local frame=Instance.new("Frame")
                frame.Size=UDim2.new(0,200,0,50)
                frame.Position=UDim2.new(0.5,-100,0.5,-25)
                frame.Parent=player:WaitForChild("PlayerGui")
                local t=0
                while runtime.rainbowBooth do
                    t=t+RunService.Heartbeat:Wait()
                    frame.BackgroundColor3=Color3.fromHSV((t*0.25)%1,1,1)
                end
            end)
        end
    end
})

for i,c in pairs({Color3.fromRGB(255,0,0),Color3.fromRGB(0,255,0),Color3.fromRGB(0,0,255)}) do
    BoothTab:CreateButton({Name="Booth Color "..i, Callback=function()
        local frame=Instance.new("Frame")
        frame.Size=UDim2.new(0,200,0,50)
        frame.Position=UDim2.new(0.5,-100,0.5,-25)
        frame.BackgroundColor3=c
        frame.Parent=player:WaitForChild("PlayerGui")
    end})
end

-- =====================
-- Visuals Features
-- =====================
VisualsTab:CreateToggle({Name="Name Tag Glow", CurrentValue=false, Callback=function(Value)
    local head=character:FindFirstChild("Head")
    if head then
        if Value then
            if not head:FindFirstChild("NameBillboard") then
                local b=Instance.new("BillboardGui",head)
                b.Name="NameBillboard"
                b.Size=UDim2.new(0,150,0,40)
                b.AlwaysOnTop=true
                local t=Instance.new("TextLabel",b)
                t.Size=UDim2.new(1,0,1,0)
                t.BackgroundTransparency=1
                t.Text=player.Name
                t.TextStrokeTransparency=0
            end
        else
            local bb=head:FindFirstChild("NameBillboard")
            if bb then bb:Destroy() end
        end
    end
end})

VisualsTab:CreateSlider({Name="Camera Zoom", CurrentValue=cam.FieldOfView, Min=30, Max=120, Callback=function(Value) cam.FieldOfView=Value end})

VisualsTab:CreateToggle({Name="Rainbow Trails", CurrentValue=false, Callback=function(Value)
    if Value then
        local hrp=character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local att0=Instance.new("Attachment",hrp)
            local att1=Instance.new("Attachment",hrp)
            local trail=Instance.new("Trail",hrp)
            trail.Attachment0=att0 trail.Attachment1=att1
            spawn(function()
                local t=0
                while Value do
                    t=t+RunService.Heartbeat:Wait()
                    trail.Color=ColorSequence.new(Color3.fromHSV((t*0.25)%1,1,1))
                end
            end)
        end
    end
end})

-- =====================
-- Fun Features
-- =====================
FunTab:CreateToggle({Name="Chat Auto-Messages", CurrentValue=false, Callback=function(Value)
    runtime.chatAuto=Value
    if Value then
        spawn(function()
            while runtime.chatAuto do
                StarterGui:SetCore("ChatMakeSystemMessage",{Text="Enjoying my booth? Donate!"})
                wait(15)
            end
        end)
    end
end})

FunTab:CreateToggle({Name="Local HUD", CurrentValue=false, Callback=function(Value)
    if Value then
        local f=Instance.new("Frame")
        f.Size=UDim2.new(0,150,0,60)
        f.Position=UDim2.new(1,-180,1,-120)
        f.BackgroundTransparency=0.3
        f.Parent=player:WaitForChild("PlayerGui")
        local t=Instance.new("TextLabel",f)
        t.Size=UDim2.new(1,0,1,0)
        t.BackgroundTransparency=1
        t.Text="Local Donations: 0"
    end
end})

print("✅ Pls Donate Rayfield GUI loaded! Key System enabled.")
