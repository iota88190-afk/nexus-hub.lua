-- 🧠 BRAINROT INSTA TP SCRIPT 🧠
-- Téléportation instantanée dès que tu ramasses un brainrot

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- 📍 POSITION DE TA BASE (MODIFIE CES COORDONNÉES)
local basePosition = Vector3.new(0, 10, 0)

-- Supprime l'ancien GUI s'il existe
if player.PlayerGui:FindFirstChild("BrainrotTP") then
    player.PlayerGui.BrainrotTP:Destroy()
end

-- GUI Simple pour configurer la base
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotTP"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
title.Text = "🧠 BRAINROT INSTA TP"
title.TextColor3 = Color3.fromRGB(255, 100, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Bouton Save Position
local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.9, 0, 0, 25)
saveBtn.Position = UDim2.new(0.05, 0, 0, 40)
saveBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
saveBtn.Text = "💾 SAVE BASE POSITION"
saveBtn.TextColor3 = Color3.white
saveBtn.TextScaled = true
saveBtn.Font = Enum.Font.Gotham
saveBtn.Parent = frame

local saveBtnCorner = Instance.new("UICorner")
saveBtnCorner.CornerRadius = UDim.new(0, 5)
saveBtnCorner.Parent = saveBtn

-- Status
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 20)
status.Position = UDim2.new(0, 0, 0, 75)
status.BackgroundTransparency = 1
status.Text = "⚡ READY - Ramasse un brainrot pour TP!"
status.TextColor3 = Color3.fromRGB(100, 255, 100)
status.TextScaled = true
status.Font = Enum.Font.Gotham
status.Parent = frame

-- Drag
frame.Active = true
frame.Draggable = true

-- Fonction TP ULTRA RAPIDE
local function instantTP()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        -- TP instantané sans délai
        char.HumanoidRootPart.CFrame = CFrame.new(basePosition)
        status.Text = "🧠 TÉLÉPORTÉ À LA BASE!"
        status.TextColor3 = Color3.fromRGB(255, 100, 255)
        
        -- Reset status après 2 secondes
        spawn(function()
            wait(2)
            status.Text = "⚡ READY - Ramasse un brainrot pour TP!"
            status.TextColor3 = Color3.fromRGB(100, 255, 100)
        end)
    end
end

-- Save position
saveBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        basePosition = char.HumanoidRootPart.Position
        saveBtn.Text = "✅ POSITION SAVED!"
        saveBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        spawn(function()
            wait(2)
            saveBtn.Text = "💾 SAVE BASE POSITION"
            saveBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        end)
    end
end)

-- Détection INSTANTANÉE quand tu ramasses
local function onChildAdded(child)
    if child:IsA("Tool") then
        instantTP()
    end
end

-- Connexions multiples pour être sûr
player.Backpack.ChildAdded:Connect(onChildAdded)

player.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(onChildAdded)
end)

if player.Character then
    player.Character.ChildAdded:Connect(onChildAdded)
end

print("🧠 BRAINROT INSTA TP LOADED!")
print("⚡ Téléportation instantanée activée!")
