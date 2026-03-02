-- evitar duplicado
if getgenv().BashHubLoaded then return end
getgenv().BashHubLoaded = true

-- BLOQUEAR EXECUTORS
pcall(function()
    if identifyexecutor then
        local exe = string.lower(identifyexecutor())

        if string.find(exe,"fluxus") or string.find(exe,"hydrogen") then
            warn("Executor no soportado")
            return
        end
    end
end)

-- servicios
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local VIM
pcall(function()
    VIM = game:GetService("VirtualInputManager")
end)

if not VIM then
    warn("Executor no soporta VirtualInputManager")
    return
end

local isMobile = UIS.TouchEnabled

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BashHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- LOGO
local logo = Instance.new("TextButton")
logo.Size = UDim2.new(0,50,0,50)
logo.Position = UDim2.new(0,20,0.5,0)
logo.Text = "⚡"
logo.TextScaled = true
logo.BackgroundColor3 = Color3.fromRGB(25,25,25)
logo.TextColor3 = Color3.new(1,1,1)
logo.Parent = gui

Instance.new("UICorner",logo)

-- FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,240,0,240)
frame.Position = UDim2.new(0.4,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Visible = false
frame.Parent = gui

Instance.new("UICorner",frame)

-- TITULO
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Text = "BASH HUB"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Parent = frame

-- TOGGLE
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,200,0,35)
toggle.Position = UDim2.new(0,20,0,40)
toggle.Text = "OFF"
toggle.BackgroundColor3 = Color3.fromRGB(255,60,60)
toggle.Parent = frame
Instance.new("UICorner",toggle)

-- SKILLS
local skill1 = Instance.new("TextButton")
skill1.Size = UDim2.new(0,90,0,35)
skill1.Position = UDim2.new(0,20,0,90)
skill1.Text = "Skill 1"
skill1.BackgroundColor3 = Color3.fromRGB(50,50,50)
skill1.Parent = frame
Instance.new("UICorner",skill1)

local skill2 = skill1:Clone()
skill2.Position = UDim2.new(0,130,0,90)
skill2.Text = "Skill 2"
skill2.Parent = frame

local skill3 = skill1:Clone()
skill3.Position = UDim2.new(0,20,0,140)
skill3.Text = "Skill 3"
skill3.Parent = frame

local skill4 = skill1:Clone()
skill4.Position = UDim2.new(0,130,0,140)
skill4.Text = "Skill 4"
skill4.Parent = frame

-- BOTON KILL
local kill = Instance.new("TextButton")
kill.Size = UDim2.new(0,200,0,30)
kill.Position = UDim2.new(0,20,0,190)
kill.Text = "KILL SCRIPT"
kill.BackgroundColor3 = Color3.fromRGB(120,0,0)
kill.TextColor3 = Color3.new(1,1,1)
kill.Parent = frame
Instance.new("UICorner",kill)

-- BOTON MOVIL
local punch = Instance.new("TextButton")
punch.Size = UDim2.new(0,70,0,70)
punch.Position = UDim2.new(1,-100,1,-120)
punch.Text = "👊"
punch.TextScaled = true
punch.BackgroundColor3 = Color3.fromRGB(40,40,40)
punch.Visible = false
punch.Parent = gui
Instance.new("UICorner",punch)

-- VARIABLES
local enabled = false
local selectedSkill = Enum.KeyCode.One

-- ABRIR UI
logo.MouseButton1Click:Connect(function()
frame.Visible = not frame.Visible
end)

-- TOGGLE
toggle.MouseButton1Click:Connect(function()

enabled = not enabled

if enabled then
toggle.Text = "ON"
toggle.BackgroundColor3 = Color3.fromRGB(60,255,60)

if isMobile then
punch.Visible = true
end

else
toggle.Text = "OFF"
toggle.BackgroundColor3 = Color3.fromRGB(255,60,60)
punch.Visible = false

end

end)

-- SELECCION SKILL
local function selectSkill(button,key)

selectedSkill = key

skill1.BackgroundColor3 = Color3.fromRGB(50,50,50)
skill2.BackgroundColor3 = Color3.fromRGB(50,50,50)
skill3.BackgroundColor3 = Color3.fromRGB(50,50,50)
skill4.BackgroundColor3 = Color3.fromRGB(50,50,50)

button.BackgroundColor3 = Color3.fromRGB(60,255,60)

end

skill1.MouseButton1Click:Connect(function()
selectSkill(skill1,Enum.KeyCode.One)
end)

skill2.MouseButton1Click:Connect(function()
selectSkill(skill2,Enum.KeyCode.Two)
end)

skill3.MouseButton1Click:Connect(function()
selectSkill(skill3,Enum.KeyCode.Three)
end)

skill4.MouseButton1Click:Connect(function()
selectSkill(skill4,Enum.KeyCode.Four)
end)

-- DASH CANCEL
local function DashCancel()

task.wait(0.025)

VIM:SendKeyEvent(true,selectedSkill,false,game)
VIM:SendKeyEvent(false,selectedSkill,false,game)

VIM:SendKeyEvent(true,Enum.KeyCode.S,false,game)

task.wait(0.03)

VIM:SendKeyEvent(true,Enum.KeyCode.Q,false,game)
task.wait(0.02)
VIM:SendKeyEvent(false,Enum.KeyCode.Q,false,game)

task.wait(0.045)

VIM:SendKeyEvent(false,Enum.KeyCode.S,false,game)

end

-- PC
UIS.InputBegan:Connect(function(input,gp)

if gp then return end
if not enabled then return end

if input.KeyCode == Enum.KeyCode.H then
DashCancel()
end

end)

-- MOVIL
punch.MouseButton1Click:Connect(function()

if enabled then
DashCancel()
end

end)

-- KILL SCRIPT
kill.MouseButton1Click:Connect(function()

getgenv().BashHubLoaded = false
gui:Destroy()

end)
