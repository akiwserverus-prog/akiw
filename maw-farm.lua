-- AKIW AUTO FARM PRO - PROFESSIONAL MODERN GUI
local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")
local plr = Players.LocalPlayer
local pgui = plr:WaitForChild("PlayerGui")

if pgui:FindFirstChild("AKIW_HUB") then pgui.AKIW_HUB:Destroy() end

SubagentsShellTerminalsescshow inactive ctrl+atabs ←/→… Switch agent… One-shot answer from the session's context without adding to the conversation… Change working directory… Clear session… Compact session… Connect an integration… Switch session… Copy last assistant message… View debug info… Open diff viewer… Open editor… Switch model variant… Exit the app… Export session transcript… Fork session… keep working until an objective is met [pause|resume|clear]… Help… Show release highlights… guided AGENTS.md setup… MCP servers… Switch model… New session… Open session or project… Pair device… Plugins… Open session or project… Open session or project… Exit the app… Exit the app… Reload configuration… Rename session… Restart service… Switch session… review changes [commit|branch|pr], defaults to uncommitted… Switch session… Open settings… Skills… Usage statistics… View status… New terminal… Switch theme… Switch model variant… Jump to message… Undo previous message… Update OpenCode… View usage… Switch model variant… Pair device… Manage workspaces-- ScreenGui Setup
local sg = Instance.new("ScreenGui")
sg.Name = "AKIW_HUB"
sg.ResetOnSpawn = falseBuild·ngodingmendangmending9router
sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
~sg.DisplayOrder = 9999
sg.Parent = pgui

-- Palette
local c = {
    bg = Color3.fromRGB(18, 18, 22),
    panel = Color3.fromRGB(26, 26, 32),
    sidebar = Color3.fromRGB(12, 12, 16),
    accent = Color3.fromRGB(0, 162, 255),
    text = Color3.fromRGB(245, 245, 250),
    textMuted = Color3.fromRGB(120, 120, 135),
    border = Color3.fromRGB(40, 40, 50)
}

local MAIN_FONT = Enum.Font.SourceSans
local BOLD_FONT = Enum.Font.SourceSansBold

-- Main Container
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 680, 0, 480)
main.Position = UDim2.new(0.5, -340, 0.5, -240)
main.BackgroundColor3 = c.bg
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = sg

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 1
mainStroke.Color = c.border
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Parent = main

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = c.panel
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ AKIW HUB"
title.TextColor3 = c.accent
title.TextSize = 18
title.Font = BOLD_FONT
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -42, 0.5, -16)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
closeBtn.Text = "✕"
closeBtn.TextColor3 = c.textMuted
closeBtn.TextSize = 14
closeBtn.Font = BOLD_FONT
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 60, 0, 390)
sidebar.Position = UDim2.new(0, 10, 0, 60)
sidebar.BackgroundColor3 = c.sidebar
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 10)
sideCorner.Parent = sidebar

local tabs = {}
local activeTab = nil
local tabData = {
    {icon = "⚔️", name = "Combat"},
    {icon = "📍", name = "Teleport"},
    {icon = "⛏️", name = "Mining"},
    {icon = "🌿", name = "Gathering"},
    {icon = "📦", name = "Pickup"},
    {icon = "🌌", name = "WildQi"},
    {icon = "🗺️", name = "Map"}
}

for i, t in ipairs(tabData) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 40, 0, 40)
    btn.Position = UDim2.new(0.5, -20, 0, 10 + (i-1) * 52)
    btn.BackgroundColor3 = i == 1 and c.accent or c.panel
    btn.Text = t.icon
    btn.TextColor3 = i == 1 and c.text or c.textMuted
    btn.TextSize = 16
    btn.Font = MAIN_FONT
    btn.Parent = sidebar

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    local tabView = Instance.new("Frame")
    tabView.Name = t.name .. "View"
    tabView.Size = UDim2.new(1, -90, 0, 390)
    tabView.Position = UDim2.new(0, 80, 0, 60)
    tabView.BackgroundTransparency = 1
    tabView.Visible = i == 1
    tabView.Parent = main

    btn.MouseButton1Click:Connect(function()
        if activeTab then 
            activeTab.btn.BackgroundColor3 = c.panel
            activeTab.btn.TextColor3 = c.textMuted
            activeTab.view.Visible = false
        end
        tabView.Visible = true
        activeTab = {btn = btn, view = tabView}
        btn.BackgroundColor3 = c.accent
        btn.TextColor3 = c.text
    end)
    if i == 1 then activeTab = {btn = btn, view = tabView} end
    table.insert(tabs, {btn = btn, view = tabView, name = t.name})
