-- interface.lua - ملف الواجهة الأساسية
-- يقرأ الأزرار من buttons.lua على GitHub

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
TitleText.Size = UDim2.new(0.6, 0, 1, 0)
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

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 6)
UICornerClose.Parent = CloseButton

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

local UICornerSettings = Instance.new("UICorner")
UICornerSettings.CornerRadius = UDim.new(0, 6)
UICornerSettings.Parent = SettingsButton

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

-- متغيرات البيانات المحلية
local tabNames = {}
local tabFrames = {}
local tabButtons = {}
local buttonsList = {}

-- تحميل التابات من البيانات
for _, tabInfo in ipairs(buttonsData.tabs or {}) do
    table.insert(tabNames, tabInfo.name)
end

-- تحميل الأزرار
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
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextSize = 13
    
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
local function addScriptButton(parentTab, btnText, rawCode, orderNum)
    local btn = Instance.new("TextButton")
    btn.Parent = parentTab
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = btnText
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.LayoutOrder = orderNum or 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local success2, err = pcall(function()
            local func = loadstring(rawCode)
            if func then
                func()
            end
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
    if tabFrames[btnInfo.tab] then
        addScriptButton(tabFrames[btnInfo.tab], btnInfo.name, btnInfo.code, btnInfo.order)
    end
end
-- ==================== نافذة الاعدادات ====================
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
local c1 = Instance.new("UICorner"); c1.CornerRadius = UDim.new(0, 5); c1.Parent = STab1

local STab2 = Instance.new("TextButton")
STab2.Parent = SettingsTabsBar
STab2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
STab2.Position = UDim2.new(0.5, 3, 0, 0)
STab2.Size = UDim2.new(0.5, -3, 1, 0)
STab2.Font = Enum.Font.SourceSansBold
STab2.Text = "إدارة الأزرار"
STab2.TextColor3 = Color3.fromRGB(200, 200, 200)
STab2.TextSize = 13
STab2.ZIndex = 6
local c2 = Instance.new("UICorner"); c2.CornerRadius = UDim.new(0, 5); c2.Parent = STab2

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
SContent2.CanvasSize = UDim2.new(0, 0, 0, 500)
SContent2.ScrollBarThickness = 4

STab1.MouseButton1Click:Connect(function()
    STab1.BackgroundColor3 = Color3.fromRGB(50, 50, 50); STab1.TextColor3 = Color3.fromRGB(255, 255, 255)
    STab2.BackgroundColor3 = Color3.fromRGB(40, 40, 40); STab2.TextColor3 = Color3.fromRGB(200, 200, 200)
    SContent1.Visible = true
    SContent2.Visible = false
end)

STab2.MouseButton1Click:Connect(function()
    STab2.BackgroundColor3 = Color3.fromRGB(50, 50, 50); STab2.TextColor3 = Color3.fromRGB(255, 255, 255)
    STab1.BackgroundColor3 = Color3.fromRGB(40, 40, 40); STab1.TextColor3 = Color3.fromRGB(200, 200, 200)
    SContent2.Visible = true
    SContent1.Visible = false
end)

SettingsButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = not SettingsFrame.Visible
    SettingsButton.Text = SettingsFrame.Visible and "✖" or "⚙️"
end)

-- ==================== تاب إدارة التابات ====================
-- زر إضافة تاب
local AddTabBtn = Instance.new("TextButton")
AddTabBtn.Parent = SContent1
AddTabBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
AddTabBtn.Size = UDim2.new(0.32, -4, 0, 35)
AddTabBtn.Font = Enum.Font.SourceSansBold
AddTabBtn.Text = "➕ إضافة تاب"
AddTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AddTabBtn.TextSize = 12
AddTabBtn.LayoutOrder = 1
AddTabBtn.ZIndex = 7
local ac1 = Instance.new("UICorner"); ac1.CornerRadius = UDim.new(0, 6); ac1.Parent = AddTabBtn

-- زر إزالة تاب
local DelTabBtn = Instance.new("TextButton")
DelTabBtn.Parent = SContent1
DelTabBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
DelTabBtn.Position = UDim2.new(0.34, 0, 0, 0)
DelTabBtn.Size = UDim2.new(0.32, -4, 0, 35)
DelTabBtn.Font = Enum.Font.SourceSansBold
DelTabBtn.Text = "🗑️ إزالة تاب"
DelTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DelTabBtn.TextSize = 12
DelTabBtn.LayoutOrder = 2
DelTabBtn.ZIndex = 7
local ac2 = Instance.new("UICorner"); ac2.CornerRadius = UDim.new(0, 6); ac2.Parent = DelTabBtn

-- زر تعديل مكان تاب
local MoveTabBtn = Instance.new("TextButton")
MoveTabBtn.Parent = SContent1
MoveTabBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
MoveTabBtn.Position = UDim2.new(0.68, 0, 0, 0)
MoveTabBtn.Size = UDim2.new(0.32, 0, 0, 35)
MoveTabBtn.Font = Enum.Font.SourceSansBold
MoveTabBtn.Text = "✏️ تعديل مكان"
MoveTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MoveTabBtn.TextSize = 12
MoveTabBtn.LayoutOrder = 3
MoveTabBtn.ZIndex = 7
local ac3 = Instance.new("UICorner"); ac3.CornerRadius = UDim.new(0, 6); ac3.Parent = MoveTabBtn

