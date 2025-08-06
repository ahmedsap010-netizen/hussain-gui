-- Script: ضريح الحسين | المطور أحمد 🪄🤌
-- Exploit Support: Delta / KRNL

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Notify in chat
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("سكربت ضريح الحسين المطور أحمد 🪄🤌", "All")

-- GUI setup
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "HusseinHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 230)
frame.Position = UDim2.new(0.5, -150, 0.5, -115)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "⚔️ ضريح الحسين ⚔️"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

local nameBox = Instance.new("TextBox", frame)
nameBox.PlaceholderText = "أكتب اسم اللاعب"
nameBox.Size = UDim2.new(0.9, 0, 0, 30)
nameBox.Position = UDim2.new(0.05, 0, 0.2, 0)
nameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
nameBox.TextColor3 = Color3.new(1,1,1)
nameBox.TextScaled = true
nameBox.Font = Enum.Font.SourceSans

local flingBtn = Instance.new("TextButton", frame)
flingBtn.Text = "⚡ Fling Player"
flingBtn.Size = UDim2.new(0.9, 0, 0, 30)
flingBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
flingBtn.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
flingBtn.TextColor3 = Color3.new(1,1,1)
flingBtn.TextScaled = true
flingBtn.Font = Enum.Font.SourceSansBold

local tpBtn = Instance.new("TextButton", frame)
tpBtn.Text = "📍 Teleport to Player"
tpBtn.Size = UDim2.new(0.9, 0, 0, 30)
tpBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
tpBtn.BackgroundColor3 = Color3.fromRGB(0, 90, 0)
tpBtn.TextColor3 = Color3.new(1,1,1)
tpBtn.TextScaled = true
tpBtn.Font = Enum.Font.SourceSansBold

local speedSlider = Instance.new("TextBox", frame)
speedSlider.PlaceholderText = "🏃 سرعة المشي (مثلاً 30)"
speedSlider.Size = UDim2.new(0.9, 0, 0, 30)
speedSlider.Position = UDim2.new(0.05, 0, 0.8, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
speedSlider.TextColor3 = Color3.new(1,1,1)
speedSlider.TextScaled = true
speedSlider.Font = Enum.Font.SourceSans

-- Fly setup
local flyEnabled = false
local flyBtn = Instance.new("TextButton", frame)
flyBtn.Text = "🕊️ Toggle Fly"
flyBtn.Size = UDim2.new(0.9, 0, 0, 30)
flyBtn.Position = UDim2.new(0.05, 0, 1.0, 0)
flyBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 90)
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.TextScaled = true
flyBtn.Font = Enum.Font.SourceSansBold

-- Functions

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
		local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			local BV = Instance.new("BodyVelocity")
			BV.Velocity = Vector3.new(9999,9999,9999)
			BV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
			BV.Parent = target.Character.HumanoidRootPart
			wait(0.2)
			BV:Destroy()
		end
	end
end)

tpBtn.MouseButton1Click:Connect(function()
	local target = getPlayer(nameBox.Text)
	if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
		end
	end
end)

speedSlider.FocusLost:Connect(function()
	local val = tonumber(speedSlider.Text)
	if val and LocalPlayer.Character then
		local hum = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
		if hum then
			hum.WalkSpeed = val
		end
	end
end)

-- Basic fly function
flyBtn.MouseButton1Click:Connect(function()
	flyEnabled = not flyEnabled
	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")

	if flyEnabled and hrp then
		local flyBody = Instance.new("BodyVelocity")
		flyBody.Velocity = Vector3.zero
		flyBody.MaxForce = Vector3.new(1e5,1e5,1e5)
		flyBody.Name = "FlyForce"
		flyBody.Parent = hrp

		RunService:BindToRenderStep("FlyUpdate", Enum.RenderPriority.Input.Value, function()
			local cam = Workspace.CurrentCamera
			local dir = Vector3.zero
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
			if flyBody then flyBody.Velocity = dir.Unit * 70 end
		end)
	else
		RunService:UnbindFromRenderStep("FlyUpdate")
		if hrp:FindFirstChild("FlyForce") then hrp.FlyForce:Destroy() end
	end
end)
