-- 🌈 LongDepTrai - Steal a Brainrot OP Script
-- ✅ Auto Steal 1 Pet + Teleport về nhà + AntiBan + UI + Banner

-- 📦 Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- 🛡 AntiBan Hook
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	if method == "Kick" or method == "Destroy" or method == "BreakJoints" then
		warn("[AntiBan] Blocked:", method)
		return
	end
	return old(self, ...)
end)

-- 🌟 Variables
local toggles = {
	Steal = false,
	Teleport = false,
	Speed = false
}
local speedValue = 50
local collected = 0

-- 🎨 UI
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "LongDepTrai_Brainrot_OP"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0, 20, 0, 40)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Text = "☠ LongDepTrai Hub ☠"
title.Size = UDim2.new(1, 0, 0, 30)
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local function createButton(text, y, callback)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -20, 0, 35)
	btn.Position = UDim2.new(0, 10, 0, y)
	btn.Text = text .. ": OFF"
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.MouseButton1Click:Connect(function()
		toggles[text] = not toggles[text]
		btn.Text = text .. ": " .. (toggles[text] and "ON" or "OFF")
	end)
end

createButton("Steal", 0.2, nil)
createButton("Teleport", 0.4, nil)
createButton("Speed", 0.6, nil)

-- ✈ Speed Hack
RunService.RenderStepped:Connect(function()
	if toggles.Speed then
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("Humanoid") then
			char.Humanoid.WalkSpeed = speedValue
		end
	end
end)

-- 🐾 Steal + Teleport Pet Loop
task.spawn(function()
	while true do
		task.wait(1)
		if toggles.Steal then
			for _, v in ipairs(Workspace:GetDescendants()) do
				if v:IsA("Model") and v.Name == "Pet" and v:FindFirstChild("HumanoidRootPart") and not v:IsDescendantOf(LocalPlayer.Character) then
					local char = LocalPlayer.Character
					if char and char:FindFirstChild("HumanoidRootPart") then
						char.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
						collected += 1
						break
					end
				end
			end
		end

		if toggles.Teleport and collected >= 1 then
			local char = LocalPlayer.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				local home = Workspace:FindFirstChild(LocalPlayer.Name .. "_House")
				if home and home:FindFirstChild("HomePoint") then
					char.HumanoidRootPart.CFrame = home.HomePoint.CFrame + Vector3.new(0, 2, 0)
					collected = 0
				end
			end
		end
	end
end)