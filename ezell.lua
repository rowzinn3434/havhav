--// NoxLera Hack Menu - Güncel Ultra Güvenli Infinity Jump
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NoxLeraGui"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Frame
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 180, 0, 220)
Frame.Position = UDim2.new(1, -190, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
local corner = Instance.new("UICorner", Frame)
corner.CornerRadius = UDim.new(0, 10)

-- Başlık
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "NoxLeraX"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold

-- Layout
local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Buton oluşturma fonksiyonu
local function createButton(name, callback)
    local btn = Instance.new("Frame", Frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.BorderSizePixel = 0
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)

    local label = Instance.new("TextLabel", btn)
    label.Size = UDim2.new(1, -35, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("Frame", btn)
    box.Size = UDim2.new(0, 20, 0, 20)
    box.Position = UDim2.new(1, -25, 0.5, -10)
    box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    local border = Instance.new("UIStroke", box)
    border.Color = Color3.fromRGB(0, 0, 0)
    border.Thickness = 2
    local boxCorner = Instance.new("UICorner", box)
    boxCorner.CornerRadius = UDim.new(0, 4)

    local state = false
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state
            if state then
                box.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            else
                box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            end
            callback(state)
        end
    end)
end

----------------------------------------------------------------
-- Hile Fonksiyonları
----------------------------------------------------------------

-- Player ESP (isimler beyaz, harf dışı siyah)
local function toggleESP(state)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if state then
                if not plr.Character:FindFirstChild("NoxLera_HL") then
                    local highlight = Instance.new("Highlight", plr.Character)
                    highlight.Name = "NoxLera_HL"
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    highlight.FillTransparency = 0.7
                    highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                    highlight.Adornee = plr.Character
                end
            else
                if plr.Character:FindFirstChild("NoxLera_HL") then
                    plr.Character.NoxLera_HL:Destroy()
                end
            end
        end
    end
end

-- Speed Hack
local speedEnabled = false
local speedValue = 41
local speedConn
local function toggleSpeed(state)
    speedEnabled = state
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if state then
        if humanoid then humanoid.WalkSpeed = speedValue end
        speedConn = RunService.RenderStepped:Connect(function()
            if speedEnabled and humanoid and humanoid.WalkSpeed ~= speedValue then
                humanoid.WalkSpeed = speedValue
            end
        end)
    else
        if humanoid then humanoid.WalkSpeed = 16 end
        if speedConn then speedConn:Disconnect() end
    end
end

-- Infinity Jump (Ultra Güvenli)
local infJumpEnabled = false
local jumpCooldown = false
local function toggleInfJump(state)
    infJumpEnabled = state
end

RunService.RenderStepped:Connect(function()
    if infJumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoid and hrp then
            humanoid.Health = math.max(humanoid.Health, 20)
            if hrp.Velocity.Y < -50 then
                hrp.Velocity = Vector3.new(hrp.Velocity.X, -50, hrp.Velocity.Z)
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and not jumpCooldown then
            jumpCooldown = true
            humanoid:ChangeState("Jumping")
            task.delay(0.25, function()
                jumpCooldown = false
            end)
        end
    end
end)

----------------------------------------------------------------
-- Butonlar
----------------------------------------------------------------
createButton("Player ESP", toggleESP)
createButton("Speed Hack", toggleSpeed)
createButton("Infinity Jump", toggleInfJump)

-- Menü aç/kapa (sağ Ctrl)
local hiddenPosition = UDim2.new(1, 0, 0.2, 0)
local shownPosition = UDim2.new(1, -190, 0.2, 0)
Frame.Position = hiddenPosition

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        if Frame.Position == hiddenPosition then
            TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = shownPosition}):Play()
        else
            TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = hiddenPosition}):Play()
        end
    end
end)