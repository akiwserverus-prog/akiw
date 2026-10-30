-- MAW AUTO FARM PRO - COMBAT BOSSES & MOBS (SORTED A-Z)
local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")
local plr = Players.LocalPlayer
local pgui = plr:WaitForChild("PlayerGui")

if pgui:FindFirstChild("MAW_HUB") then pgui.MAW_HUB:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = "MAW_HUB"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.DisplayOrder = 9999
sg.Parent = pgui

local BG_COLOR = Color3.fromRGB(15, 15, 18)
local PANEL_COLOR = Color3.fromRGB(24, 24, 28)
local SIDEBAR_COLOR = Color3.fromRGB(10, 10, 12)
local ACCENT_BLUE = Color3.fromRGB(0, 162, 255)
local TEXT_MAIN = Color3.fromRGB(240, 240, 240)
local TEXT_DARK = Color3.fromRGB(130, 130, 140)

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 620, 0, 420)
main.Position = UDim2.new(0.5, -310, 0.5, -210)
main.BackgroundColor3 = BG_COLOR
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = sg

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = main

local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 55, 1, 0)
sidebar.BackgroundColor3 = SIDEBAR_COLOR
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 8)
sideCorner.Parent = sidebar

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 50)
logo.BackgroundTransparency = 1
logo.Text = "⚡"
logo.TextColor3 = ACCENT_BLUE
logo.TextSize = 24
logo.Font = Enum.Font.SourceSansBold
logo.Parent = sidebar

local topbar = Instance.new("Frame")
topbar.Name = "TopBar"
topbar.Size = UDim2.new(1, -55, 0, 45)
topbar.Position = UDim2.new(0, 55, 0, 0)
topbar.BackgroundTransparency = 1
topbar.Parent = main

local pathLbl = Instance.new("TextLabel")
pathLbl.Name = "PathLbl"
pathLbl.Size = UDim2.new(1, -80, 1, 0)
pathLbl.Position = UDim2.new(0, 15, 0, 0)
pathLbl.BackgroundTransparency = 1
pathLbl.Text = "MAW Hub > Combat"
pathLbl.TextColor3 = TEXT_DARK
pathLbl.TextSize = 13
pathLbl.Font = Enum.Font.SourceSans
pathLbl.TextXAlignment = Enum.TextXAlignment.Left
pathLbl.Parent = topbar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -35, 0.5, -12)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = TEXT_DARK
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Parent = topbar

closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -65, 1, -55)
contentArea.Position = UDim2.new(0, 60, 0, 45)
contentArea.BackgroundTransparency = 1
contentArea.Parent = main

-- STRICT COMBAT LISTS (BOSSES & MOBS)
local BossList = {
    "All Bosses",
    "Abbot Wuxin",
    "Black Tiger King, Lord of the Black Wind Fortress",
    "Crimson Moon Priestess",
    "Foreman Gou",
    "Grey Fang",
    "Gu Mingfeng, the Corpse Daoist",
    "Hebo, the River Lord",
    "Hu Yaoji",
    "Iron-Beak Hou",
    "Jiao, the Flood Dragon",
    "Khan Temur",
    "Knife-Hand Lu",
    "Lei Wuji",
    "Mo Qingshan, the Deviated",
    "Old Scar Ma",
    "Old Scarback",
    "Qara Ashina",
    "Red Sail Mao",
    "Sunni, the Dragon King's Fifth Son",
    "Sword Wraith of Cloudbreak Peak",
    "Taotie, the Devouring Maw",
    "The Nameless General",
    "The Tiger Elder",
    "The Unburied General",
    "The Warden of the Heavenly River"
}

