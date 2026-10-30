local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local W = Rayfield:CreateWindow({Name="MAW Auto Farm",KeySystem=false,ConfigurationSaving={Enabled=false}})

-- DATA TARGET
local NPCList = {"All NPCs", "Porter Dong", "Constable Tie", "Apprentice Gu", "Salt Merchant Hu", "Wandering Swordsman Ling", "Martial Alliance Guard", "Old Woman Guo", "Magistrate’s Clerk Zhen", "Blacksmith’s Apprentice", "Pill Master Yao", "Travelling Scholar", "Village Constable", "Beggars’ Union Elder", "Scholar Bai", "Black Road Broker", "Tang Clans Envoy", "Green Forest Thug", "Road Cutpurse", "Constable Captain Yun Baek", "Rice Merchant Fu", "Alliance Clerk Han", "Envoy Han Jingxu", "Granny Tsang", "Oathkeeper Shi Wuyan", "Town Crier Liu", "Riddle-Keeper Su", "Prize-Keeper Lu", "Beggar Boy Xiao", "Drunk Swordsman Ma", "Merchant Wang", "Tailor Mei", "Storyteller Wu", "Tea Girl Lan", "Blacksmith Old Pak", "Master Smith Ou", "Madam Hong", "Kunlun Swordsman", "Innkeeper Choi", "Waiter Xiao Er", "Caravan Guard Bo", "The Old Wayfarer", "Suanni, the Dragon King’s Fifth Son", "Marshal Tie Yan, the Burnt Marshal", "Black Tiger King, Lord of the Green Forest", "Jiao, the Flood Dragon", "Sad Cultivator", "Bonewrath, the War-Qilin of the Ninefold Lord", "Commander Shen Tingjun", "Crimson Moon Priestess", "Mo Qingshan, the Deviated", "Lü Jiugong, Master of the Shattered Array", "Snack-Seller Hua", "Drum-Master Feng", "Auntie Tangyuan", "Granny Lian", "Auctioneer Qian", "Mount Hua Disciple", "Plum Blossom Trainee", "Travelling Martial Artist", "Alley Rat", "Carpenter Lu", "Forest Bandit", "Heavenly Demon Disciple", "Old Tuskers", "Iron-Shell Snapper", "Emei Sword Nun", "Training Post", "Parrying Post", "Guarding Post", "Ox-Fist Brute", "Mount Hua Outer Elder", "Old Snapjaw", "Wild Boar", "Grey Wolf", "Highway Robber", "Drunken Fist Master", "Registrar Wen", "Stable-Master Gong", "Weaver Jin", "Wu the Younger", "Hunter Gao", "Qi-Touched Wolf", "Old Blackpaw", "Scarback", "Mountain Brigand", "Pass Reaver", "Jade-Horn Rhino", "Stoneplate Rhino", "Ashen Demon Ape", "Hungry Ghost", "Wailing Shade", "Restless Spirit", "Blood-Eyed Demon Ape", "Old Fisherman Lao", "Lean Grey Wolf", "Moon-Eyed Wolf", "Dire Wolf", "Green Forest Blade", "Iron-Beak Hou", "Abbot Wuxin", "Flood Dragon Pirate", "Bandit Captain Ma", "Grey Fang", "Fishmonger", "Black Wind Lookout", "Pass Reaver Wind", "Tusked Boar", "Tempered Old Tusker", "Fallen Monk", "Hollow-Eyed Novice", "Lake Cutthroat", "Elder Zhou", "Ferryman Ou", "Widow Lin", "Little Mei", "Red Sail Raider", "Pass Reaver", "Tempered Grey Wolf", "Lake Cutthroat", "Bandit Enforcer", "Thunder-Striped Tiger", "Heavenly Demon Cult Envoy", "Jade-Tusk Boar", "Crimson Heretic", "Demonic Cult Zealot", "Black Moon Assassin", "Black Moon Warrior", "Shaolin Warrior Monk", "Red Sail Cutthroat", "Red Sail Mao", "Blood Cult Acolyte", "Fence Mo", "Innkeeper’s Daughter"}
local MineList = {"All Ores", "Iron Ore", "Copper Ore", "Spirit Jade Shard", "Qi Crystal Shard"}
local GatherList = {"All Plants", "Wild Ginger", "Bamboo Shoot", "Sunfire Blossom", "Spirit Rice", "Moonshade Orchid", "Cloudcap Mushroom", "Jade-Dew Grass", "Vein-Bloom Orchid", "Crimson Lotus", "Spirit Grass", "Heavenly Snow Lotus", "Mountain Ginseng", "Thunderstruck Root", "Frost Moss"}
local PickList = {"All Items", "Steamed Bun", "Tiger Fur Collar — low-grade", "Five Tigers Door-Breaking Saber", "Jade Headband — low-grade"}

_G.SelectedNPC = "All NPCs"
_G.SelectedMine = "All Ores"
_G.SelectedGather = "All Plants"
_G.SelectedPick = "All Items"

_G.fk = false
_G.autoMine = false
_G.autoGather = false
_G.autoPick = false

-- TAB 1: KILL AURA
local TabKill = W:CreateTab("⚔️ Kill Aura")
TabKill:CreateDropdown({Name="Pilih Target NPC", Options=NPCList, CurrentOption="All NPCs", Flag="npcSel", Callback=function(v) _G.SelectedNPC = type(v)=="table" and v[1] or v end})
TabKill:CreateToggle({Name="Float Kill Aura (8.5 stud)", CurrentValue=false, Flag="fk", Callback=function(v) _G.fk = v end})

