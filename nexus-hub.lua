-- ⚡ NEXUS HUB ⚡ - Ultimate TP Script
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Variables
local savedPos = nil

-- Supprime l'ancien GUI s'il existe
if player.PlayerGui:FindFirstChild("NexusHub") then
    player.PlayerGui.NexusHub:Destroy()
end

-- GUI Style Hub
local gui = Instance.new("ScreenGui")
gui.Name = "NexusHub"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 160)
frame.Position = UDim2.new(0.5, -140, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
frame.BorderSizePixel = 0
frame.Parent = gui

-- Coins arrondis
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Titre stylé
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
title.Text = "⚡ NEXUS HUB ⚡"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = title

-- Sous-titre
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 45)
subtitle.BackgroundTransparency = 1
subtitle.Text = "🚀 Ultimate Teleportation System 🚀"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 255)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = frame

-- Bouton Save stylé
local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.9, 0, 0, 30)
saveBtn.Position = UDim2.new(0.05, 0, 0, 75)
saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
saveBtn.Text = "💾 SAVE POSITION"
saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
saveBtn.TextScaled = true
saveBtn.Font = Enum.Font.GothamBold
saveBtn.Parent = frame

local saveBtnCorner = Instance.new("UICorner")
saveBtnCorner.CornerRadius = UDim.new(0, 8)
saveBtnCorner.Parent = saveBtn

-- Bouton TP stylé
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.9, 0, 0, 30)
tpBtn.Position = UDim2.new(0.05, 0, 0, 115)
tpBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
tpBtn.Text = "⚡ TELEPORT NOW"
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.TextScaled = true
tpBtn.Font = Enum.Font.GothamBold
tpBtn.Parent = frame

local tpBtnCorner = Instance.new("UICorner")
tpBtnCorner.CornerRadius = UDim.new(0, 8)
tpBtnCorner.Parent = tpBtn

-- Drag
frame.Active = true
frame.Draggable = true

-- Fonction TP
local function nexusTP(position)
    local char = player.Character
    if not char then 
        print("NEXUS: Character not found!")
        return false
    end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then 
        print("NEXUS: HumanoidRootPart not found!")
        return false
    end
    
    hrp.CFrame = CFrame.new(position)
    print("NEXUS: Teleported to " .. tostring(position))
    return true
end

-- Events avec animations
saveBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char.HumanoidRootPart then
        savedPos = char.HumanoidRootPart.Position
        saveBtn.Text = "✅ POSITION SAVED!"
        saveBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("NEXUS: Position saved at " .. tostring(savedPos))
        
        spawn(function()
            wait(1.5)
            saveBtn.Text = "💾 SAVE POSITION"
            saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        end)
    else
        saveBtn.Text = "❌ ERROR!"
        saveBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        spawn(function()
            wait(1)
            saveBtn.Text = "💾 SAVE POSITION"
            saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        end)
    end
end)

tpBtn.MouseButton1Click:Connect(function()
    if savedPos then
        if nexusTP(savedPos) then
            tpBtn.Text = "🚀 TELEPORTED!"
            tpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            tpBtn.Text = "❌ FAILED!"
            tpBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
        
        spawn(function()
            wait(1.5)
            tpBtn.Text = "⚡ TELEPORT NOW"
            tpBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        end)
    else
        tpBtn.Text = "⚠️ NO POSITION SAVED!"
        tpBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        spawn(function()
            wait(1.5)
            tpBtn.Text = "⚡ TELEPORT NOW"
            tpBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        end)
    end
end)

print("⚡ NEXUS HUB ⚡ - Ultimate TP Script Loaded!")
print("🚀 Created by Nexus Team")
print("💎 Premium Teleportation Experience")
