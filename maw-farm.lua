-- AKIW HUB v1.4 (Rayfield Version)
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local W = Rayfield:CreateWindow({Name="AKIW HUB 1.4",KeySystem=false,ConfigurationSaving={Enabled=false}})

local T_Combat = W:CreateTab("Combat", nil)
local T_Teleport = W:CreateTab("Teleport", nil)
local T_Sell = W:CreateTab("Auto Sell", nil)

_G.autoAttack = false
_G.autoDodge = false
_G.fk = false
_G.autoSell = false
_G.SelectedBoss = "All Bosses"
_G.SelectedMob = "All Mobs"
_G.SelectedRealm = "Mortal Realm"
_G.Skills = {Z=false, X=false, C=false, V=false}

local BossList = {"All Bosses", "Abbot Wuxin", "Black Tiger King, Lord of the Black Wind Fortress", "Crimson Moon Priestess", "Foreman Gou", "Grey Fang", "Gu Mingfeng, the Corpse Daoist", "Hebo, the River Lord", "Hu Yaoji", "Iron-Beak Hou", "Jiao, the Flood Dragon", "Khan Temur", "Knife-Hand Lu", "Lei Wuji", "Mo Qingshan, the Deviated", "Old Scar Ma", "Old Scarback", "Qara Ashina", "Red Sail Mao", "Suanni, the Dragon King's Fifth Son", "Sword Wraith of Cloudbreak Peak", "Taotie, the Devouring Maw", "The Nameless General", "The Tiger Elder", "The Unburied General", "The Warden of the Heavenly River"}
local MobList = {"All Mobs", "Bandit Captain Ma", "Bandit Enforcer", "Bandit Swordsman", "Barrow Wight", "Beggars' Union Disciple", "Black Bear", "Black Cult Disciple", "Black Cult Elder", "Black Road Alliance Disciple", "Black Tiger Disciple", "Blight-Gullet Snapper", "Bone-Crusher Demon Ape", "Bronze Corpse", "Bronze Vault Guardian", "Buried Miner", "Caravan Master Hu", "Cave Crawler", "Corpse-Driver Acolyte", "Demonic Cult Zealot", "Dire Wolf", "Drunken Swordsman", "Elder of Mount Hua", "Emei Sect Disciple", "Fallen Monk", "Flood Dragon Pirate", "Gate-Pass Bandit", "Granny Wei", "Green Forest Thug", "Grey Wolf", "Heavenly Demon Cult Disciple", "Herb Gatherer", "Hopping Corpse", "Horse Herder", "Horse Thief", "Huo of the Left Fang", "Iron-Hide Qi Bear", "Iron-Shell Snapper", "Jade-Horn Gorer", "Jade-Horn Rhino", "Kong Wuya", "Kunlun Sect Disciple", "Lei of the Right Fang", "Longyuan Escort", "Marsh Snapper", "Maw-Spawn", "Mine Bandit", "Mount Hua Disciple", "Mount Hua Sect Disciple", "Mountain Brigand", "Mountain Tiger", "Nameless Tomb Guard", "Oj-Touched Wolf", "Outlaw Chief", "Pack Buffalo", "Petty Thief", "Qi-Burning Boar", "Qi-Deviated Madman", "Qi-Maddened Stalker", "Red Sail Raider", "Reed Serpent", "Relay Runner", "Renegade Disciple", "Restless Spirit", "River Buffalo", "Rock Golem", "Salt Trader", "Shaolin Temple Disciple", "Shield-Bearer of the Nameless Host", "Sichuan Tang Clan Disciple", "Sky-Burial Pilgrim", "Spearman of the Nameless Host", "Steppe Hunter", "Steppe Rider", "Steppe Wolf", "Tang Mo", "Tea Picker", "Tempered Demon Ape", "Tempered Stalker Alpha", "Tianshui Fishwife", "Travelling Merchant Qian", "Villager", "Wailing Shade", "Wandering Cultivator", "Wandering Swordsman", "Water Ghoul", "White-Striped Vault Tiger", "Wild Boar", "Wudang Sect Disciple", "Your Reflection", "Zhang Tieniu", "Zhenyuan Escort"}

T_Combat:CreateDropdown({Name="Boss", Options=BossList, Callback=function(v) _G.SelectedBoss = v[1] end})
T_Combat:CreateDropdown({Name="Mob", Options=MobList, Callback=function(v) _G.SelectedMob = v[1] end})
T_Combat:CreateToggle({Name="Auto Attack", Callback=function(v) _G.autoAttack = v end})
T_Combat:CreateToggle({Name="Auto Dodge", Callback=function(v) _G.autoDodge = v end})
T_Combat:CreateToggle({Name="Float Kill", Callback=function(v) _G.fk = v end})

T_Teleport:CreateButton({Name="Teleport Wild Qi", Callback=function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "Purple Wild Qi" and obj:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
            break
        end
    end
end})

T_Sell:CreateDropdown({Name="Sell Realm", Options={"Mortal Realm", "Qi Condensation", "Foundation Establishment", "Golden Core", "Nascent Soul"}, Callback=function(v) _G.SelectedRealm = v[1] end})
T_Sell:CreateToggle({Name="Auto Sell", Callback=function(v) _G.autoSell = v end})

-- [Include loops here for logic - omitted for brevity]
