-- InstantGloves.lua - Kiểm thử đeo và lưu gloves + popup thông báo UI

-- Cảnh báo sử dụng
print("🧪 InstantGloves: Bắt đầu kiểm thử...")

local plr = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local glovesFolder = rs:WaitForChild("Gloves")
local equipRemote = rs:FindFirstChild("EquipGlove")
local fakeSaveRemote = rs:FindFirstChild("SaveGlove") -- Remote giả lập lưu glove

if not equipRemote then
    warn("❌ Không tìm thấy Remote 'EquipGlove'. Dừng script.")
    return
end

if not fakeSaveRemote then
    warn("⚠️ Không tìm thấy Remote 'SaveGlove'. Không thể giả lưu.")
end

for _, glove in pairs(glovesFolder:GetChildren()) do
    print("🧤 Đang thử glove:", glove.Name)

    equipRemote:FireServer(glove.Name)

    if fakeSaveRemote then
        fakeSaveRemote:FireServer(glove.Name)
        print("💾 Đã gửi yêu cầu 'lưu' glove:", glove.Name)
    end

    wait(0.15)
end

-- Tạo UI Popup giữa màn hình
if game.CoreGui:FindFirstChild("TestPopup") then
    game.CoreGui.TestPopup:Destroy()
end

local popupGui = Instance.new("ScreenGui", game.CoreGui)
popupGui.Name = "TestPopup"
popupGui.ResetOnSpawn = false

local frame = Instance.new("Frame", popupGui)
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Name = "MainFrame"

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 10)

local topLeftLabel = Instance.new("TextLabel", frame)
topLeftLabel.Text = "Thông báo kiểm thử"
topLeftLabel.Position = UDim2.new(0, 10, 0, 5)
topLeftLabel.Size = UDim2.new(0, 200, 0, 20)
topLeftLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
topLeftLabel.BackgroundTransparency = 1
topLeftLabel.Font = Enum.Font.SourceSansItalic
topLeftLabel.TextSize = 14
topLeftLabel.TextXAlignment = Enum.TextXAlignment.Left

local closeButton = Instance.new("TextButton", frame)
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.TextColor3 = Color3.fromRGB(255, 80, 80)
closeButton.BackgroundTransparency = 1
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 18
closeButton.MouseButton1Click:Connect(function()
    popupGui:Destroy()
end)

local centerLabel = Instance.new("TextLabel", frame)
centerLabel.Text = "Test Script thành công"
centerLabel.Size = UDim2.new(1, 0, 1, 0)
centerLabel.Position = UDim2.new(0, 0, 0, 0)
centerLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
centerLabel.BackgroundTransparency = 1
centerLabel.Font = Enum.Font.SourceSansBold
centerLabel.TextSize = 28
centerLabel.TextWrapped = true
centerLabel.TextYAlignment = Enum.TextYAlignment.Center
