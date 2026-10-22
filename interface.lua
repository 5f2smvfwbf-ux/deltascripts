-- interface.lua - ملف الواجهة الأساسية (النسخة المطورة بذكاء)
local BUTTONS_URL = "https://raw.githubusercontent.com/5f2smvfwbf-ux/deltascripts/main/buttons.lua"

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("MyCustomHub") then
    CoreGui.MyCustomHub:Destroy()
end

-- تحميل بيانات الأزرار
local success, buttonsData = pcall(function()
    local response = game:HttpGet(BUTTONS_URL)
    return loadstring(response)()
end)

if not success or not buttonsData then
    warn("فشل تحميل الأزرار من GitHub")
    buttonsData = {tabs = {}, buttons = {}}
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyCustomHub"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.Position = UDim2.new(0.05, 0, 0.1, 0)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "⚡"
ToggleButton.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleButton.TextSize = 20
ToggleButton.Draggable = true

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(1, 0)
UICornerBtn.Parent = ToggleButton

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 8)
UICornerMain.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 8)
UICornerTitle.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Size = UDim2.new(0.5, 0, 1, 0)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.Text = "لوحة السكربتات المجمعة"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Position = UDim2.new(1, -35, 0, 7)
CloseButton.Size = UDim2.new(0, 26, 0, 26)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local SettingsButton = Instance.new("TextButton")
SettingsButton.Parent = TitleBar
SettingsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SettingsButton.Position = UDim2.new(1, -70, 0, 7)
SettingsButton.Size = UDim2.new(0, 26, 0, 26)
SettingsButton.Font = Enum.Font.SourceSansBold
SettingsButton.Text = "⚙️"
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.TextSize = 13
Instance.new("UICorner", SettingsButton).CornerRadius = UDim.new(0, 6)

-- زر المهملات الجديد بجانب الإعدادات 🗑️
local TrashButton = Instance.new("TextButton")
TrashButton.Parent = TitleBar
TrashButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TrashButton.Position = UDim2.new(1, -105, 0, 7)
TrashButton.Size = UDim2.new(0, 26, 0, 26)
TrashButton.Font = Enum.Font.SourceSansBold
TrashButton.Text = "🗑️"
TrashButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TrashButton.TextSize = 13
Instance.new("UICorner", TrashButton).CornerRadius = UDim.new(0, 6)

local TabsBar = Instance.new("Frame")
TabsBar.Parent = MainFrame
TabsBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabsBar.Position = UDim2.new(0, 10, 0, 50)
TabsBar.Size = UDim2.new(1, -20, 0, 35)
TabsBar.BackgroundTransparency = 1

local UIListLayoutTabs = Instance.new("UIListLayout")
UIListLayoutTabs.Parent = TabsBar
UIListLayoutTabs.FillDirection = Enum.FillDirection.Horizontal
UIListLayoutTabs.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayoutTabs.Padding = UDim.new(0, 4)

local ContentContainer = Instance.new("Frame")
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 10, 0, 95)
ContentContainer.Size = UDim2.new(1, -20, 1, -105)

-- متغيرات البيانات المحلية (إضافة تاب المهملات تلقائياً إذا لم يكن موجوداً)
local tabNames = {"المهملات"}
local tabFrames = {}
local tabButtons = {}
local buttonsList = {}

for _, tabInfo in ipairs(buttonsData.tabs or {}) do
    if tabInfo.name ~= "المهملات" then
        table.insert(tabNames, tabInfo.name)
    end
end

for _, btnInfo in ipairs(buttonsData.buttons or {}) do
    table.insert(buttonsList, btnInfo)
end

