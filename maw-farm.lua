-- AKIW HUB v1.3 (Rayfield Minimal)
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local W = Rayfield:CreateWindow({Name="Akiw HUB 1.3",KeySystem=false,ConfigurationSaving={Enabled=false}})
local T = W:CreateTab("Main")

-- Global Variables
_G.autoAttack = false
_G.autoDodge = false
_G.fk = false
_G.autoSell = false
_G.SelectedBoss = "All Bosses"
_G.SelectedMob = "All Mobs"
_G.SelectedRealm = "Mortal Realm"
_G.Skills = {Z=false, X=false, C=false, V=false}

local plr = game.Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

local BossList = {"All Bosses", "Abbot Wuxin", "Black Tiger King, Lord of the Black Wind Fortress", "Crimson Moon Priestess", "Foreman Gou", "Grey Fang", "Gu Mingfeng, the Corpse Daoist", "Hebo, the River Lord", "Hu Yaoji", "Iron-Beak Hou", "Jiao, the Flood Dragon", "Khan Temur", "Knife-Hand Lu", "Lei Wuji", "Mo Qingshan, the Deviated", "Old Scar Ma", "Old Scarback", "Qara Ashina", "Red Sail Mao", "Suanni, the Dragon King's Fifth Son", "Sword Wraith of Cloudbreak Peak", "Taotie, the Devouring Maw", "The Nameless General", "The Tiger Elder", "The Unburied General", "The Warden of the Heavenly River"}
local MobList = {"All Mobs", "Bandit Captain Ma", "Bandit Enforcer", "Bandit Swordsman", "Barrow Wight", "Beggars' Union Disciple", "Black Bear", "Black Cult Disciple", "Black Cult Elder", "Black Road Alliance Disciple", "Black Tiger Disciple", "Blight-Gullet Snapper", "Bone-Crusher Demon Ape", "Bronze Corpse", "Bronze Vault Guardian", "Buried Miner", "Caravan Master Hu", "Cave Crawler", "Corpse-Driver Acolyte", "Demonic Cult Zealot", "Dire Wolf", "Drunken Swordsman", "Elder of Mount Hua", "Emei Sect Disciple", "Fallen Monk", "Flood Dragon Pirate", "Gate-Pass Bandit", "Granny Wei", "Green Forest Thug", "Grey Wolf", "Heavenly Demon Cult Disciple", "Herb Gatherer", "Hopping Corpse", "Horse Herder", "Horse Thief", "Huo of the Left Fang", "Iron-Hide Qi Bear", "Iron-Shell Snapper", "Jade-Horn Gorer", "Jade-Horn Rhino", "Kong Wuya", "Kunlun Sect Disciple", "Lei of the Right Fang", "Longyuan Escort", "Marsh Snapper", "Maw-Spawn", "Mine Bandit", "Mount Hua Disciple", "Mount Hua Sect Disciple", "Mountain Brigand", "Mountain Tiger", "Nameless Tomb Guard", "Oj-Touched Wolf", "Outlaw Chief", "Pack Buffalo", "Petty Thief", "Qi-Burning Boar", "Qi-Deviated Madman", "Qi-Maddened Stalker", "Red Sail Raider", "Reed Serpent", "Relay Runner", "Renegade Disciple", "Restless Spirit", "River Buffalo", "Rock Golem", "Salt Trader", "Shaolin Temple Disciple", "Shield-Bearer of the Nameless Host", "Sichuan Tang Clan Disciple", "Sky-Burial Pilgrim", "Spearman of the Nameless Host", "Steppe Hunter", "Steppe Rider", "Steppe Wolf", "Tang Mo", "Tea Picker", "Tempered Demon Ape", "Tempered Stalker Alpha", "Tianshui Fishwife", "Travelling Merchant Qian", "Villager", "Wailing Shade", "Wandering Cultivator", "Wandering Swordsman", "Water Ghoul", "White-Striped Vault Tiger", "Wild Boar", "Wudang Sect Disciple", "Your Reflection", "Zhang Tieniu", "Zhenyuan Escort"}

-- Combat Section
local CombatSection = T:CreateSection("Combat")

T:CreateDropdown({
    Name = "Select Boss",
    Options = BossList,
    CurrentOption = {"All Bosses"},
    MultipleOptions = false,
    Callback = function(Value)
        _G.SelectedBoss = Value[1]
    end
})

T:CreateDropdown({
    Name = "Select Mob",
    Options = MobList,
    CurrentOption = {"All Mobs"},
    MultipleOptions = false,
    Callback = function(Value)
        _G.SelectedMob = Value[1]
    end
})

T:CreateToggle({
    Name = "Auto Attack",
    CurrentValue = false,
    Callback = function(Value)
        _G.autoAttack = Value
    end
})

