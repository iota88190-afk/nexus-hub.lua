local Players = game:GetService("Players")
local player = Players.LocalPlayer
local basePosition = Vector3.new(0, 10, 0)

pcall(function() player.PlayerGui.BrainrotTP:Destroy() end)

local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotTP"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 160, 0, 60)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 20)
title.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
title.Text = "🧠 BRAINROT TP"
title.TextColor3 = Color3.white
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.9, 0, 0, 15)
saveBtn.Position = UDim2.new(0.05, 0, 0, 22)
saveBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
saveBtn.Text = "💾 SAVE BASE"
saveBtn.TextScaled = true
saveBtn.Parent = frame

local saveBtnCorner = Instance.new("UICorner")
saveBtnCorner.CornerRadius = UDim.new(0, 4)
saveBtnCorner.Parent = saveBtn

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 12)
status.Position = UDim2.new(0, 0, 0, 42)
status.BackgroundTransparency = 1
status.Text = "⚡ READY"
status.TextColor3 = Color3.fromRGB(100, 255, 100)
status.TextScaled = true
status.Parent = frame

local function instantTP()
    local char = player.Character
    if char and char.HumanoidRootPart then
        char.HumanoidRootPart.CFrame = CFrame.new(basePosition)
        status.Text = "🧠 TÉLÉPORTÉ!"
        status.TextColor3 = Color3.fromRGB(255, 100, 255)
        spawn(function() wait(1.5) status.Text = "⚡ READY" status.TextColor3 = Color3.fromRGB(100, 255, 100) end)
    end
end

saveBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character.HumanoidRootPart then
        basePosition = player.Character.HumanoidRootPart.Position
        saveBtn.Text = "✅ SAVED!"
        spawn(function() wait(1) saveBtn.Text = "💾 SAVE BASE" end)
    end
end)

player.Backpack.ChildAdded:Connect(function(child) if child:IsA("Tool") then instantTP() end end)
player.CharacterAdded:Connect(function(char) char.ChildAdded:Connect(function(child) if child:IsA("Tool") then instantTP() end end) end)
if player.Character then player.Character.ChildAdded:Connect(function(child) if child:IsA("Tool") then instantTP() end end) end

print("🧠 BRAINROT INSTA TP LOADED!")