local function refreshTabsLayout()
    for i, btn in ipairs(tabButtons) do
        btn.Size = UDim2.new(1 / math.max(#tabNames, 1), -4, 1, 0)
    end
end

-- إنشاء التابات
for i, name in ipairs(tabNames) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabsBar
    TabBtn.BackgroundColor3 = name == "المهملات" and Color3.fromRGB(60, 40, 40) or Color3.fromRGB(40, 40, 40)
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.Text = name == "المهملات" and "🗑️ المهملات" or name
    TabBtn.TextColor3 = name == "المهملات" and Color3.fromRGB(255, 150, 150) or Color3.fromRGB(200, 200, 200)
    TabBtn.TextSize = 12
    
    local UICornerTab = Instance.new("UICorner")
    UICornerTab.CornerRadius = UDim.new(0, 6)
    UICornerTab.Parent = TabBtn

    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Parent = ContentContainer
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabFrame.BorderSizePixel = 0
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabFrame.ScrollBarThickness = 4
    TabFrame.Visible = (i == 1)
    
    local UIListLayoutContent = Instance.new("UIListLayout")
    UIListLayoutContent.Parent = TabFrame
    UIListLayoutContent.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayoutContent.Padding = UDim.new(0, 5)

    local UICornerFrame = Instance.new("UICorner")
    UICornerFrame.CornerRadius = UDim.new(0, 6)
    UICornerFrame.Parent = TabFrame

    tabFrames[name] = TabFrame
    tabButtons[i] = TabBtn

    TabBtn.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do
            frame.Visible = false
        end
        TabFrame.Visible = true
    end)
end
refreshTabsLayout()

-- دالة إضافة زر
local function addScriptButton(parentTab, btnText, rawCode, orderNum, isTrash)
    local btn = Instance.new("TextButton")
    btn.Parent = parentTab
    btn.BackgroundColor3 = isTrash and Color3.fromRGB(50, 35, 35) or Color3.fromRGB(50, 50, 50)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = btnText
    btn.TextColor3 = isTrash and Color3.fromRGB(255, 180, 180) or Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.LayoutOrder = orderNum or 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local success2, err = pcall(function()
            local func = loadstring(rawCode)
            if func then func() end
        end)
        if not success2 then
            pcall(function()
                loadstring("return " .. rawCode)()
            end)
        end
    end)
    
    parentTab.CanvasSize = UDim2.new(0, 0, 0, #parentTab:GetChildren() * 40)
end

-- تركيب الأزرار
table.sort(buttonsList, function(a, b)
    if a.tab == b.tab then
        return (a.order or 0) < (b.order or 0)
    end
    return false
end)

for _, btnInfo in ipairs(buttonsList) do
    local targetTabName = btnInfo.tab
    if not tabFrames[targetTabName] then
        targetTabName = "المهملات" -- لو التاب غير موجود ينزل للمهملات تلقائياً
    end
    addScriptButton(tabFrames[targetTabName], btnInfo.name, btnInfo.code, btnInfo.order, targetTabName == "المهملات")
end

-- ==================== نافذة الاعدادات الأساسية ====================
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Parent = MainFrame
SettingsFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
SettingsFrame.BorderSizePixel = 0
SettingsFrame.Position = UDim2.new(0, 0, 0, 40)
SettingsFrame.Size = UDim2.new(1, 0, 1, -40)
SettingsFrame.Visible = false
SettingsFrame.ZIndex = 5

local SettingsTabsBar = Instance.new("Frame")
SettingsTabsBar.Parent = SettingsFrame
SettingsTabsBar.BackgroundTransparency = 1
SettingsTabsBar.Position = UDim2.new(0, 10, 0, 10)
SettingsTabsBar.Size = UDim2.new(1, -20, 0, 30)
SettingsTabsBar.ZIndex = 6

local STab1 = Instance.new("TextButton")
STab1.Parent = SettingsTabsBar
STab1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
STab1.Size = UDim2.new(0.5, -3, 1, 0)
STab1.Font = Enum.Font.SourceSansBold
STab1.Text = "إدارة التابات"
STab1.TextColor3 = Color3.fromRGB(255, 255, 255)
STab1.TextSize = 13
STab1.ZIndex = 6
Instance.new("UICorner", STab1).CornerRadius = UDim.new(0, 5)

local STab2 = Instance.new("TextButton")
STab2.Parent = SettingsTabsBar
STab2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
STab2.Position = UDim2.new(0.5, 3, 0, 0)
STab2.Size = UDim2.new(0.5, -3, 1, 0)
STab2.Font = Enum.Font.SourceSansBold
STab2.Text = "إدارة الأزرار والمهملات 🗑️"
STab2.TextColor3 = Color3.fromRGB(200, 200, 200)
STab2.TextSize = 12
STab2.ZIndex = 6
Instance.new("UICorner", STab2).CornerRadius = UDim.new(0, 5)

local SContent1 = Instance.new("ScrollingFrame")
SContent1.Parent = SettingsFrame
SContent1.BackgroundTransparency = 1
SContent1.Position = UDim2.new(0, 10, 0, 48)
SContent1.Size = UDim2.new(1, -20, 1, -105)
SContent1.Visible = true
SContent1.ZIndex = 6
SContent1.CanvasSize = UDim2.new(0, 0, 0, 400)
SContent1.ScrollBarThickness = 4

local SContent2 = Instance.new("ScrollingFrame")
SContent2.Parent = SettingsFrame
SContent2.BackgroundTransparency = 1
SContent2.Position = UDim2.new(0, 10, 0, 48)
SContent2.Size = UDim2.new(1, -20, 1, -105)
SContent2.Visible = false
SContent2.ZIndex = 6
SContent2.CanvasSize = UDim2.new(0, 0, 0, 600)
SContent2.ScrollBarThickness = 4

STab1.MouseButton1Click:Connect(function()
    STab1.BackgroundColor3 = Color3.fromRGB(50, 50, 50); STab1.TextColor3 = Color3.fromRGB(255, 255, 255)
    STab2.BackgroundColor3 = Color3.fromRGB(40, 40, 40); STab2.TextColor3 = Color3.fromRGB(200, 200, 200)
    SContent1.Visible = true; SContent2.Visible = false
end)

STab2.MouseButton1Click:Connect(function()
    STab2.BackgroundColor3 = Color3.fromRGB(50, 50, 50); STab2.TextColor3 = Color3.fromRGB(255, 255, 255)
    STab1.BackgroundColor3 = Color3.fromRGB(40, 40, 40); STab1.TextColor3 = Color3.fromRGB(200, 200, 200)
    SContent2.Visible = true; SContent1.Visible = false
end)

SettingsButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = not SettingsFrame.Visible
    SettingsButton.Text = SettingsFrame.Visible and "✖" or "⚙️"
end)

