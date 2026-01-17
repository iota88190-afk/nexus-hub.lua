-- ⚡ VANTRIX HUB ⚡ - TP Ultra Renforcé
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Variables
local savedPos = nil
local autoTpEnabled = false

-- Supprime l'ancien GUI
if player.PlayerGui:FindFirstChild("VantrixHub") then
    player.PlayerGui.VantrixHub:Destroy()
end

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
subtitle.Text = "🚀 Ultra Force TP 🚀"
subtitle.TextColor3 = Color3.fromRGB(200, 100, 255)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = frame

local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.9, 0, 0, 35)
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

-- Fonction TP ULTRA FORCE (toutes les méthodes)
local function ultraForceTP()
    local char = player.Character
    if not char or not savedPos then 
        print("VANTRIX: Pas de character ou position!")
        return false 
    end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    
    if not hrp then 
        print("VANTRIX: Pas de HumanoidRootPart!")
        return false 
    end
    
    print("VANTRIX: Début TP ultra force...")
    
    -- Méthode 1: Disable humanoid
    if humanoid then
        humanoid.PlatformStand = true
        humanoid.Sit = false
    end
    
    -- Méthode 2: Anchored + multiple CFrame
    hrp.Anchored = true
    for i = 1, 5 do
        hrp.CFrame = CFrame.new(savedPos)
        wait(0.02)
    end
    
    -- Méthode 3: Position + Velocity reset
    hrp.Position = savedPos
    hrp.Velocity = Vector3.new(0, 0, 0)
    hrp.RotVelocity = Vector3.new(0, 0, 0)
    
    -- Méthode 4: CFrame avec lookVector
    hrp.CFrame = CFrame.new(savedPos, savedPos + Vector3.new(0, 0, 1))
    
    wait(0.1)
    
    -- Re-enable
    hrp.Anchored = false
    if humanoid then
        humanoid.PlatformStand = false
    end
    
    print("VANTRIX: TP ultra force terminé vers " .. tostring(savedPos))
    return true
end

-- Détection d'objets pris
local lastToolCount = 0
local function checkForNewItem()
    if not autoTpEnabled or not savedPos then return end
    
    local char = player.Character
    local backpack = player:FindFirstChild("Backpack")
    
    if char and backpack then
        local totalTools = 0
        
        -- Compte tous les tools
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                totalTools = totalTools + 1
            end
        end
        
        for _, item in pairs(char:GetChildren()) do
            if item:IsA("Tool") then
                totalTools = totalTools + 1
            end
        end
        
        -- Nouvel objet = TP ULTRA FORCE
        if totalTools > lastToolCount then
            print("VANTRIX: OBJET DÉTECTÉ! TP ULTRA FORCE!")
            ultraForceTP()
        end
        
        lastToolCount = totalTools
    end
end

-- Events
saveBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char.HumanoidRootPart then
        savedPos = char.HumanoidRootPart.Position
        saveBtn.Text = "✅ SAVED!"
        saveBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        print("VANTRIX: Position sauvée: " .. tostring(savedPos))
        
        spawn(function()
            wait(1.5)
            saveBtn.Text = "💾 SAVE POSITION"
            saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        end)
    else
        print("VANTRIX: ERREUR - Pas de character!")
    end
end)

autoBtn.MouseButton1Click:Connect(function()
    if not savedPos then
        autoBtn.Text = "⚠️ SAVE FIRST!"
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
        subtitle.Text = "🚀 Ultra Force Activé! 🚀"
        
        -- Reset compteur
        lastToolCount = 0
        local char = player.Character
        local backpack = player:FindFirstChild("Backpack")
        
        if char then
            for _, item in pairs(char:GetChildren()) do
                if item:IsA("Tool") then
                    lastToolCount = lastToolCount + 1
                end
            end
        end
        
        if backpack then
            for _, item in pairs(backpack:GetChildren()) do
                if item:IsA("Tool") then
                    lastToolCount = lastToolCount + 1
                end
            end
        end
        
        print("VANTRIX: ULTRA FORCE TP ACTIVÉ! Tools actuels: " .. lastToolCount)
    else
        autoBtn.Text = "🔴 AUTO TP: OFF"
        autoBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        title.Text = "⚡ VANTRIX HUB ⚡"
        subtitle.Text = "🚀 Ultra Force TP 🚀"
        print("VANTRIX: Auto-TP désactivé")
    end
end)

-- Loop de détection
spawn(function()
    while true do
        wait(0.1)
        pcall(checkForNewItem)
    end
end)

print("⚡ VANTRIX HUB ⚡ - Ultra Force TP System!")
print("🚀 TP avec 4 méthodes combinées!")
print("💎 Si ça marche pas, le jeu a un anti-cheat très fort!")

