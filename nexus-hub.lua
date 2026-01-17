-- 🧠 BRAINROT INSTA TP - DELTA MOBILE OPTIMIZED 🧠
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local basePosition = Vector3.new(0, 10, 0)

-- Supprime ancien GUI
if player.PlayerGui:FindFirstChild("BrainrotTP") then
    player.PlayerGui.BrainrotTP:Destroy()
end

-- GUI Ultra Simple pour Delta
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotTP"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 140, 0, 50)
frame.Position = UDim2.new(0, 5, 0, 5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Titre compact
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 18)
title.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
title.Text = "🧠 BRAINROT TP"
title.TextColor3 = Color3.white
title.TextSize = 12
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

-- Bouton Save simple
local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.6, 0, 0, 14)
saveBtn.Position = UDim2.new(0.02, 0, 0, 20)
saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
saveBtn.Text = "💾 SAVE"
saveBtn.TextColor3 = Color3.white
saveBtn.TextSize = 10
saveBtn.Font = Enum.Font.SourceSans
saveBtn.Parent = frame

-- Status simple
local status = Instance.new("TextLabel")
status.Size = UDim2.new(0.35, 0, 0, 14)
status.Position = UDim2.new(0.63, 0, 0, 20)
status.BackgroundTransparency = 1
status.Text = "⚡ READY"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.TextSize = 9
status.Font = Enum.Font.SourceSans
status.Parent = frame

-- Status info
local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, 0, 0, 12)
info.Position = UDim2.new(0, 0, 0, 36)
info.BackgroundTransparency = 1
info.Text = "Ramasse = TP Direct"
info.TextColor3 = Color3.fromRGB(150, 150, 150)
info.TextSize = 8
info.Font = Enum.Font.SourceSans
info.Parent = frame

-- Fonction TP DELTA OPTIMIZED
local function deltaTP()
    spawn(function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Méthode Delta Mobile
            char.HumanoidRootPart.CFrame = CFrame.new(basePosition)
            status.Text = "🧠 TP!"
            status.TextColor3 = Color3.fromRGB(255, 0, 255)
            wait(1)
            status.Text = "⚡ READY"
            status.TextColor3 = Color3.fromRGB(0, 255, 0)
        end
    end)
end

-- Save pour Delta
saveBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        basePosition = char.HumanoidRootPart.Position
        saveBtn.Text = "✅ OK"
        saveBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        wait(1)
        saveBtn.Text = "💾 SAVE"
        saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    end
end)

-- Détection Delta Mobile
local function onPickup(item)
    if item:IsA("Tool") then
        deltaTP()
    end
end

-- Connexions Delta
player.Backpack.ChildAdded:Connect(onPickup)

-- Character setup
local function setupChar(char)
    if char then
        char.ChildAdded:Connect(onPickup)
    end
end

player.CharacterAdded:Connect(setupChar)
if player.Character then
    setupChar(player.Character)
end

print("🧠 BRAINROT TP - DELTA READY!")