end

-- Data
local BossList = {"All Bosses", "Abbot Wuxin", "Black Tiger King, Lord of the Black Wind Fortress", "Crimson Moon Priestess", "Foreman Gou", "Grey Fang", "Gu Mingfeng, the Corpse Daoist", "Hebo, the River Lord", "Hu Yaoji", "Iron-Beak Hou", "Jiao, the Flood Dragon", "Khan Temur", "Knife-Hand Lu", "Lei Wuji", "Mo Qingshan, the Deviated", "Old Scar Ma", "Old Scarback", "Qara Ashina", "Red Sail Mao", "Sunni, the Dragon King's Fifth Son", "Sword Wraith of Cloudbreak Peak", "Taotie, the Devouring Maw", "The Nameless General", "The Tiger Elder", "The Unburied General", "The Warden of the Heavenly River"}
local MobList = {"All Mobs", "Bandit Captain Ma", "Bandit Enforcer", "Bandit Swordsman", "Barrow Wight", "Beggars' Union Disciple", "Black Bear", "Black Cult Disciple", "Black Cult Elder", "Black Road Alliance Disciple", "Black Tiger Disciple", "Blight-Gullet Snapper", "Bone-Crusher Demon Ape", "Bronze Corpse", "Bronze Vault Guardian", "Buried Miner", "Caravan Master Hu", "Cave Crawler", "Corpse-Driver Acolyte", "Demonic Cult Zealot", "Dire Wolf", "Drunken Swordsman", "Elder of Mount Hua", "Emei Sect Disciple", "Fallen Monk", "Flood Dragon Pirate", "Gate-Pass Bandit", "Granny Wei", "Green Forest Thug", "Grey Wolf", "Heavenly Demon Cult Disciple", "Herb Gatherer", "Hopping Corpse", "Horse Herder", "Horse Thief", "Huo of the Left Fang", "Iron-Hide Qi Bear", "Iron-Shell Snapper", "Jade-Horn Gorer", "Jade-Horn Rhino", "Kong Wuya", "Kunlun Sect Disciple", "Lei of the Right Fang", "Longyuan Escort", "Marsh Snapper", "Maw-Spawn", "Mine Bandit", "Mount Hua Disciple", "Mount Hua Sect Disciple", "Mountain Brigand", "Mountain Tiger", "Nameless Tomb Guard", "Oj-Touched Wolf", "Outlaw Chief", "Pack Buffalo", "Petty Thief", "Qi-Burning Boar", "Qi-Deviated Madman", "Qi-Maddened Stalker", "Red Sail Raider", "Reed Serpent", "Relay Runner", "Renegade Disciple", "Restless Spirit", "River Buffalo", "Rock Golem", "Salt Trader", "Shaolin Temple Disciple", "Shield-Bearer of the Nameless Host", "Sichuan Tang Clan Disciple", "Sky-Burial Pilgrim", "Spearman of the Nameless Host", "Steppe Hunter", "Steppe Rider", "Steppe Wolf", "Tang Mo", "Tea Picker", "Tempered Demon Ape", "Tempered Stalker Alpha", "Tianshui Fishwife", "Travelling Merchant Qian", "Villager", "Wailing Shade", "Wandering Cultivator", "Wandering Swordsman", "Water Ghoul", "White-Striped Vault Tiger", "Wild Boar", "Wudang Sect Disciple", "Your Reflection", "Zhang Tieniu", "Zhenyuan Escort"}
local NpcTpList = {"All Locations", "Auctioneer Qian", "Beggars' Union Elder", "Beggar Boy Xiao", "Black Road Broker", "Blacksmith Old Pak", "Caravan Guard Bo", "Constable Captain Yun Baek", "Constable Tie", "Drunk Swordsman Ma", "Elder Zhou", "Emei Sword Nun", "Envoy Han Jingxu", "Fence Mo", "Ferryman Ou", "Granny Lian", "Granny Tsang", "Guarding Post", "Heavenly Demon Cult Envoy", "Hunter Gao", "Innkeeper Choi", "Kunlun Swordsman", "Little Mei", "Magistrate's Clerk Zhen", "Madam Hong", "Master Smith Ou", "Merchant Wang", "Oathkeeper Shi Wuyan", "Old Fisherman Lao", "Old Woman Guo", "Parrying Post", "Pill Master Yao", "Porter Dong", "Prize-Keeper Lu", "Registrar Wen", "Rice Merchant Fu", "Riddle-Keeper Su", "Salt Merchant Hu", "Scholar Bai", "Storyteller Wu", "Tailor Mei", "Tea Girl Lan", "The Old Wayfarer", "Town Crier Liu", "Training Post", "Wandering Swordsman Ling", "Waiter Xiao Er", "Weaver Jin", "Wu the Younger", "Alliance Clerk Han", "Apprentice Gu"}
local MineList = {"All Ores", "Copper Ore", "Iron Ore", "Qi Crystal Shard", "Spirit Jade Shard"}
local GatherList = {"All Plants", "Bamboo Shoot", "Cloudcap Mushroom", "Crimson Lotus", "Frost Moss", "Heavenly Snow Lotus", "Jade-Dew Grass", "Moonshade Orchid", "Mountain Ginseng", "Purple Wild Qi", "Spirit Grass", "Spirit Rice", "Sunfire Blossom", "Thunderstruck Root", "Vein-Bloom Orchid", "Wild Ginger"}
local PickList = {"All Items", "Five Tigers Door-Breaking Saber", "Jade Headband — low-grade", "Steamed Bun", "Tiger Fur Collar — low-grade"}
local QiSpotList = {"QiSpot_QingyunGarden", "QiSpot_EastfieldShrine", "QiSpot_SouthbrookShrine", "QiSpot_West_SunkenPagoda", "QiSpot_West_WillowShrine", "QiSpot_West_MonkHermitage"}

