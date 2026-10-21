--=============================================================
--  MAGRIN HUB - UI PROFISSIONAL + AIMBOT + ESP 🌈
--  Tudo inicia DESATIVADO e com cores arco-íris
--=============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Config = {
    FOV = 300,
    ATIVO = false,       -- Aimbot desligado
    MostrarFov = false,  -- FOV desligado
    Timeout = false,     -- Desligado
    BrilhoFov = 2,
    ESP_Ativo = false,   -- ESP desligado
}
local ALVO = nil

if CoreGui:FindFirstChild("MagrinHub") then CoreGui.MagrinHub:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = "MagrinHub"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.DisplayOrder = 999999
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = CoreGui

--==================== FOV CIRCLE ====================
local fovFrame = Instance.new("Frame")
fovFrame.Name = "FovCircle"
fovFrame.BackgroundTransparency = 1
fovFrame.BorderSizePixel = 0
fovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
fovFrame.Position = UDim2.fromScale(0.5, 0.5)
fovFrame.Size = UDim2.fromOffset(Config.FOV * 2, Config.FOV * 2)
fovFrame.Visible = Config.MostrarFov
fovFrame.ZIndex = 1
fovFrame.Parent = sg

local fovStroke = Instance.new("UIStroke")
fovStroke.Thickness = 2
fovStroke.Transparency = 0.25
fovStroke.Parent = fovFrame

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovFrame

local centerDot = Instance.new("Frame")
centerDot.Size = UDim2.fromOffset(6, 6)
centerDot.Position = UDim2.fromScale(0.5, 0.5)
centerDot.AnchorPoint = Vector2.new(0.5, 0.5)
centerDot.BorderSizePixel = 0
centerDot.Visible = Config.MostrarFov
centerDot.ZIndex = 2
centerDot.Parent = sg

local centerCorner = Instance.new("UICorner")
centerCorner.CornerRadius = UDim.new(1, 0)
centerCorner.Parent = centerDot

--==================== JANELA ====================
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(520, 420)
Main.Position = UDim2.new(0.5, -260, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ZIndex = 10
Main.Parent = sg

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(140, 80, 255)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.2
MainStroke.Parent = Main

local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1, 60, 1, 60)
Glow.Position = UDim2.new(0, -30, 0, -30)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://5028857472"
Glow.ImageColor3 = Color3.fromRGB(140, 80, 255)
Glow.ImageTransparency = 0.85
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(24, 24, 276, 276)
Glow.ZIndex = 9
Glow.Parent = Main

--==================== HEADER ====================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundColor3 = Color3.fromRGB(20, 18, 30)
Header.BorderSizePixel = 0
Header.ZIndex = 11
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 14)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 14)
HeaderFix.Position = UDim2.new(0, 0, 1, -14)
HeaderFix.BackgroundColor3 = Color3.fromRGB(20, 18, 30)
HeaderFix.BorderSizePixel = 0
HeaderFix.ZIndex = 11
HeaderFix.Parent = Header

local HeaderLine = Instance.new("Frame")
HeaderLine.Size = UDim2.new(1, 0, 0, 2)
HeaderLine.Position = UDim2.new(0, 0, 1, -2)
HeaderLine.BorderSizePixel = 0
HeaderLine.ZIndex = 12
HeaderLine.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 40, 40)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 60, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 80, 255)),
}
HeaderGradient.Parent = HeaderLine

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.fromOffset(40, 40)
Logo.Position = UDim2.fromOffset(20, 15)
Logo.BackgroundColor3 = Color3.fromRGB(30, 24, 45)
Logo.Text = "M"
Logo.TextColor3 = Color3.fromRGB(180, 120, 255)
Logo.TextSize = 26
Logo.Font = Enum.Font.GothamBlack
Logo.BorderSizePixel = 0
Logo.ZIndex = 12
Logo.Parent = Header
Instance.new("UICorner", Logo).CornerRadius = UDim.new(0, 10)

local LogoStroke = Instance.new("UIStroke", Logo)
LogoStroke.Color = Color3.fromRGB(180, 120, 255)
LogoStroke.Thickness = 1.5
LogoStroke.Transparency = 0.3

local NomeHub = Instance.new("TextLabel")
NomeHub.Size = UDim2.new(0, 200, 0, 22)
NomeHub.Position = UDim2.fromOffset(72, 16)
NomeHub.BackgroundTransparency = 1
NomeHub.Text = "MAGRIN HUB"
NomeHub.TextColor3 = Color3.fromRGB(255, 255, 255)
NomeHub.TextSize = 20
NomeHub.Font = Enum.Font.GothamBlack
NomeHub.TextXAlignment = Enum.TextXAlignment.Left
NomeHub.ZIndex = 12
NomeHub.Parent = Header

