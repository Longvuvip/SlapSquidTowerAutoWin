-- 🏔️ Climb & Jump Tower Script + UI – LongDepTrai Hub

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- 🛡️ AntiBan Hook
local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNC = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method=="Kick" or method=="Destroy" or method=="BreakJoints" then
        return warn("[AntiBan] Blocked:", method)
    end
    return oldNC(self, ...)
end)

-- 💡 States
local toggles = { AutoJump = false, SpeedHack = false }
local speedValue = 70

-- 🎨 UI Setup
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "ClimbTower_UI"
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 240, 0, 150)
frame.Position = UDim2.new(0, 20, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Text = "☠ LongDepTrai Hub ☠"
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 18

local function makeBtn(name, yPos)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,-20,0,40)
    btn.Position = UDim2.new(0,10,0,yPos)
    btn.Text = name..": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.MouseButton1Click:Connect(function()
        toggles[name] = not toggles[name]
        btn.Text = name..": "..(toggles[name] and "ON" or "OFF")
    end)
end

makeBtn("AutoJump", 300)
makeBtn("SpeedHack", 300)

-- ⚡ Speed Hack
RunService.RenderStepped:Connect(function()
    if toggles.SpeedHack then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = speedValue
        end
    end
end)

-- 🧗 Auto Jump / Climb
RunService.Stepped:Connect(function()
    if toggles.AutoJump then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
