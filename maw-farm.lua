-- AKIW HUB v1.6 (Full Restoration)
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local W = Rayfield:CreateWindow({Name="AKIW HUB v1.6",KeySystem=false,ConfigurationSaving={Enabled=false}})

local T_Combat = W:CreateTab("Combat", nil)
local T_Teleport = W:CreateTab("Teleport & Map", nil)
local T_Farm = W:CreateTab("Farm", nil)
local T_WildQi = W:CreateTab("Wild Qi", nil)
local T_Sell = W:CreateTab("Auto Sell", nil)

-- Data Lists (Complete)
local BossList = {"All Bosses", "Abbot Wuxin", "Black Tiger King, Lord of the Black Wind Fortress", "Crimson Moon Priestess", "Foreman Gou", "Grey Fang", "Gu Mingfeng, the Corpse Daoist", "Hebo, the River Lord", "Hu Yaoji", "Iron-Beak Hou", "Jiao, the Flood Dragon", "Khan Temur", "Knife-Hand Lu", "Lei Wuji", "Mo Qingshan, the Deviated", "Old Scar Ma", "Old Scarback", "Qara Ashina", "Red Sail Mao", "Suanni, the Dragon King's Fifth Son", "Sword Wraith of Cloudbreak Peak", "Taotie, the Devouring Maw", "The Nameless General", "The Tiger Elder", "The Unburied General", "The Warden of the Heavenly River"}

local MobList = {"All Mobs", "Bandit Captain Ma", "Bandit Enforcer", "Bandit Swordsman", "Barrow Wight", "Beggars' Union Disciple", "Black Bear", "Black Cult Disciple", "Black Cult Elder", "Black Road Alliance Disciple", "Black Tiger Disciple", "Blight-Gullet Snapper", "Bone-Crusher Demon Ape", "Bronze Corpse", "Bronze Vault Guardian", "Buried Miner", "Caravan Master Hu", "Cave Crawler", "Corpse-Driver Acolyte", "Demonic Cult Zealot", "Dire Wolf", "Drunken Swordsman", "Elder of Mount Hua", "Emei Sect Disciple", "Fallen Monk", "Flood Dragon Pirate", "Gate-Pass Bandit", "Granny Wei", "Green Forest Thug", "Grey Wolf", "Heavenly Demon Cult Disciple", "Herb Gatherer", "Hopping Corpse", "Horse Herder", "Horse Thief", "Huo of the Left Fang", "Iron-Hide Qi Bear", "Iron-Shell Snapper", "Jade-Horn Gorer", "Jade-Horn Rhino", "Kong Wuya", "Kunlun Sect Disciple", "Lei of the Right Fang", "Longyuan Escort", "Marsh Snapper", "Maw-Spawn", "Mine Bandit", "Mount Hua Disciple", "Mount Hua Sect Disciple", "Mountain Brigand", "Mountain Tiger", "Nameless Tomb Guard", "Oj-Touched Wolf", "Outlaw Chief", "Pack Buffalo", "Petty Thief", "Qi-Burning Boar", "Qi-Deviated Madman", "Qi-Maddened Stalker", "Red Sail Raider", "Reed Serpent", "Relay Runner", "Renegade Disciple", "Restless Spirit", "River Buffalo", "Rock Golem", "Salt Trader", "Shaolin Temple Disciple", "Shield-Bearer of the Nameless Host", "Sichuan Tang Clan Disciple", "Sky-Burial Pilgrim", "Spearman of the Nameless Host", "Steppe Hunter", "Steppe Rider", "Steppe Wolf", "Tang Mo", "Tea Picker", "Tempered Demon Ape", "Tempered Stalker Alpha", "Tianshui Fishwife", "Travelling Merchant Qian", "Villager", "Wailing Shade", "Wandering Cultivator", "Wandering Swordsman", "Water Ghoul", "White-Striped Vault Tiger", "Wild Boar", "Wudang Sect Disciple", "Your Reflection", "Zhang Tieniu", "Zhenyuan Escort"}