-- زر المهملات يفتح إعدادات إدارة الأزرار مباشرة
TrashButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = true
    STab2.BackgroundColor3 = Color3.fromRGB(50, 50, 50); STab2.TextColor3 = Color3.fromRGB(255, 255, 255)
    STab1.BackgroundColor3 = Color3.fromRGB(40, 40, 40); STab1.TextColor3 = Color3.fromRGB(200, 200, 200)
    SContent2.Visible = true; SContent1.Visible = false
    SettingsButton.Text = "✖"
end)

-- ==================== إدارة التابات ====================
local AddTabBtn = Instance.new("TextButton", SContent1)
AddTabBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
AddTabBtn.Size = UDim2.new(0.32, -4, 0, 35)
AddTabBtn.Font = Enum.Font.SourceSansBold
AddTabBtn.Text = "➕ إضافة تاب"
AddTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AddTabBtn.TextSize = 12
AddTabBtn.LayoutOrder = 1
AddTabBtn.ZIndex = 7
Instance.new("UICorner", AddTabBtn).CornerRadius = UDim.new(0, 6)

local DelTabBtn = Instance.new("TextButton", SContent1)
DelTabBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
DelTabBtn.Position = UDim2.new(0.34, 0, 0, 0)
DelTabBtn.Size = UDim2.new(0.32, -4, 0, 35)
DelTabBtn.Font = Enum.Font.SourceSansBold
DelTabBtn.Text = "🗑️ إزالة تاب"
DelTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DelTabBtn.TextSize = 12
DelTabBtn.LayoutOrder = 2
DelTabBtn.ZIndex = 7
Instance.new("UICorner", DelTabBtn).CornerRadius = UDim.new(0, 6)

local MoveTabBtn = Instance.new("TextButton", SContent1)
MoveTabBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
MoveTabBtn.Position = UDim2.new(0.68, 0, 0, 0)
MoveTabBtn.Size = UDim2.new(0.32, 0, 0, 35)
MoveTabBtn.Font = Enum.Font.SourceSansBold
MoveTabBtn.Text = "✏️ تعديل مكان"
MoveTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MoveTabBtn.TextSize = 12
MoveTabBtn.LayoutOrder = 3
MoveTabBtn.ZIndex = 7
Instance.new("UICorner", MoveTabBtn).CornerRadius = UDim.new(0, 6)

