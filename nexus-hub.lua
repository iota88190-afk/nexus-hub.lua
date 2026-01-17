-- 🧠 BRAINROT INSTA TP SCRIPT 🧠
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Position de ta base (CHANGE CES COORDONNÉES)
local basePosition = Vector3.new(0, 10, 0)

-- Fonction TP instantané
local function instantTP()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(basePosition)
        print("🧠 INSTA TP vers la base!")
    end
end

-- Détection directe quand tu ramasses
local function onChildAdded(child)
    -- Dès qu'un objet arrive dans ton backpack = TP direct
    if child:IsA("Tool") or child:IsA("LocalScript") then
        instantTP()
    end
end

-- Détection sur le backpack
player.Backpack.ChildAdded:Connect(onChildAdded)

-- Détection alternative sur le character (au cas où)
player.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            instantTP()
        end
    end)
end)

-- Si le character existe déjà
if player.Character then
    player.Character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            instantTP()
        end
    end)
end

print("🧠 BRAINROT INSTA TP activé!")
print("⚡ Téléportation instantanée dès que tu ramasses!")
print("📍 Base: " .. tostring(basePosition))
