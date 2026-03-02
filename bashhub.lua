-- SERVICIOS
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

-- PLAYER SEGURO
local player = Players.LocalPlayer
if not player then return end

local PlayerGui = player:WaitForChild("PlayerGui",10)
if not PlayerGui then
warn("PlayerGui no cargó")
return
end

-- detectar móvil mejor
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

-- ANTI DUPLICADO
if PlayerGui:FindFirstChild("DashCancelUI") then
PlayerGui:FindFirstChild("DashCancelUI"):Destroy()
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "DashCancelUI"
gui.Parent = PlayerGui
gui.ResetOnSpawn = false

-- logo
local logo = Instance.new("TextButton")
logo.Size = UDim2.new(0,50,0,50)
logo.Position = UDim2.new(0,20,0.5,0)
logo.Text = "⚡"
logo.BackgroundColor3 = Color3.fromRGB(20,20,20)
logo.TextColor3 = Color3.new(1,1,1)
logo.Parent = gui

-- frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,220,0,200)
frame.Position = UDim2.new(0.4,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Visible = false
frame.Parent = gui

-- toggle
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,180,0,35)
toggle.Position = UDim2.new(0,20,0,10)
toggle.Text = "OFF"
toggle.BackgroundColor3 = Color3.fromRGB(255,60,60)
toggle.Parent = frame

-- botones skill
local skill1 = Instance.new("TextButton")
skill1.Size = UDim2.new(0,80,0,35)
skill1.Position = UDim2.new(0,20,0,60)
skill1.Text = "Skill 1"
skill1.Parent = frame

local skill2 = Instance.new("TextButton")
skill2.Size = UDim2.new(0,80,0,35)
skill2.Position = UDim2.new(0,120,0,60)
skill2.Text = "Skill 2"
skill2.Parent = frame

local skill3 = Instance.new("TextButton")
skill3.Size = UDim2.new(0,80,0,35)
skill3.Position = UDim2.new(0,20,0,110)
skill3.Text = "Skill 3"
skill3.Parent = frame

local skill4 = Instance.new("TextButton")
skill4.Size = UDim2.new(0,80,0,35)
skill4.Position = UDim2.new(0,120,0,110)
skill4.Text = "Skill 4"
skill4.Parent = frame

-- botón móvil
local punch = Instance.new("TextButton")
punch.Size = UDim2.new(0,70,0,70)
punch.Position = UDim2.new(1,-90,1,-120)
punch.Text = "👊"
punch.TextScaled = true
punch.BackgroundColor3 = Color3.fromRGB(40,40,40)
punch.Visible = false
punch.Parent = gui

local enabled = false
local selectedSkill = Enum.KeyCode.One
local debounce = false

-- abrir interfaz
logo.MouseButton1Click:Connect(function()
frame.Visible = not frame.Visible
end)

-- toggle
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

-- DASH CANCEL MEJORADO
local function DashCancel()

if debounce then return end
debounce = true

task.spawn(function()

task.wait(0.03)

-- presiona skill seleccionada
VIM:SendKeyEvent(true,selectedSkill,false,game)
VIM:SendKeyEvent(false,selectedSkill,false,game)

-- dash atrás más largo
VIM:SendKeyEvent(true,Enum.KeyCode.S,false,game)

task.wait(0.025)

-- dash
VIM:SendKeyEvent(true,Enum.KeyCode.Q,false,game)
task.wait(0.02)
VIM:SendKeyEvent(false,Enum.KeyCode.Q,false,game)

-- mantener S un poco más para más distancia
task.wait(0.03)

VIM:SendKeyEvent(false,Enum.KeyCode.S,false,game)

task.wait(0.1)
debounce = false

end)

end

-- seleccionar habilidad
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

-- tecla PC
UIS.InputBegan:Connect(function(input,gp)

if gp then return end
if not enabled then return end

if input.KeyCode == Enum.KeyCode.H then
DashCancel()
end

end)

-- móvil
punch.MouseButton1Click:Connect(function()

if enabled then
DashCancel()
end

end)

-- DRAG GUI
local dragging
local dragStart
local startPos

frame.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then

dragging = true
dragStart = input.Position
startPos = frame.Position

end

end)

UIS.InputChanged:Connect(function(input)

if dragging then

local delta = input.Position - dragStart

frame.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)

end

end)

UIS.InputEnded:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then
dragging = false
end

end)
