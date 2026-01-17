-- ⚡ NEXUS HUB ⚡ - Auto TP quand tu prends un objet
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Variables
local savedPos = nil
local autoTpEnabled = false

-- Supprime l'ancien GUI
if player.PlayerGui:FindFirstChild("NexusHub") then
    player.PlayerGui.NexusHub:Destroy()
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NexusHub"
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
title.Text = "⚡ NEXUS HUB ⚡"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
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
subtitle.Text = "🚀 Auto-Teleport System 🚀"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 255)
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

-- Fonction TP Anti-Detection
local function autoTeleport()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
    
    local hrp = char.HumanoidRootPart
    
    -- TP par petits bonds (anti-detection)
    local startPos = hrp.Position
    local distance = (savedPos - startPos).Magnitude
    
    if distance < 5 then return true end -- Déjà proche
    
    local steps = math.ceil(distance / 20) -- 20 studs par step
    
    for i = 1, steps do
        if not autoTpEnabled then break end
        local alpha = i / steps
        local newPos = startPos:Lerp(savedPos, alpha)
        hrp.CFrame = CFrame.new(newPos)
        wait(0.05)
    end
    
    statusLabel.Text = "Status: TP effectué!"
    print("NEXUS: Auto-TP vers la base!")
    return true
end

-- Détection quand tu prends un objet
local lastToolCount = 0
local function checkForNewItem()
    if not autoTpEnabled or not savedPos then return end
    
    local char = player.Character
    local backpack = player:FindFirstChild("Backpack")
    
    if char and backpack then
        local totalTools = 0
        
        -- Compte les tools dans le backpack
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                totalTools = totalTools + 1
            end
        end
        
        -- Compte les tools équipés
        for _, item in pairs(char:GetChildren()) do
            if item:IsA("Tool") then
                totalTools = totalTools + 1
            end
        end
        
        -- Si on a plus d'objets qu'avant = objet pris
        if totalTools > lastToolCount then
            statusLabel.Text = "Status: Objet détecté! TP..."
            print("NEXUS: Nouvel objet détecté! Auto-TP...")
            autoTeleport()
        end
        
        lastToolCount = totalTools
    end
end

-- Events
saveBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char.HumanoidRootPart then
        savedPos = char.HumanoidRootPart.Position
        saveBtn.Text = "✅ POSITION SAVED!"
        saveBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        statusLabel.Text = "Status: Position sauvée!"
        print("NEXUS: Position saved at " .. tostring(savedPos))
        
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
        autoBtn.Text = "⚠️ SAVE POSITION FIRST!"
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
        title.Text = "⚡ NEXUS HUB ✅"
        statusLabel.Text = "Status: Auto-TP activé!"
        
        -- Reset compteur
        local char = player.Character
        local backpack = player:FindFirstChild("Backpack")
        lastToolCount = 0
        
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
        
        print("NEXUS: Auto-TP activé! Objets actuels: " .. lastToolCount)
    else
        autoBtn.Text = "🔴 AUTO TP: OFF"
        autoBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        title.Text = "⚡ NEXUS HUB ⚡"
        statusLabel.Text = "Status: Auto-TP désactivé"
        print("NEXUS: Auto-TP désactivé!")
    end
end)

testBtn.MouseButton1Click:Connect(function()
    if savedPos then
        testBtn.Text = "🔄 TESTING..."
        testBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        statusLabel.Text = "Status: Test en cours..."
        
        spawn(function()
            if autoTeleport() then
                testBtn.Text = "✅ TEST OK!"
                testBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            else
                testBtn.Text = "❌ TEST FAILED!"
                testBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            end
            
            wait(2)
            testBtn.Text = "🧪 TEST TP"
            testBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
            statusLabel.Text = "Status: Prêt"
        end)
    else
        testBtn.Text = "⚠️ NO POSITION!"
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

print("⚡ NEXUS HUB ⚡ - Auto-TP System Loaded!")
print("🚀 Dès que tu prends un objet = TP automatique!")
print("💎 1. Save Position 2. Auto TP: ON 3. Prends des objets!")