_G.SelectedBoss = "All Bosses"
_G.SelectedMob = "All Mobs"
_G.SelectedTp = "All Locations"
_G.SelectedMine = "All Ores"
_G.SelectedGather = "All Plants"
_G.SelectedPick = "All Items"
_G.SelectedQiSpot = "QiSpot_QingyunGarden"

_G.fk = false
_G.autoMine = false
_G.autoGather = false
_G.autoPick = false
_G.autoCultivate = false
_G.Skills = {Z=false, X=false, C=false, V=false, ["9"]=false, ["8"]=false, ["7"]=false, ["6"]=false}

-- UI Helpers
local function createSection(parent, title, pos, size)
    local section = Instance.new("Frame")
    section.Size = size
    section.Position = pos
    section.BackgroundColor3 = c.panel
    section.BorderSizePixel = 0
    section.Parent = parent

    local secCorner = Instance.new("UICorner")
    secCorner.CornerRadius = UDim.new(0, 8)
    secCorner.Parent = section

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -16, 0, 28)
    titleLbl.Position = UDim2.new(0, 8, 0, 4)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = c.text
    titleLbl.TextSize = 13
    titleLbl.Font = BOLD_FONT
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = section

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -16, 1, -36)
    content.Position = UDim2.new(0, 8, 0, 32)
    content.BackgroundTransparency = 1
    content.Parent = section
    return content
end

