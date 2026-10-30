-- MAW AUTO FARM PRO - GUI KIRI
local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")
local plr = Players.LocalPlayer
local pgui = plr:WaitForChild("PlayerGui")

-- Hapus UI lama
if pgui:FindFirstChild("MAW_HUB") then pgui.MAW_HUB:Destroy() end

-- ScreenGui
local sg = Instance.new("ScreenGui")
sg.Name = "MAW_HUB"
sg.ResetOnSpawn = false
sg.Parent = pgui

-- MAIN FRAME (Kiri)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 220, 0, 600)
mainFrame.Position = UDim2.new(0, 10, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 150)
mainFrame.BorderSizePixel = 2
mainFrame.Parent = sg

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
title.Text = "MAW FARM PRO"
title.TextColor3 = Color3.fromRGB(0, 255, 150)
title.TextSize = 16
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

-- CONTENT FRAME
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- GLOBAL VAR
local MobList = {"All Mobs", "Martial Alliance Guard", "Blacksmith's Apprentice", "Travelling Scholar", "Village Constable", "Tang Clans Envoy", "Green Forest Thug", "Road Cutpurse", "Suanni, the Dragon King's Fifth Son", "Marshal Tie Yan, the Burnt Marshal", "Black Tiger King, Lord of the Green Forest", "Jiao, the Flood Dragon", "Sad Cultivator", "Bonewrath, the War-Qilin of the Ninefold Lord", "Commander Shen Tingjun", "Crimson Moon Priestess", "Mo Qingshan, the Deviated", "Lü Jiugong, Master of the Shattered Array", "Snack-Seller Hua", "Drum-Master Feng", "Auntie Tangyuan", "Mount Hua Disciple", "Plum Blossom Trainee", "Travelling Martial Artist", "Alley Rat", "Carpenter Lu", "Forest Bandit", "Heavenly Demon Disciple", "Old Tuskers", "Iron-Shell Snapper", "Ox-Fist Brute", "Mount Hua Outer Elder", "Old Snapjaw", "Wild Boar", "Grey Wolf", "Highway Robber", "Drunken Fist Master", "Stable-Master Gong", "Qi-Touched Wolf", "Old Blackpaw", "Scarback", "Mountain Brigand", "Pass Reaver", "Jade-Horn Rhino", "Stoneplate Rhino", "Ashen Demon Ape", "Hungry Ghost", "Wailing Shade", "Restless Spirit", "Blood-Eyed Demon Ape", "Lean Grey Wolf", "Moon-Eyed Wolf", "Dire Wolf", "Green Forest Blade", "Iron-Beak Hou", "Abbot Wuxin", "Flood Dragon Pirate", "Bandit Captain Ma", "Grey Fang", "Fishmonger", "Black Wind Lookout", "Pass Reaver Wind", "Tusked Boar", "Tempered Old Tusker", "Fallen Monk", "Hollow-Eyed Novice", "Lake Cutthroat", "Tempered Grey Wolf", "Bandit Enforcer", "Thunder-Striped Tiger", "Widow Lin", "Red Sail Raider", "Demonic Cult Zealot", "Black Moon Assassin", "Black Moon Warrior", "Shaolin Warrior Monk", "Red Sail Cutthroat", "Red Sail Mao", "Blood Cult Acolyte", "Innkeeper's Daughter", "Jade-Tusk Boar", "Crimson Heretic"}
local TpList = {"Training Post", "Parrying Post", "Guarding Post"}
local MineList = {"All Ores", "Iron Ore", "Copper Ore", "Spirit Jade Shard", "Qi Crystal Shard"}
local GatherList = {"All Plants", "Wild Ginger", "Bamboo Shoot", "Sunfire Blossom", "Spirit Rice", "Moonshade Orchid", "Cloudcap Mushroom", "Jade-Dew Grass", "Vein-Bloom Orchid", "Crimson Lotus", "Spirit Grass", "Heavenly Snow Lotus", "Mountain Ginseng", "Thunderstruck Root", "Frost Moss"}
local PickList = {"All Items", "Steamed Bun", "Tiger Fur Collar — low-grade", "Five Tigers Door-Breaking Saber", "Jade Headband — low-grade"}

_G.SelectedMob = "All Mobs"
_G.SelectedTp = "Training Post"
_G.SelectedMine = "All Ores"
_G.SelectedGather = "All Plants"
_G.SelectedPick = "All Items"