local NpcTpList = {"All Locations", "Auctioneer Qian", "Beggars' Union Elder", "Beggar Boy Xiao", "Black Road Broker", "Blacksmith Old Pak", "Caravan Guard Bo", "Constable Captain Yun Baek", "Constable Tie", "Drunk Swordsman Ma", "Elder Zhou", "Emei Sword Nun", "Envoy Han Jingxu", "Fence Mo", "Ferryman Ou", "Granny Lian", "Granny Tsang", "Guarding Post", "Heavenly Demon Cult Envoy", "Hunter Gao", "Innkeeper Choi", "Kunlun Swordsman", "Little Mei", "Magistrate's Clerk Zhen", "Madam Hong", "Master Smith Ou", "Merchant Wang", "Oathkeeper Shi Wuyan", "Old Fisherman Lao", "Old Woman Guo", "Parrying Post", "Pill Master Yao", "Porter Dong", "Prize-Keeper Lu", "Registrar Wen", "Rice Merchant Fu", "Riddle-Keeper Su", "Salt Merchant Hu", "Scholar Bai", "Storyteller Wu", "Tailor Mei", "Tea Girl Lan", "The Old Wayfarer", "Town Crier Liu", "Training Post", "Wandering Swordsman Ling", "Waiter Xiao Er", "Weaver Jin", "Wu the Younger"}

local MineList = {"All Ores", "Copper Ore", "Iron Ore", "Qi Crystal Shard", "Spirit Jade Shard"}
local GatherList = {"All Plants", "Bamboo Shoot", "Cloudcap Mushroom", "Crimson Lotus", "Frost Moss", "Heavenly Snow Lotus", "Jade-Dew Grass", "Moonshade Orchid", "Mountain Ginseng", "Purple Wild Qi", "Spirit Grass", "Spirit Rice", "Sunfire Blossom", "Thunderstruck Root", "Vein-Bloom Orchid", "Wild Ginger"}
local PickList = {"All Items", "Five Tigers Door-Breaking Saber", "Jade Headband â€” low-grade", "Steamed Bun", "Tiger Fur Collar â€” low-grade"}
local QiSpotList = {"QiSpot_QingyunGarden", "QiSpot_EastfieldShrine", "QiSpot_SouthbrookShrine", "QiSpot_West_SunkenPagoda", "QiSpot_West_WillowShrine", "QiSpot_West_MonkHermitage"}

-- Global Variables
_G.SelectedBoss = "All Bosses"
_G.SelectedMob = "All Mobs"
_G.SelectedTp = "All Locations"
_G.SelectedMine = "All Ores"
_G.SelectedGather = "All Plants"
_G.SelectedPick = "All Items"
_G.SelectedQiSpot = "QiSpot_QingyunGarden"
_G.SelectedWildQiType = "All Wild Qi"

_G.fk = false
_G.autoAttack = false
_G.autoMine = false
_G.autoGather = false
_G.autoPick = false
_G.autoCultivate = false
_G.autoDodge = false
_G.autoSell = false
_G.Skills = {Z=false, X=false, C=false, V=false}

local plr = game.Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")
local visitedWildQi = {}

-- Combat Section
local Section1 = T_Combat:CreateSection("Target Selection")
T_Combat:CreateDropdown({Name="Boss Target", Options=BossList, CurrentOption={"All Bosses"}, Callback=function(v) _G.SelectedBoss=v[1] end})
T_Combat:CreateDropdown({Name="Mob Target", Options=MobList, CurrentOption={"All Mobs"}, Callback=function(v) _G.SelectedMob=v[1] end})

local Section2 = T_Combat:CreateSection("Combat")
T_Combat:CreateToggle({Name="Float Kill Aura (8.5)", CurrentValue=false, Callback=function(v) _G.fk=v end})
T_Combat:CreateToggle({Name="Auto Attack (Punch & Skill)", CurrentValue=false, Callback=function(v) _G.autoAttack=v end})
T_Combat:CreateToggle({Name="Auto Dodge", CurrentValue=false, Callback=function(v) _G.autoDodge=v end})

local Section3 = T_Combat:CreateSection("Auto Skills Toggle")
for _, k in ipairs({"Z","X","C","V"}) do
	T_Combat:CreateToggle({Name="Skill "..k, CurrentValue=false, Callback=function(v) _G.Skills[k]=v end})
end

-- Teleport Tab
local Section4 = T_Teleport:CreateSection("Location Select")
T_Teleport:CreateDropdown({Name="Select NPC", Options=NpcTpList, CurrentOption={"All Locations"}, Callback=function(v) _G.SelectedTp=v[1] end})