-- لوحة إضافة تاب
local AddTabPanel = Instance.new("Frame")
AddTabPanel.Parent = SContent1
AddTabPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AddTabPanel.Position = UDim2.new(0, 0, 0, 45)
AddTabPanel.Size = UDim2.new(1, 0, 0, 110)
AddTabPanel.Visible = false
AddTabPanel.LayoutOrder = 4
AddTabPanel.ZIndex = 7
local atc = Instance.new("UICorner"); atc.CornerRadius = UDim.new(0, 6); atc.Parent = AddTabPanel

local NewTabBox = Instance.new("TextBox")
NewTabBox.Parent = AddTabPanel
NewTabBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
NewTabBox.Position = UDim2.new(0, 10, 0, 10)
NewTabBox.Size = UDim2.new(1, -20, 0, 30)
NewTabBox.Font = Enum.Font.SourceSans
NewTabBox.PlaceholderText = "اكتب اسم التاب الجديد..."
NewTabBox.Text = ""
NewTabBox.TextColor3 = Color3.fromRGB(255, 255, 255)
NewTabBox.TextSize = 13
NewTabBox.ZIndex = 8
local ntc = Instance.new("UICorner"); ntc.CornerRadius = UDim.new(0, 5); ntc.Parent = NewTabBox

local ConfirmAddTab = Instance.new("TextButton")
ConfirmAddTab.Parent = AddTabPanel
ConfirmAddTab.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ConfirmAddTab.Position = UDim2.new(0, 10, 0, 55)
ConfirmAddTab.Size = UDim2.new(1, -20, 0, 35)
ConfirmAddTab.Font = Enum.Font.SourceSansBold
ConfirmAddTab.Text = "تأكيد إضافة التاب"
ConfirmAddTab.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmAddTab.TextSize = 13
ConfirmAddTab.ZIndex = 8
local catc = Instance.new("UICorner"); catc.CornerRadius = UDim.new(0, 5); catc.Parent = ConfirmAddTab

-- لوحة إزالة تاب
local DelTabPanel = Instance.new("Frame")
DelTabPanel.Parent = SContent1
DelTabPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DelTabPanel.Position = UDim2.new(0, 0, 0, 45)
DelTabPanel.Size = UDim2.new(1, 0, 0, 110)
DelTabPanel.Visible = false
DelTabPanel.LayoutOrder = 5
DelTabPanel.ZIndex = 7
local dtc = Instance.new("UICorner"); dtc.CornerRadius = UDim.new(0, 6); dtc.Parent = DelTabPanel

local DelTabBox = Instance.new("TextBox")
DelTabBox.Parent = DelTabPanel
DelTabBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
DelTabBox.Position = UDim2.new(0, 10, 0, 10)
DelTabBox.Size = UDim2.new(1, -20, 0, 30)
DelTabBox.Font = Enum.Font.SourceSans
DelTabBox.PlaceholderText = "اكتب اسم التاب المراد حذفه..."
DelTabBox.Text = ""
DelTabBox.TextColor3 = Color3.fromRGB(255, 255, 255)
DelTabBox.TextSize = 13
DelTabBox.ZIndex = 8
local dtbc = Instance.new("UICorner"); dtbc.CornerRadius = UDim.new(0, 5); dtbc.Parent = DelTabBox

local ConfirmDelTab = Instance.new("TextButton")
ConfirmDelTab.Parent = DelTabPanel
ConfirmDelTab.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ConfirmDelTab.Position = UDim2.new(0, 10, 0, 55)
ConfirmDelTab.Size = UDim2.new(1, -20, 0, 35)
ConfirmDelTab.Font = Enum.Font.SourceSansBold
ConfirmDelTab.Text = "تأكيد إزالة التاب"
ConfirmDelTab.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmDelTab.TextSize = 13
ConfirmDelTab.ZIndex = 8
local cdtc = Instance.new("UICorner"); cdtc.CornerRadius = UDim.new(0, 5); cdtc.Parent = ConfirmDelTab

-- لوحة تعديل مكان تاب
local MoveTabPanel = Instance.new("Frame")
MoveTabPanel.Parent = SContent1
MoveTabPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MoveTabPanel.Position = UDim2.new(0, 0, 0, 45)
MoveTabPanel.Size = UDim2.new(1, 0, 0, 150)
MoveTabPanel.Visible = false
MoveTabPanel.LayoutOrder = 6
MoveTabPanel.ZIndex = 7
local mtc = Instance.new("UICorner"); mtc.CornerRadius = UDim.new(0, 6); mtc.Parent = MoveTabPanel

