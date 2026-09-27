-- ملف الأزرار والتابات
-- لا تعدل هذا الملف يدوياً — استخدم زر النسخ داخل السكربت

return {
    tabs = {
        {name = "اللاعب", order = 1},
        {name = "ريموتات", order = 2},
        {name = "مهم", order = 3},
        {name = "عشوائي", order = 4}
    },

    buttons = {
        -- ==================== تاب اللاعب ====================
        {
            name = "الطيران",
            tab = "اللاعب",
            order = 1,
            code = [[loadstring(game:HttpGet("https://rawscripts.net/raw/free-HD-admin-hacker-island-Fly-V3-X-111485"))()]]
        },

        -- ==================== تاب مهم ====================
        {
            name = "Gui",
            tab = "مهم",
            order = 0,
            code = [[loadstring(game:HttpGet("https://pastebin.com/raw/JpxyApA7"))()]]
        },

        -- ==================== تاب عشوائي ====================
        {
            name = "ماب الكورة",
            tab = "عشوائي",
            order = 1,
            code = [[local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

local enabled = false
local hitboxSize = 12
local originalProperties = {}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TouchlineRedHitboxGui"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 130)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "هيدبوكس الكرة (أحمر)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.Text = "الحالة: مطفي (OFF)"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Parent = MainFrame

ToggleBtn.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        ToggleBtn.Text = "الحالة: شغال (ON)"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        ToggleBtn.Text = "الحالة: مطفي (OFF)"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        for ball, props in pairs(originalProperties) do
            if ball and ball.Parent then
                ball.Size = props.Size
                ball.Color = props.Color
                ball.Material = props.Material
                ball.Transparency = props.Transparency
            end
        end
        originalProperties = {}
    end
end)

local SizeBtn = Instance.new("TextButton")
SizeBtn.Size = UDim2.new(0.9, 0, 0, 35)
SizeBtn.Position = UDim2.new(0.05, 0, 0.68, 0)
SizeBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
SizeBtn.Text = "حجم الهيدبوكس: " .. hitboxSize
SizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SizeBtn.TextSize = 14
SizeBtn.Font = Enum.Font.SourceSansBold
SizeBtn.Parent = MainFrame

SizeBtn.MouseButton1Click:Connect(function()
    hitboxSize = hitboxSize + 5
    if hitboxSize > 35 then hitboxSize = 10 end
    SizeBtn.Text = "حجم الهيدبوكس: " .. hitboxSize
end)

RunService.RenderStepped:Connect(function()
    if not enabled then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name == "Ball" or obj.Name:lower():match("ball") or obj.Name:lower():match("كورة") or obj.Name:lower():match("كرة")) then
            if not originalProperties[obj] then
                originalProperties[obj] = {Size = obj.Size, Color = obj.Color, Material = obj.Material, Transparency = obj.Transparency}
            end
            obj.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
            obj.CanCollide = true
            obj.Color = Color3.fromRGB(255, 0, 0)
            obj.Material = Enum.Material.Neon
            obj.Transparency = 0.3
        end
    end
end)]]
        },
        {
            name = "Wars",
            tab = "عشوائي",
            order = 2,
            code = [[loadstring(game:HttpGet("https://pastebin.com/raw/KKw7Kedf"))()]]
        },
        {
            name = "تدبيل ارينا",
            tab = "عشوائي",
            order = 3,
            code = [[loadstring(game:HttpGet("https://pastebin.com/raw/df4BL9tb"))()]]
        },
        {
            name = "تليبورت",
            tab = "عشوائي",
            order = 4,
            code = [[local sg = Instance.new("ScreenGui", game.CoreGui)

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 160, 0, 160)
Main.Position = UDim2.new(0.05, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

local stroke = Instance.new("UIStroke", Main)
stroke.Color = Color3.fromRGB(0, 170, 255)
stroke.Thickness = 1.5

local title = Instance.new("TextLabel", Main)
title.Size = UDim2.new(1, 0, 0, 25)
title.Text = "TP MANAGER"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1

local savedPos = nil
local lp = game.Players.LocalPlayer

local btnSave = Instance.new("TextButton", Main)
btnSave.Size = UDim2.new(0.9, 0, 0, 35)
btnSave.Position = UDim2.new(0.05, 0, 0.2, 0)
btnSave.Text = "💾 حفظ الموقع"
btnSave.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btnSave.TextColor3 = Color3.new(1, 1, 1)
btnSave.Font = Enum.Font.Gotham
Instance.new("UICorner", btnSave)

local btnTp = Instance.new("TextButton", Main)
btnTp.Size = UDim2.new(0.9, 0, 0, 35)
btnTp.Position = UDim2.new(0.05, 0, 0.45, 0)
btnTp.Text = "🚀 انتقال للمحفوظ"
btnTp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btnTp.TextColor3 = Color3.new(1, 1, 1)
btnTp.Font = Enum.Font.Gotham
Instance.new("UICorner", btnTp)

local btnCopy = Instance.new("TextButton", Main)
btnCopy.Size = UDim2.new(0.9, 0, 0, 35)
btnCopy.Position = UDim2.new(0.05, 0, 0.7, 0)
btnCopy.Text = "📋 نسخ الإحداثيات"
btnCopy.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btnCopy.TextColor3 = Color3.new(1, 1, 1)
btnCopy.Font = Enum.Font.Gotham
Instance.new("UICorner", btnCopy)

btnSave.MouseButton1Click:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedPos = char.HumanoidRootPart.CFrame
        btnSave.Text = "✅ تم الحفظ!"
        task.wait(1)
        btnSave.Text = "💾 حفظ الموقع"
    end
end)

btnTp.MouseButton1Click:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") and savedPos then
        char.HumanoidRootPart.CFrame = savedPos
    else
        btnTp.Text = "❌ لا يوجد موقع!"
        task.wait(1)
        btnTp.Text = "🚀 انتقال للمحفوظ"
    end
end)

btnCopy.MouseButton1Click:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local pos = char.HumanoidRootPart.Position
        local coords = string.format("Vector3.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z)
        if setclipboard then
            setclipboard(coords)
            btnCopy.Text = "✅ تم النسخ!"
        else
            btnCopy.Text = "❌ جهازك لا يدعم النسخ"
        end
        task.wait(1)
        btnCopy.Text = "📋 نسخ الإحداثيات"
    end
end)]]
        },
        {
            name = "اظهار الشنطه",
            tab = "عشوائي",
            order = 5,
            code = [[local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)]]
        },
        {
            name = "ايم بوت",
            tab = "عشوائي",
            order = 6,
            code = [[if game.CoreGui:FindFirstChild("GeminiToggleGUI") then
    game.CoreGui.GeminiToggleGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICornerMain = Instance.new("UICorner")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "GeminiToggleGUI"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 175, 0, 92)
MainFrame.Active = true
MainFrame.Draggable = true

UICornerMain.CornerRadius = UDim.new(0, 8)
UICornerMain.Parent = MainFrame

TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
TopBar.Size = UDim2.new(1, 0, 0, 26)

Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.06, 0, 0, 0)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "GEMINI MENU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 10

CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseButton.Position = UDim2.new(1, -22, 0.5, -7)
CloseButton.Size = UDim2.new(0, 15, 0, 15)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 9

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ToggleButton.Position = UDim2.new(0.06, 0, 0.38, 0)
ToggleButton.Size = UDim2.new(0, 152, 0, 36)
ToggleButton.Font = Enum.Font.GothamSemibold
ToggleButton.Text = "  الإيم بوت: معطل"
ToggleButton.TextColor3 = Color3.fromRGB(180, 180, 195)
ToggleButton.TextSize = 10
ToggleButton.TextXAlignment = Enum.TextXAlignment.Left

local aimbotActive = false

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = not ScreenGui.Enabled
end)