local MobList = {
    "All Mobs",
    "Bandit Captain Ma",
    "Bandit Enforcer",
    "Bandit Swordsman",
    "Barrow Wight",
    "Beggars' Union Disciple",
    "Black Bear",
    "Black Cult Disciple",
    "Black Cult Elder",
    "Black Road Alliance Disciple",
    "Black Tiger Disciple",
    "Blight-Gullet Snapper",
    "Bone-Crusher Demon Ape",
    "Bronze Corpse",
    "Bronze Vault Guardian",
    "Buried Miner",
    "Caravan Master Hu",
    "Cave Crawler",
    "Corpse-Driver Acolyte",
    "Demonic Cult Zealot",
    "Dire Wolf",
    "Drunken Swordsman",
    "Elder of Mount Hua",
    "Emei Sect Disciple",
    "Fallen Monk",
    "Flood Dragon Pirate",
    "Gate-Pass Bandit",
    "Granny Wei",
    "Green Forest Thug",
    "Grey Wolf",
    "Heavenly Demon Cult Disciple",
    "Herb Gatherer",
    "Hopping Corpse",
    "Horse Herder",
    "Horse Thief",
    "Huo of the Left Fang",
    "Iron-Hide Qi Bear",
    "Iron-Shell Snapper",
    "Jade-Horn Gorer",
    "Jade-Horn Rhino",
    "Kong Wuya",
    "Kunlun Sect Disciple",
    "Lei of the Right Fang",
    "Longyuan Escort",
    "Marsh Snapper",
    "Maw-Spawn",
    "Mine Bandit",
    "Mount Hua Disciple",
    "Mount Hua Sect Disciple",
    "Mountain Brigand",
    "Mountain Tiger",
    "Nameless Tomb Guard",
    "Oj-Touched Wolf",
    "Outlaw Chief",
    "Pack Buffalo",
    "Petty Thief",
    "Qi-Burning Boar",
    "Qi-Deviated Madman",
    "Qi-Maddened Stalker",
    "Red Sail Raider",
    "Reed Serpent",
    "Relay Runner",
    "Renegade Disciple",
    "Restless Spirit",
    "River Buffalo",
    "Rock Golem",
    "Salt Trader",
    "Shaolin Temple Disciple",
    "Shield-Bearer of the Nameless Host",
    "Sichuan Tang Clan Disciple",
    "Sky-Burial Pilgrim",
    "Spearman of the Nameless Host",
    "Steppe Hunter",
    "Steppe Rider",
    "Steppe Wolf",
    "Tang Mo",
    "Tea Picker",
    "Tempered Demon Ape",
    "Tempered Stalker Alpha",
    "Tianshui Fishwife",
    "Travelling Merchant Qian",
    "Villager",
    "Wailing Shade",
    "Wandering Cultivator",
    "Wandering Swordsman",
    "Water Ghoul",
    "White-Striped Vault Tiger",
    "Wild Boar",
    "Wudang Sect Disciple",
    "Your Reflection",
    "Zhang Tieniu",
    "Zhenyuan Escort"
}

local NpcTpList = {
    "Auctioneer Qian",
    "Beggars' Union Elder",
    "Beggar Boy Xiao",
    "Black Road Broker",
    "Blacksmith Old Pak",
    "Caravan Guard Bo",
    "Constable Captain Yun Baek",
    "Constable Tie",
    "Drunk Swordsman Ma",
    "Elder Zhou",
    "Emei Sword Nun",
    "Envoy Han Jingxu",
    "Fence Mo",
    "Ferryman Ou",
    "Granny Lian",
    "Granny Tsang",
    "Guarding Post",
    "Heavenly Demon Cult Envoy",
    "Hunter Gao",
    "Innkeeper Choi",
    "Kunlun Swordsman",
    "Little Mei",
    "Magistrate's Clerk Zhen",
    "Madam Hong",
    "Master Smith Ou",
    "Merchant Wang",
    "Oathkeeper Shi Wuyan",
    "Old Fisherman Lao",
    "Old Woman Guo",
    "Parrying Post",
    "Pill Master Yao",
    "Porter Dong",
    "Prize-Keeper Lu",
    "Registrar Wen",
    "Rice Merchant Fu",
    "Riddle-Keeper Su",
    "Salt Merchant Hu",
    "Scholar Bai",
    "Storyteller Wu",
    "Tailor Mei",
    "Tea Girl Lan",
    "The Old Wayfarer",
    "Town Crier Liu",
    "Training Post",
    "Wandering Swordsman Ling",
    "Waiter Xiao Er",
    "Weaver Jin",
    "Wu the Younger",
    "Alliance Clerk Han",
    "Apprentice Gu"
}

local MineList = {"All Ores", "Copper Ore", "Iron Ore", "Qi Crystal Shard", "Spirit Jade Shard"}
local GatherList = {"All Plants", "Bamboo Shoot", "Cloudcap Mushroom", "Crimson Lotus", "Frost Moss", "Heavenly Snow Lotus", "Jade-Dew Grass", "Moonshade Orchid", "Mountain Ginseng", "Spirit Grass", "Spirit Rice", "Sunfire Blossom", "Thunderstruck Root", "Vein-Bloom Orchid", "Wild Ginger"}
local PickList = {"All Items", "Five Tigers Door-Breaking Saber", "Jade Headband — low-grade", "Steamed Bun", "Tiger Fur Collar — low-grade"}

