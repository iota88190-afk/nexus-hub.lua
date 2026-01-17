local Players = game:GetService("Players")
local player = Players.LocalPlayer
local basePosition = Vector3.new(0, 10, 0)

if player.PlayerGui:FindFirstChild("BrainrotTP") then
    player.PlayerGui.BrainrotTP:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotTP"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 120, 0, 40)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 15)
title.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
title.Text = "🧠 BRAINROT TP"
title.TextColor3 = Color3.white
title.TextSize = 10
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.5, 0, 0, 12)
saveBtn.Position = UDim2.new(0, 2, 0, 17)
saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
saveBtn.Text = "💾 SAVE"
saveBtn.TextColor3 = Color3.white
saveBtn.TextSize = 8
saveBtn.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(0.45, 0, 0, 12)
status.Position = UDim2.new(0.52, 0, 0, 17)
status.BackgroundTransparency = 1
status.Text = "⚡ READY"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.TextSize = 7
status.Parent = frame

local function instantTP()
    local char = player.Character
    if char and char.HumanoidRootPart then
        char.HumanoidRootPart.CFrame = CFrame.new(basePosition)
        status.Text = "🧠 TP!"
        status.TextColor3 = Color3.fromRGB(255, 0, 255)
        spawn(function()
            wait(1)
            status.Text = "⚡ READY"
            status.TextColor3 = Color3.fromRGB(0, 255, 0)
        end)
    end
end

saveBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character.HumanoidRootPart then
        basePosition = player.Character.HumanoidRootPart.Position
        saveBtn.Text = "✅ OK"
        spawn(function()
            wait(1)
            saveBtn.Text = "💾 SAVE"
        end)
    end
end)

player.Backpack.ChildAdded:Connect(function(child)
    if child:IsA("Tool") then
        instantTP()
    end
end)

if player.Character then
    player.Character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            instantTP()
        end
    end)
end

player.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            instantTP()
        end
    end)
end)

print("🧠 BRAINROT TP LOADED FOR DELTA!")

