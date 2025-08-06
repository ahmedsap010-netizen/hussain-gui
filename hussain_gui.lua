-- Hussein GUI | Fully Revised by RoboLOx 🪄
-- Exploit Compatibility: Delta / KRNL

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Safe Notification
pcall(function()
    local chatRemote = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents", 3)
    if chatRemote then
        local SayMessageRequest = chatRemote:FindFirstChild("SayMessageRequest")
        if SayMessageRequest then
            SayMessageRequest:FireServer("سكربت ضريح الحسين المطور أحمد 🪄🤌", "All")
        end
    end
end)

-- GUI setup
local gui = Instance.new("ScreenGui")
gui.Name = "HusseinGUI"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
title.Text = "⚔️ ضريح الحسين ⚔️"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

local nameBox = Instance.new("TextBox", frame)
nameBox.PlaceholderText = "أكتب اسم اللاعب"
nameBox.Size = UDim2.new(0.9, 0, 0, 30)
nameBox.Position = UDim2.new(0.05, 0, 0.18, 0)
nameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
nameBox.TextColor3 = Color3.new(1,1,1)
nameBox.Font = Enum.Font.SourceSans
nameBox.TextScaled = true

local flingBtn = Instance.new("TextButton", frame)
flingBtn.Text = "⚡ Fling Player"
flingBtn.Size = UDim2.new(0.9, 0, 0, 30)
flingBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
flingBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
flingBtn.TextColor3 = Color3.new(1, 1, 1)
flingBtn.Font = Enum.Font.SourceSansBold
flingBtn.TextScaled = true

local tpBtn = Instance.new("TextButton", frame)
tpBtn.Text = "📍 Teleport to Player"
tpBtn.Size = UDim2.new(0.9, 0, 0, 30)
tpBtn.Position = UDim2.new(0.05, 0, 0.52, 0)
tpBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
tpBtn.TextColor3 = Color3.new(1, 1, 1)
tpBtn.Font = Enum.Font.SourceSansBold
tpBtn.TextScaled = true

local speedBox = Instance.new("TextBox", frame)
speedBox.PlaceholderText = "🏃 السرعة (مثلاً 30)"
speedBox.Size = UDim2.new(0.9, 0, 0, 30)
speedBox.Position = UDim2.new(0.05, 0, 0.69, 0)
speedBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.Font = Enum.Font.SourceSans
speedBox.TextScaled = true

local flyBtn = Instance.new("TextButton", frame)
flyBtn.Text = "🕊️ Toggle Fly"
flyBtn.Size = UDim2.new(0.9, 0, 0, 30)
flyBtn.Position = UDim2.new(0.05, 0, 0.86, 0)
flyBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 90)
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.Font = Enum.Font.SourceSansBold
flyBtn.TextScaled = true

-- Helpers
local function getPlayer(name)
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name:lower():sub(1, #name) == name:lower() then
            return player
        end
    end
end

flingBtn.MouseButton1Click:Connect(function()
    local target = getPlayer(nameBox.Text)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(9999,9999,9999)
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Parent = target.Character.HumanoidRootPart
            wait(0.3)
            bv:Destroy()
        end
    end
end)

tpBtn.MouseButton1Click:Connect(function()
    local target = getPlayer(nameBox.Text)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
        end
    end
end)

speedBox.FocusLost:Connect(function()
    local val = tonumber(speedBox.Text)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if val and hum then
        hum.WalkSpeed = val
    end
end)

local flying = false
flyBtn.MouseButton1Click:Connect(function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    flying = not flying
    if flying then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlyForce"
        bv.MaxForce = Vector3.new(1e5,1e5,1e5)
        bv.Velocity = Vector3.zero
        bv.Parent = hrp

        RunService:BindToRenderStep("FlyLoop", Enum.RenderPriority.Input.Value, function()
            if not flying then return end
            local cam = workspace.CurrentCamera
            local dir = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
            hrp:FindFirstChild("FlyForce").Velocity = dir.Unit * 75
        end)
    else
        RunService:UnbindFromRenderStep("FlyLoop")
        if hrp:FindFirstChild("FlyForce") then
            hrp.FlyForce:Destroy()
        end
    end
end)