local function createDropdown(parent, y, label, options, selectedVar)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 50)
    container.Position = UDim2.new(0, 0, 0, y)
    container.BackgroundTransparency = 1
    container.ZIndex = 10
    container.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 16)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = c.textMuted
    lbl.TextSize = 10
    lbl.Font = MAIN_FONT
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container

    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.new(1, 0, 0, 30)
    dropBtn.Position = UDim2.new(0, 0, 0, 18)
    dropBtn.BackgroundColor3 = c.bg
    dropBtn.TextColor3 = c.text
    dropBtn.TextSize = 12
    dropBtn.Font = MAIN_FONT
    dropBtn.Text = "  " .. _G[selectedVar]
    dropBtn.TextXAlignment = Enum.TextXAlignment.Left
    dropBtn.ZIndex = 11
    dropBtn.Parent = container

    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 6)
    dropCorner.Parent = dropBtn

    local isOpen = false
    local listContainer = nil

    dropBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            listContainer = Instance.new("ScrollingFrame")
            listContainer.Size = UDim2.new(1, 0, 0, 200)
            listContainer.Position = UDim2.new(0, 0, 0, 52)
            listContainer.BackgroundColor3 = c.panel
            listContainer.BorderSizePixel = 0
            listContainer.ZIndex = 100
            listContainer.ScrollBarThickness = 6
            listContainer.ScrollBarImageColor3 = c.accent
            listContainer.CanvasSize = UDim2.new(0, 0, 0, #options * 28)
            listContainer.TopImage = ""
            listContainer.BottomImage = ""
            listContainer.MidImage = ""
            listContainer.Parent = container

            local layout = Instance.new("UIListLayout")
            layout.Padding = UDim.new(0, 1)
            layout.FillDirection = Enum.FillDirection.Vertical
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Parent = listContainer

            for i, opt in ipairs(options) do
                local optBtn = Instance.new("TextButton")
                optBtn.Size = UDim2.new(1, -8, 0, 26)
                optBtn.BackgroundColor3 = c.panel
                optBtn.TextColor3 = c.text
                optBtn.TextSize = 11
                optBtn.Font = MAIN_FONT
                optBtn.Text = "  " .. opt
                optBtn.TextXAlignment = Enum.TextXAlignment.Left
                optBtn.ZIndex = 101
                optBtn.LayoutOrder = i
                optBtn.Parent = listContainer
                
                optBtn.MouseEnter:Connect(function()
                    optBtn.BackgroundColor3 = c.accent
                end)
                optBtn.MouseLeave:Connect(function()
                    optBtn.BackgroundColor3 = c.panel
                end)
                
                optBtn.MouseButton1Click:Connect(function()
                    _G[selectedVar] = opt
                    dropBtn.Text = "  " .. opt
                    isOpen = false
                    listContainer:Destroy()
                    listContainer = nil
                end)
            end
        elseif listContainer then
            listContainer:Destroy()
            listContainer = nil
        end
    end)
    return container
end

local function createToggle(parent, y, label, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 32)
    container.Position = UDim2.new(0, 0, 0, y)
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    local toggleBg = Instance.new("TextButton")
    toggleBg.Size = UDim2.new(0, 40, 0, 20)
    toggleBg.Position = UDim2.new(1, -45, 0.5, -10)
    toggleBg.BackgroundColor3 = c.bg
    toggleBg.Text = ""
    toggleBg.Parent = container

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 10)
    toggleCorner.Parent = toggleBg

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -50, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = c.text
    lbl.TextSize = 12
    lbl.Font = MAIN_FONT
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container

    local isOn = false
    toggleBg.MouseButton1Click:Connect(function()
        isOn = not isOn
        toggleBg.BackgroundColor3 = isOn and c.accent or c.bg
        callback(isOn)
    end)
end