-- لوحات التحكم بالتابات
local AddTabPanel = Instance.new("Frame", SContent1)
AddTabPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AddTabPanel.Position = UDim2.new(0, 0, 0, 45)
AddTabPanel.Size = UDim2.new(1, 0, 0, 110)
AddTabPanel.Visible = false
AddTabPanel.LayoutOrder = 4
AddTabPanel.ZIndex = 7
Instance.new("UICorner", AddTabPanel).CornerRadius = UDim.new(0, 6)

local NewTabBox = Instance.new("TextBox", AddTabPanel)
NewTabBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
NewTabBox.Position = UDim2.new(0, 10, 0, 10)
NewTabBox.Size = UDim2.new(1, -20, 0, 30)
NewTabBox.PlaceholderText = "اكتب اسم التاب الجديد..."
NewTabBox.Text = ""
NewTabBox.TextColor3 = Color3.fromRGB(255, 255, 255)
NewTabBox.TextSize = 13
NewTabBox.ZIndex = 8
Instance.new("UICorner", NewTabBox).CornerRadius = UDim.new(0, 5)

local ConfirmAddTab = Instance.new("TextButton", AddTabPanel)
ConfirmAddTab.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ConfirmAddTab.Position = UDim2.new(0, 10, 0, 55)
ConfirmAddTab.Size = UDim2.new(1, -20, 0, 35)
ConfirmAddTab.Font = Enum.Font.SourceSansBold
ConfirmAddTab.Text = "تأكيد إضافة التاب"
ConfirmAddTab.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmAddTab.TextSize = 13
ConfirmAddTab.ZIndex = 8
Instance.new("UICorner", ConfirmAddTab).CornerRadius = UDim.new(0, 5)

AddTabBtn.MouseButton1Click:Connect(function() AddTabPanel.Visible = not AddTabPanel.Visible end)
ConfirmAddTab.MouseButton1Click:Connect(function()
    local name = NewTabBox.Text
    if name ~= "" and name ~= "المهملات" and not tabFrames[name] then
        table.insert(tabNames, name)
        local TabBtn = Instance.new("TextButton", TabsBar)
        TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabBtn.Font = Enum.Font.SourceSansBold
        TabBtn.Text = name
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.TextSize = 13
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

        local TabFrame = Instance.new("ScrollingFrame", ContentContainer)
        TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabFrame.BorderSizePixel = 0
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabFrame.ScrollBarThickness = 4
        TabFrame.Visible = false
        local UIListLayoutContent = Instance.new("UIListLayout", TabFrame)
        UIListLayoutContent.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayoutContent.Padding = UDim.new(0, 5)
        Instance.new("UICorner", TabFrame).CornerRadius = UDim.new(0, 6)

        tabFrames[name] = TabFrame
        table.insert(tabButtons, TabBtn)
        refreshTabsLayout()

        TabBtn.MouseButton1Click:Connect(function()
            for _, f in pairs(tabFrames) do f.Visible = false end
            TabFrame.Visible = true
        end)
        NewTabBox.Text = ""
        AddTabPanel.Visible = false
    end
end)

-- ==================== إدارة الأزرار والمهملات (الميزة الجديدة المطلوبة) ====================
local AddBtnOpt = Instance.new("TextButton", SContent2)
AddBtnOpt.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
AddBtnOpt.Size = UDim2.new(0.48, -3, 0, 35)
AddBtnOpt.Font = Enum.Font.SourceSansBold
AddBtnOpt.Text = "➕ إضافة زر جديد"
AddBtnOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
AddBtnOpt.TextSize = 12
AddBtnOpt.LayoutOrder = 1
AddBtnOpt.ZIndex = 7
Instance.new("UICorner", AddBtnOpt).CornerRadius = UDim.new(0, 6)

local DelBtnOpt = Instance.new("TextButton", SContent2)
DelBtnOpt.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
DelBtnOpt.Position = UDim2.new(0.52, 0, 0, 0)
DelBtnOpt.Size = UDim2.new(0.48, 0, 0, 35)
DelBtnOpt.Font = Enum.Font.SourceSansBold
DelBtnOpt.Text = "🗑️ حذف نهائي"
DelBtnOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
DelBtnOpt.TextSize = 12
DelBtnOpt.LayoutOrder = 2
DelBtnOpt.ZIndex = 7
Instance.new("UICorner", DelBtnOpt).CornerRadius = UDim.new(0, 6)

