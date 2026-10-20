-- Aimbot + ESP com Interface (Arceus X / Delta)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- ====== CONFIGURAÇÕES ======
getgenv().Aimbot = false
getgenv().ESP = false
getgenv().TeamCheck = true
getgenv().AimPart = "Head"
getgenv().FOV = 250
-- ===========================

-- Limpa GUI antiga se existir
if CoreGui:FindFirstChild("AimbotESPGUI") then
    CoreGui.AimbotESPGUI:Destroy()
end

-- ==================== CRIA A INTERFACE ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AimbotESPGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Position = UDim2.new(0, 20, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 200, 100)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.BorderSizePixel = 0
Title.Text = "Aimbot + ESP"
Title.TextColor3 = Color3.fromRGB(0, 255, 130)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- Botão Aimbot
local AimbotBtn = Instance.new("TextButton")
AimbotBtn.Name = "AimbotBtn"
AimbotBtn.Size = UDim2.new(0.85, 0, 0, 38)
AimbotBtn.Position = UDim2.new(0.075, 0, 0, 50)
AimbotBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AimbotBtn.Text = "Aimbot: OFF"
AimbotBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
AimbotBtn.TextSize = 16
AimbotBtn.Font = Enum.Font.GothamBold
AimbotBtn.Parent = MainFrame

local AimbotCorner = Instance.new("UICorner")
AimbotCorner.CornerRadius = UDim.new(0, 8)
AimbotCorner.Parent = AimbotBtn

-- Botão ESP
local ESPBtn = Instance.new("TextButton")
ESPBtn.Name = "ESPBtn"
ESPBtn.Size = UDim2.new(0.85, 0, 0, 38)
ESPBtn.Position = UDim2.new(0.075, 0, 0, 100)
ESPBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ESPBtn.Text = "ESP: OFF"
ESPBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
ESPBtn.TextSize = 16
ESPBtn.Font = Enum.Font.GothamBold
ESPBtn.Parent = MainFrame

local ESPCorner = Instance.new("UICorner")
ESPCorner.CornerRadius = UDim.new(0, 8)
ESPCorner.Parent = ESPBtn

-- Botão Fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 3)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 1, -28)
Status.BackgroundTransparency = 1
Status.Text = "Pronto para usar"
Status.TextColor3 = Color3.fromRGB(180, 180, 180)
Status.TextSize = 12
Status.Font = Enum.Font.Gotham
Status.Parent = MainFrame

-- ==================== FUNÇÕES ====================

-- ESP
local function CreateESP(player)
    if player == LocalPlayer or not player.Character then return end
    if player.Character:FindFirstChild("ESP_Highlight") then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = player.Character
    highlight.FillColor = Color3.fromRGB(255, 50, 50)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.55
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = player.Character
end

local function RemoveESP(player)
    if player.Character and player.Character:FindFirstChild("ESP_Highlight") then
        player.Character.ESP_Highlight:Destroy()
    end
end

local function ClearAllESP()
    for _, player in pairs(Players:GetPlayers()) do
        RemoveESP(player)
    end
end

-- Pega alvo mais próximo
local function GetClosestPlayer()
    local closest = nil
    local shortestDistance = getgenv().FOV
    
    for _, player in pairs(Players:GetPlayers()) do
        if player \~= LocalPlayer 
            and player.Character 
            and player.Character:FindFirstChild("Humanoid") 
            and player.Character.Humanoid.Health > 0 
            and player.Character:FindFirstChild(getgenv().AimPart) then
            
            if getgenv().TeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                continue
            end
            
            local part = player.Character[getgenv().AimPart]
            local screenPoint, onScreen = Camera:WorldToViewportPoint(part.Position)
            
            if onScreen then
                local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                
                if distance < shortestDistance then
                    shortestDistance = distance
                    closest = part
                end
            end
        end
    end
    return closest
end

-- Silent Aim
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if getgenv().Aimbot and method == "FindPartOnRayWithIgnoreList" and not checkcaller() then
        local target = GetClosestPlayer()
        if target then
            local origin = args[1].Origin
            local direction = (target.Position - origin).Unit * args[1].Direction.Magnitude
            args[1] = Ray.new(origin, direction)
            return oldNamecall(self, unpack(args))
        end
    end
    
    return oldNamecall(self, ...)
end)

-- Loop do ESP
RunService.RenderStepped:Connect(function()
    if getgenv().ESP then
        for _, player in pairs(Players:GetPlayers()) do
            if player \~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                CreateESP(player)
            end
        end
    end
end)

-- Atualiza quando alguém spawna
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if getgenv().ESP then
            CreateESP(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(RemoveESP)

-- ==================== BOTÕES ====================

AimbotBtn.MouseButton1Click:Connect(function()
    getgenv().AimBot = not getgenv().AimBot
    if getgenv().AimBot then
        AimbotBtn.Text = "Aimbot: ON"
        AimbotBtn.TextColor3 = Color3.fromRGB(0, 255, 130)
        AimbotBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 40)
        Status.Text = "Aimbot ativado"
    else
        AimbotBtn.Text = "Aimbot: OFF"
        AimbotBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
        AimbotBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Status.Text = "Aimbot desativado"
    end
end)

ESPBtn.MouseButton1Click:Connect(function()
    getgenv().ESP = not getgenv().ESP
    if getgenv().ESP then
        ESPBtn.Text = "ESP: ON"
        ESPBtn.TextColor3 = Color3.fromRGB(0, 255, 130)
        ESPBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 40)
        Status.Text = "ESP ativado"
    else
        ESPBtn.Text = "ESP: OFF"
        ESPBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
        ESPBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        ClearAllESP()
        Status.Text = "ESP desativado"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("✅ Interface carregada! Use os botões na tela.")