T:CreateToggle({
    Name = "Auto Dodge",
    CurrentValue = false,
    Callback = function(Value)
        _G.autoDodge = Value
    end
})

T:CreateToggle({
    Name = "Float Kill (8.5)",
    CurrentValue = false,
    Callback = function(Value)
        _G.fk = Value
    end
})

-- Skills Section
local SkillsSection = T:CreateSection("Skills")

for _, key in ipairs({"Z", "X", "C", "V"}) do
    T:CreateToggle({
        Name = "Skill " .. key,
        CurrentValue = false,
        Callback = function(Value)
            _G.Skills[key] = Value
        end
    })
end

-- Auto Sell Section
local AutoSellSection = T:CreateSection("Auto Sell")

local RealmList = {"Mortal Realm", "Qi Condensation", "Foundation Establishment", "Golden Core", "Nascent Soul"}
T:CreateDropdown({
    Name = "Sell Realm",
    Options = RealmList,
    CurrentOption = {"Mortal Realm"},
    MultipleOptions = false,
    Callback = function(Value)
        _G.SelectedRealm = Value[1]
    end
})

T:CreateToggle({
    Name = "Auto Sell Items",
    CurrentValue = false,
    Callback = function(Value)
        _G.autoSell = Value
    end
})

-- Teleport Section
local TpSection = T:CreateSection("Teleport")

T:CreateButton({
    Name = "Teleport to NPC",
    Callback = function()
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == "Auctioneer Qian" and obj:FindFirstChild("HumanoidRootPart") then
                    hrp.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                    break
                end
            end
        end
    end
})

T:CreateButton({
    Name = "Teleport Wild Qi",
    Callback = function()
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == "Purple Wild Qi" and obj:FindFirstChild("HumanoidRootPart") then
                    hrp.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                    break
                end
            end
        end
    end
})

-- Auto Attack Loop
task.spawn(function()
    local lockedTarget = nil
    while true do
        if _G.autoAttack then
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and char:FindFirstChild("Humanoid") then
                if lockedTarget and lockedTarget:FindFirstChild("Humanoid") and lockedTarget.Humanoid.Health > 0 then
                else
                    local minDist = math.huge
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") and obj.Humanoid.Health > 0 then
                            local d = (hrp.Position - obj.HumanoidRootPart.Position).Magnitude
                            if d < minDist then minDist = d; lockedTarget = obj end
                        end
                    end
                end
                if lockedTarget and lockedTarget:FindFirstChild("HumanoidRootPart") then
                    VIM:SendMouseButtonEvent(0,0,0,true,game,0)
                    task.wait(0.02)
                    VIM:SendMouseButtonEvent(0,0,0,false,game,0)
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes.CombatInput:FireServer(lockedTarget.HumanoidRootPart)
                    end)
                    for k,v in pairs(_G.Skills) do
                        if v then
                            VIM:SendKeyEvent(true,Enum.KeyCode[k],false,game)
                            task.wait(0.05)
                            VIM:SendKeyEvent(false,Enum.KeyCode[k],false,game)
                        end
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)

-- Auto Dodge Loop
task.spawn(function()
    while true do
        if _G.autoDodge then
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                        if obj.Humanoid.Health > 0 and (hrp.Position - obj.HumanoidRootPart.Position).Magnitude < 12 then
                            local right = hrp.CFrame.RightVector
                            hrp.CFrame = hrp.CFrame + right * (math.random() > 0.5 and 8 or -8)
                            task.wait(0.3)
                            break
                        end
                    end
                end
            end
        end
        task.wait(0.2)
    end
end)

-- Float Kill Loop
task.spawn(function()
    while true do
        if _G.fk then
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                        if obj.Humanoid.Health > 0 then
                            local objHrp = obj.HumanoidRootPart
                            local dist = (hrp.Position - objHrp.Position).Magnitude
                            if dist < 15 then
                                objHrp.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 8.5
                                objHrp.Velocity = Vector3.zero
                                objHrp.RotVelocity = Vector3.zero
                            end
                        end
                    end
                end
            end
        end
        task.wait(0.05)
    end
end)

-- Auto Sell Loop
task.spawn(function()
    while true do
        if _G.autoSell then
            pcall(function()
                local backpack = plr:FindFirstChild("Backpack")
                if backpack then
                    for _, item in ipairs(backpack:GetChildren()) do
                        if item:IsA("Tool") and item:FindFirstChild("Realm") then
                            local itemRealm = item.Realm.Value
                            if itemRealm == _G.SelectedRealm or _G.SelectedRealm == "Mortal Realm" then
                                game:GetService("ReplicatedStorage").Remotes.SellItem:FireServer(item)
                                task.wait(0.1)
                            end
                        end
                    end
                end
            end)
        end
        task.wait(1)
    end
end)