local SubNome = Instance.new("TextLabel")
SubNome.Size = UDim2.new(0, 200, 0, 16)
SubNome.Position = UDim2.fromOffset(72, 38)
SubNome.BackgroundTransparency = 1
SubNome.Text = "by Magrin >⁠.⁠<"
SubNome.TextColor3 = Color3.fromRGB(160, 140, 200)
SubNome.TextSize = 11
SubNome.Font = Enum.Font.GothamMedium
SubNome.TextXAlignment = Enum.TextXAlignment.Left
SubNome.ZIndex = 12
SubNome.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(30, 30)
CloseBtn.Position = UDim2.new(1, -42, 0, 12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 30)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.TextSize = 22
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 12
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
CloseBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.fromOffset(30, 30)
MinBtn.Position = UDim2.new(1, -78, 0, 12)
MinBtn.BackgroundColor3 = Color3.fromRGB(35, 32, 45)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(200, 180, 255)
MinBtn.TextSize = 16
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.ZIndex = 12
MinBtn.Parent = Header
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 8)

--==================== BOTÃO FLUTUANTE (M) ====================
local Reopen = Instance.new("TextButton")
Reopen.Size = UDim2.fromOffset(60, 60)
Reopen.Position = UDim2.fromOffset(20, 20)
Reopen.BackgroundColor3 = Color3.fromRGB(30, 24, 45)
Reopen.Text = "M"
Reopen.TextColor3 = Color3.fromRGB(180, 120, 255)
Reopen.TextSize = 26
Reopen.Font = Enum.Font.GothamBlack
Reopen.BorderSizePixel = 0
Reopen.Active = true
Reopen.Draggable = true
Reopen.Visible = false
Reopen.ZIndex = 20
Reopen.Parent = sg
Instance.new("UICorner", Reopen).CornerRadius = UDim.new(1, 0)

local ReopenStroke = Instance.new("UIStroke", Reopen)
ReopenStroke.Color = Color3.fromRGB(180, 120, 255)
ReopenStroke.Thickness = 2
ReopenStroke.Transparency = 0.3

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    Reopen.Visible = true
end)

Reopen.MouseButton1Click:Connect(function()
    Main.Visible = true
    Reopen.Visible = false
end)

--==================== TABS ====================
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -40, 0, 38)
TabBar.Position = UDim2.fromOffset(20, 78)
TabBar.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 11
TabBar.Parent = Main
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 10)

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 4)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabBar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingLeft = UDim.new(0, 4)
TabPadding.PaddingTop = UDim.new(0, 4)
TabPadding.Parent = TabBar

--==================== CONTEÚDO ====================
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -40, 1, -140)
Content.Position = UDim2.fromOffset(20, 126)
Content.BackgroundTransparency = 1
Content.ZIndex = 11
Content.Parent = Main

local PageAimbot = Instance.new("ScrollingFrame")
PageAimbot.Size = UDim2.fromScale(1, 1)
PageAimbot.BackgroundTransparency = 1
PageAimbot.BorderSizePixel = 0
PageAimbot.ScrollBarThickness = 3
PageAimbot.ScrollBarImageColor3 = Color3.fromRGB(140, 80, 255)
PageAimbot.CanvasSize = UDim2.new(0, 0, 0, 0)
PageAimbot.AutomaticCanvasSize = Enum.AutomaticSize.Y
PageAimbot.ZIndex = 11
PageAimbot.Parent = Content

local PageLayout = Instance.new("UIListLayout")
PageLayout.Padding = UDim.new(0, 10)
PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
PageLayout.Parent = PageAimbot

local PageVisual = Instance.new("ScrollingFrame")
PageVisual.Size = UDim2.fromScale(1, 1)
PageVisual.BackgroundTransparency = 1
PageVisual.BorderSizePixel = 0
PageVisual.ScrollBarThickness = 3
PageVisual.ScrollBarImageColor3 = Color3.fromRGB(140, 80, 255)
PageVisual.CanvasSize = UDim2.new(0, 0, 0, 0)
PageVisual.AutomaticCanvasSize = Enum.AutomaticSize.Y
PageVisual.Visible = false
PageVisual.ZIndex = 11
PageVisual.Parent = Content

local PageVisualLayout = Instance.new("UIListLayout")
PageVisualLayout.Padding = UDim.new(0, 10)
PageVisualLayout.SortOrder = Enum.SortOrder.LayoutOrder
PageVisualLayout.Parent = PageVisual