ToggleButton.MouseButton1Click:Connect(function()
    aimbotActive = not aimbotActive
    if aimbotActive then
        ToggleButton.Text = "  الإيم بوت: مفعل"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 75, 40)
    else
        ToggleButton.Text = "  الإيم بوت: معطل"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotActive then
        local localPlayer = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        local nearestTarget = nil
        local shortestDistance = math.huge
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Head") then
                local sameTeam = false
                if player.Team and localPlayer.Team and player.Team == localPlayer.Team then
                    sameTeam = true
                end
                if not sameTeam then
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        local head = player.Character.Head
                        local distance = (head.Position - camera.CFrame.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            nearestTarget = head
                        end
                    end
                end
            end
        end
        if nearestTarget then
            camera.CFrame = CFrame.new(camera.CFrame.Position, nearestTarget.Position)
        end
    end
end)]]
        },

        -- ==================== تاب مهم ====================
        {
            name = "تغيير التيم",
            tab = "مهم",
            order = 1,
            code = [[loadstring(game:HttpGet("https://pastebin.com/raw/WsJAi93z"))()]]
        },
        {
            name = "اوتو كليك",
            tab = "مهم",
            order = 2,
            code = [[loadstring(game:HttpGet("https://pastebin.com/raw/eR1HPXfw"))()]]
        },
        {
            name = "هيد بوكس",
            tab = "مهم",
            order = 4,
            code = [[loadstring(game:HttpGet("https://pastebin.com/raw/NH2jfsuj"))()]]
        },

        -- ==================== تاب ريموتات ====================
        {
            name = "مصدر الريموتات",
            tab = "ريموتات",
            order = 1,
            code = [[loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Turtle-Spy-21930"))()]]
        },

        -- ==================== تاب اللاعب ====================
        {
            name = "السرعة",
            tab = "اللاعب",
            order = 2,
            code = [[loadstring(game:HttpGet("https://pastebin.com/raw/hsK3Dtij"))()]]
        },

        -- ==================== تاب مهم ====================
        {
            name = "هيتبوكس",
            tab = "مهم",
            order = 5,
            code = [[loadstring(game:HttpGet("https://pastebin.com/raw/XHCg7Xha"))()]]
        },

        -- ==================== تاب ريموتات ====================
        {
            name = "مصدر ريموتات 2",
            tab = "ريموتات",
            order = 3,
            code = [[loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Ketamine-46055"))()]]
        },

        -- ==================== تاب اللاعب ====================
        {
            name = "القفز",
            tab = "اللاعب",
            order = 3,
            code = [[loadstring(game:HttpGet("https://pastebin.com/raw/FqnLehSG"))()]]
        },

        -- ==================== تاب مهم ====================
        {
            name = "كشف",
            tab = "مهم",
            order = 3,
            code = [[loadstring(game:HttpGet("https://pastebin.com/raw/3QSEqEms"))()]]
        },
        {
            name = "Vr7",
            tab = "مهم",
            order = 6,
            code = [[loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-VR7-45290"))()]]
        },

        -- ==================== تاب ريموتات ====================
        {
            name = "اربيجي لوس تاون",
            tab = "ريموتات",
            order = 1,
            code = [[local args = {
    [1] = "Rocket Launcher",
    [2] = 0,
    n = 2,
}
game:GetService("ReplicatedStorage").SoobiaEvent:FireServer(unpack(args, 1, args.n or #args))]]
        },
        {
            name = "بحث ريموتات",
            tab = "ريموتات",
            order = 2,
            code = [[local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local SearchBox = Instance.new("TextBox", MainFrame)
local Scroll = Instance.new("ScrollingFrame", MainFrame)
local Layout = Instance.new("UIListLayout", Scroll)
local MenuBtn = Instance.new("TextButton", ScreenGui)

MainFrame.Size = UDim2.new(0, 280, 0, 350)
MainFrame.Position = UDim2.new(0.5, -140, 0.4, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Draggable = true 
MainFrame.Active = true
Instance.new("UICorner", MainFrame)

SearchBox.Size = UDim2.new(0.9, 0, 0, 35)
SearchBox.Position = UDim2.new(0.05, 0, 0.05, 0)
SearchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SearchBox.PlaceholderText = "ابحث عن ريموت لنسخ مساره..."
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", SearchBox)

Scroll.Size = UDim2.new(1, -10, 1, -60)
Scroll.Position = UDim2.new(0, 5, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 3
Layout.Padding = UDim.new(0, 5)

MenuBtn.Size = UDim2.new(0, 50, 0, 50)
MenuBtn.Position = UDim2.new(0, 10, 0.5, 0)
MenuBtn.Text = "SCAN"
MenuBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
MenuBtn.Draggable = true
Instance.new("UICorner", MenuBtn).CornerRadius = UDim.new(1, 0)
MenuBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local function GetFullName(obj)
    local path = obj.Name
    local parent = obj.Parent
    while parent and parent ~= game do
        path = parent.Name .. "." .. path
        parent = parent.Parent
    end
    return "game." .. path
end

local function AddRemoteBtn(remote)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Text = remote.Name
    btn.TextColor3 = Color3.fromRGB(255, 200, 0)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        local fullPath = GetFullName(remote)
        if setclipboard then
            setclipboard(fullPath)
            btn.Text = "تم النسخ! ✅"
            task.wait(1)
            btn.Text = remote.Name
        else
            print("المسار: " .. fullPath)
        end
    end)
end

local function UpdateSearch()
    for _, child in pairs(Scroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local searchText = SearchBox.Text:lower()
    for _, v in pairs(game:GetDescendants()) do
        if (v:IsA("RemoteEvent") or v:IsA("RemoteFunction")) then
            if searchText == "" or v.Name:lower():find(searchText) then
                AddRemoteBtn(v)
            end
        end
    end
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(UpdateSearch)
UpdateSearch()]]
        },
        {
            name = "كلاشنكوف لوس تاون",
            tab = "ريموتات",
            order = 2,
            code = [[local args = {
	[1] = "Kalashnikov",
	[2] = 0,
	n = 2,
}
game:GetService("ReplicatedStorage").SoobiaEvent:FireServer(unpack(args, 1, args.n or #args))]]
        },
        {
            name = "طلق لوس تاون",
            tab = "ريموتات",
            order = 4,
            code = [[local args = {
	[1] = "Ammo Box",
	[2] = 0,
	n = 2,
}
game:GetService("ReplicatedStorage").SoobiaEvent:FireServer(unpack(args, 1, args.n or #args))]]
        },
        {
            name = "كلبشة لوس تاون",
            tab = "ريموتات",
            order = 5,
            code = [[local args = {
	[1] = "Handcuffs",
	[2] = 0,
	n = 2,
}
game:GetService("ReplicatedStorage").SoobiaEvent:FireServer(unpack(args, 1, args.n or #args))]]
        },
        {
            name = "قرنيد لوس تاون",
            tab = "ريموتات",
            order = 6,
            code = [[local args = {
	[1] = "Grenade",
	[2] = 0,
	n = 2,
}
game:GetService("ReplicatedStorage").SoobiaEvent:FireServer(unpack(args, 1, args.n or #args))]]
        }
    }
}