-- زر نقل الأزرار للمهملات (الذي طلبته في المنتصف) 🗑️
local MoveToTrashBtn = Instance.new("TextButton", SContent2)
MoveToTrashBtn.BackgroundColor3 = Color3.fromRGB(140, 80, 0)
MoveToTrashBtn.Position = UDim2.new(0, 0, 0, 45)
MoveToTrashBtn.Size = UDim2.new(1, 0, 0, 35)
MoveToTrashBtn.Font = Enum.Font.SourceSansBold
MoveToTrashBtn.Text = "📥 نقل الأزرار للمهملات 🗑️"
MoveToTrashBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MoveToTrashBtn.TextSize = 12
MoveToTrashBtn.LayoutOrder = 3
MoveToTrashBtn.ZIndex = 7
Instance.new("UICorner", MoveToTrashBtn).CornerRadius = UDim.new(0, 6)

-- أزرار تعديل المكان والكود
local MoveBtnOpt = Instance.new("TextButton", SContent2)
MoveBtnOpt.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
MoveBtnOpt.Position = UDim2.new(0, 0, 0, 90)
MoveBtnOpt.Size = UDim2.new(0.48, -3, 0, 35)
MoveBtnOpt.Font = Enum.Font.SourceSansBold
MoveBtnOpt.Text = "✏️ ترتيب الأزرار (جماعي)"
MoveBtnOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
MoveBtnOpt.TextSize = 12
MoveBtnOpt.LayoutOrder = 4
MoveBtnOpt.ZIndex = 7
Instance.new("UICorner", MoveBtnOpt).CornerRadius = UDim.new(0, 6)

local EditCodeBtnOpt = Instance.new("TextButton", SContent2)
EditCodeBtnOpt.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
EditCodeBtnOpt.Position = UDim2.new(0.52, 0, 0, 90)
EditCodeBtnOpt.Size = UDim2.new(0.48, 0, 0, 35)
EditCodeBtnOpt.Font = Enum.Font.SourceSansBold
EditCodeBtnOpt.Text = "🔄 تعديل كود زر"
EditCodeBtnOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
EditCodeBtnOpt.TextSize = 12
EditCodeBtnOpt.LayoutOrder = 5
EditCodeBtnOpt.ZIndex = 7
Instance.new("UICorner", EditCodeBtnOpt).CornerRadius = UDim.new(0, 6)

-- ==================== لوحة نقل الأزرار للمهملات (الذكية والجماعية) ====================
local TrashPanel = Instance.new("Frame", SContent2)
TrashPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
TrashPanel.Position = UDim2.new(0, 0, 0, 135)
TrashPanel.Size = UDim2.new(1, 0, 0, 180)
TrashPanel.Visible = false
TrashPanel.LayoutOrder = 6
TrashPanel.ZIndex = 7
Instance.new("UICorner", TrashPanel).CornerRadius = UDim.new(0, 6)

local TrashInfoLabel = Instance.new("TextLabel", TrashPanel)
TrashInfoLabel.BackgroundTransparency = 1
TrashInfoLabel.Position = UDim2.new(0, 10, 0, 10)
TrashInfoLabel.Size = UDim2.new(1, -20, 0, 30)
TrashInfoLabel.Font = Enum.Font.SourceSansBold
TrashInfoLabel.Text = "اكتب اسم التاب واسم الزر لنقله للمهملات:"
TrashInfoLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
TrashInfoLabel.TextSize = 12
TrashInfoLabel.TextXAlignment = Enum.TextXAlignment.Left

local TrashTabBox = Instance.new("TextBox", TrashPanel)
TrashTabBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TrashTabBox.Position = UDim2.new(0, 10, 0, 45)
TrashTabBox.Size = UDim2.new(1, -20, 0, 30)
TrashTabBox.PlaceholderText = "اسم التاب الحالي للزر..."
TrashTabBox.Text = ""
TrashTabBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TrashTabBox.TextSize = 12
TrashTabBox.ZIndex = 8
Instance.new("UICorner", TrashTabBox).CornerRadius = UDim.new(0, 5)

