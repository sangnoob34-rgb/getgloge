-- InstantGloves.lua - Script kiểm thử nội bộ (tester only)

local plr = game.Players.LocalPlayer
local glovesFolder = game:GetService("ReplicatedStorage"):WaitForChild("Gloves")
local equipRemote = game:GetService("ReplicatedStorage"):FindFirstChild("EquipGlove")

if not equipRemote then
    warn("⚠️ Không tìm thấy Remote 'EquipGlove'. Dừng script.")
    return
end

for _, glove in pairs(glovesFolder:GetChildren()) do
    print("🧤 Thử đeo glove:", glove.Name)
    equipRemote:FireServer(glove.Name)
    wait(0.2)
end

game.StarterGui:SetCore("SendNotification", {
    Title = "InstantGloves Tester";
    Text = "✅ Đã gửi yêu cầu đeo tất cả gloves!";
    Duration = 5;
})