-- TAB 2: MINING
local TabMine = W:CreateTab("⛏️ Mining")
TabMine:CreateDropdown({Name="Pilih Tambang", Options=MineList, CurrentOption="All Ores", Flag="mineSel", Callback=function(v) _G.SelectedMine = type(v)=="table" and v[1] or v end})
TabMine:CreateToggle({Name="Auto Mine", CurrentValue=false, Flag="autoMine", Callback=function(v) _G.autoMine = v end})

-- TAB 3: GATHERING
local TabGather = W:CreateTab("🌿 Gathering")
TabGather:CreateDropdown({Name="Pilih Tanaman", Options=GatherList, CurrentOption="All Plants", Flag="gatherSel", Callback=function(v) _G.SelectedGather = type(v)=="table" and v[1] or v end})
TabGather:CreateToggle({Name="Auto Gather", CurrentValue=false, Flag="autoGather", Callback=function(v) _G.autoGather = v end})

-- TAB 4: PICKUP
local TabPick = W:CreateTab("📦 Item Pickup")
TabPick:CreateDropdown({Name="Pilih Item", Options=PickList, CurrentOption="All Items", Flag="pickSel", Callback=function(v) _G.SelectedPick = type(v)=="table" and v[1] or v end})
TabPick:CreateToggle({Name="Auto Pick Up", CurrentValue=false, Flag="autoPick", Callback=function(v) _G.autoPick = v end})

pcall(function() W.Enabled = true; Rayfield.Enabled = true end)

-- HELPER PROXIMITY PROMPT
local function interactWithPrompt(targetName, actionKeyword, stateVar)
    local plr = game:GetService("Players").LocalPlayer
    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local ws = game:GetService("Workspace")
    local targetPrompt = nil
    local targetPart = nil
    local minDist = math.huge

    for _, v in ipairs(ws:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local act = string.lower(v.ActionText)
            if string.find(act, actionKeyword) then
                local model = v:FindFirstAncestorOfClass("Model") or v.Parent
                local objName = v.ObjectText ~= "" and v.ObjectText or model.Name
                local match = (targetName == "All Ores" or targetName == "All Plants" or targetName == "All Items") or (string.lower(objName):find(string.lower(targetName)) ~= nil)
                
                if match then
                    local part = v.Parent:IsA("BasePart") and v.Parent or model:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local dist = (hrp.Position - part.Position).Magnitude
                        if dist < minDist then
                            minDist = dist
                            targetPrompt = v
                            targetPart = part
                        end
                    end
                end
            end
        end
    end

    if targetPrompt and targetPart then
        hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
        task.wait(0.2)
        if fireproximityprompt then
            fireproximityprompt(targetPrompt)
        else
            pcall(function()
                local rem = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                if rem and rem:FindFirstChild("Interact") then
                    rem.Interact:FireServer(targetPrompt.Parent)
                end
            end)
        end
        task.wait(targetPrompt.HoldDuration + 0.2)
    end
end

-- LOOP FLOAT KILL AURA
task.spawn(function()
    while true do
        if _G.fk then
            local plr = game:GetService("Players").LocalPlayer
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")

            if hrp and hum then
                hum.PlatformStand = true
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero

                local target = nil
                local minDist = math.huge
                local tName = _G.SelectedNPC or "All NPCs"

                for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                        local h = obj.Humanoid
                        local tHrp = obj.HumanoidRootPart
                        if h and h.Health > 0 and tHrp then
                            local match = (tName == "All NPCs") or (string.lower(obj.Name):find(string.lower(tName)) ~= nil)
                            if match then
                                local d = (hrp.Position - tHrp.Position).Magnitude
                                if d < minDist and d < 150 then
                                    minDist = d
                                    target = obj
                                end
                            end
                        end
                    end
                end

                if target then
                    local tHrp = target:FindFirstChild("HumanoidRootPart")
                    hrp.CFrame = CFrame.lookAt(tHrp.Position + Vector3.new(0, 8.5, 0), tHrp.Position)

                    pcall(function()
                        local rem = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                        if rem and rem:FindFirstChild("CombatInput") then
                            rem.CombatInput:FireServer()
                            rem.CombatInput:FireServer()
                            rem.CombatInput:FireServer()
                        end
                    end)
                end
            end
        else
            local plr = game:GetService("Players").LocalPlayer
            local char = plr.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum then hum.PlatformStand = false end
        end
        task.wait(0.03)
    end
end)

-- LOOP AUTO MINE
task.spawn(function()
    while true do
        if _G.autoMine then
            interactWithPrompt(_G.SelectedMine, "mine", _G.autoMine)
        end
        task.wait(0.5)
    end
end)

-- LOOP AUTO GATHER
task.spawn(function()
    while true do
        if _G.autoGather then
            interactWithPrompt(_G.SelectedGather, "gather", _G.autoGather)
        end
        task.wait(0.5)
    end
end)

-- LOOP AUTO PICKUP
task.spawn(function()
    while true do
        if _G.autoPick then
            interactWithPrompt(_G.SelectedPick, "pick", _G.autoPick)
        end
        task.wait(0.5)
    end
end)
