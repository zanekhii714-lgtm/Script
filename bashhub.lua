if getgenv().BashHubLoaded then return end
getgenv().BashHubLoaded = true

-- servicios
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local WS = game:GetService("Workspace")

local isMobile = UIS.TouchEnabled

-- CONFIG
local delay = 0.015
local backTime = 0.067
local guiLocked = false
local superTechEnabled = false -- Nueva variable sin duplicar

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
frame.Size = UDim2.new(0,240,0,360) -- Aumento mínimo solo para nuevo toggle
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

-- TOGGLE SUPER TECH (NUEVO - sin duplicar elementos)
local superTechToggle = Instance.new("TextButton")
superTechToggle.Size = UDim2.new(0,200,0,35)
superTechToggle.Position = UDim2.new(0,20,0,230) -- Posición entre Config y ConfigFrame
superTechToggle.Text = "SUPER TECH OFF"
superTechToggle.BackgroundColor3 = Color3.fromRGB(255,60,60)
superTechToggle.Parent = frame
Instance.new("UICorner",superTechToggle)

-- SKILL SELECTOR
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

-- CONFIG
local config = Instance.new("TextButton")
config.Size = UDim2.new(0,200,0,30)
config.Position = UDim2.new(0,20,0,190)
config.Text = "CONFIG"
config.BackgroundColor3 = Color3.fromRGB(50,50,50)
config.Parent = frame
Instance.new("UICorner",config)

-- CONFIG FRAME
local configFrame = Instance.new("Frame")
configFrame.Size = UDim2.new(0,200,0,120)
configFrame.Position = UDim2.new(0,20,0,275) -- Ajuste mínimo para no superponer
configFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
configFrame.Visible = false
configFrame.Parent = frame
Instance.new("UICorner",configFrame)

-- DELAY
local delayPlus = Instance.new("TextButton")
delayPlus.Size = UDim2.new(0,80,0,30)
delayPlus.Position = UDim2.new(0,10,0,10)
delayPlus.Text = "Delay +"
delayPlus.Parent = configFrame
Instance.new("UICorner",delayPlus)

local delayMinus = delayPlus:Clone()
delayMinus.Position = UDim2.new(0,110,0,10)
delayMinus.Text = "Delay -"
delayMinus.Parent = configFrame

-- DISTANCIA
local distPlus = delayPlus:Clone()
distPlus.Position = UDim2.new(0,10,0,60)
distPlus.Text = "Back +"
distPlus.Parent = configFrame

local distMinus = delayPlus:Clone()
distMinus.Position = UDim2.new(0,110,0,60)
distMinus.Text = "Back -"
distMinus.Parent = configFrame

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

-- BOTON MOVIL SUPER TECH (NUEVO - sin duplicar)
local superTechBtn = Instance.new("TextButton")
superTechBtn.Size = UDim2.new(0,70,0,70)
superTechBtn.Position = UDim2.new(1,-100,1,-200)
superTechBtn.Text = "💥"
superTechBtn.TextScaled = true
superTechBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
superTechBtn.Visible = false
superTechBtn.Parent = gui
superTechBtn.Active = true
superTechBtn.Draggable = true
Instance.new("UICorner",superTechBtn)

-- VARIABLES
local enabled = false
local selectedSkill = Enum.KeyCode.One