local MoveTabNameBox = Instance.new("TextBox")
MoveTabNameBox.Parent = MoveTabPanel
MoveTabNameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MoveTabNameBox.Position = UDim2.new(0, 10, 0, 10)
MoveTabNameBox.Size = UDim2.new(1, -20, 0, 30)
MoveTabNameBox.Font = Enum.Font.SourceSans
MoveTabNameBox.PlaceholderText = "اسم التاب المراد نقله..."
MoveTabNameBox.Text = ""
MoveTabNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MoveTabNameBox.TextSize = 13
MoveTabNameBox.ZIndex = 8
local mtnc = Instance.new("UICorner"); mtnc.CornerRadius = UDim.new(0, 5); mtnc.Parent = MoveTabNameBox

local MoveTabNumBox = Instance.new("TextBox")
MoveTabNumBox.Parent = MoveTabPanel
MoveTabNumBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MoveTabNumBox.Position = UDim2.new(0, 10, 0, 50)
MoveTabNumBox.Size = UDim2.new(1, -20, 0, 30)
MoveTabNumBox.Font = Enum.Font.SourceSans
MoveTabNumBox.PlaceholderText = "الرقم الجديد (1، 2، 3...)..."
MoveTabNumBox.Text = ""
MoveTabNumBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MoveTabNumBox.TextSize = 13
MoveTabNumBox.ZIndex = 8
local mtnbc = Instance.new("UICorner"); mtnbc.CornerRadius = UDim.new(0, 5); mtnbc.Parent = MoveTabNumBox

local ConfirmMoveTab = Instance.new("TextButton")
ConfirmMoveTab.Parent = MoveTabPanel
ConfirmMoveTab.BackgroundColor3 = Color3.fromRGB(0, 100, 180)
ConfirmMoveTab.Position = UDim2.new(0, 10, 0, 95)
ConfirmMoveTab.Size = UDim2.new(1, -20, 0, 35)
ConfirmMoveTab.Font = Enum.Font.SourceSansBold
ConfirmMoveTab.Text = "تأكيد نقل التاب"
ConfirmMoveTab.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmMoveTab.TextSize = 13
ConfirmMoveTab.ZIndex = 8
local cmtc = Instance.new("UICorner"); cmtc.CornerRadius = UDim.new(0, 5); cmtc.Parent = ConfirmMoveTab

-- ربط أزرار التابات
AddTabBtn.MouseButton1Click:Connect(function()
    AddTabPanel.Visible = true
    DelTabPanel.Visible = false
    MoveTabPanel.Visible = false
end)

DelTabBtn.MouseButton1Click:Connect(function()
    DelTabPanel.Visible = true
    AddTabPanel.Visible = false
    MoveTabPanel.Visible = false
end)

MoveTabBtn.MouseButton1Click:Connect(function()
    MoveTabPanel.Visible = true
    AddTabPanel.Visible = false
    DelTabPanel.Visible = false
end)

-- دالة إضافة تاب جديد
local function createNewTab(name, orderNum)
    if tabFrames[name] then return false end
    
    table.insert(tabNames, name)
    
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabsBar
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextSize = 13
    TabBtn.LayoutOrder = orderNum or #tabNames
    
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
    TabFrame.Visible = false
    
    local UIListLayoutContent = Instance.new("UIListLayout")
    UIListLayoutContent.Parent = TabFrame
    UIListLayoutContent.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayoutContent.Padding = UDim.new(0, 5)

    local UICornerFrame = Instance.new("UICorner")
    UICornerFrame.CornerRadius = UDim.new(0, 6)
    UICornerFrame.Parent = TabFrame

    tabFrames[name] = TabFrame
    table.insert(tabButtons, TabBtn)
    refreshTabsLayout()

    TabBtn.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do frame.Visible = false end
        TabFrame.Visible = true
    end)
    
    return true
end

