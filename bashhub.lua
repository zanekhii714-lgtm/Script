-- ANTI DUPLICADO
if getgenv().BashHubLoaded then return end
getgenv().BashHubLoaded = true

-- BLOQUEAR EXECUTORS
pcall(function()
if identifyexecutor then
local exe = string.lower(identifyexecutor())

if exe:find("fluxus") or exe:find("hydrogen") then
warn("Executor no soportado")
return
end
end
end)

-- SERVICIOS
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")

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
frame.Size = UDim2.new(0,240,0,260)
frame.Position = UDim2.new(0.4,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Visible = false
frame.Parent = gui
Instance.new("UICorner",frame)

-- TITULO
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Text = "BASH HUB V2"
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

-- BOTON SETTINGS
local settings = Instance.new("TextButton")
settings.Size = UDim2.new(0,200,0,25)
settings.Position = UDim2.new(0,20,0,185)
settings.Text = "SETTINGS"
settings.BackgroundColor3 = Color3.fromRGB(60,60,60)
settings.TextColor3 = Color3.new(1,1,1)
settings.Parent = frame
Instance.new("UICorner",settings)

-- BOTON KILL
local kill = Instance.new("TextButton")
kill.Size = UDim2.new(0,200,0,25)
kill.Position = UDim2.new(0,20,0,215)
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

-- FRAME SETTINGS
local configFrame = Instance.new("Frame")
configFrame.Size = UDim2.new(0,220,0,170)
configFrame.Position = UDim2.new(0.5,-110,0.5,-85)
configFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
configFrame.Visible = false
configFrame.Parent = gui
Instance.new("UICorner",configFrame)

local configTitle = Instance.new("TextLabel")
configTitle.Size = UDim2.new(1,0,0,30)
configTitle.Text = "CONFIG"
configTitle.BackgroundTransparency = 1
configTitle.TextColor3 = Color3.new(1,1,1)
configTitle.TextScaled = true
configTitle.Parent = configFrame

-- VARIABLES
local enabled = false
local selectedSkill = Enum.KeyCode.One
local dashKey = Enum.KeyCode.H

local dashDelay = 0.02
local backTime = 0.035

-- DRAG SYSTEM
local function dragify(obj)

local drag=false
local start
local startPos

obj.InputBegan:Connect(function(input)

if input.UserInputType==Enum.UserInputType.MouseButton1
or input.UserInputType==Enum.UserInputType.Touch then

drag=true
start=input.Position
startPos=obj.Position

end

end)

obj.InputEnded:Connect(function(input)

if input.UserInputType==Enum.UserInputType.MouseButton1
or input.UserInputType==Enum.UserInputType.Touch then
drag=false
end

end)

UIS.InputChanged:Connect(function(input)

if drag then

local delta=input.Position-start

obj.Position=UDim2.new(
startPos.X.Scale,
startPos.X.Offset+delta.X,
startPos.Y.Scale,
startPos.Y.Offset+delta.Y
)

end

end)

end

dragify(frame)
dragify(logo)
dragify(punch)

-- ANIMACION GUI
local function animateOpen()

frame.Size = UDim2.new(0,0,0,0)

TweenService:Create(
frame,
TweenInfo.new(0.25),
{Size = UDim2.new(0,240,0,260)}
):Play()

end

-- ABRIR GUI
logo.MouseButton1Click:Connect(function()

frame.Visible = not frame.Visible

if frame.Visible then
animateOpen()
end

end)

-- SETTINGS
settings.MouseButton1Click:Connect(function()
configFrame.Visible = not configFrame.Visible
end)

-- BOTONES CONFIG
local delayMinus = Instance.new("TextButton")
delayMinus.Size = UDim2.new(0,90,0,30)
delayMinus.Position = UDim2.new(0,10,0,50)
delayMinus.Text = "Delay -"
delayMinus.Parent = configFrame

delayMinus.MouseButton1Click:Connect(function()
dashDelay = math.max(0.01,dashDelay - 0.005)
end)

local delayPlus = Instance.new("TextButton")
delayPlus.Size = UDim2.new(0,90,0,30)
delayPlus.Position = UDim2.new(0,120,0,50)
delayPlus.Text = "Delay +"
delayPlus.Parent = configFrame

delayPlus.MouseButton1Click:Connect(function()
dashDelay = dashDelay + 0.005
end)

local distMinus = Instance.new("TextButton")
distMinus.Size = UDim2.new(0,90,0,30)
distMinus.Position = UDim2.new(0,10,0,100)
distMinus.Text = "Distance -"
distMinus.Parent = configFrame

distMinus.MouseButton1Click:Connect(function()
backTime = math.max(0.02,backTime - 0.01)
end)

local distPlus = Instance.new("TextButton")
distPlus.Size = UDim2.new(0,90,0,30)
distPlus.Position = UDim2.new(0,120,0,100)
distPlus.Text = "Distance +"
distPlus.Parent = configFrame

distPlus.MouseButton1Click:Connect(function()
backTime = backTime + 0.01
end)

-- TOGGLE
toggle.MouseButton1Click:Connect(function()

enabled = not enabled

if enabled then
toggle.Text="ON"
toggle.BackgroundColor3=Color3.fromRGB(60,255,60)

if isMobile then
punch.Visible=true
end

else
toggle.Text="OFF"
toggle.BackgroundColor3=Color3.fromRGB(255,60,60)
punch.Visible=false
end

end)

-- SKILL SELECT
local function selectSkill(button,key)

selectedSkill=key

skill1.BackgroundColor3=Color3.fromRGB(50,50,50)
skill2.BackgroundColor3=Color3.fromRGB(50,50,50)
skill3.BackgroundColor3=Color3.fromRGB(50,50,50)
skill4.BackgroundColor3=Color3.fromRGB(50,50,50)

button.BackgroundColor3=Color3.fromRGB(60,255,60)

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

task.wait(dashDelay)

VIM:SendKeyEvent(true,selectedSkill,false,game)
VIM:SendKeyEvent(false,selectedSkill,false,game)

VIM:SendKeyEvent(true,Enum.KeyCode.S,false,game)

task.wait(0.02)

VIM:SendKeyEvent(true,Enum.KeyCode.Q,false,game)
task.wait(0.015)
VIM:SendKeyEvent(false,Enum.KeyCode.Q,false,game)

task.wait(backTime)

VIM:SendKeyEvent(false,Enum.KeyCode.S,false,game)

end

-- PC
UIS.InputBegan:Connect(function(input,gp)

if gp then return end
if not enabled then return end

if input.KeyCode==dashKey then
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

getgenv().BashHubLoaded=false
gui:Destroy()

end)
