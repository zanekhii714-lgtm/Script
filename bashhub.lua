if getgenv().BashHubLoaded then return end
getgenv().BashHubLoaded = true

-- Servicios
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")

local isMobile = UIS.TouchEnabled

-- Configuración
local delay = 0.015
local backTime = 0.067
local guiLocked = false
local superTechEnabled = false
local selectedSkill = Enum.KeyCode.One -- Uppercut asignado por defecto
local enabled = false

-- GUI (estructura mantenida, solo ajustes mínimos)
local gui = Instance.new("ScreenGui")
gui.Name = "BashHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

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

local lock = Instance.new("TextButton")
lock.Size = UDim2.new(0,50,0,50)
lock.Position = UDim2.new(0,80,0.5,0)
lock.Text = "🔓"
lock.TextScaled = true
logo.BackgroundColor3 = Color3.fromRGB(25,25,25)
lock.TextColor3 = Color3.new(1,1,1)
lock.Parent = gui
lock.Active = true
lock.Draggable = true
Instance.new("UICorner",lock)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,240,0,380)
frame.Position = UDim2.new(0.4,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Visible = false
frame.Parent = gui
frame.Active = true
frame.Draggable = true
Instance.new("UICorner",frame)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Text = "BASH HUB v1.0 FREE"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Parent = frame

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,200,0,35)
toggle.Position = UDim2.new(0,20,0,40)
toggle.Text = "OFF"
toggle.BackgroundColor3 = Color3.fromRGB(255,60,60)
toggle.Parent = frame
Instance.new("UICorner",toggle)

local superTechToggle = Instance.new("TextButton")
superTechToggle.Size = UDim2.new(0,200,0,35)
superTechToggle.Position = UDim2.new(0,20,0,240)
superTechToggle.Text = "SUPER TECH OFF"
superTechToggle.BackgroundColor3 = Color3.fromRGB(255,60,60)
superTechToggle.Parent = frame
Instance.new("UICorner",superTechToggle)

local skill1 = Instance.new("TextButton")
skill1.Size = UDim2.new(0,90,0,35)
skill1.Position = UDim2.new(0,20,0,90)
skill1.Text = "Uppercut" -- Etiqueta actualizada
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

local config = Instance.new("TextButton")
config.Size = UDim2.new(0,200,0,30)
config.Position = UDim2.new(0,20,0,190)
config.Text = "CONFIG"
config.BackgroundColor3 = Color3.fromRGB(50,50,50)
config.Parent = frame
Instance.new("UICorner",config)

local configFrame = Instance.new("Frame")
configFrame.Size = UDim2.new(0,200,0,120)
configFrame.Position = UDim2.new(0,20,0,290)
configFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
configFrame.Visible = false
configFrame.Parent = frame
Instance.new("UICorner",configFrame)

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

local distPlus = delayPlus:Clone()
distPlus.Position = UDim2.new(0,10,0,60)
distPlus.Text = "Back +"
distPlus.Parent = configFrame

local distMinus = delayPlus:Clone()
distMinus.Position = UDim2.new(0,110,0,60)
distMinus.Text = "Back -"
distMinus.Parent = configFrame

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

-- Funciones principales
local function getClosestEnemy()
    local closestEnemy = nil
    local minDistance = math.huge
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local root = char.HumanoidRootPart
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
            local enemyRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            if enemyRoot then
                local distance = (root.Position - enemyRoot.Position).Magnitude
                if distance < minDistance then
                    minDistance = distance
                    closestEnemy = plr.Character
                end
            end
        end
    end
    return closestEnemy
end

local function moveToEnemy(enemy)
    local char = player.Character
    if not char or not enemy or not enemy:FindFirstChild("HumanoidRootPart") then return end
    
    local root = char.HumanoidRootPart
    local enemyRoot = enemy.HumanoidRootPart
    local targetPos = enemyRoot.Position - (enemyRoot.CFrame.LookVector * 1.2) -- Posición cerca del enemigo
    
    -- Ejecutar dash hacia el enemigo
    VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
    VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    task.wait(0.02)
    VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
    
    -- Ajustar posición hasta estar en contacto
    local connection
    connection = RS.Heartbeat:Connect(function()
        if (root.Position - targetPos).Magnitude < 1.5 then
            VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
            connection:Disconnect()
        end
    end)
    task.wait(0.05)
end

local function UppercutSuperTech()
    if not enabled or not superTechEnabled then return end
    
    local enemy = getClosestEnemy()
    if not enemy then return end
    
    -- Paso 1: Moverse y acercarse al enemigo con dash
    moveToEnemy(enemy)
    task.wait(delay)
    
    -- Paso 2: Ejecutar Uppercut en contacto
    VIM:SendKeyEvent(true, selectedSkill, false, game)
    VIM:SendKeyEvent(false, selectedSkill, false, game)
    task.wait(0.03)
    
    -- Paso 3: Secuencia Super Tech posterior
    VIM:SendKeyEvent(true, Enum.KeyCode.S, false, game)
    task.wait(0.02)
    VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.025)
    VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    task.wait(backTime)
    VIM:SendKeyEvent(false, Enum.KeyCode.S, false, game)
    
    -- Dash final de ajuste
    VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    task.wait(0.015)
    VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end

-- Manejadores de eventos
logo.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)

lock.MouseButton1Click:Connect(function()
    guiLocked = not guiLocked
    lock.Text = guiLocked and "🔒" or "🔓"
    frame.Draggable = not guiLocked
    logo.Draggable = not guiLocked
    punch.Draggable = not guiLocked
    superTechBtn.Draggable = not guiLocked
end)

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

config.MouseButton1Click:Connect(function() configFrame.Visible = not configFrame.Visible end)

delayPlus.MouseButton1Click:Connect(function() delay += 0.005 end)
delayMinus.MouseButton1Click:Connect(function() delay = math.max(0.01, delay - 0.005) end)
distPlus.MouseButton1Click:Connect(function() backTime += 0.01 end)
distMinus.MouseButton1Click:Connect(function() backTime = math.max(0.02, backTime - 0.01) end)

toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    toggle.Text = enabled and "ON" or "OFF"
    toggle.BackgroundColor3 = enabled and Color3.fromRGB(60,255,60) or Color3.fromRGB(255,60,60)
    punch.Visible = enabled and isMobile
end)

superTechToggle.MouseButton1Click:Connect(function()
    superTechEnabled = not superTechEnabled
    superTechToggle.Text = superTechEnabled and "SUPER TECH ON" or "SUPER TECH OFF"
    superTechToggle.BackgroundColor3 = superTechEnabled and Color3.fromRGB(60,255,60) or Color3.fromRGB(255,60,60)
    superTechBtn.Visible = superTechEnabled and isMobile
end)

-- Ejecución: Uppercut + Super Tech automático
UIS.InputBegan:Connect(function(input,gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.H or input.KeyCode == selectedSkill then
        UppercutSuperTech()
    end
end)

punch.MouseButton1Click:Connect(UppercutSuperTech)
superTechBtn.MouseButton1Click:Connect(UppercutSuperTech)