_G.SelectedBoss = "All Bosses"
_G.SelectedMob = "All Mobs"
_G.SelectedTp = NpcTpList[1]
_G.SelectedMine = "All Ores"
_G.SelectedGather = "All Plants"
_G.SelectedPick = "All Items"

_G.fk = false 
_G.autoMine = false 
_G.autoGather = false 
_G.autoPick = false
_G.Skills = {Z=false, X=false, C=false, V=false, ["9"]=false, ["8"]=false, ["7"]=false, ["6"]=false}

-- HELPER: Create Card
local function createCard(parentTab, title, xOffset, width)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, width, 1, -10)
    card.Position = UDim2.new(0, xOffset, 0, 0)
    card.BackgroundColor3 = PANEL_COLOR
    card.BorderSizePixel = 0
    card.Parent = parentTab

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 6)
    cardCorner.Parent = card

    local cardTitle = Instance.new("TextLabel")
    cardTitle.Size = UDim2.new(1, 0, 0, 30)
    cardTitle.BackgroundTransparency = 1
    cardTitle.Text = title
    cardTitle.TextColor3 = TEXT_MAIN
    cardTitle.TextSize = 13
    cardTitle.Font = Enum.Font.SourceSansBold
    cardTitle.Parent = card

    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, -10, 1, -35)
    container.Position = UDim2.new(0, 5, 0, 32)
    container.BackgroundTransparency = 1
    container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    container.CanvasSize = UDim2.new(0, 0, 0, 0)
    container.ScrollBarThickness = 4
    container.ScrollBarImageColor3 = ACCENT_BLUE
    container.Parent = card

    return container
end