local function createButton(parent, y, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Position = UDim2.new(0, 0, 0, y)
    btn.BackgroundColor3 = c.accent
    btn.TextColor3 = c.text
    btn.TextSize = 13
    btn.Font = BOLD_FONT
    btn.Text = text
    btn.Parent = parent

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- TAB 1: COMBAT
local combatView = tabs[1].view
local cLeftTop = createSection(combatView, "🎯 Target Selection", UDim2.new(0,0,0,0), UDim2.new(0.48, 0, 0, 150))
local cLeftBot = createSection(combatView, "⚔️ Kill Aura", UDim2.new(0,0,0,160), UDim2.new(0.48, 0, 0, 80))
local cRight = createSection(combatView, "⚡ Auto Skills", UDim2.new(0.52,0,0,0), UDim2.new(0.48, 0, 0, 310))

createDropdown(cLeftTop, 0, "BOSS TARGET", BossList, "SelectedBoss")
createDropdown(cLeftTop, 60, "MOB TARGET", MobList, "SelectedMob")
createToggle(cLeftBot, 0, "Float Kill Aura", function(v) _G.fk = v end)

local skillKeys = {"Z", "X", "C", "V", "9", "8", "7", "6"}
for i, k in ipairs(skillKeys) do
    createToggle(cRight, (i - 1) * 35, "Skill " .. k, function(v) _G.Skills[k] = v end)
end

-- TAB 2: TELEPORT
local tpView = tabs[2].view
local tpLeft = createSection(tpView, "📍 Location", UDim2.new(0,0,0,0), UDim2.new(0.48, 0, 0, 120))
local tpRight = createSection(tpView, "⚡ Quick Access", UDim2.new(0.52,0,0,0), UDim2.new(0.48, 0, 0, 280))

createDropdown(tpLeft, 0, "SELECT TARGET", NpcTpList, "SelectedTp")
createButton(tpRight, 0, "Teleport Now", function()
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local targetName = _G.SelectedTp
        if targetName == "All Locations" then return end
        for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
            if obj:IsA("Model") and obj ~= char and obj.Name == targetName and obj:FindFirstChild("HumanoidRootPart") then
                hrp.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                break
            end
        end
    end
end)

createButton(tpRight, 45, "Go to West Region (+18km East)", function()
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local qingyun = nil
        for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
            if obj:IsA("Model") and obj ~= char and (string.lower(obj.Name):find("qingyun") or string.lower(obj.Name):find("town")) and obj:FindFirstChild("HumanoidRootPart") then
                qingyun = obj.HumanoidRootPart
                break
            end
        end
        
        if qingyun then
            hrp.CFrame = qingyun.CFrame + Vector3.new(18000, 5, 0)
        else
            hrp.CFrame = hrp.CFrame + Vector3.new(18000, 5, 0)
        end
    end
end)

createButton(tpRight, 90, "Go to Pill Seller", function()
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local found = false
        for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
            if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("HumanoidRootPart") then
                if string.lower(obj.Name):find("pill") and string.lower(obj.Name):find("seller") then
                    hrp.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    found = true
                    break
                end
            end
        end
        if not found then warn("Pill Seller not found") end
    end
end)

createButton(tpRight, 135, "Go to Blacksmith", function()
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
            if obj:IsA("Model") and obj ~= char and string.find(obj.Name, "Smith") and obj:FindFirstChild("HumanoidRootPart") then
                hrp.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                break
            end
        end
    end
end)

createButton(tpRight, 180, "Go to Merchant", function()
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
            if obj:IsA("Model") and obj ~= char and string.find(obj.Name, "Merchant") and obj:FindFirstChild("HumanoidRootPart") then
                hrp.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                break
            end
        end
    end
end)

-- TAB 3: MINING
local mView = tabs[3].view
local mLeft = createSection(mView, "⛏️ Ore", UDim2.new(0,0,0,0), UDim2.new(0.48, 0, 0, 120))
local mRight = createSection(mView, "⚡ Auto", UDim2.new(0.52,0,0,0), UDim2.new(0.48, 0, 0, 120))
createDropdown(mLeft, 0, "SELECT ORE", MineList, "SelectedMine")
createToggle(mRight, 0, "Auto Mine", function(v) _G.autoMine = v end)

-- TAB 4: GATHERING
local gView = tabs[4].view
local gLeft = createSection(gView, "🌿 Plant", UDim2.new(0,0,0,0), UDim2.new(0.48, 0, 0, 120))
local gRight = createSection(gView, "⚡ Auto", UDim2.new(0.52,0,0,0), UDim2.new(0.48, 0, 0, 120))
createDropdown(gLeft, 0, "SELECT PLANT", GatherList, "SelectedGather")
createToggle(gRight, 0, "Auto Gather", function(v) _G.autoGather = v end)

-- TAB 5: PICKUP
local pView = tabs[5].view
local pLeft = createSection(pView, "📦 Item", UDim2.new(0,0,0,0), UDim2.new(0.48, 0, 0, 120))
local pRight = createSection(pView, "⚡ Auto", UDim2.new(0.52,0,0,0), UDim2.new(0.48, 0, 0, 120))
createDropdown(pLeft, 0, "SELECT ITEM", PickList, "SelectedPick")
createToggle(pRight, 0, "Auto Pickup", function(v) _G.autoPick = v end)

-- TAB 6: WILD QI
local qView = tabs[6].view
local qLeft = createSection(qView, "🌌 Qi Spot", UDim2.new(0,0,0,0), UDim2.new(0.48, 0, 0, 120))
local qRight = createSection(qView, "⚡ Auto", UDim2.new(0.52,0,0,0), UDim2.new(0.48, 0, 0, 120))
createDropdown(qLeft, 0, "SELECT QI SPOT", QiSpotList, "SelectedQiSpot")
createToggle(qRight, 0, "Auto Cultivate (+15 float)", function(v) _G.autoCultivate = v end)

-- TAB 7: MAP
local mapView = tabs[7].view
local mapSection = createSection(mapView, "🗺️ Region Teleport", UDim2.new(0,0,0,0), UDim2.new(1, 0, 0, 280))

local regions = {
    {name = "Qingyun Garden", x = 0, y = 0},
    {name = "West Region", x = 1, y = 0},
    {name = "Eastfield Shrine", x = 0, y = 1},
    {name = "Southbrook Shrine", x = 1, y = 1}
}

for i, reg in ipairs(regions) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.48, 0, 0, 110)
    btn.Position = UDim2.new(reg.x * 0.52, 0, reg.y * 0.52, reg.y * 120)
    btn.BackgroundColor3 = c.panel
    btn.TextColor3 = c.text
    btn.TextSize = 13
    btn.Font = BOLD_FONT
    btn.Text = reg.name
    btn.Parent = mapSection
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Thickness = 1
    btnStroke.Color = c.border
    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    btnStroke.Parent = btn
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = c.accent
        btnStroke.Color = c.accent
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = c.panel
        btnStroke.Color = c.border
    end)
    
    btn.MouseButton1Click:Connect(function()
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            if reg.name == "West Region" then
                hrp.CFrame = hrp.CFrame + Vector3.new(18000, 5, 0)
            elseif reg.name == "Qingyun Garden" then
                for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if obj:IsA("Model") and obj ~= char and string.find(string.lower(obj.Name), "qingyun") and obj:FindFirstChild("HumanoidRootPart") then
                        hrp.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                        break
                    end
                end
            elseif reg.name == "Eastfield Shrine" then
                for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if obj.Name == "QiSpot_EastfieldShrine" and obj:FindFirstChild("Position") then
                        hrp.CFrame = CFrame.new(obj.Position.Value) + Vector3.new(0, 5, 0)
                        break
                    end
                end
            elseif reg.name == "Southbrook Shrine" then
                for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if obj.Name == "QiSpot_SouthbrookShrine" and obj:FindFirstChild("Position") then
                        hrp.CFrame = CFrame.new(obj.Position.Value) + Vector3.new(0, 5, 0)
                        break
                    end
                end
            end
        end
    end)
