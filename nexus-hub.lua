-- 🧠 BRAINROT AUTO TP - DELTA MOBILE 🧠
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local basePosition = Vector3.new(0, 10, 0)

-- Supprime ancien GUI
if player.PlayerGui:FindFirstChild("BrainrotAutoTP") then
    player.PlayerGui.BrainrotAutoTP:Destroy()
end

-- GUI Ultra Simple
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotAutoTP"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 110, 0, 35)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 15)
title.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
title.Text = "🧠 AUTO TP"
title.TextColor3 = Color3.white
title.TextSize = 9
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

-- Bouton Save + Status
local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.6, 0, 0, 15)
saveBtn.Position = UDim2.new(0.02, 0, 0, 17)
saveBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
saveBtn.Text = "💾 SAVE BASE"
saveBtn.TextColor3 = Color3.white
saveBtn.TextSize = 7
saveBtn.Font = Enum.Font.SourceSans
saveBtn.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(0.35, 0, 0, 15)
status.Position = UDim2.new(0.63, 0, 0, 17)
status.BackgroundTransparency = 1
status.Text = "⚡ ON"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.TextSize = 8
status.Font = Enum.Font.SourceSansBold
status.Parent = frame

-- Fonction TP INSTANTANÉ
local function autoTP()
    spawn(function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(basePosition)
            status.Text = "🧠 TP!"
            status.TextColor3 = Color3.fromRGB(255, 0, 255)
            wait(1)
            status.Text = "⚡ ON"
            status.TextColor3 = Color3.fromRGB(0, 255, 0)
        end
    end)
end

-- Save position
saveBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        basePosition = char.HumanoidRootPart.Position
        saveBtn.Text = "✅ SAVED"
        saveBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        spawn(function()
            wait(1.5)
            saveBtn.Text = "💾 SAVE BASE"
            saveBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        end)
    end
end)

-- AUTO TP quand tu ramasses
local function onItemPickup(item)
    if item:IsA("Tool") then
        autoTP()
    end
end

-- Connexions pour Delta
player.Backpack.ChildAdded:Connect(onItemPickup)

-- Setup character
local function setupCharacter(char)
    if char then
        char.ChildAdded:Connect(onItemPickup)
    end
end

player.CharacterAdded:Connect(setupCharacter)
if player.Character then
    setupCharacter(player.Character)
end

print("🧠 BRAINROT AUTO TP - DELTA READY!")
print("⚡ Ramasse un brainrot = TP automatique!")