local PageInfo = Instance.new("Frame")
PageInfo.Size = UDim2.fromScale(1, 1)
PageInfo.BackgroundTransparency = 1
PageInfo.Visible = false
PageInfo.ZIndex = 11
PageInfo.Parent = Content

--==================== TABS SISTEMA ====================
local function CriarTab(nome, pagina)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.fromOffset(100, 30)
    tabBtn.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
    tabBtn.Text = nome
    tabBtn.TextColor3 = Color3.fromRGB(160, 140, 200)
    tabBtn.TextSize = 13
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.BorderSizePixel = 0
    tabBtn.AutoButtonColor = false
    tabBtn.ZIndex = 12
    tabBtn.Parent = TabBar
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 7)

    tabBtn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Content:GetChildren()) do
            if p:IsA("Frame") or p:IsA("ScrollingFrame") then p.Visible = false end
        end
        for _, b in ipairs(TabBar:GetChildren()) do
            if b:IsA("TextButton") then
                TweenService:Create(b, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(22, 20, 30),
                    TextColor3 = Color3.fromRGB(160, 140, 200)
                }):Play()
            end
        end
        pagina.Visible = true
        TweenService:Create(tabBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(140, 80, 255),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)
    return tabBtn
end

local TabAimbot = CriarTab("Aimbot", PageAimbot)
local TabVisual = CriarTab("Visual (ESP)", PageVisual)
local TabInfo = CriarTab("Info", PageInfo)
TabAimbot.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
TabAimbot.TextColor3 = Color3.fromRGB(255, 255, 255)

--==================== COMPONENTES ====================
local function CreateSection(parent, titulo)
    local sec = Instance.new("Frame")
    sec.Size = UDim2.new(1, 0, 0, 30)
    sec.BackgroundTransparency = 1
    sec.ZIndex = 11
    sec.Parent = parent
    local linha = Instance.new("Frame")
    linha.Size = UDim2.new(0, 4, 1, -10)
    linha.Position = UDim2.new(0, 0, 0, 5)
    linha.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
    linha.BorderSizePixel = 0
    linha.ZIndex = 12
    linha.Parent = sec
    Instance.new("UICorner", linha).CornerRadius = UDim.new(1, 0)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -14, 1, 0)
    lbl.Position = UDim2.fromOffset(14, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = titulo
    lbl.TextColor3 = Color3.fromRGB(200, 180, 255)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 12
    lbl.Parent = sec
end

local function CreateToggle(parent, texto, default, callback)
    local cont = Instance.new("Frame")
    cont.Size = UDim2.new(1, 0, 0, 40)
    cont.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
    cont.BorderSizePixel = 0
    cont.ZIndex = 11
    cont.Parent = parent
    Instance.new("UICorner", cont).CornerRadius = UDim.new(0, 8)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -80, 1, 0)
    lbl.Position = UDim2.fromOffset(14, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = texto
    lbl.TextColor3 = Color3.fromRGB(220, 210, 240)
    lbl.TextSize = 14
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 12
    lbl.Parent = cont
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.fromOffset(46, 24)
    toggle.Position = UDim2.new(1, -60, 0.5, -12)
    toggle.BackgroundColor3 = default and Color3.fromRGB(140, 80, 255) or Color3.fromRGB(40, 36, 50)
    toggle.Text = ""
    toggle.BorderSizePixel = 0
    toggle.AutoButtonColor = false
    toggle.ZIndex = 12
    toggle.Parent = cont
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)
    local ball = Instance.new("Frame")
    ball.Size = UDim2.fromOffset(18, 18)
    ball.Position = default and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    ball.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ball.BorderSizePixel = 0
    ball.ZIndex = 13
    ball.Parent = toggle
    Instance.new("UICorner", ball).CornerRadius = UDim.new(1, 0)
    local state = default
    local function set(v)
        state = v
        TweenService:Create(toggle, TweenInfo.new(0.15), {
            BackgroundColor3 = v and Color3.fromRGB(140, 80, 255) or Color3.fromRGB(40, 36, 50)
        }):Play()
        TweenService:Create(ball, TweenInfo.new(0.15), {
            Position = v and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        }):Play()
        callback(v)
    end
    toggle.MouseButton1Click:Connect(function() set(not state) end)
    return set
end

