-- interface.lua - ملف الواجهة الأساسية (النسخة المرتبة والجاهزة)
local BUTTONS_URL = "https://raw.githubusercontent.com/5f2smvfwbf-ux/deltascripts/main/buttons.lua"

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("MyCustomHub") then
    CoreGui.MyCustomHub:Destroy()
end

local success, buttonsData = pcall(function()
    local response = game:HttpGet(BUTTONS_URL)
    return loadstring(response)()
end)

if not success or not buttonsData then
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
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Size = UDim2.new(0.5, 0, 1, 0)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.Text = "لوحة السكربتات الذكية"
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

-- زر المهملات المستقل بجانب الإعدادات 🗑️
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

-- نافذة المهملات المستقلة والمنفردة
local TrashWindow = Instance.new("Frame", MainFrame)
TrashWindow.BackgroundColor3 = Color3.fromRGB(25, 22, 22)
TrashWindow.Position = UDim2.new(0, 0, 0, 40)
TrashWindow.Size = UDim2.new(1, 0, 1, -40)
TrashWindow.Visible = false
TrashWindow.ZIndex = 10

local TrashTitle = Instance.new("TextLabel", TrashWindow)
TrashTitle.BackgroundTransparency = 1
TrashTitle.Position = UDim2.new(0, 15, 0, 10)
TrashTitle.Size = UDim2.new(1, -30, 0, 30)
TrashTitle.Font = Enum.Font.SourceSansBold
TrashTitle.Text = "🗑️ قائمة المهملات (الأزرار غير المستخدمة)"
TrashTitle.TextColor3 = Color3.fromRGB(255, 150, 150)
TrashTitle.TextSize = 14
TrashTitle.TextXAlignment = Enum.TextXAlignment.Left

local TrashScroll = Instance.new("ScrollingFrame", TrashWindow)
TrashScroll.BackgroundTransparency = 1
TrashScroll.Position = UDim2.new(0, 10, 0, 50)
TrashScroll.Size = UDim2.new(1, -20, 1, -60)
TrashScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
TrashScroll.ScrollBarThickness = 4
local TrashLayout = Instance.new("UIListLayout", TrashScroll)
TrashLayout.SortOrder = Enum.SortOrder.LayoutOrder
TrashLayout.Padding = UDim.new(0, 5)

TrashButton.MouseButton1Click:Connect(function()
    TrashWindow.Visible = not TrashWindow.Visible
    SettingsFrame.Visible = false
end)

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

local tabNames = {}
local tabFrames = {}
local tabButtons = {}
local buttonsList = {}

for _, tabInfo in ipairs(buttonsData.tabs or {}) do
    table.insert(tabNames, tabInfo.name)
end

for _, btnInfo in ipairs(buttonsData.buttons or {}) do
    table.insert(buttonsList, btnInfo)
end

local function refreshTabsLayout()
    for i, btn in ipairs(tabButtons) do
        btn.Size = UDim2.new(1 / math.max(#tabNames, 1), -4, 1, 0)
    end
end

for i, name in ipairs(tabNames) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabsBar
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextSize = 13
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

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
    Instance.new("UICorner", TabFrame).CornerRadius = UDim.new(0, 6)

    tabFrames[name] = TabFrame
    tabButtons[i] = TabBtn

    TabBtn.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do frame.Visible = false end
        TabFrame.Visible = true
        TrashWindow.Visible = false
    end)
end
refreshTabsLayout()

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
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        pcall(function()
            local func = loadstring(rawCode)
            if func then func() end
        end)
    end)
    
    parentTab.CanvasSize = UDim2.new(0, 0, 0, #parentTab:GetChildren() * 40)
end

table.sort(buttonsList, function(a, b)
    if a.tab == b.tab then
        return (a.order or 0) < (b.order or 0)
    end
    return false
end)

for _, btnInfo in ipairs(buttonsList) do
    if btnInfo.tab == "المهملات" then
        addScriptButton(TrashScroll, btnInfo.name, btnInfo.code, btnInfo.order)
    elseif tabFrames[btnInfo.tab] then
        addScriptButton(tabFrames[btnInfo.tab], btnInfo.name, btnInfo.code, btnInfo.order)
    end
end

-- نافذة الإعدادات
local SettingsFrame = Instance.new("Frame", MainFrame)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
SettingsFrame.BorderSizePixel = 0
SettingsFrame.Position = UDim2.new(0, 0, 0, 40)
SettingsFrame.Size = UDim2.new(1, 0, 1, -40)
SettingsFrame.Visible = false
SettingsFrame.ZIndex = 5

local SettingsLabel = Instance.new("TextLabel", SettingsFrame)
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Position = UDim2.new(0, 15, 0, 20)
SettingsLabel.Size = UDim2.new(1, -30, 0, 30)
SettingsLabel.Font = Enum.Font.SourceSansBold
SettingsLabel.Text = "⚙️ لوحة الإعدادات العامة"
SettingsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsLabel.TextSize = 15
SettingsLabel.TextXAlignment = Enum.TextXAlignment.Left

SettingsButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = not SettingsFrame.Visible
    SettingsButton.Text = SettingsFrame.Visible and "✖" or "⚙️"
    TrashWindow.Visible = false
end)

-- زر النسخ الشامل لحفظ التعديلات وجيت هاب
local CopyAllBtn = Instance.new("TextButton", SettingsFrame)
CopyAllBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
CopyAllBtn.Position = UDim2.new(0, 10, 1, -55)
CopyAllBtn.Size = UDim2.new(1, -20, 0, 40)
CopyAllBtn.Font = Enum.Font.SourceSansBold
CopyAllBtn.Text = "📋 نسخ كافة التابات والأزرار لتحديث GitHub"
CopyAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyAllBtn.TextSize = 13
CopyAllBtn.ZIndex = 6
Instance.new("UICorner", CopyAllBtn).CornerRadius = UDim.new(0, 6)

CopyAllBtn.MouseButton1Click:Connect(function()
    if not setclipboard then return end
    local code = "-- ملف الأزرار والتابات\nreturn {\n    tabs = {\n"
    for i, tName in ipairs(tabNames) do
        code = code .. '        {name = "' .. tName .. '", order = ' .. i .. '},\n'
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
    CopyAllBtn.Text = "✅ تم النسخ بنجاح!"
    task.wait(2)
    CopyAllBtn.Text = "📋 نسخ كافة التابات والأزرار لتحديث GitHub"
end)

local isOpen = false
ToggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
end)