T_Teleport:CreateButton({Name="Teleport Now", Callback=function()
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		local targetName = _G.SelectedTp
		if targetName == "All Locations" then return end
		for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
			if obj:IsA("Model") and obj ~= char and obj.Name == targetName and obj:FindFirstChild("HumanoidRootPart") then
				hrp.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
				break
			end
		end
	end
end})

T_Teleport:CreateButton({Name="West Region (+18km)", Callback=function()
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = CFrame.new(hrp.Position + Vector3.new(18000, 0, 0))
	end
end})

-- Farm Tab
local Section5 = T_Farm:CreateSection("Mine")
T_Farm:CreateDropdown({Name="Select Ore", Options=MineList, CurrentOption={"All Ores"}, Callback=function(v) _G.SelectedMine=v[1] end})
T_Farm:CreateToggle({Name="Auto Mine", CurrentValue=false, Callback=function(v) _G.autoMine=v end})

local Section6 = T_Farm:CreateSection("Gather")
T_Farm:CreateDropdown({Name="Select Plant", Options=GatherList, CurrentOption={"All Plants"}, Callback=function(v) _G.SelectedGather=v[1] end})
T_Farm:CreateToggle({Name="Auto Gather", CurrentValue=false, Callback=function(v) _G.autoGather=v end})

local Section7 = T_Farm:CreateSection("Pick")
T_Farm:CreateDropdown({Name="Select Item", Options=PickList, CurrentOption={"All Items"}, Callback=function(v) _G.SelectedPick=v[1] end})
T_Farm:CreateToggle({Name="Auto Pick", CurrentValue=false, Callback=function(v) _G.autoPick=v end})

-- Wild Qi Tab
local Section8 = T_WildQi:CreateSection("Wild Qi Teleport")
T_WildQi:CreateButton({Name="Teleport Wild Qi", Callback=function()
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name == "Purple Wild Qi" and obj:FindFirstChild("HumanoidRootPart") then
			if not visitedWildQi[obj] then
				hrp.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
				visitedWildQi[obj] = true
				break
			end
		end
	end
end})

T_WildQi:CreateButton({Name="Reset Wild Qi Log", Callback=function()
	visitedWildQi = {}
end})

-- Auto Sell Tab
local Section9 = T_Sell:CreateSection("Sell Settings")
T_Sell:CreateToggle({Name="Auto Sell Items", CurrentValue=false, Callback=function(v) _G.autoSell=v end})

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

-- Float Kill Loop (Working)
task.spawn(function()
	while true do
		if _G.fk then
			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChild("Humanoid")
			
			if hrp and hum then
				hum.PlatformStand = true
				hrp.AssemblyLinearVelocity = Vector3.zero
				hrp.AssemblyAngularVelocity = Vector3.zero
				
				local target = nil
				local minDist = math.huge
				
				for _, obj in ipairs(workspace:GetDescendants()) do
					if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
						local h = obj.Humanoid
						local tHrp = obj.HumanoidRootPart
						if h and h.Health > 0 and tHrp then
							local match = (_G.SelectedBoss == "All Bosses" or string.lower(obj.Name):find(string.lower(_G.SelectedBoss)) ~= nil) or (_G.SelectedMob == "All Mobs" or string.lower(obj.Name):find(string.lower(_G.SelectedMob)) ~= nil)
							if match then
								local d = (hrp.Position - tHrp.Position).Magnitude
								if d < minDist and d < 100 then
									minDist = d
									target = obj
								end
							end
						end
					end
				end
				
				if target then
					local tHrp = target:FindFirstChild("HumanoidRootPart")
					local floatPos = tHrp.Position + Vector3.new(0, 8.5, 0)
					hrp.CFrame = CFrame.lookAt(floatPos, tHrp.Position)
					
					pcall(function()
						local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
						if remotes and remotes:FindFirstChild("CombatInput") then
							remotes.CombatInput:FireServer()
							remotes.CombatInput:FireServer()
							remotes.CombatInput:FireServer()
						end
					end)
				end
			end
		else
			local char = plr.Character
			local hum = char and char:FindFirstChild("Humanoid")
			if hum then hum.PlatformStand = false end
			task.wait(1)
		end
		task.wait(0.03)
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
						if item:IsA("Tool") then
							game:GetService("ReplicatedStorage").Remotes.SellItem:FireServer(item)
							task.wait(0.15)
						end
					end
				end
			end)
		end
		task.wait(1)
	end
end)

print("[AKIW v1.6] Script loaded successfully!")
