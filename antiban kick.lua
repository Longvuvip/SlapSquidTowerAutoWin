-- ✅ ANTI-KICK + ANTIBAN cho Steal a Brainrot
-- ⚠️ Nên chạy TRƯỚC bất kỳ script nào khác

local Players = game:GetService("Players")
local mt = getrawmetatable(game)
setreadonly(mt, false)

-- 🚫 Chặn các hành động nghi ngờ
local oldNamecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	local args = {...}

	-- Chặn kick từ server
	if method == "Kick" and self == Players.LocalPlayer then
		warn("[⚠️] Phát hiện lệnh Kick, đã chặn.")
		return nil
	end

	-- Chặn RemoteEvent nghi ngờ (anti-report)
	if method == "FireServer" and tostring(self):lower():find("report") then
		warn("[⚠️] Block report remote: ", self:GetFullName())
		return nil
	end

	return oldNamecall(self, unpack(args))
end)

-- 🛡️ Gỡ các kết nối kick có sẵn (LocalScript trap)
for _, v in pairs(getconnections(Players.LocalPlayer.Kick)) do
	v:Disable()
end

-- 🧠 Ẩn hành vi bất thường (delay hợp lý)
getgenv().BrainrotAntiDelay = 1.5 + math.random() * 1.5  -- Dùng delay 1.5–3s mỗi hành động

print("[✅] Anti-Kick & Anti-Ban đã được kích hoạt thành công!")