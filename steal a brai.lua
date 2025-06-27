-- ⚙️ Tự động steal pet (KHÔNG antiban vì đã có riêng)

local lp = game:GetService("Players").LocalPlayer
local StealRunning = false
local SelectedPet = nil
local MyHouse = nil

-- 🔍 Tìm nhà
local function FindMyHouse()
	for _, v in pairs(workspace:GetChildren()) do
		if v:FindFirstChild("Owner") and v.Owner.Value == lp.Name then
			return v
		end
	end
	return nil
end

-- 🐾 Steal 1 pet
local function StealOnePet()
	if not MyHouse then return end
	for _, house in pairs(workspace:GetChildren()) do
		if house:FindFirstChild("Pets") then
			for _, pet in pairs(house.Pets:GetChildren()) do
				if pet:IsA("Model") and pet.Name == SelectedPet and not pet:FindFirstChild("Stolen") then
					firetouchinterest(lp.Character.HumanoidRootPart, pet.PrimaryPart, 0)
					wait(0.5 + math.random())
					lp.Character.HumanoidRootPart.CFrame = MyHouse.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
					wait(0.5)
					return
				end
			end
		end
	end
end

-- 🔁 Vòng lặp
task.spawn(function()
	while true do
		if StealRunning and SelectedPet then
			StealOnePet()
		end
		wait(2 + math.random())
	end
end)

-- 🖥️ UI
local ui = Instance.new("ScreenGui", game.CoreGui)
ui.Name = "StealPetUI"

local frame = Instance.new("Frame", ui)
frame.Size = UDim2.new(0, 250, 0, 160)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🐾 Steal a Brainrot Hub"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.TextScaled = true

local dropdown = Instance.new("TextBox", frame)
dropdown.Position = UDim2.new(0, 10, 0, 40)
dropdown.Size = UDim2.new(1, -20, 0, 30)
dropdown.PlaceholderText = "Nhập tên Pet (VD: Capybara)"
dropdown.Text = ""

local toggle = Instance.new("TextButton", frame)
toggle.Position = UDim2.new(0, 10, 0, 80)
toggle.Size = UDim2.new(1, -20, 0, 30)
toggle.Text = "▶️ Bắt đầu Auto Steal"
toggle.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
toggle.TextColor3 = Color3.new(1, 1, 1)

toggle.MouseButton1Click:Connect(function()
	if not MyHouse then
		MyHouse = FindMyHouse()
	end

	if dropdown.Text ~= "" then
		SelectedPet = dropdown.Text
	end

	StealRunning = not StealRunning
	toggle.Text = StealRunning and "⏹️ Dừng Auto Steal" or "▶️ Bắt đầu Auto Steal"
end)