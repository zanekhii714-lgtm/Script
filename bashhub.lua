-- servicios
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

-- detectar móvil
local isMobile = UIS.TouchEnabled

-- random timing
math.randomseed(tick())
local function rand(a,b)
    return a + math.random()*(b-a)
end

-- anti spam
local lastDash = 0
local dashCooldown = 0.12

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- LOGO
local logo = Instance.new("TextButton")
logo.Size = UDim2.new(0,50,0,50)
logo.Position = UDim2.new(0,20,0.5,0)
logo.Text = "⚡"
logo.BackgroundColor3 = Color3.fromRGB(20,20,20)
logo.TextColor3 = Color3.new(1,1,1)
logo.Parent = gui

-- FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,220,0,200)
frame.Position = UDim2.new(0.4,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Visible = false
frame.Parent = gui

-- TOGGLE
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,180,0,35)
toggle.Position = UDim2.new(0,20,0,10)
toggle.Text = "OFF"
toggle.BackgroundColor3 = Color3.fromRGB(255,60,60)
toggle.Parent = frame

-- SKILLS
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

-- PUÑO MOVIL
local punch = Instance.new("TextButton")
punch.Size = UDim2.new(0,70,0,70)
punch.Position = UDim2.new(1,-90,1,-120)
punch.Text = "👊"
punch.TextScaled = true
punch.BackgroundColor3 = Color3.fromRGB(40,40,40)
punch.Visible = false
punch.Parent = gui

local enabled = false

-- abrir UI
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

if tick() - lastDash < dashCooldown then return end
lastDash = tick()

task.wait(rand(0.035,0.05))

VIM:SendKeyEvent(true,Enum.KeyCode.S,false,game)
task.wait(rand(0.015,0.025))

VIM:SendKeyEvent(true,Enum.KeyCode.Q,false,game)
task.wait(rand(0.015,0.025))
VIM:SendKeyEvent(false,Enum.KeyCode.Q,false,game)

task.wait(rand(0.015,0.025))

VIM:SendKeyEvent(false,Enum.KeyCode.S,false,game)

end

-- detectar skills pc
UIS.InputBegan:Connect(function(input,gp)

if gp then return end
if not enabled then return end

if input.KeyCode == Enum.KeyCode.One
or input.KeyCode == Enum.KeyCode.Two
or input.KeyCode == Enum.KeyCode.Three
or input.KeyCode == Enum.KeyCode.Four then

DashCancel()

end

end)

-- usar skill
local function UseSkill(key)

VIM:SendKeyEvent(true,key,false,game)
VIM:SendKeyEvent(false,key,false,game)

DashCancel()

end

-- botones skill
skill1.MouseButton1Click:Connect(function()
if enabled then UseSkill(Enum.KeyCode.One) end
end)

skill2.MouseButton1Click:Connect(function()
if enabled then UseSkill(Enum.KeyCode.Two) end
end)

skill3.MouseButton1Click:Connect(function()
if enabled then UseSkill(Enum.KeyCode.Three) end
end)

skill4.MouseButton1Click:Connect(function()
if enabled then UseSkill(Enum.KeyCode.Four) end
end)

-- puño móvil
punch.MouseButton1Click:Connect(function()
if enabled then
UseSkill(Enum.KeyCode.One)
end
end)

-- drag UI
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
