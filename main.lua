-- ==========================================
-- STEP HUB — ULTIMATE EDITION (MM2)
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local Language = "RU"
local Themes = {
    ["Neon Blue"] = Color3.fromRGB(0, 170, 255),
    ["Cyberpunk"] = Color3.fromRGB(180, 0, 255),
    ["Crimson"]   = Color3.fromRGB(255, 40, 40)
}
local CurrentThemeColor = Themes["Neon Blue"]

local function getRole(player)
    if not player or not player.Character then return "Innocent" end
    local backpack = player:FindFirstChild("Backpack")
    local char = player.Character
    if (backpack and backpack:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife")) then return "Murderer"
    elseif (backpack and backpack:FindFirstChild("Gun")) or (char and char:FindFirstChild("Gun")) then return "Sheriff" end
    return "Innocent"
end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 220, 0, 200)
Main.Position = UDim2.new(0.5, -110, 0.4, -100)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "⚡ StepHub MM2"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local function addButton(name, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, #Main:GetChildren() * 35 - 30)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(callback)
end

addButton("Fullbright (Яркость)", function()
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.Brightness = 2
end)

addButton("Noclip (Сквозь стены)", function()
    RunService.Stepped:Connect(function()
        if LocalPlayer.Character then
            for _, p in pairs(LocalPlayer.Character:GetChildren()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end)
end)

addButton("Speed (Скорость)", function()
    LocalPlayer.Character.Humanoid.WalkSpeed = 30
end)

addButton("Удалить меню", function()
    ScreenGui:Destroy()
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "StepHub",
    Text = "Полный скрипт загружен!",
    Duration = 3
})