-- HELPER: Create Toggle
local function createToggle(parent, y, labelText, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 28)
    frame.Position = UDim2.new(0, 5, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local box = Instance.new("TextButton")
    box.Size = UDim2.new(0, 16, 0, 16)
    box.Position = UDim2.new(0, 0, 0.5, -8)
    box.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    box.Text = ""
    box.AutoButtonColor = false
    box.Parent = frame

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 3)
    boxCorner.Parent = box

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -25, 1, 0)
    label.Position = UDim2.new(0, 24, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = TEXT_MAIN
    label.TextSize = 12
    label.Font = Enum.Font.SourceSans
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local state = false
    box.MouseButton1Click:Connect(function()
        state = not state
        box.BackgroundColor3 = state and ACCENT_BLUE or Color3.fromRGB(35, 35, 42)
        callback(state)
    end)

    return frame
end

-- HELPER: Create Button
local function createButton(parent, y, btnText, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.Position = UDim2.new(0, 5, 0, y)
    btn.BackgroundColor3 = ACCENT_BLUE
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = btnText
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- HELPER: Create Dropdown
local function createDropdown(parent, y, labelText, options, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 45)
    frame.Position = UDim2.new(0, 5, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = TEXT_DARK
    lbl.TextSize = 11
    lbl.Font = Enum.Font.SourceSans
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.new(1, 0, 0, 24)
    dropBtn.Position = UDim2.new(0, 0, 0, 20)
    dropBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    dropBtn.TextColor3 = TEXT_MAIN
    dropBtn.TextSize = 11
    dropBtn.Font = Enum.Font.SourceSans
    dropBtn.Text = "  " .. tostring(options[1])
    dropBtn.TextXAlignment = Enum.TextXAlignment.Left
    dropBtn.Parent = frame

    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 4)
    dropCorner.Parent = dropBtn

    local open = false
    local listFrame = nil

    dropBtn.MouseButton1Click:Connect(function()
        open = not open
        if not open then
            if listFrame then listFrame:Destroy() end
            return
        end

        listFrame = Instance.new("Frame")
        listFrame.Size = UDim2.new(1, 0, 0, math.min(#options * 22, 160))
        listFrame.Position = UDim2.new(0, 0, 1, 2)
        listFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
        listFrame.BorderSizePixel = 0
        listFrame.ZIndex = 500
        listFrame.Parent = dropBtn

        local listCorner = Instance.new("UICorner")
        listCorner.CornerRadius = UDim.new(0, 4)
        listCorner.Parent = listFrame

        local scroll = Instance.new("ScrollingFrame")
        scroll.Size = UDim2.new(1, 0, 1, 0)
        scroll.BackgroundTransparency = 1
        scroll.CanvasSize = UDim2.new(0, 0, 0, #options * 22)
        scroll.ScrollBarThickness = 5
        scroll.ScrollBarImageColor3 = ACCENT_BLUE
        scroll.ZIndex = 501
        scroll.Parent = listFrame

        for i, opt in ipairs(options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 22)
            optBtn.Position = UDim2.new(0, 0, 0, (i-1)*22)
            optBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
            optBtn.TextColor3 = TEXT_MAIN
            optBtn.TextSize = 11
            optBtn.Font = Enum.Font.SourceSans
            optBtn.Text = "  " .. tostring(opt)
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtn.ZIndex = 502
            optBtn.Parent = scroll

            optBtn.MouseButton1Click:Connect(function()
                dropBtn.Text = "  " .. tostring(opt)
                callback(opt)
                open = false
                listFrame:Destroy()
            end)
        end
    end)

    return frame
end

-- TABS SETUP
local tabs = {}
local activeTab = nil
local tabIcons = {"⚔️", "📍", "⛏️", "🌿", "📦"}
local tabNames = {"Combat", "Teleport", "Mining", "Gathering", "Pickup"}

for i, icon in ipairs(tabIcons) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 35, 0, 35)
    btn.Position = UDim2.new(0.5, -17, 0, 50 + (i-1)*42)
    btn.BackgroundColor3 = SIDEBAR_COLOR
    btn.Text = icon
    btn.TextColor3 = TEXT_DARK
    btn.TextSize = 16
    btn.Font = Enum.Font.SourceSans
    btn.Parent = sidebar

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local tabView = Instance.new("Frame")
    tabView.Name = tabNames[i] .. "View"
    tabView.Size = UDim2.new(1, 0, 1, 0)
    tabView.BackgroundTransparency = 1
    tabView.Visible = false
    tabView.Parent = contentArea

    btn.MouseButton1Click:Connect(function()
        if activeTab then activeTab.view.Visible = false end
        tabView.Visible = true
        activeTab = {btn = btn, view = tabView}

        pathLbl.Text = "MAW Hub > " .. tabNames[i]

        for _, t in ipairs(tabs) do
            t.btn.BackgroundColor3 = SIDEBAR_COLOR
            t.btn.TextColor3 = TEXT_DARK
        end
        btn.BackgroundColor3 = ACCENT_BLUE
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    table.insert(tabs, {btn = btn, view = tabView, name = tabNames[i]})
end

-- TAB 1: COMBAT (BOSSES & MOBS SEPARATE DROPDOWNS)
local cLeft = createCard(tabs[1].view, "⚔️ Combat Targets", 0, 260)
local cRight = createCard(tabs[1].view, "🔥 Auto Skills", 270, 275)

createDropdown(cLeft, 0, "Select Boss Target", BossList, function(v) _G.SelectedBoss = v end)
createDropdown(cLeft, 55, "Select Mob Target", MobList, function(v) _G.SelectedMob = v end)
createToggle(cLeft, 110, "Float Kill Aura", function(v) _G.fk = v end)

local skillKeys = {"Z", "X", "C", "V", "9", "8", "7", "6"}
for idx, k in ipairs(skillKeys) do
    createToggle(cRight, (idx-1)*30, "Auto Skill " .. k, function(v) _G.Skills[k] = v end)
end

-- TAB 2: TELEPORT
local tpLeft = createCard(tabs[2].view, "📍 Select NPC / Dummy Target", 0, 260)
local tpRight = createCard(tabs[2].view, "⚡ Teleport Action", 270, 275)

createDropdown(tpLeft, 0, "NPC / Dummy (HP 100 & 1M)", NpcTpList, function(v) _G.SelectedTp = v end)

createButton(tpRight, 10, "Teleport Now (1-Click)", function()
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local target = nil
        for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
            if obj:IsA("Model") and obj ~= char and obj.Name == _G.SelectedTp and obj:FindFirstChild("HumanoidRootPart") then
                target = obj
                break
            end
        end
        if target then
            hrp.CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)

-- TAB 3: MINING
local mLeft = createCard(tabs[3].view, "⛏️ Target Ores", 0, 260)
local mRight = createCard(tabs[3].view, "⚡ Mining Farm", 270, 275)
createDropdown(mLeft, 0, "Select Ore Type", MineList, function(v) _G.SelectedMine = v end)
createToggle(mRight, 0, "Auto Mine (Continuous)", function(v) _G.autoMine = v end)

-- TAB 4: GATHERING
local gLeft = createCard(tabs[4].view, "🌿 Target Plants", 0, 260)
local gRight = createCard(tabs[4].view, "⚡ Gathering Farm", 270, 275)
createDropdown(gLeft, 0, "Select Plant Type", GatherList, function(v) _G.SelectedGather = v end)
createToggle(gRight, 0, "Auto Gather (Continuous)", function(v) _G.autoGather = v end)

-- TAB 5: PICKUP
local pLeft = createCard(tabs[5].view, "📦 Target Items", 0, 260)
local pRight = createCard(tabs[5].view, "⚡ Item Pickup", 270, 275)
createDropdown(pLeft, 0, "Select Item Type", PickList, function(v) _G.SelectedPick = v end)
createToggle(pRight, 0, "Auto Pick Up (Continuous)", function(v) _G.autoPick = v end)

-- FOOTER
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(0, 200, 0, 20)
footer.Position = UDim2.new(1, -210, 1, -22)
footer.BackgroundTransparency = 1
footer.Text = "made by akiwe"
footer.TextColor3 = TEXT_DARK
footer.TextSize = 11
footer.Font = Enum.Font.SourceSansItalic
footer.TextXAlignment = Enum.TextXAlignment.Right
footer.Parent = main

-- SET DEFAULT TAB
tabs[1].btn.BackgroundColor3 = ACCENT_BLUE
tabs[1].btn.TextColor3 = Color3.fromRGB(255, 255, 255)
tabs[1].view.Visible = true
activeTab = {btn = tabs[1].btn, view = tabs[1].view}

print("[MAW] UI Loaded - Bosses & Mobs separated!")

-- ============ LOGIC LOOPS ============

local function chainLoop(toggleKey, selectedVar, keyword)
    task.spawn(function()
        local harvestedLocations = {}
        while true do
            if _G[toggleKey] then
                local char = plr.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local ws = game:GetService("Workspace")
                    local targetPrompt = nil
                    local targetPart = nil
                    local minDist = math.huge
                    local selected = _G[selectedVar] or "All"
                    
                    for _, v in ipairs(ws:GetDescendants()) do
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
                        task.wait(0.3)
                    else
                        harvestedLocations = {}
                        task.wait(0.5)
                    end
                end
            else
                harvestedLocations = {}
            end
            task.wait(0.1)
        end
    end)
end

chainLoop("autoMine", "SelectedMine", "mine")
chainLoop("autoGather", "SelectedGather", "gather")
chainLoop("autoPick", "SelectedPick", "pick")

-- FLOAT KILL AURA (TARGETS BOSSES OR MOBS)
task.spawn(function()
    while true do
        if _G.fk then
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and char:FindFirstChild("Humanoid") then
                char.Humanoid.PlatformStand = true
                hrp.AssemblyLinearVelocity = Vector3.zero
                local target = nil
                local minDist = math.huge
                
                for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") and obj.Humanoid.Health > 0 then
                        local name = obj.Name
                        local matchBoss = (_G.SelectedBoss == "All Bosses") or (name == _G.SelectedBoss)
                        local matchMob = (_G.SelectedMob == "All Mobs") or (name == _G.SelectedMob)
                        
                        if matchBoss or matchMob then
                            local d = (hrp.Position - obj.HumanoidRootPart.Position).Magnitude
                            if d < minDist then minDist = d; target = obj end
                        end
                    end
                end
                
                if target then
                    hrp.CFrame = CFrame.lookAt(target.HumanoidRootPart.Position + Vector3.new(0, 8.5, 0), target.HumanoidRootPart.Position)
                    pcall(function() 
                        game:GetService("ReplicatedStorage").Remotes.CombatInput:FireServer()
                        for k, v in pairs(_G.Skills) do 
                            if v then VIM:SendKeyEvent(true, Enum.KeyCode[k], false, game) end 
                        end
                    end)
                end
            end
        else 
            local char = plr.Character
            if char and char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end 
        end
        task.wait(0.05)
    end
end)
