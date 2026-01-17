-- ⚡ VANTRIX HUB ⚡ - Spécial Steal a Brainrot
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Variables
local savedPos = nil
local autoTpEnabled = false
local lastCash = 0

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "VantrixHub"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 180)
frame.Position = UDim2.new(0.5, -140, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
title.Text = "⚡ VANTRIX HUB ⚡"
title.TextColor3 = Color3.fromRGB(255, 0, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = title

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 45)
subtitle.BackgroundTransparency = 1
subtitle.Text = "🧠 Brainrot Auto-Steal 🧠"
subtitle.TextColor3 = Color3.fromRGB(200, 100, 255)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = frame

local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.9, 0, 0, 35)
saveBtn.Position = UDim2.new(0.05, 0, 0, 75)
saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
saveBtn.Text = "💾 SAVE BASE"
saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
saveBtn.TextScaled = true
saveBtn.Font = Enum.Font.GothamBold
saveBtn.Parent = frame

local saveBtnCorner = Instance.new("UICorner")
saveBtnCorner.CornerRadius = UDim.new(0, 8)
saveBtnCorner.Parent = saveBtn

local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(0.9, 0, 0, 35)
autoBtn.Position = UDim2.new(0.05, 0, 0, 120)
autoBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
autoBtn.Text = "🔴 AUTO TP: OFF"
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.TextScaled = true
autoBtn.Font = Enum.Font.GothamBold
autoBtn.Parent = frame

local autoBtnCorner = Instance.new("UICorner")
autoBtnCorner.CornerRadius = UDim.new(0, 8)
autoBtnCorner.Parent = autoBtn

frame.Active = true
frame.Draggable = true

-- Fonction TP pour Steal a Brainrot
local function brainrotTP()
    local char = player.Character
    if char and char.HumanoidRootPart and savedPos then
        char.HumanoidRootPart.CFrame = CFrame.new(savedPos)
        print("VANTRIX: TP à la base après vol!")
        return true
    end
    return false
end

-- Détection spéciale pour Steal a Brainrot
local function checkBrainrotSteal()
    if not autoTpEnabled then return end
    
    -- Méthode 1: Détection changement d'argent
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local cash = leaderstats:FindFirstChild("Cash") or leaderstats:FindFirstChild("Money")
        if cash and cash.Value > lastCash then
            print("VANTRIX: Argent augmenté! Brainrot volé!")
            brainrotTP()
            lastCash = cash.Value
        elseif cash then
            lastCash = cash.Value
        end
    end
    
    -- Méthode 2: Détection GUI de vol
    for _, gui in pairs(player.PlayerGui:GetDescendants()) do
        if gui:IsA("TextLabel") then
            local text = gui.Text:lower()
            if string.find(text, "stolen") or string.find(text, "brainrot") or string.find(text, "+") then
                print("VANTRIX: Message de vol détecté!")
                brainrotTP()
                break
            end
        end
    end
    
    -- Méthode 3: Détection proximité avec brainrots
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local playerPos = player.Character.HumanoidRootPart.Position
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") and obj.Name:lower():find("brainrot") then
                local distance = (obj.Position - playerPos).Magnitude
                if distance < 3 then -- Très proche d'un brainrot
                    wait(0.2) -- Attendre un peu
                    if not obj.Parent then -- L'objet a disparu = volé
                        print("VANTRIX: Brainrot volé par proximité!")
                        brainrotTP()
                        return
                    end
                end
            end
        end
    end
end

-- Events
saveBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char.HumanoidRootPart then
        savedPos = char.HumanoidRootPart.Position
        saveBtn.Text = "✅ BASE SAVED!"
        saveBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("VANTRIX: Base sauvée: " .. tostring(savedPos))
        
        spawn(function()
            wait(1.5)
            saveBtn.Text = "💾 SAVE BASE"
            saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        end)
    end
end)

autoBtn.MouseButton1Click:Connect(function()
    if not savedPos then
        autoBtn.Text = "⚠️ SAVE BASE FIRST!"
        spawn(function()
            wait(2)
            autoBtn.Text = "🔴 AUTO TP: OFF"
        end)
        return
    end
    
    autoTpEnabled = not autoTpEnabled
    if autoTpEnabled then
        autoBtn.Text = "🟢 AUTO TP: ON"
        autoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        title.Text = "⚡ VANTRIX HUB ✅"
        subtitle.Text = "🧠 Auto-Steal Activé! 🧠"
        
        -- Initialise le cash
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            local cash = leaderstats:FindFirstChild("Cash") or leaderstats:FindFirstChild("Money")
            if cash then
                lastCash = cash.Value
            end
        end
        
        print("VANTRIX: Auto-TP activé pour Steal a Brainrot!")
    else
        autoBtn.Text = "🔴 AUTO TP: OFF"
        autoBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        title.Text = "⚡ VANTRIX HUB ⚡"
        subtitle.Text = "🧠 Brainrot Auto-Steal 🧠"
        print("VANTRIX: Auto-TP désactivé")
    end
end)

-- Loop de détection
spawn(function()
    while true do
        wait(0.2)
        pcall(checkBrainrotSteal)
    end
end)

print("⚡ VANTRIX HUB ⚡ - Steal a Brainrot Edition!")
print("🧠 Détecte: Changement d'argent, messages de vol, proximité")
print("💎 Dès que tu voles un brainrot = TP à ta base!")