end

-- Logic Loops
local function chainLoop(toggleKey, selectedVar, keyword)
    task.spawn(function()
        local harvestedLocations = {}
        while true do
            if _G[toggleKey] then
                local char = plr.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local targetPrompt = nil
                    local targetPart = nil
                    local minDist = math.huge
                    local selected = _G[selectedVar] or "All"
                    for _, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                        if v:IsA("ProximityPrompt") and string.find(string.lower(v.ActionText), keyword) then
                            local model = v:FindFirstAncestorOfClass("Model") or v.Parent
                            local objName = v.ObjectText ~= "" and v.ObjectText or model.Name
                            if selected:find("All") or string.lower(objName):find(string.lower(selected)) then
                                local part = v.Parent:IsA("BasePart") and v.Parent or model:FindFirstChildWhichIsA("BasePart")
                                if part then
                                    local locKey = tostring(part.Position)
                                    if not harvestedLocations[locKey] then
                                        local dist = (hrp.Position - part.Position).Magnitude
                                        if dist < minDist then minDist = dist; targetPrompt = v; targetPart = part end
                                    end
                                end
                            end
                        end
                    end
                    if targetPrompt and targetPart then
                        local locKey = tostring(targetPart.Position)
                        hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.2)
                        if fireproximityprompt then fireproximityprompt(targetPrompt)
                        else pcall(function() game:GetService("ReplicatedStorage").Remotes.Interact:FireServer(targetPrompt.Parent) end) end
                        task.wait(targetPrompt.HoldDuration + 0.5)
                        harvestedLocations[locKey] = true
                    else
                        harvestedLocations = {}
                        task.wait(0.5)
                    end
                end
            else harvestedLocations = {} end
            task.wait(0.1)
        end
    end)