_G.fk = false 
_G.autoTp = false
_G.autoMine = false 
_G.autoGather = false 
_G.autoPick = false
_G.Skills = {Z=false, X=false, C=false, V=false, ["9"]=false, ["8"]=false, ["7"]=false, ["6"]=false}

-- HELPER: Create Dropdown
local function createDropdown(parent, y, options, callback)
    local dropFrame = Instance.new("Frame")
    dropFrame.Size = UDim2.new(1, -10, 0, 25)
    dropFrame.Position = UDim2.new(0, 5, 0, y)
    dropFrame.BackgroundTransparency = 1
    dropFrame.Parent = parent

    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.new(1, 0, 1, 0)
    dropBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    dropBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    dropBtn.TextSize = 11
    dropBtn.Font = Enum.Font.SourceSans
    dropBtn.Text = options[1]
    dropBtn.Parent = dropFrame

    dropBtn.MouseButton1Click:Connect(function()
        local listFrame = Instance.new("Frame")
        listFrame.Size = UDim2.new(1, 0, 0, #options * 20)
        listFrame.Position = UDim2.new(0, 0, 1, 0)
        listFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        listFrame.BorderColor3 = Color3.fromRGB(0, 255, 150)
        listFrame.BorderSizePixel = 1
        listFrame.Parent = dropFrame
        listFrame.ZIndex = 100

        for i, opt in ipairs(options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 20)
            optBtn.Position = UDim2.new(0, 0, 0, (i-1)*20)
            optBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            optBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            optBtn.TextSize = 10
            optBtn.Font = Enum.Font.SourceSans
            optBtn.Text = opt
            optBtn.Parent = listFrame
            optBtn.ZIndex = 101

            optBtn.MouseButton1Click:Connect(function()
                dropBtn.Text = opt
                callback(opt)
                listFrame:Destroy()
            end)
        end
    end)

    return dropFrame
end

-- HELPER: Create Toggle
local function createToggle(parent, y, label, callback)
    local togFrame = Instance.new("Frame")
    togFrame.Size = UDim2.new(1, -10, 0, 25)
    togFrame.Position = UDim2.new(0, 5, 0, y)
    togFrame.BackgroundTransparency = 1
    togFrame.Parent = parent

    local togBtn = Instance.new("TextButton")
    togBtn.Size = UDim2.new(0, 25, 0, 25)
    togBtn.Position = UDim2.new(0, 0, 0, 0)
    togBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
    togBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    togBtn.TextSize = 12
    togBtn.Font = Enum.Font.SourceSansBold
    togBtn.Text = "OFF"
    togBtn.Parent = togFrame

    local togLbl = Instance.new("TextLabel")
    togLbl.Size = UDim2.new(1, -35, 0, 25)
    togLbl.Position = UDim2.new(0, 30, 0, 0)
    togLbl.BackgroundTransparency = 1
    togLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    togLbl.TextSize = 11
    togLbl.Font = Enum.Font.SourceSans
    togLbl.Text = label
    togLbl.TextXAlignment = Enum.TextXAlignment.Left
    togLbl.Parent = togFrame

    local state = false
    togBtn.MouseButton1Click:Connect(function()
        state = not state
        togBtn.BackgroundColor3 = state and Color3.fromRGB(50, 150, 80) or Color3.fromRGB(100, 50, 50)
        togBtn.Text = state and "ON" or "OFF"
        callback(state)
    end)

    return togFrame
end

-- TAB BUTTONS (Vertical kiri)
local tabs = {}
local currentTab = nil

local function createTab(name)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 30)
    tabBtn.Position = UDim2.new(0, 0, 0, #tabs * 30)
    tabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    tabBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
    tabBtn.TextSize = 12
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.Text = name
    tabBtn.Parent = mainFrame

    local tabContent = Instance.new("Frame")
    tabContent.Name = name
    tabContent.Size = UDim2.new(1, -10, 1, -40-#tabs*30)
    tabContent.Position = UDim2.new(0, 5, 0, 40)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.Parent = contentFrame

    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.Parent = tabContent

    tabBtn.MouseButton1Click:Connect(function()
        if currentTab then currentTab.Visible = false end
        tabContent.Visible = true
        currentTab = tabContent
        for _, v in ipairs(mainFrame:GetChildren()) do
            if v:IsA("TextButton") then
                v.BackgroundColor3 = v == tabBtn and Color3.fromRGB(0, 150, 100) or Color3.fromRGB(50, 50, 60)
            end
        end
    end)

    table.insert(tabs, {btn=tabBtn, content=tabContent, scroll=scrollFrame})
    return scrollFrame
end

-- CREATE TABS
local combatTab = createTab("⚔️ Combat")
local dummyTab = createTab("💎 Dummy")
local mineTab = createTab("⛏️ Mine")
local gatherTab = createTab("🌿 Gather")
local pickTab = createTab("📦 Pick")

-- POPULATE TABS
local yOffset = 0

-- Combat Tab
createDropdown(combatTab, yOffset, MobList, function(v) _G.SelectedMob = v end)
yOffset = yOffset + 30
createToggle(combatTab, yOffset, "Float Kill Aura", function(v) _G.fk = v end)
yOffset = yOffset + 30
createToggle(combatTab, yOffset, "Skill Z", function(v) _G.Skills.Z = v end)
yOffset = yOffset + 30
createToggle(combatTab, yOffset, "Skill X", function(v) _G.Skills.X = v end)
yOffset = yOffset + 30
createToggle(combatTab, yOffset, "Skill C", function(v) _G.Skills.C = v end)
yOffset = yOffset + 30
createToggle(combatTab, yOffset, "Skill V", function(v) _G.Skills.V = v end)
yOffset = yOffset + 30
createToggle(combatTab, yOffset, "Skill 9", function(v) _G.Skills["9"] = v end)
yOffset = yOffset + 30
createToggle(combatTab, yOffset, "Skill 8", function(v) _G.Skills["8"] = v end)
yOffset = yOffset + 30
createToggle(combatTab, yOffset, "Skill 7", function(v) _G.Skills["7"] = v end)
yOffset = yOffset + 30
createToggle(combatTab, yOffset, "Skill 6", function(v) _G.Skills["6"] = v end)

-- Dummy Tab
yOffset = 0
createDropdown(dummyTab, yOffset, TpList, function(v) _G.SelectedTp = v end)
yOffset = yOffset + 30
createToggle(dummyTab, yOffset, "Teleport & Farm", function(v) _G.autoTp = v end)

-- Mine Tab
yOffset = 0
createDropdown(mineTab, yOffset, MineList, function(v) _G.SelectedMine = v end)
yOffset = yOffset + 30
createToggle(mineTab, yOffset, "Auto Mine", function(v) _G.autoMine = v end)

-- Gather Tab
yOffset = 0
createDropdown(gatherTab, yOffset, GatherList, function(v) _G.SelectedGather = v end)
yOffset = yOffset + 30
createToggle(gatherTab, yOffset, "Auto Gather", function(v) _G.autoGather = v end)

-- Pick Tab
yOffset = 0
createDropdown(pickTab, yOffset, PickList, function(v) _G.SelectedPick = v end)
yOffset = yOffset + 30
createToggle(pickTab, yOffset, "Auto Pick", function(v) _G.autoPick = v end)

-- Set first tab active
tabs[1].content.Visible = true
currentTab = tabs[1].content
tabs[1].btn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)

print("[MAW] GUI Loaded di kiri!")

-- ============ LOGIC LOOPS ============

-- CHAIN FARM LOOP
local function chainLoop(toggleKey, selectedVar, keyword)
    task.spawn(function()
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
                                    local dist = (hrp.Position - part.Position).Magnitude
                                    if dist < minDist then minDist = dist; targetPrompt = v; targetPart = part end
                                end
                            end
                        end
                    end

                    if targetPrompt and targetPart then
                        hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.2)
                        if fireproximityprompt then fireproximityprompt(targetPrompt)
                        else pcall(function() game:GetService("ReplicatedStorage").Remotes.Interact:FireServer(targetPrompt.Parent) end) end
                        task.wait(targetPrompt.HoldDuration + 0.1)
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

chainLoop("autoMine", "SelectedMine", "mine")
chainLoop("autoGather", "SelectedGather", "gather")
chainLoop("autoPick", "SelectedPick", "pick")

-- TELEPORT & FARM DUMMY
task.spawn(function()
    while true do
        if _G.autoTp then
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
                    hrp.CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0, 8.5, 0)
                    pcall(function() game:GetService("ReplicatedStorage").Remotes.CombatInput:FireServer() end)
                end
            end
        end
        task.wait(0.1)
    end
end)

-- FLOAT KILL AURA
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
                        if (_G.SelectedMob == "All Mobs") or string.lower(obj.Name):find(string.lower(_G.SelectedMob or "")) then
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
