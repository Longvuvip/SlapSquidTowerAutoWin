-- 🧱 Wall Hop Script + UI – LongDepTrai Hub

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Char:WaitForChild("Humanoid")

-- 🌟 Trạng thái
local wallhop = false

-- 🎨 UI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "WallHopUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 120)
Frame.Position = UDim2.new(0, 20, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Frame)
Title.Text = "☠ LongDepTrai Hub ☠"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(1, -20, 0, 40)
Toggle.Position = UDim2.new(0, 10, 0, 50)
Toggle.Text = "WallHop: OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.Font = Enum.Font.Gotham
Toggle.TextSize = 18

Toggle.MouseButton1Click:Connect(function()
	wallhop = not wallhop
	Toggle.Text = "WallHop: " .. (wallhop and "ON" or "OFF")
end)

-- 🧱 Wall Hop Loop
RunService.RenderStepped:Connect(function()
	if wallhop and Humanoid and Humanoid.FloorMaterial == Enum.Material.Air then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)