end

chainLoop("autoMine", "SelectedMine", "mine")
chainLoop("autoGather", "SelectedGather", "gather")
chainLoop("autoPick", "SelectedPick", "pick")

task.spawn(function()
    while true do
        if _G.autoCultivate then
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and char:FindFirstChild("Humanoid") then
                local qiSpot = nil
                for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if obj.Name == _G.SelectedQiSpot and obj:FindFirstChild("Position") then
                        qiSpot = obj
                        break
                    end
                end
                if qiSpot then
                    char.Humanoid.PlatformStand = true
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.CFrame = CFrame.new(qiSpot.Position.Value + Vector3.new(0, 15, 0))
                    task.wait(0.1)
                else
                    warn("QiSpot not found:", _G.SelectedQiSpot)
                end
            end
        else
            local char = plr.Character
            if char and char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    local lockedTarget = nil
    while true do
        if _G.fk then
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and char:FindFirstChild("Humanoid") then
                char.Humanoid.PlatformStand = true
                hrp.AssemblyLinearVelocity = Vector3.zero
                
                if lockedTarget and lockedTarget:FindFirstChild("Humanoid") and lockedTarget.Humanoid.Health > 0 then
                    -- keep locked target
                elseif lockedTarget and (not lockedTarget:FindFirstChild("Humanoid") or lockedTarget.Humanoid.Health <= 0) then
                    -- target died, retreat to safe zone
                    hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0)
                    task.wait(1)
                    lockedTarget = nil
                else
                    -- find new target
                    local wantBoss = _G.SelectedBoss ~= "All Bosses"
                    local wantMob = _G.SelectedMob ~= "All Mobs"
                    if wantBoss then
                        for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                            if obj:IsA("Model") and obj ~= char and obj.Name == _G.SelectedBoss and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
                                lockedTarget = obj; break
                            end
                        end
                    elseif wantMob then
                        for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                            if obj:IsA("Model") and obj ~= char and obj.Name == _G.SelectedMob and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
                                lockedTarget = obj; break
                            end
                        end
                    else
                        local minDist = math.huge
                        for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                            if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") and obj.Humanoid.Health > 0 then
                                local d = (hrp.Position - obj.HumanoidRootPart.Position).Magnitude
                                if d < minDist then minDist = d; lockedTarget = obj end
                            end
                        end
                    end
                end
                
                if lockedTarget and lockedTarget:FindFirstChild("HumanoidRootPart") then
                    hrp.CFrame = CFrame.lookAt(lockedTarget.HumanoidRootPart.Position + Vector3.new(0, 8.5, 0), lockedTarget.HumanoidRootPart.Position)
                    pcall(function() 
                        game:GetService("ReplicatedStorage").Remotes.CombatInput:FireServer()
                        for k, v in pairs(_G.Skills) do if v then VIM:SendKeyEvent(true, Enum.KeyCode[k], false, game) end end
                    end)
                end
            end
        else
            lockedTarget = nil
            local char = plr.Character
            if char and char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end
        end
        task.wait(0.05)
    end
end)

print("[AKIW] Hub Ready")
