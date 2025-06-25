-- 🛫 LongDepTrai Fly Safe Script 🛫
-- Không bị kick, tương thích với AntiBan, Swift PC friendly

local uis = game:GetService("UserInputService")
local run = game:GetService("RunService")
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Tạo BodyVelocity để bay
local bv = Instance.new("BodyVelocity")
bv.Velocity = Vector3.zero
bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
bv.Parent = hrp

local flying = false
local speed = 60

-- Toggle bay bằng phím F
uis.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.F then
		flying = not flying
	end
end)

-- Cập nhật hướng bay
run.RenderStepped:Connect(function()
	if flying then
		local cam = workspace.CurrentCamera
		local move = Vector3.new()
		if uis:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
		if uis:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
		if uis:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
		if uis:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
		if uis:IsKeyDown(Enum.KeyCode.Space) then move += cam.CFrame.UpVector end
		if uis:IsKeyDown(Enum.KeyCode.LeftControl) then move -= cam.CFrame.UpVector end
		bv.Velocity = move.Unit * speed
	else
		bv.Velocity = Vector3.zero
	end
end)