-- ==================================================
-- STEP HUB — ULTIMATE MM2 EDITION (ADVANCED)
-- ==================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Config = {ESP = false, Noclip = false, AutoShoot = false}

-- [HELPERS]
local function getRole(p)
    if not p.Character then return "Innocent" end
    if p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife") then return "Murderer" end
    if p.Character:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Gun") then return "Sheriff" end
    return "Innocent"
end

local function getMurderer()
    for _, p in pairs(Players:GetPlayers()) do if getRole(p) == "Murderer" then return p end end
    return nil
end

-- [UI BUILDER]
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", ScreenGui); Main.Size = UDim2.new(0, 320, 0, 480); Main.Position = UDim2.new(0.5, -160, 0.5, -240); Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25); Main.Draggable = true; Main.Active = true

local Tab = Instance.new("ScrollingFrame", Main); Tab.Size = UDim2.new(1, -10, 1, -50); Tab.Position = UDim2.new(0, 5, 0, 45); Tab.CanvasSize = UDim2.new(0, 0, 3, 0)

-- [BUTTONS]
local function createBtn(text, callback)
    local btn = Instance.new("TextButton", Tab); btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Text = text; btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); btn.TextColor3 = Color3.new(1,1,1)
    btn.Position = UDim2.new(0.05, 0, 0, #Tab:GetChildren() * 40 - 40); btn.MouseButton1Click:Connect(callback)
end

createBtn("ESP (Игроки)", function() Config.ESP = not Config.ESP end)
createBtn("Noclip (Сквозь стены)", function() Config.Noclip = not Config.Noclip end)
createBtn("TRIGGER BOT (Авто-выстрел)", function() Config.AutoShoot = not Config.AutoShoot end)

-- [DYNAMIC ACTION BUTTON]
local ActionBtn = Instance.new("TextButton", ScreenGui); ActionBtn.Size = UDim2.new(0, 70, 0, 70); ActionBtn.Position = UDim2.new(0.8, 0, 0.4, 0); ActionBtn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ActionBtn.MouseButton1Click:Connect(function()
    local role = getRole(LocalPlayer)
    if role == "Sheriff" then -- Стрельба в Мардера
        local m = getMurderer()
        if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") then
            local gun = LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
            if gun then gun:Activate() end
        end
    elseif role == "Murderer" then -- Метание ножа
        local knife = LocalPlayer.Character:FindFirstChild("Knife")
        if knife then knife:Activate() end
    end
end)

-- [LOGIC LOOP]
RunService.RenderStepped:Connect(function()
    -- Noclip
    if Config.Noclip and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetChildren()) do if p:IsA("BasePart") then p.CanCollide = false end end
    end
    
    -- Trigger Bot
    if Config.AutoShoot and getRole(LocalPlayer) == "Sheriff" then
        local target = Mouse.Target
        if target and target.Parent:FindFirstChild("Humanoid") then
            local player = Players:GetPlayerFromCharacter(target.Parent)
            if player and getRole(player) == "Murderer" then
                local gun = LocalPlayer.Character:FindFirstChild("Gun")
                if gun then gun:Activate() end
            end
        end
    end
    
    -- ESP
    if Config.ESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("EspBox") then
                local hl = Instance.new("Highlight", p.Character); hl.Name = "EspBox"; hl.FillColor = Color3.new(1, 0, 0)
            end
        end
    end
end)

-- [CLOSE]
local Close = Instance.new("TextButton", Main); Close.Size = UDim2.new(0, 30, 0, 30); Close.Text = "X"; Close.Position = UDim2.new(1, -35, 0, 5)
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
