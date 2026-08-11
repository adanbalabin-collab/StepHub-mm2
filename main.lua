-- Minimal StepHub Setup
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 200, 0, 50)
Main.Position = UDim2.new(0.5, -100, 0.1, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.Active = true
Main.Draggable = true

local Label = Instance.new("TextLabel", Main)
Label.Size = UDim2.new(1, 0, 1, 0)
Label.Text = "StepHub Активирован!"
Label.TextColor3 = Color3.new(1, 1, 1)
Label.BackgroundTransparency = 1

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "StepHub",
    Text = "Успешная загрузка!",
    Duration = 5
})