local TrashNameBox = Instance.new("TextBox", TrashPanel)
TrashNameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TrashNameBox.Position = UDim2.new(0, 10, 0, 85)
TrashNameBox.Size = UDim2.new(1, -20, 0, 30)
TrashNameBox.PlaceholderText = "اسم الزر المراد نقله للمهملات..."
TrashNameBox.Text = ""
TrashNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TrashNameBox.TextSize = 12
TrashNameBox.ZIndex = 8
Instance.new("UICorner", TrashNameBox).CornerRadius = UDim.new(0, 5)

local ConfirmTrashBtn = Instance.new("TextButton", TrashPanel)
ConfirmTrashBtn.BackgroundColor3 = Color3.fromRGB(180, 100, 0)
ConfirmTrashBtn.Position = UDim2.new(0, 10, 0, 125)
ConfirmTrashBtn.Size = UDim2.new(1, -20, 0, 35)
ConfirmTrashBtn.Font = Enum.Font.SourceSansBold
ConfirmTrashBtn.Text = "تأكيد النقل للمهملات 🗑️"
ConfirmTrashBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmTrashBtn.TextSize = 12
ConfirmTrashBtn.ZIndex = 8
Instance.new("UICorner", ConfirmTrashBtn).CornerRadius = UDim.new(0, 5)

MoveToTrashBtn.MouseButton1Click:Connect(function()
    TrashPanel.Visible = not TrashPanel.Visible
end)

ConfirmTrashBtn.MouseButton1Click:Connect(function()
    local tName = TrashTabBox.Text
    local bName = TrashNameBox.Text
    if tName ~= "" and bName ~= "" then
        for _, b in ipairs(buttonsList) do
            if b.name == bName and b.tab == tName then
                b.tab = "المهملات" -- نقله فعلياً لتاب المهملات في البيانات
                break
            end
        end
        TrashTabBox.Text = ""
        TrashNameBox.Text = ""
        TrashPanel.Visible = false
        -- إعادة تحميل التابات والواجهة لتحديث الأماكن
    end
end)

-- ==================== زر نسخ كل التابات والأزرار (لحفظ التعديلات لجيت هاب) ====================
local CopyAllBtn = Instance.new("TextButton", SettingsFrame)
CopyAllBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
CopyAllBtn.Position = UDim2.new(0, 10, 1, -45)
CopyAllBtn.Size = UDim2.new(1, -20, 0, 35)
CopyAllBtn.Font = Enum.Font.SourceSansBold
CopyAllBtn.Text = "📋 نسخ كافة التابات والأزرار لتحديث GitHub"
CopyAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyAllBtn.TextSize = 12
CopyAllBtn.ZIndex = 6
Instance.new("UICorner", CopyAllBtn).CornerRadius = UDim.new(0, 6)

CopyAllBtn.MouseButton1Click:Connect(function()
    if not setclipboard then return end
    
    local code = "-- ملف الأزرار والتابات\nreturn {\n    tabs = {\n"
    for i, tName in ipairs(tabNames) do
        if tName ~= "المهملات" then
            code = code .. '        {name = "' .. tName .. '", order = ' .. i .. '},\n'
        end
    end
    code = code .. "    },\n\n    buttons = {\n"
    
    for _, b in ipairs(buttonsList) do
        code = code .. "        {\n"
        code = code .. '            name = "' .. b.name .. '",\n'
        code = code .. '            tab = "' .. b.tab .. '",\n'
        code = code .. "            order = " .. (b.order or 1) .. ",\n"
        code = code .. "            code = [[" .. b.code .. "]]\n"
        code = code .. "        },\n"
    end
    code = code .. "    }\n}\n"
    
    setclipboard(code)
    CopyAllBtn.Text = "✅ تم النسخ! الصقه في buttons.lua"
    CopyAllBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    task.wait(3)
    CopyAllBtn.Text = "📋 نسخ كافة التابات والأزرار لتحديث GitHub"
    CopyAllBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
end)

-- فتح وإغلاق القائمة الرئيسية
local isOpen = false
ToggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
end)