local function CreateSlider(parent, texto, min, max, default, callback)
    local cont = Instance.new("Frame")
    cont.Size = UDim2.new(1, 0, 0, 55)
    cont.BackgroundColor3 = Color3.fromRGB(22, 20, 30)
    cont.BorderSizePixel = 0
    cont.ZIndex = 11
    cont.Parent = parent
    Instance.new("UICorner", cont).CornerRadius = UDim.new(0, 8)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -80, 0, 20)
    lbl.Position = UDim2.fromOffset(14, 6)
    lbl.BackgroundTransparency = 1
    lbl.Text = texto
    lbl.TextColor3 = Color3.fromRGB(220, 210, 240)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 12
    lbl.Parent = cont
    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.fromOffset(60, 20)
    valLbl.Position = UDim2.new(1, -74, 0, 6)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.TextColor3 = Color3.fromRGB(180, 120, 255)
    valLbl.TextSize = 13
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.ZIndex = 12
    valLbl.Parent = cont
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -28, 0, 22)
    bar.Position = UDim2.fromOffset(14, 28)
    bar.BackgroundTransparency = 1
    bar.ZIndex = 12
    bar.Parent = cont
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 5)
    line.Position = UDim2.new(0, 0, 0.5, -2.5)
    line.BackgroundColor3 = Color3.fromRGB(45, 40, 60)
    line.BorderSizePixel = 0
    line.ZIndex = 12
    line.Parent = bar
    Instance.new("UICorner", line).CornerRadius = UDim.new(1, 0)
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
    fill.BorderSizePixel = 0
    fill.ZIndex = 13
    fill.Parent = line
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(14, 14)
    knob.Position = UDim2.new(fill.Size.X.Scale, -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 14
    knob.Parent = bar
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    local dragging = false
    local function upd(inputPos)
        local rel = inputPos.X - bar.AbsolutePosition.X
        local pos = math.clamp(rel / bar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * pos + 0.5)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        knob.Position = UDim2.new(pos, -7, 0.5, -7)
        valLbl.Text = tostring(val)
        callback(val)
    end
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            upd(input.Position)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            upd(input.Position)
        end
    end)
end

--==================== CONTEÚDO - AIMBOT ====================
CreateSection(PageAimbot, "ALVO")
CreateToggle(PageAimbot, "Aimbot Ativado", Config.ATIVO, function(v)
    Config.ATIVO = v
    if not v then ALVO = nil end
end)
CreateToggle(PageAimbot, "Mostrar FOV", Config.MostrarFov, function(v)
    Config.MostrarFov = v
    fovFrame.Visible = v
    centerDot.Visible = v
end)
CreateToggle(PageAimbot, "Soltar Alvo ao Sair do FOV", Config.Timeout, function(v)
    Config.Timeout = v
end)
CreateSection(PageAimbot, "VISUAL")
CreateSlider(PageAimbot, "Tamanho do FOV", 40, 600, Config.FOV, function(v)
    Config.FOV = v
    fovFrame.Size = UDim2.fromOffset(v * 2, v * 2)
end)
CreateSlider(PageAimbot, "Brilho do FOV", 1, 5, Config.BrilhoFov, function(v)
    Config.BrilhoFov = v
    fovStroke.Thickness = v
end)

--==================== CONTEÚDO - VISUAL (ESP) ====================
CreateSection(PageVisual, "ESP JOGADORES")
CreateToggle(PageVisual, "Ativar ESP", Config.ESP_Ativo, function(v)
    Config.ESP_Ativo = v
    if not v then
        for _, v in pairs(sg:GetChildren()) do
            if v.Name == "ESP_Element" then v:Destroy() end
        end
    end
end)

--==================== CONTEÚDO - INFO ====================
local infoTitulo = Instance.new("TextLabel")
infoTitulo.Size = UDim2.new(1, 0, 0, 40)
infoTitulo.BackgroundTransparency = 1
infoTitulo.Text = "MAGRIN HUB"
infoTitulo.TextColor3 = Color3.fromRGB(180, 120, 255)
infoTitulo.TextSize = 28
infoTitulo.Font = Enum.Font.GothamBlack
infoTitulo.ZIndex = 11
infoTitulo.Parent = PageInfo

local infoSub = Instance.new("TextLabel")
infoSub.Size = UDim2.new(1, 0, 0, 25)
infoSub.Position = UDim2.fromOffset(0, 45)
infoSub.BackgroundTransparency = 1
infoSub.Text = "by Magrin >⁠.⁠<"
infoSub.TextColor3 = Color3.fromRGB(160, 140, 200)
infoSub.TextSize = 14
infoSub.Font = Enum.Font.GothamMedium
infoSub.ZIndex = 11
infoSub.Parent = PageInfo

local infoLinha = Instance.new("Frame")
infoLinha.Size = UDim2.new(1, -60, 0, 1)
infoLinha.Position = UDim2.fromOffs
