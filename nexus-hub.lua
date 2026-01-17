-- ⚡ VANTRIX HUB ⚡ - Auto TP CORRIGÉ
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
frame.Size = UDim2.new(0, 280, 0, 240)
frame.Position = UDim2.new(0.5, -140, 0.5, -120)
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
subtitle.Text = "🚀 Premium Auto-Teleport System 🚀"
subtitle.TextColor3 = Color3.fromRGB(200, 100, 255)
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = frame

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

local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(0.9, 0, 0, 30)
autoBtn.Position = UDim2.new(0.05, 0, 0, 115)
autoBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
autoBtn.Text = "🔴 AUTO TP: OFF"
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.TextScaled = true
autoBtn.Font = Enum.Font.GothamBold
autoBtn.Parent = frame

local autoBtnCorner = Instance.new("UICorner")
autoBtnCorner.CornerRadius = UDim.new(0, 8)
autoBtnCorner.Parent = autoBtn

local testBtn = Instance.new("TextButton")
testBtn.Size = UDim2.new(0.9, 0, 0, 30)
testBtn.Position = UDim2.new(0.05, 0, 0, 155)
testBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
testBtn.Text = "🧪 TEST TP"
testBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
testBtn.TextScaled = true
testBtn.Font = Enum.Font.GothamBold
testBtn.Parent = frame

local testBtnCorner = Instance.new("UICorner")
testBtnCorner.CornerRadius = UDim.new(0, 8)
testBtnCorner.Parent = testBtn

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0, 195)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Prêt"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

frame.Active = true
frame.Draggable = true

-- Fonction TP ULTRA FIABLE
local function vantrixTP()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not savedPos then 
        return false 
    end
    
    local hrp = char.HumanoidRootPart
    
    -- Méthode 1: Anchored + CFrame
    hrp.Anchored = true
    hrp.CFrame = CFrame.new(savedPos)
    wait(0.1)
    hrp.Anchored = false
    
    -- Méthode 2: Position directe
    hrp.Position = savedPos
    wait(0.1)
    
    -- Méthode 3: CFrame avec rotation
    hrp.CFrame = CFrame.new(savedPos, savedPos + Vector3.new(0, 0, 1))
    
    statusLabel.Text = "Status: TP effectué!"
    print("VANTRIX: Ultra-TP vers " .. tostring(savedPos))
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
        
        -- Nouvel objet détecté
        if totalTools > lastToolCount then
            statusLabel.Text = "Status: Objet pris! TP..."
            print("VANTRIX: Objet détecté! Auto-TP...")
            vantrixTP()
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
        statusLabel.Text = "Status: Position sauvée!"
        print("VANTRIX: Position: " .. tostring(savedPos))
        
        spawn(function()
            wait(1.5)
            saveBtn.Text = "💾 SAVE POSITION"
            saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            statusLabel.Text = "Status: Prêt"
        end)
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
        statusLabel.Text = "Status: Auto-TP ON!"
        
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
        
        print("VANTRIX: Auto-TP ON! Tools: " .. lastToolCount)
    else
        autoBtn.Text = "🔴 AUTO TP: OFF"
        autoBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        title.Text = "⚡ VANTRIX HUB ⚡"
        statusLabel.Text = "Status: Auto-TP OFF"
    end
end)

testBtn.MouseButton1Click:Connect(function()
    if savedPos then
        testBtn.Text = "🔄 TESTING..."
        testBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        
        if vantrixTP() then
            testBtn.Text = "✅ WORKS!"
            testBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            testBtn.Text = "❌ FAILED!"
            testBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
        
        spawn(function()
            wait(2)
            testBtn.Text = "🧪 TEST TP"
            testBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
        end)
    else
        testBtn.Text = "⚠️ NO POS!"
        spawn(function()
            wait(1)
            testBtn.Text = "🧪 TEST TP"
        end)
    end
end)

-- Loop de détection
spawn(function()
    while true do
        wait(0.1)
        pcall(checkForNewItem)
    end
end)

print("⚡ VANTRIX HUB ⚡ - Premium Auto-TP System!")
print("🚀 Created by Vantrix Team")
print("💎 1. Save Position 2. Test TP 3. Auto TP ON")
