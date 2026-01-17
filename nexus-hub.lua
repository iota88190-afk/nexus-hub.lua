-- ⚡ NEXUS HUB ⚡ - Anti-Detection TP
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Variables
local savedPos = nil

-- Supprime l'ancien GUI
if player.PlayerGui:FindFirstChild("NexusHub") then
    player.PlayerGui.NexusHub:Destroy()
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NexusHub"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 200)
frame.Position = UDim2.new(0.5, -140, 0.5, -100)
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
subtitle.Text = "🚀 Anti-Detection System 🚀"
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

local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.9, 0, 0, 30)
tpBtn.Position = UDim2.new(0.05, 0, 0, 115)
tpBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
tpBtn.Text = "⚡ BYPASS TP"
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.TextScaled = true
tpBtn.Font = Enum.Font.GothamBold
tpBtn.Parent = frame

local tpBtnCorner = Instance.new("UICorner")
tpBtnCorner.CornerRadius = UDim.new(0, 8)
tpBtnCorner.Parent = tpBtn

local slowTpBtn = Instance.new("TextButton")
slowTpBtn.Size = UDim2.new(0.9, 0, 0, 30)
slowTpBtn.Position = UDim2.new(0.05, 0, 0, 155)
slowTpBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
slowTpBtn.Text = "🐌 SLOW TP (Safe)"
slowTpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
slowTpBtn.TextScaled = true
slowTpBtn.Font = Enum.Font.GothamBold
slowTpBtn.Parent = frame

local slowTpBtnCorner = Instance.new("UICorner")
slowTpBtnCorner.CornerRadius = UDim.new(0, 8)
slowTpBtnCorner.Parent = slowTpBtn

frame.Active = true
frame.Draggable = true

-- Fonction TP Bypass
local function bypassTP(position)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
    
    local hrp = char.HumanoidRootPart
    local humanoid = char:FindFirstChild("Humanoid")
    
    -- Méthode 1: Network Owner
    hrp:SetNetworkOwner(nil)
    wait(0.1)
    hrp.CFrame = CFrame.new(position)
    wait(0.1)
    hrp:SetNetworkOwner(player)
    
    print("NEXUS: Bypass TP effectué!")
    return true
end

-- Fonction TP Lent (très sûr)
local function slowTP(targetPos)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
    
    local hrp = char.HumanoidRootPart
    local startPos = hrp.Position
    local distance = (targetPos - startPos).Magnitude
    local steps = math.ceil(distance / 15) -- 15 studs par step
    
    for i = 1, steps do
        local alpha = i / steps
        local newPos = startPos:Lerp(targetPos, alpha)
        hrp.CFrame = CFrame.new(newPos)
        wait(0.1)
    end
    
    print("NEXUS: Slow TP effectué!")
    return true
end

-- Events
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
    end
end)

tpBtn.MouseButton1Click:Connect(function()
    if savedPos then
        tpBtn.Text = "🔄 BYPASSING..."
        tpBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        
        if bypassTP(savedPos) then
            tpBtn.Text = "🚀 BYPASSED!"
            tpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            tpBtn.Text = "❌ FAILED!"
            tpBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
        
        spawn(function()
            wait(2)
            tpBtn.Text = "⚡ BYPASS TP"
            tpBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        end)
    else
        tpBtn.Text = "⚠️ NO POSITION!"
        spawn(function()
            wait(1)
            tpBtn.Text = "⚡ BYPASS TP"
        end)
    end
end)

slowTpBtn.MouseButton1Click:Connect(function()
    if savedPos then
        slowTpBtn.Text = "🐌 TELEPORTING..."
        slowTpBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        
        spawn(function()
            if slowTP(savedPos) then
                slowTpBtn.Text = "✅ SAFE TP DONE!"
                slowTpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            else
                slowTpBtn.Text = "❌ FAILED!"
                slowTpBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            end
            
            wait(2)
            slowTpBtn.Text = "🐌 SLOW TP (Safe)"
            slowTpBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
        end)
    else
        slowTpBtn.Text = "⚠️ NO POSITION!"
        spawn(function()
            wait(1)
            slowTpBtn.Text = "🐌 SLOW TP (Safe)"
        end)
    end
end)

print("⚡ NEXUS HUB ⚡ - Anti-Detection Loaded!")
print("🚀 Use SLOW TP if BYPASS TP gets detected!")
