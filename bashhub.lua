-- evitar duplicado
if getgenv().BashHubLoaded then return end
getgenv().BashHubLoaded = true

-- servicios
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

local isMobile = UIS.TouchEnabled

-- CONFIG
local delay = 0.025
local backTime = 0.045
local guiLocked = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BashHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- UPDATE NOTES
local updateFrame = Instance.new("Frame")
updateFrame.Size = UDim2.new(0,260,0,200)
updateFrame.Position = UDim2.new(0.5,-130,0.5,-100)
updateFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
updateFrame.Parent = gui
Instance.new("UICorner",updateFrame)

local updateTitle = Instance.new("TextLabel")
updateTitle.Size = UDim2.new(1,0,0,30)
updateTitle.Text = "BASH HUB v1.0 FREE"
updateTitle.BackgroundTransparency = 1
updateTitle.TextColor3 = Color3.new(1,1,1)
updateTitle.TextScaled = true
updateTitle.Parent = updateFrame

local updateText = Instance.new("TextLabel")
updateText.Size = UDim2.new(1,-20,0,120)
updateText.Position = UDim2.new(0,10,0,40)
updateText.BackgroundTransparency = 1
updateText.TextColor3 = Color3.new(1,1,1)
updateText.TextWrapped = true
updateText.TextScaled = true
updateText.Text =
"⚠ BETA VERSION\n\n"..
"Novedades v1.0:\n"..
"- GUI movible\n"..
"- Boton LOCK UI\n"..
"- Configuracion delay\n"..
"- Configuracion distancia\n"..
"- Boton movil dash\n\n"..
"Puede haber errores."
updateText.Parent = updateFrame

local closeUpdate = Instance.new("TextButton")
closeUpdate.Size = UDim2.new(0,120,0,30)
closeUpdate.Position = UDim2.new(0.5,-60,1,-40)
closeUpdate.Text = "CERRAR"
closeUpdate.BackgroundColor3 = Color3.fromRGB(60,60,60)
closeUpdate.TextColor3 = Color3.new(1,1,1)
closeUpdate.Parent = updateFrame
Instance.new("UICorner",closeUpdate)

closeUpdate.MouseButton1Click:Connect(function()
updateFrame:Destroy()
end)

-- LOGO
local logo = Instance.new("TextButton")
logo.Size = UDim2.new(0,50,0,50)
logo.Position = UDim2.new(0,20,0.5,0)
logo.Text = "⚡"
logo.TextScaled = true
logo.BackgroundColor3 = Color3.fromRGB(25,25,25)
logo.TextColor3 = Color3.new(1,1,1)
logo.Parent = gui
logo.Active = true
logo.Draggable = true
Instance.new("UICorner",logo)

-- LOCK
local lock = Instance.new("TextButton")
lock.Size = UDim2.new(0,50,0,50)
lock.Position = UDim2.new(0,80,0.5,0)
lock.Text = "🔓"
lock.TextScaled = true
lock.BackgroundColor3 = Color3.fromRGB(25,25,25)
lock.TextColor3 = Color3.new(1,1,1)
lock.Parent = gui
lock.Active = true
lock.Draggable = true
Instance.new("UICorner",lock)

-- FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,240,0,260)
frame.Position = UDim2.new(0.4,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Visible = false
frame.Parent = gui
frame.Active = true
frame.Draggable = true
Instance.new("UICorner",frame)

-- TITULO
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Text = "BASH HUB v1.0 FREE"
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

-- CONFIG BOTON
local config = Instance.new("TextButton")
config.Size = UDim2.new(0,200,0,30)
config.Position = UDim2.new(0,20,0,80)
config.Text = "CONFIG"
config.BackgroundColor3 = Color3.fromRGB(50,50,50)
config.Parent = frame
Instance.new("UICorner",config)

-- CONFIG FRAME
local configFrame = Instance.new("Frame")
configFrame.Size = UDim2.new(0,200,0,120)
configFrame.Position = UDim2.new(0,20,0,120)
configFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
configFrame.Visible = false
configFrame.Parent = frame
Instance.new("UICorner",configFrame)

-- DELAY +
local delayPlus = Instance.new("TextButton")
delayPlus.Size = UDim2.new(0,80,0,30)
delayPlus.Position = UDim2.new(0,10,0,10)
delayPlus.Text = "Delay +"
delayPlus.Parent = configFrame
Instance.new("UICorner",delayPlus)

-- DELAY -
local delayMinus = Instance.new("TextButton")
delayMinus.Size = UDim2.new(0,80,0,30)
delayMinus.Position = UDim2.new(0,110,0,10)
delayMinus.Text = "Delay -"
delayMinus.Parent = configFrame
Instance.new("UICorner",delayMinus)

-- DIST +
local distPlus = Instance.new("TextButton")
distPlus.Size = UDim2.new(0,80,0,30)
distPlus.Position = UDim2.new(0,10,0,60)
distPlus.Text = "Back +"
distPlus.Parent = configFrame
Instance.new("UICorner",distPlus)

-- DIST -
local distMinus = Instance.new("TextButton")
distMinus.Size = UDim2.new(0,80,0,30)
distMinus.Position = UDim2.new(0,110,0,60)
distMinus.Text = "Back -"
distMinus.Parent = configFrame
Instance.new("UICorner",distMinus)

-- BOTON MOVIL
local punch = Instance.new("TextButton")
punch.Size = UDim2.new(0,70,0,70)
punch.Position = UDim2.new(1,-100,1,-120)
punch.Text = "👊"
punch.TextScaled = true
punch.BackgroundColor3 = Color3.fromRGB(40,40,40)
punch.Visible = false
punch.Parent = gui
punch.Active = true
punch.Draggable = true
Instance.new("UICorner",punch)

-- VARIABLES
local enabled = false
local selectedSkill = Enum.KeyCode.One

-- abrir ui
logo.MouseButton1Click:Connect(function()
frame.Visible = not frame.Visible
end)

-- LOCK
lock.MouseButton1Click:Connect(function()

guiLocked = not guiLocked

if guiLocked then
lock.Text = "🔒"
frame.Draggable = false
logo.Draggable = false
punch.Draggable = false
else
lock.Text = "🔓"
frame.Draggable = true
logo.Draggable = true
punch.Draggable = true
end

end)

-- CONFIG abrir
config.MouseButton1Click:Connect(function()
configFrame.Visible = not configFrame.Visible
end)

-- DELAY
delayPlus.MouseButton1Click:Connect(function()
delay = delay + 0.005
end)

delayMinus.MouseButton1Click:Connect(function()
delay = math.max(0.01,delay - 0.005)
end)

-- DISTANCIA
distPlus.MouseButton1Click:Connect(function()
backTime = backTime + 0.01
end)

distMinus.MouseButton1Click:Connect(function()
backTime = math.max(0.02,backTime - 0.01)
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

-- DASH CANCEL
local function DashCancel()

task.wait(delay)

VIM:SendKeyEvent(true,selectedSkill,false,game)
VIM:SendKeyEvent(false,selectedSkill,false,game)

VIM:SendKeyEvent(true,Enum.KeyCode.S,false,game)

task.wait(0.03)

VIM:SendKeyEvent(true,Enum.KeyCode.Q,false,game)
task.wait(0.02)
VIM:SendKeyEvent(false,Enum.KeyCode.Q,false,game)

task.wait(backTime)

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