ConfirmAddTab.MouseButton1Click:Connect(function()
    local name = NewTabBox.Text
    if name ~= "" and not tabFrames[name] then
        createNewTab(name, #tabNames + 1)
        -- إضافة التاب لجدول البيانات
        table.insert(buttonsData.tabs, {name = name, order = #buttonsData.tabs + 1})
        NewTabBox.Text = ""
        AddTabPanel.Visible = false
    end
end)

ConfirmDelTab.MouseButton1Click:Connect(function()
    local name = DelTabBox.Text
    if tabFrames[name] then
        tabFrames[name]:Destroy()
        tabFrames[name] = nil
        
        -- حذف أزرار التاب
        for i = #buttonsList, 1, -1 do
            if buttonsList[i].tab == name then
                table.remove(buttonsList, i)
            end
        end
        
        -- حذف التاب من البيانات
        for i = #buttonsData.tabs, 1, -1 do
            if buttonsData.tabs[i].name == name then
                table.remove(buttonsData.tabs, i)
                break
            end
        end
        
        -- حذف من القوائم
        for i, tName in ipairs(tabNames) do
            if tName == name then
                table.remove(tabNames, i)
                tabButtons[i]:Destroy()
                table.remove(tabButtons, i)
                break
            end
        end
        refreshTabsLayout()
        DelTabBox.Text = ""
        DelTabPanel.Visible = false
        if tabNames[1] then tabFrames[tabNames[1]].Visible = true end
    end
end)

ConfirmMoveTab.MouseButton1Click:Connect(function()
    local name = MoveTabNameBox.Text
    local num = tonumber(MoveTabNumBox.Text)
    if tabFrames[name] and num and num >= 1 and num <= #tabNames then
        -- نقل في tabNames
        local currentIndex = nil
        for i, tName in ipairs(tabNames) do
            if tName == name then
                currentIndex = i
                break
            end
        end
        if currentIndex then
            table.remove(tabNames, currentIndex)
            table.insert(tabNames, num, name)
            
            -- إعادة ترتيب الأزرار
            for i, tName in ipairs(tabNames) do
                for _, btn in ipairs(tabButtons) do
                    if btn.Text == tName then
                        btn.LayoutOrder = i
                        break
                    end
                end
            end
            
            -- تحديث في البيانات
            for _, tabInfo in ipairs(buttonsData.tabs) do
                if tabInfo.name == name then
                    tabInfo.order = num
                    break
                end
            end
            
            MoveTabNameBox.Text = ""
            MoveTabNumBox.Text = ""
            MoveTabPanel.Visible = false
        end
    end
end)
-- ==================== تاب إدارة الأزرار ====================
-- زر إضافة زر
local AddBtnOpt = Instance.new("TextButton")
AddBtnOpt.Parent = SContent2
AddBtnOpt.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
AddBtnOpt.Size = UDim2.new(0.48, -3, 0, 35)
AddBtnOpt.Font = Enum.Font.SourceSansBold
AddBtnOpt.Text = "➕ إضافة زر"
AddBtnOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
AddBtnOpt.TextSize = 12
AddBtnOpt.LayoutOrder = 1
AddBtnOpt.ZIndex = 7
local abo = Instance.new("UICorner"); abo.CornerRadius = UDim.new(0, 6); abo.Parent = AddBtnOpt

-- زر إزالة زر
local DelBtnOpt = Instance.new("TextButton")
DelBtnOpt.Parent = SContent2
DelBtnOpt.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
DelBtnOpt.Position = UDim2.new(0.52, 0, 0, 0)
DelBtnOpt.Size = UDim2.new(0.48, 0, 0, 35)
DelBtnOpt.Font = Enum.Font.SourceSansBold
DelBtnOpt.Text = "🗑️ إزالة زر"
DelBtnOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
DelBtnOpt.TextSize = 12
DelBtnOpt.LayoutOrder = 2
DelBtnOpt.ZIndex = 7
local dbo = Instance.new("UICorner"); dbo.CornerRadius = UDim.new(0, 6); dbo.Parent = DelBtnOpt

-- زر تعديل مكان زر
local MoveBtnOpt = Instance.new("TextButton")
MoveBtnOpt.Parent = SContent2
MoveBtnOpt.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
MoveBtnOpt.Position = UDim2.new(0, 0, 0, 45)
MoveBtnOpt.Size = UDim2.new(0.48, -3, 0, 35)
MoveBtnOpt.Font = Enum.Font.SourceSansBold
MoveBtnOpt.Text = "✏️ تعديل مكان"
MoveBtnOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
MoveBtnOpt.TextSize = 12
MoveBtnOpt.LayoutOrder = 3
MoveBtnOpt.ZIndex = 7
local mbo = Instance.new("UICorner"); mbo.CornerRadius = UDim.new(0, 6); mbo.Parent = MoveBtnOpt

-- زر تعديل كود زر
local EditCodeBtnOpt = Instance.new("TextButton")
EditCodeBtnOpt.Parent = SContent2
EditCodeBtnOpt.BackgroundColor3 = Color3.fromRGB(120, 80, 0)
EditCodeBtnOpt.Position = UDim2.new(0.52, 0, 0, 45)
EditCodeBtnOpt.Size = UDim2.new(0.48, 0, 0, 35)
EditCodeBtnOpt.Font = Enum.Font.SourceSansBold
EditCodeBtnOpt.Text = "🔄 تعديل كود"
EditCodeBtnOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
EditCodeBtnOpt.TextSize = 12
EditCodeBtnOpt.LayoutOrder = 4
EditCodeBtnOpt.ZIndex = 7
local ecbo = Instance.new("UICorner"); ecbo.CornerRadius = UDim.new(0, 6); ecbo.Parent = EditCodeBtnOpt

-- ==================== لوحة إضافة زر ====================
local AddBtnBoxPanel = Instance.new("Frame")
AddBtnBoxPanel.Parent = SContent2
AddBtnBoxPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
AddBtnBoxPanel.Position = UDim2.new(0, 0, 0, 90)
AddBtnBoxPanel.Size = UDim2.new(1, 0, 0, 210)
AddBtnBoxPanel.Visible = false
AddBtnBoxPanel.LayoutOrder = 5
AddBtnBoxPanel.ZIndex = 7
local abbp = Instance.new("UICorner"); abbp.CornerRadius = UDim.new(0, 6); abbp.Parent = AddBtnBoxPanel

local InBtnName = Instance.new("TextBox")
InBtnName.Parent = AddBtnBoxPanel
InBtnName.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
InBtnName.Position = UDim2.new(0, 10, 0, 10)
InBtnName.Size = UDim2.new(1, -20, 0, 30)
InBtnName.Font = Enum.Font.SourceSans
InBtnName.PlaceholderText = "اسم الزر..."
InBtnName.Text = ""
InBtnName.TextColor3 = Color3.fromRGB(255, 255, 255)
InBtnName.TextSize = 12
InBtnName.ZIndex = 8
local ibnc = Instance.new("UICorner"); ibnc.CornerRadius = UDim.new(0, 5); ibnc.Parent = InBtnName

local InBtnTab = Instance.new("TextBox")
InBtnTab.Parent = AddBtnBoxPanel
InBtnTab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
InBtnTab.Position = UDim2.new(0, 10, 0, 50)
InBtnTab.Size = UDim2.new(1, -20, 0, 30)
InBtnTab.Font = Enum.Font.SourceSans
InBtnTab.PlaceholderText = "اسم التاب..."
InBtnTab.Text = ""
InBtnTab.TextColor3 = Color3.fromRGB(255, 255, 255)
InBtnTab.TextSize = 12
InBtnTab.ZIndex = 8
local ibtc = Instance.new("UICorner"); ibtc.CornerRadius = UDim.new(0, 5); ibtc.Parent = InBtnTab

local InBtnScript = Instance.new("TextBox")
InBtnScript.Parent = AddBtnBoxPanel
InBtnScript.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
InBtnScript.Position = UDim2.new(0, 10, 0, 90)
InBtnScript.Size = UDim2.new(1, -20, 0, 60)
InBtnScript.Font = Enum.Font.SourceSans
InBtnScript.PlaceholderText = "الكود (loadstring أو كود مباشر)..."
InBtnScript.Text = ""
InBtnScript.TextColor3 = Color3.fromRGB(255, 255, 255)
InBtnScript.TextSize = 12
InBtnScript.TextWrapped = true
InBtnScript.ZIndex = 8
local ibsc = Instance.new("UICorner"); ibsc.CornerRadius = UDim.new(0, 5); ibsc.Parent = InBtnScript

local ConfirmAddBtn = Instance.new("TextButton")
ConfirmAddBtn.Parent = AddBtnBoxPanel
ConfirmAddBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ConfirmAddBtn.Position = UDim2.new(0, 10, 0, 160)
ConfirmAddBtn.Size = UDim2.new(1, -20, 0, 35)
ConfirmAddBtn.Font = Enum.Font.SourceSansBold
ConfirmAddBtn.Text = "تأكيد إضافة الزر"
ConfirmAddBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmAddBtn.TextSize = 12
ConfirmAddBtn.ZIndex = 8
local cabc = Instance.new("UICorner"); cabc.CornerRadius = UDim.new(0, 5); cabc.Parent = ConfirmAddBtn

-- ==================== لوحة إزالة زر ====================
local DelBtnBoxPanel = Instance.new("Frame")
DelBtnBoxPanel.Parent = SContent2
DelBtnBoxPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
DelBtnBoxPanel.Position = UDim2.new(0, 0, 0, 90)
DelBtnBoxPanel.Size = UDim2.new(1, 0, 0, 160)
DelBtnBoxPanel.Visible = false
DelBtnBoxPanel.LayoutOrder = 6
DelBtnBoxPanel.ZIndex = 7
local dbbp = Instance.new("UICorner"); dbbp.CornerRadius = UDim.new(0, 6); dbbp.Parent = DelBtnBoxPanel

local DelTargetTab = Instance.new("TextBox")
DelTargetTab.Parent = DelBtnBoxPanel
DelTargetTab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
DelTargetTab.Position = UDim2.new(0, 10, 0, 10)
DelTargetTab.Size = UDim2.new(1, -20, 0, 30)
DelTargetTab.Font = Enum.Font.SourceSans
DelTargetTab.PlaceholderText = "اسم التاب..."
DelTargetTab.Text = ""
DelTargetTab.TextColor3 = Color3.fromRGB(255, 255, 255)
DelTargetTab.TextSize = 12
DelTargetTab.ZIndex = 8
local dttc = Instance.new("UICorner"); dttc.CornerRadius = UDim.new(0, 5); dttc.Parent = DelTargetTab

local DelTargetName = Instance.new("TextBox")
DelTargetName.Parent = DelBtnBoxPanel
DelTargetName.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
DelTargetName.Position = UDim2.new(0, 10, 0, 50)
DelTargetName.Size = UDim2.new(1, -20, 0, 30)
DelTargetName.Font = Enum.Font.SourceSans
DelTargetName.PlaceholderText = "اسم الزر..."
DelTargetName.Text = ""
DelTargetName.TextColor3 = Color3.fromRGB(255, 255, 255)
DelTargetName.TextSize = 12
DelTargetName.ZIndex = 8
local dtnc = Instance.new("UICorner"); dtnc.CornerRadius = UDim.new(0, 5); dtnc.Parent = DelTargetName

local ConfirmDelBtn = Instance.new("TextButton")
ConfirmDelBtn.Parent = DelBtnBoxPanel
ConfirmDelBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ConfirmDelBtn.Position = UDim2.new(0, 10, 0, 100)
ConfirmDelBtn.Size = UDim2.new(1, -20, 0, 35)
ConfirmDelBtn.Font = Enum.Font.SourceSansBold
ConfirmDelBtn.Text = "تأكيد إزالة الزر"
ConfirmDelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmDelBtn.TextSize = 12
ConfirmDelBtn.ZIndex = 8
local cdbc = Instance.new("UICorner"); cdbc.CornerRadius = UDim.new(0, 5); cdbc.Parent = ConfirmDelBtn

-- ==================== لوحة تعديل مكان زر ====================
local MoveBtnBoxPanel = Instance.new("Frame")
MoveBtnBoxPanel.Parent = SContent2
MoveBtnBoxPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
MoveBtnBoxPanel.Position = UDim2.new(0, 0, 0, 90)
MoveBtnBoxPanel.Size = UDim2.new(1, 0, 0, 200)
MoveBtnBoxPanel.Visible = false
MoveBtnBoxPanel.LayoutOrder = 7
MoveBtnBoxPanel.ZIndex = 7
local mbbp = Instance.new("UICorner"); mbbp.CornerRadius = UDim.new(0, 6); mbbp.Parent = MoveBtnBoxPanel

local MoveBtnNameBox = Instance.new("TextBox")
MoveBtnNameBox.Parent = MoveBtnBoxPanel
MoveBtnNameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MoveBtnNameBox.Position = UDim2.new(0, 10, 0, 10)
MoveBtnNameBox.Size = UDim2.new(1, -20, 0, 30)
MoveBtnNameBox.Font = Enum.Font.SourceSans
MoveBtnNameBox.PlaceholderText = "اسم الزر..."
MoveBtnNameBox.Text = ""
MoveBtnNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MoveBtnNameBox.TextSize = 12
MoveBtnNameBox.ZIndex = 8
local mbnc = Instance.new("UICorner"); mbnc.CornerRadius = UDim.new(0, 5); mbnc.Parent = MoveBtnNameBox

local MoveBtnTabBox = Instance.new("TextBox")
MoveBtnTabBox.Parent = MoveBtnBoxPanel
MoveBtnTabBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MoveBtnTabBox.Position = UDim2.new(0, 10, 0, 50)
MoveBtnTabBox.Size = UDim2.new(1, -20, 0, 30)
MoveBtnTabBox.Font = Enum.Font.SourceSans
MoveBtnTabBox.PlaceholderText = "اسم التاب..."
MoveBtnTabBox.Text = ""
MoveBtnTabBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MoveBtnTabBox.TextSize = 12
MoveBtnTabBox.ZIndex = 8
local mbtc = Instance.new("UICorner"); mbtc.CornerRadius = UDim.new(0, 5); mbtc.Parent = MoveBtnTabBox

local MoveBtnNumBox = Instance.new("TextBox")
MoveBtnNumBox.Parent = MoveBtnBoxPanel
MoveBtnNumBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MoveBtnNumBox.Position = UDim2.new(0, 10, 0, 90)
MoveBtnNumBox.Size = UDim2.new(1, -20, 0, 30)
MoveBtnNumBox.Font = Enum.Font.SourceSans
MoveBtnNumBox.PlaceholderText = "الرقم الجديد..."
MoveBtnNumBox.Text = ""
MoveBtnNumBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MoveBtnNumBox.TextSize = 12
MoveBtnNumBox.ZIndex = 8
local mbtnc = Instance.new("UICorner"); mbtnc.CornerRadius = UDim.new(0, 5); mbtnc.Parent = MoveBtnNumBox

local ConfirmMoveBtn = Instance.new("TextButton")
ConfirmMoveBtn.Parent = MoveBtnBoxPanel
ConfirmMoveBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 180)
ConfirmMoveBtn.Position = UDim2.new(0, 10, 0, 140)
ConfirmMoveBtn.Size = UDim2.new(1, -20, 0, 35)
ConfirmMoveBtn.Font = Enum.Font.SourceSansBold
ConfirmMoveBtn.Text = "تأكيد نقل الزر"
ConfirmMoveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmMoveBtn.TextSize = 12
ConfirmMoveBtn.ZIndex = 8
local cmbc = Instance.new("UICorner"); cmbc.CornerRadius = UDim.new(0, 5); cmbc.Parent = ConfirmMoveBtn

-- ==================== لوحة تعديل كود زر ====================
local EditCodeBoxPanel = Instance.new("Frame")
EditCodeBoxPanel.Parent = SContent2
EditCodeBoxPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
EditCodeBoxPanel.Position = UDim2.new(0, 0, 0, 90)
EditCodeBoxPanel.Size = UDim2.new(1, 0, 0, 220)
EditCodeBoxPanel.Visible = false
EditCodeBoxPanel.LayoutOrder = 8
EditCodeBoxPanel.ZIndex = 7
local ecbp = Instance.new("UICorner"); ecbp.CornerRadius = UDim.new(0, 6); ecbp.Parent = EditCodeBoxPanel

local EditCodeNameBox = Instance.new("TextBox")
EditCodeNameBox.Parent = EditCodeBoxPanel
EditCodeNameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
EditCodeNameBox.Position = UDim2.new(0, 10, 0, 10)
EditCodeNameBox.Size = UDim2.new(1, -20, 0, 30)
EditCodeNameBox.Font = Enum.Font.SourceSans
EditCodeNameBox.PlaceholderText = "اسم الزر..."
EditCodeNameBox.Text = ""
EditCodeNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
EditCodeNameBox.TextSize = 12
EditCodeNameBox.ZIndex = 8
local ecnc = Instance.new("UICorner"); ecnc.CornerRadius = UDim.new(0, 5); ecnc.Parent = EditCodeNameBox

local EditCodeTabBox = Instance.new("TextBox")
EditCodeTabBox.Parent = EditCodeBoxPanel
EditCodeTabBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
EditCodeTabBox.Position = UDim2.new(0, 10, 0, 50)
EditCodeTabBox.Size = UDim2.new(1, -20, 0, 30)
EditCodeTabBox.Font = Enum.Font.SourceSans
EditCodeTabBox.PlaceholderText = "اسم التاب..."
EditCodeTabBox.Text = ""
EditCodeTabBox.TextColor3 = Color3.fromRGB(255, 255, 255)
EditCodeTabBox.TextSize = 12
EditCodeTabBox.ZIndex = 8
local ectc = Instance.new("UICorner"); ectc.CornerRadius = UDim.new(0, 5); ectc.Parent = EditCodeTabBox

local EditCodeNewBox = Instance.new("TextBox")
EditCodeNewBox.Parent = EditCodeBoxPanel
EditCodeNewBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
EditCodeNewBox.Position = UDim2.new(0, 10, 0, 90)
EditCodeNewBox.Size = UDim2.new(1, -20, 0, 60)
EditCodeNewBox.Font = Enum.Font.SourceSans
EditCodeNewBox.PlaceholderText = "الكود الجديد..."
EditCodeNewBox.Text = ""
EditCodeNewBox.TextColor3 = Color3.fromRGB(255, 255, 255)
EditCodeNewBox.TextSize = 12
EditCodeNewBox.TextWrapped = true
EditCodeNewBox.ZIndex = 8
local ecnbc = Instance.new("UICorner"); ecnbc.CornerRadius = UDim.new(0, 5); ecnbc.Parent = EditCodeNewBox

local ConfirmEditCode = Instance.new("TextButton")
ConfirmEditCode.Parent = EditCodeBoxPanel
ConfirmEditCode.BackgroundColor3 = Color3.fromRGB(180, 120, 0)
ConfirmEditCode.Position = UDim2.new(0, 10, 0, 160)
ConfirmEditCode.Size = UDim2.new(1, -20, 0, 35)
ConfirmEditCode.Font = Enum.Font.SourceSansBold
ConfirmEditCode.Text = "تأكيد تعديل الكود"
ConfirmEditCode.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmEditCode.TextSize = 12
ConfirmEditCode.ZIndex = 8
local cec = Instance.new("UICorner"); cec.CornerRadius = UDim.new(0, 5); cec.Parent = ConfirmEditCode

-- ربط أزرار الأزرار
AddBtnOpt.MouseButton1Click:Connect(function()
    AddBtnBoxPanel.Visible = not AddBtnBoxPanel.Visible
    DelBtnBoxPanel.Visible = false
    MoveBtnBoxPanel.Visible = false
    EditCodeBoxPanel.Visible = false
end)

DelBtnOpt.MouseButton1Click:Connect(function()
    DelBtnBoxPanel.Visible = not DelBtnBoxPanel.Visible
    AddBtnBoxPanel.Visible = false
    MoveBtnBoxPanel.Visible = false
    EditCodeBoxPanel.Visible = false
end)

MoveBtnOpt.MouseButton1Click:Connect(function()
    MoveBtnBoxPanel.Visible = not MoveBtnBoxPanel.Visible
    AddBtnBoxPanel.Visible = false
    DelBtnBoxPanel.Visible = false
    EditCodeBoxPanel.Visible = false
end)

EditCodeBtnOpt.MouseButton1Click:Connect(function()
    EditCodeBoxPanel.Visible = not EditCodeBoxPanel.Visible
    AddBtnBoxPanel.Visible = false
    DelBtnBoxPanel.Visible = false
    MoveBtnBoxPanel.Visible = false
end)

-- ==================== تنفيذ العمليات ====================
ConfirmAddBtn.MouseButton1Click:Connect(function()
    local bName = InBtnName.Text
    local tName = InBtnTab.Text
    local bScript = InBtnScript.Text
    if bName ~= "" and tabFrames[tName] and bScript ~= "" then
        local newOrder = 1
        for _, b in ipairs(buttonsList) do
            if b.tab == tName and (b.order or 0) >= newOrder then
                newOrder = (b.order or 0) + 1
            end
        end
        table.insert(buttonsList, {name = bName, tab = tName, order = newOrder, code = bScript})
        addScriptButton(tabFrames[tName], bName, bScript, newOrder)
        InBtnName.Text = ""
        InBtnTab.Text = ""
        InBtnScript.Text = ""
        AddBtnBoxPanel.Visible = false
    end
end)

ConfirmDelBtn.MouseButton1Click:Connect(function()
    local tName = DelTargetTab.Text
    local bName = DelTargetName.Text
    if tabFrames[tName] then
        for _, child in ipairs(tabFrames[tName]:GetChildren()) do
            if child:IsA("TextButton") and child.Text == bName then
                child:Destroy()
                break
            end
        end
        for i = #buttonsList, 1, -1 do
            if buttonsList[i].name == bName and buttonsList[i].tab == tName then
                table.remove(buttonsList, i)
                break
            end
        end
        DelTargetTab.Text = ""
        DelTargetName.Text = ""
        DelBtnBoxPanel.Visible = false
    end
end)

ConfirmMoveBtn.MouseButton1Click:Connect(function()
    local bName = MoveBtnNameBox.Text
    local tName = MoveBtnTabBox.Text
    local num = tonumber(MoveBtnNumBox.Text)
    if tabFrames[tName] and num then
        for _, child in ipairs(tabFrames[tName]:GetChildren()) do
            if child:IsA("TextButton") and child.Text == bName then
                child.LayoutOrder = num
                break
            end
        end
        for _, b in ipairs(buttonsList) do
            if b.name == bName and b.tab == tName then
                b.order = num
                break
            end
        end
        MoveBtnNameBox.Text = ""
        MoveBtnTabBox.Text = ""
        MoveBtnNumBox.Text = ""
        MoveBtnBoxPanel.Visible = false
    end
end)

ConfirmEditCode.MouseButton1Click:Connect(function()
    local bName = EditCodeNameBox.Text
    local tName = EditCodeTabBox.Text
    local newCode = EditCodeNewBox.Text
    if tabFrames[tName] and newCode ~= "" then
        for _, b in ipairs(buttonsList) do
            if b.name == bName and b.tab == tName then
                b.code = newCode
                break
            end
        end
        for _, child in ipairs(tabFrames[tName]:GetChildren()) do
            if child:IsA("TextButton") and child.Text == bName then
                local newBtn = child
                local newConnection
                newConnection = newBtn.MouseButton1Click:Connect(function() end)
                newConnection:Disconnect()
                
                for _, conn in pairs(getconnections(newBtn.MouseButton1Click)) do
                    conn:Disconnect()
                end
                
                newBtn.MouseButton1Click:Connect(function()
                    pcall(function()
                        loadstring(newCode)()
                    end)
                end)
                break
            end
        end
        EditCodeNameBox.Text = ""
        EditCodeTabBox.Text = ""
        EditCodeNewBox.Text = ""
        EditCodeBoxPanel.Visible = false
    end
end)

-- ==================== زر نسخ كل التابات والأزرار ====================
local CopyAllBtn = Instance.new("TextButton")
CopyAllBtn.Parent = SettingsFrame
CopyAllBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
CopyAllBtn.Position = UDim2.new(0, 10, 1, -45)
CopyAllBtn.Size = UDim2.new(1, -20, 0, 35)
CopyAllBtn.Font = Enum.Font.SourceSansBold
CopyAllBtn.Text = "📋 نسخ التابات والأزرار جميعها"
CopyAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyAllBtn.TextSize = 12
CopyAllBtn.ZIndex = 6
local cab = Instance.new("UICorner"); cab.CornerRadius = UDim.new(0, 6); cab.Parent = CopyAllBtn

CopyAllBtn.MouseButton1Click:Connect(function()
    if not setclipboard then return end
    
    local code = "-- ملف الأزرار والتابات\n"
    code = code .. "-- لا تعدل هذا الملف يدوياً — استخدم زر النسخ داخل السكربت\n\n"
    code = code .. "return {\n"
    code = code .. "    tabs = {\n"
    
    for i, tName in ipairs(tabNames) do
        code = code .. '        {name = "' .. tName .. '", order = ' .. i .. '}'
        if i < #tabNames then code = code .. "," end
        code = code .. "\n"
    end
    code = code .. "    },\n\n"
    code = code .. "    buttons = {\n"
    
    local lastTab = ""
    for _, b in ipairs(buttonsList) do
        if b.tab ~= lastTab then
            if lastTab ~= "" then code = code .. "\n" end
            code = code .. "        -- ==================== تاب " .. b.tab .. " ====================\n"
            lastTab = b.tab
        end
        code = code .. "        {\n"
        code = code .. '            name = "' .. b.name .. '",\n'
        code = code .. '            tab = "' .. b.tab .. '",\n'
        code = code .. "            order = " .. (b.order or 1) .. ",\n"
        code = code .. "            code = [[" .. b.code .. "]]\n"
        code = code .. "        },\n"
    end
    
    if #buttonsList > 0 then
        code = code:sub(1, -3)
        code = code .. "\n"
    end
    
    code = code .. "    }\n"
    code = code .. "}\n"
    
    setclipboard(code)
    CopyAllBtn.Text = "✅ تم النسخ! الصقه في buttons.lua على GitHub"
    CopyAllBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    task.wait(3)
    CopyAllBtn.Text = "📋 نسخ التابات والأزرار جميعها"
    CopyAllBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
end)

-- ==================== فتح وإغلاق القائمة ====================
local isOpen = false
ToggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
end)
