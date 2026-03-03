if getgenv().BashHubLoaded then return end
getgenv().BashHubLoaded = true

-- servicios
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local WS = game:GetService("Workspace")
local RS = game:GetService("RunService")

local isMobile = UIS.TouchEnabled

-- CONFIG
local delay = 0.015
local backTime = 0.067
local guiLocked = false
local superTechAutoActive = false -- Ahora es auto-activo cuando está ON

-- GUI (TODO ORIGINAL - SOLO CAMBIO EN TEXTO DEL TOGGLE)
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
lock.BackgroundColor3 = Color3.fromRGB(25,25,25)
lock.TextColor3 = Color3.new(1,1,1)
lock.Parent = gui
lock.Active = true
lock.Draggable = true
Instance.new("UICorner",lock)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,240,0,320) -- TAMAÑO ORIGINAL DE VUELTA
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

-- TOGGLE MODIFICADO: AHORA ACTIVA SUPER TECH AUTO
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,200,0,35)
toggle.Position = UDim2.new(0,20,0,40)
toggle.Text = "OFF (SUPER TECH INACTIVO)"
toggle.BackgroundColor3 = Color3.fromRGB(255,60,60)
toggle.Parent = frame
Instance.new("UICorner",toggle)

-- SKILL SELECTOR ORIGINAL - TEXTO ACTUALIZADO A UPPERCUT
local skill1 = Instance.new("TextButton")
skill1.Size = UDim2.new(0,90,0,35)
skill1.Position = UDim2.new(0,20,0,90)
skill1.Text = "Uppercut"
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

-- CONFIG ORIGINAL
local config = Instance.new("TextButton")
config.Size = UDim2.new(0,200,0,30)
config.Position = UDim2.new(0,20,0,190)
config.Text = "CONFIG"
config.BackgroundColor3 = Color3.fromRGB(50,50,50)
config.Parent = frame
Instance.new("UICorner",config)

local configFrame = Instance.new("Frame")
configFrame.Size = UDim2.new(0,200,0,120)
configFrame.Position = UDim2.new(0,20,0,230)
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

-- BOTON MOVIL ORIGINAL
local punch = Instance.new("TextButton")
punch.Size = UDim2.new(0,70,0,70)
punch.Position = UDim2.new(1,-100,1,-120)
punch.Text = "👊 UPPERCUT"
punch.TextScaled = true
punch.BackgroundColor3 = Color3.fromRGB(40,40,40)
punch.Visible = false
punch.Parent = gui
punch.Active = true
punch.Draggable = true
Instance.new("UICorner",punch)

-- VARIABLES ORIGINALES
local enabled = false
local selectedSkill = Enum.KeyCode.One -- Uppercut asignado por defecto
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")
local uppercutExecuted = false

-- FUNCION: DETECCION DE ENEMIGO AL QUE SE LE HIZO UPPERCUT
local function getHitEnemy()
    local hitEnemy = nil
    if not char or not rootPart then return nil end

    -- Busca enemigo cerca y con animacion de ser lanzado arriba
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local enemyChar = plr.Character
            local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
            local enemyHum = enemyChar:FindFirstChild("Humanoid")
            if enemyRoot and enemyHum and enemyHum.Health > 0 then
                -- Verifica si el enemigo esta en el aire (despues del uppercut)
                if enemyRoot.Position.Y > enemyChar.Humanoid.HipHeight * 2 then
                    hitEnemy = enemyChar
                    break
                end
            end
        end
    end
    return hitEnemy
end

-- FUNCION SUPER TECH AUTOMATICO DESPUES DE UPPERCUT
local function AutoSuperTechAfterUppercut()
    if not superTechAutoActive then return end
    
    -- Espera a que el enemigo este en el aire
    task.wait(0.1)
    local enemy = getHitEnemy()
    if not enemy then return end
    local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
    if not enemyRoot then return end

    -- SECUENCIA SUPER TECH AUTOMATICA DESPUES DEL UPPERCUT
    -- Paso 1: Dash hacia el enemigo en el aire
    rootPart.CFrame = CFrame.new(rootPart.Position, enemyRoot.Position)
    VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
    task.wait(0.01)
    VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    task.wait(0.07)
    VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
    VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
    task.wait(0.02)

    -- Paso 2: Ataque seguido en el aire
    VIM:SendKeyEvent(true, selectedSkill, false, game)
    task.wait(0.05)
    VIM:SendKeyEvent(false, selectedSkill, false, game)
    task.wait(0.02)

    -- Paso 3: Dash ajuste para finalizar combo
    VIM:SendKeyEvent(true, Enum.KeyCode.S, false, game)
    task.wait(0.01)
    VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    task.wait(0.05)
    VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
    task.wait(backTime)
    VIM:SendKeyEvent(false, Enum.KeyCode.S, false, game)

    uppercutExecuted = false
end

-- FUNCION UPPERCUT QUE ACTIVA SUPER TECH AUTOMATICAMENTE
local function ExecuteUppercut()
    if not enabled then return end
    
    -- Ejecuta Uppercut
    VIM:SendKeyEvent(true, selectedSkill, false, game)
    task.wait(0.06)
    VIM:SendKeyEvent(false, selectedSkill, false, game)
    uppercutExecuted = true

    -- Activa Super Tech automaticamente si esta habilitado
    if superTechAutoActive then
        spawn(AutoSuperTechAfterUppercut)
    end
end

-- ACTUALIZAR PERSONAJE CUANDO SPAWNE
player.CharacterAdded:Connect(function(newChar)
    char = newChar
    humanoid = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")
end)

-- EVENTOS ORIGINALES MODIFICADOS
logo.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

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

config.MouseButton1Click:Connect(function()
    configFrame.Visible = not configFrame.Visible
end)

delayPlus.MouseButton1Click:Connect(function() delay = delay + 0.005 end)
delayMinus.MouseButton1Click:Connect(function() delay = math.max(0.01,delay - 0.005) end)
distPlus.MouseButton1Click:Connect(function() backTime = backTime + 0.01 end)
distMinus.MouseButton1Click:Connect(function() backTime = math.max(0.02,backTime - 0.01) end)

-- TOGGLE PRINCIPAL MODIFICADO: ACTIVA SUPER TECH AUTO AL ENCENDER
toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    superTechAutoActive = enabled -- Super Tech se activa automaticamente con el toggle

    if enabled then
        toggle.Text = "ON (SUPER TECH ACTIVO)"
        toggle.BackgroundColor3 = Color3.fromRGB(60,255,60)
        if isMobile then punch.Visible = true end
    else
        toggle.Text = "OFF (SUPER TECH INACTIVO)"
        toggle.BackgroundColor3 = Color3.fromRGB(255,60,60)
        punch.Visible = false
        superTechAutoActive = false
    end
end)

-- ENTRADAS MODIFICADAS: SOLO UPPERCUT QUE ACTIVA SUPER TECH AUTO
UIS.InputBegan:Connect(function(input,gp)
    if gp or not enabled then return end
    -- Al presionar la tecla del Uppercut o H, se ejecuta y luego Super Tech automaticamente
    if input.KeyCode == selectedSkill or input.KeyCode == Enum.KeyCode.H then
        ExecuteUppercut()
    end
end)

-- MOVIL: BOTON DE UPPERCUT ACTIVA SUPER TECH AUTO
punch.MouseButton1Click:Connect(function()
    if enabled then
        ExecuteUppercut()
    end
end)