-- FUNCION SUPER TECH AUTOMATICA (según tutorial)
local function getClosestEnemy()
    local closest = nil
    local minDist = math.huge
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local root = char.HumanoidRootPart

    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character.Humanoid and plr.Character.Humanoid.Health > 0 then
            local enemyRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            if enemyRoot then
                local dist = (root.Position - enemyRoot.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = plr.Character
                end
            end
        end
    end
    return closest
end

local function AutoSuperTech()
    if not enabled or not superTechEnabled then return end
    local enemy = getClosestEnemy()
    if not enemy then return end

    -- Secuencia exacta del tutorial: Ataque -> Dash hacia enemigo -> Ataque -> Dash atrás
    VIM:SendKeyEvent(true, selectedSkill, false, game)
    VIM:SendKeyEvent(false, selectedSkill, false, game)
    task.wait(delay)

    -- Dash hacia enemigo
    VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
    task.wait(0.01)
    VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    task.wait(0.02)
    VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
    VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
    task.wait(0.03)

    -- Segundo ataque en contacto
    VIM:SendKeyEvent(true, selectedSkill, false, game)
    VIM:SendKeyEvent(false, selectedSkill, false, game)
    task.wait(0.02)

    -- Dash atrás para finalizar
    VIM:SendKeyEvent(true, Enum.KeyCode.S, false, game)
    task.wait(0.01)
    VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    task.wait(0.015)
    VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
    task.wait(backTime)
    VIM:SendKeyEvent(false, Enum.KeyCode.S, false, game)
end

-- DASH CANCEL (ORIGINAL SIN MODIFICAR)
local function DashCancel()
    task.wait(delay)
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

-- ABRIR UI (ORIGINAL)
logo.MouseButton1Click:Connect(function()
frame.Visible = not frame.Visible
end)

-- LOCK (ORIGINAL - actualizado solo para boton super tech)
lock.MouseButton1Click:Connect(function()
guiLocked = not guiLocked
if guiLocked then
lock.Text = "🔒"
frame.Draggable = false
logo.Draggable = false
punch.Draggable = false
superTechBtn.Draggable = false -- Solo adición aquí
else
lock.Text = "🔓"
frame.Draggable = true
logo.Draggable = true
punch.Draggable = true
superTechBtn.Draggable = true -- Solo adición aquí
end
end)

-- SELECT SKILL (ORIGINAL)
local function selectSkill(button,key)
selectedSkill = key
skill1.BackgroundColor3 = Color3.fromRGB(50,50,50)
skill2.BackgroundColor3 = Color3.fromRGB(50,50,50)
skill3.BackgroundColor3 = Color3.fromRGB(50,50,50)
skill4.BackgroundColor3 = Color3.fromRGB(50,50,50)
button.BackgroundColor3 = Color3.fromRGB(60,255,60)
end
skill1.MouseButton1Click:Connect(function() selectSkill(skill1,Enum.KeyCode.One) end)
skill2.MouseButton1Click:Connect(function() selectSkill(skill2,Enum.KeyCode.Two) end)
skill3.MouseButton1Click:Connect(function() selectSkill(skill3,Enum.KeyCode.Three) end)
skill4.MouseButton1Click:Connect(function() selectSkill(skill4,Enum.KeyCode.Four) end)

-- CONFIG abrir (ORIGINAL)
config.MouseButton1Click:Connect(function()
configFrame.Visible = not configFrame.Visible
end)

-- AJUSTES CONFIG (ORIGINAL)
delayPlus.MouseButton1Click:Connect(function() delay = delay + 0.005 end)
delayMinus.MouseButton1Click:Connect(function() delay = math.max(0.01,delay - 0.005) end)
distPlus.MouseButton1Click:Connect(function() backTime = backTime + 0.01 end)
distMinus.MouseButton1Click:Connect(function() backTime = math.max(0.02,backTime - 0.01) end)

-- TOGGLE PRINCIPAL (ORIGINAL)
toggle.MouseButton1Click:Connect(function()
enabled = not enabled
if enabled then
toggle.Text = "ON"
toggle.BackgroundColor3 = Color3.fromRGB(60,255,60)
if isMobile then punch.Visible = true end
else
toggle.Text = "OFF"
toggle.BackgroundColor3 = Color3.fromRGB(255,60,60)
punch.Visible = false
end
end)

-- TOGGLE SUPER TECH (NUEVO - sin duplicar lógica)
superTechToggle.MouseButton1Click:Connect(function()
superTechEnabled = not superTechEnabled
if superTechEnabled then
superTechToggle.Text = "SUPER TECH ON"
superTechToggle.BackgroundColor3 = Color3.fromRGB(60,255,60)
if isMobile then superTechBtn.Visible = true end
else
superTechToggle.Text = "SUPER TECH OFF"
superTechToggle.BackgroundColor3 = Color3.fromRGB(255,60,60)
superTechBtn.Visible = false
end
end)

-- PC INPUT (ORIGINAL + super tech tecla J)
UIS.InputBegan:Connect(function(input,gp)
if gp then return end
if not enabled then return end
if input.KeyCode == Enum.KeyCode.H then DashCancel() end
if input.KeyCode == Enum.KeyCode.J then AutoSuperTech() end -- Solo adición aquí
end)

-- MOVIL INPUT (ORIGINAL + super tech boton)
punch.MouseButton1Click:Connect(function() if enabled then DashCancel() end end)
superTechBtn.MouseButton1Click:Connect(function() if enabled then AutoSuperTech() end end) -- NUEVO
