-- AKIW HUB v1.2 (Wild Qi Physics Lock Fix)
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local W = Rayfield:CreateWindow({Name="AKIW HUB v1.2",KeySystem=false,ConfigurationSaving={Enabled=false}})

local T_Combat = W:CreateTab("⚔️ Combat", 4483362458)
local T_Teleport = W:CreateTab("📍 Teleport & Map", 4483362458)
local T_Farm = W:CreateTab("🚜 Farm", 4483362458)
local T_WildQi = W:CreateTab("🌌 Wild Qi", 4483362458)

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
_G.Skills = {Z=false, X=false, C=false, V=false, ["9"]=false, ["8"]=false, ["7"]=false, ["6"]=false}

-- Data
local BossList = {"All Bosses", "Abbot Wuxin", "Black Tiger King, Lord of the Black Wind Fortress", "Crimson Moon Priestess", "Foreman Gou", "Grey Fang", "Gu Mingfeng, the Corpse Daoist", "Hebo, the River Lord", "Hu Yaoji", "Iron-Beak Hou", "Jiao, the Flood Dragon", "Khan Temur", "Knife-Hand Lu", "Lei Wuji", "Mo Qingshan, the Deviated", "Old Scar Ma", "Old Scarback", "Qara Ashina", "Red Sail Mao", "Sunni, the Dragon King's Fifth Son", "Sword Wraith of Cloudbreak Peak", "Taotie, the Devouring Maw", "The Nameless General", "The Tiger Elder", "The Unburied General", "The Warden of the Heavenly River"}
local MobList = {"All Mobs", "Bandit Captain Ma", "Bandit Enforcer", "Bandit Swordsman", "Barrow Wight", "Beggars' Union Disciple", "Black Bear", "Black Cult Disciple", "Black Cult Elder", "Black Road Alliance Disciple", "Black Tiger Disciple", "Blight-Gullet Snapper", "Bone-Crusher Demon Ape", "Bronze Corpse", "Bronze Vault Guardian", "Buried Miner", "Caravan Master Hu", "Cave Crawler", "Corpse-Driver Acolyte", "Demonic Cult Zealot", "Dire Wolf", "Drunken Swordsman", "Elder of Mount Hua", "Emei Sect Disciple", "Fallen Monk", "Flood Dragon Pirate", "Gate-Pass Bandit", "Granny Wei", "Green Forest Thug", "Grey Wolf", "Heavenly Demon Cult Disciple", "Herb Gatherer", "Hopping Corpse", "Horse Herder", "Horse Thief", "Huo of the Left Fang", "Iron-Hide Qi Bear", "Iron-Shell Snapper", "Jade-Horn Gorer", "Jade-Horn Rhino", "Kong Wuya", "Kunlun Sect Disciple", "Lei of the Right Fang", "Longyuan Escort", "Marsh Snapper", "Maw-Spawn", "Mine Bandit", "Mount Hua Disciple", "Mount Hua Sect Disciple", "Mountain Brigand", "Mountain Tiger", "Nameless Tomb Guard", "Oj-Touched Wolf", "Outlaw Chief", "Pack Buffalo", "Petty Thief", "Qi-Burning Boar", "Qi-Deviated Madman", "Qi-Maddened Stalker", "Red Sail Raider", "Reed Serpent", "Relay Runner", "Renegade Disciple", "Restless Spirit", "River Buffalo", "Rock Golem", "Salt Trader", "Shaolin Temple Disciple", "Shield-Bearer of the Nameless Host", "Sichuan Tang Clan Disciple", "Sky-Burial Pilgrim", "Spearman of the Nameless Host", "Steppe Hunter", "Steppe Rider", "Steppe Wolf", "Tang Mo", "Tea Picker", "Tempered Demon Ape", "Tempered Stalker Alpha", "Tianshui Fishwife", "Travelling Merchant Qian", "Villager", "Wailing Shade", "Wandering Cultivator", "Wandering Swordsman", "Water Ghoul", "White-Striped Vault Tiger", "Wild Boar", "Wudang Sect Disciple", "Your Reflection", "Zhang Tieniu", "Zhenyuan Escort"}
local NpcTpList = {"All Locations", "Auctioneer Qian", "Beggars' Union Elder", "Beggar Boy Xiao", "Black Road Broker", "Blacksmith Old Pak", "Caravan Guard Bo", "Constable Captain Yun Baek", "Constable Tie", "Drunk Swordsman Ma", "Elder Zhou", "Emei Sword Nun", "Envoy Han Jingxu", "Fence Mo", "Ferryman Ou", "Granny Lian", "Granny Tsang", "Guarding Post", "Heavenly Demon Cult Envoy", "Hunter Gao", "Innkeeper Choi", "Kunlun Swordsman", "Little Mei", "Magistrate's Clerk Zhen", "Madam Hong", "Master Smith Ou", "Merchant Wang", "Oathkeeper Shi Wuyan", "Old Fisherman Lao", "Old Woman Guo", "Parrying Post", "Pill Master Yao", "Porter Dong", "Prize-Keeper Lu", "Registrar Wen", "Rice Merchant Fu", "Riddle-Keeper Su", "Salt Merchant Hu", "Scholar Bai", "Storyteller Wu", "Tailor Mei", "Tea Girl Lan", "The Old Wayfarer", "Town Crier Liu", "Training Post", "Wandering Swordsman Ling", "Waiter Xiao Er", "Weaver Jin", "Wu the Younger", "Alliance Clerk Han", "Apprentice Gu"}
local MineList = {"All Ores", "Copper Ore", "Iron Ore", "Qi Crystal Shard", "Spirit Jade Shard"}
local GatherList = {"All Plants", "Bamboo Shoot", "Cloudcap Mushroom", "Crimson Lotus", "Frost Moss", "Heavenly Snow Lotus", "Jade-Dew Grass", "Moonshade Orchid", "Mountain Ginseng", "Purple Wild Qi", "Spirit Grass", "Spirit Rice", "Sunfire Blossom", "Thunderstruck Root", "Vein-Bloom Orchid", "Wild Ginger"}
local PickList = {"All Items", "Five Tigers Door-Breaking Saber", "Jade Headband — low-grade", "Steamed Bun", "Tiger Fur Collar — low-grade"}
local QiSpotList = {"QiSpot_QingyunGarden", "QiSpot_EastfieldShrine", "QiSpot_SouthbrookShrine", "QiSpot_West_SunkenPagoda", "QiSpot_West_WillowShrine", "QiSpot_West_MonkHermitage"}

local plr = game.Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

-- Combat Tab
local Section1 = T_Combat:CreateSection("Target Selection")
T_Combat:CreateDropdown({Name="Boss Target",Options=BossList,CurrentOption={"All Bosses"},MultipleOptions=false,Flag="BossDropdown",Callback=function(Option)_G.SelectedBoss=Option[1]end,})
T_Combat:CreateDropdown({Name="Mob Target",Options=MobList,CurrentOption={"All Mobs"},MultipleOptions=false,Flag="MobDropdown",Callback=function(Option)_G.SelectedMob=Option[1]end,})

local Section2 = T_Combat:CreateSection("Combat")
T_Combat:CreateToggle({Name="Float Kill Aura (8.5)",CurrentValue=false,Flag="FK",Callback=function(V)_G.fk=V end,})
T_Combat:CreateToggle({Name="Auto Attack (Punch & Skill)",CurrentValue=false,Flag="AutoAttack",Callback=function(V)_G.autoAttack=V end,})

local Section3 = T_Combat:CreateSection("Auto Skills Toggle")
for _, k in ipairs({"Z","X","C","V","9","8","7","6"}) do
	T_Combat:CreateToggle({Name="Skill "..k,CurrentValue=false,Flag="Skill"..k,Callback=function(V)_G.Skills[k]=V end,})
end

-- Teleport Tab
local Section4 = T_Teleport:CreateSection("Location Select")
T_Teleport:CreateDropdown({Name="Select NPC",Options=NpcTpList,CurrentOption={"All Locations"},MultipleOptions=false,Flag="NpcDropdown",Callback=function(Option)_G.SelectedTp=Option[1]end,})

T_Teleport:CreateButton({Name="Teleport Now",Callback=function()
	local char=plr.Character
	local hrp=char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		local targetName=_G.SelectedTp
		if targetName=="All Locations"then return end
		for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
			if obj:IsA("Model")and obj~=char and obj.Name==targetName and obj:FindFirstChild("HumanoidRootPart")then
				hrp.CFrame=obj.HumanoidRootPart.CFrame+Vector3.new(0,3,0)
				break
			end
		end
	end
end,})

T_Teleport:CreateButton({Name="West Region (+18km)",Callback=function()
	local char=plr.Character
	local hrp=char and char:FindFirstChild("HumanoidRootPart")
	if hrp then hrp.CFrame=hrp.CFrame+Vector3.new(18000,5,0)end
end,})

T_Teleport:CreateButton({Name="Pill Seller",Callback=function()
	local char=plr.Character
	local hrp=char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
			if obj:IsA("Model")and obj~=char and obj:FindFirstChild("HumanoidRootPart")then
				if string.lower(obj.Name):find("pill")and string.lower(obj.Name):find("seller")then
					hrp.CFrame=obj.HumanoidRootPart.CFrame+Vector3.new(0,3,0)
					break
				end
			end
		end
	end
end,})

T_Teleport:CreateButton({Name="Blacksmith",Callback=function()
	local char=plr.Character
	local hrp=char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
			if obj:IsA("Model")and obj~=char and string.find(obj.Name,"Smith")and obj:FindFirstChild("HumanoidRootPart")then
				hrp.CFrame=obj.HumanoidRootPart.CFrame+Vector3.new(0,3,0)
				break
			end
		end
	end
end,})

T_Teleport:CreateButton({Name="Merchant",Callback=function()
	local char=plr.Character
	local hrp=char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
			if obj:IsA("Model")and obj~=char and string.find(obj.Name,"Merchant")and obj:FindFirstChild("HumanoidRootPart")then
				hrp.CFrame=obj.HumanoidRootPart.CFrame+Vector3.new(0,3,0)
				break
			end
		end
	end
end,})

-- Mining Tab
T_Farm:CreateSection("Mining")
T_Farm:CreateDropdown({Name="Select Ore",Options=MineList,CurrentOption={"All Ores"},MultipleOptions=false,Flag="OreDropdown",Callback=function(Option)_G.SelectedMine=Option[1]end,})
T_Farm:CreateToggle({Name="Auto Mine",CurrentValue=false,Flag="AutoMine",Callback=function(V)_G.autoMine=V end,})

-- Gathering Tab
T_Farm:CreateSection("Gathering")
T_Farm:CreateDropdown({Name="Select Plant",Options={"All Plants", "Wild Qi", "Bamboo Shoot", "Cloudcap Mushroom", "Crimson Lotus", "Frost Moss", "Heavenly Snow Lotus", "Jade-Dew Grass", "Moonshade Orchid", "Mountain Ginseng", "Spirit Grass", "Spirit Rice", "Sunfire Blossom", "Thunderstruck Root", "Vein-Bloom Orchid", "Wild Ginger"},CurrentOption={"All Plants"},MultipleOptions=false,Flag="PlantDropdown",Callback=function(Option)_G.SelectedGather=Option[1]end,})
T_Farm:CreateToggle({Name="Auto Gathering",CurrentValue=false,Flag="AutoGather",Callback=function(V)_G.autoGather=V end,})

-- Pickup Tab
T_Farm:CreateSection("Pickup")
T_Farm:CreateDropdown({Name="Select Item",Options=PickList,CurrentOption={"All Items"},MultipleOptions=false,Flag="ItemDropdown",Callback=function(Option)_G.SelectedPick=Option[1]end,})
T_Farm:CreateToggle({Name="Auto Pickup",CurrentValue=false,Flag="AutoPickup",Callback=function(V)_G.autoPick=V end,})

-- Wild Qi Tab
T_WildQi:CreateButton({Name="Teleport to Wild Qi", Callback=function()
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		local targetQi = nil
		local minDist = math.huge
		for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
			if obj.Name == "WildQi" and obj:IsA("Model") then
				local targetPos = nil
				if obj.PrimaryPart then
					targetPos = obj.PrimaryPart.Position
				else
					local part = obj:FindFirstChildWhichIsA("BasePart")
					if part then targetPos = part.Position end
				end
				
				if targetPos then
					local dist = (hrp.Position - targetPos).Magnitude
					if dist < minDist then minDist = dist; targetQi = targetPos end
				end
			end
		end
		
		if targetQi then
			-- Normal Teleport
			hrp.CFrame = CFrame.new(targetQi)
		else
			Rayfield:Notify({Title = "AKIW HUB v1.2", Content = "No Wild Qi found!", Duration = 3, Image = 4483362458})
		end
	end
end})

-- Map Section (Inside Teleport)
T_Teleport:CreateSection("2x2 Map Teleport")
T_Teleport:CreateButton({Name="Qingyun Garden",Callback=function()
	local char=plr.Character
	local hrp=char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
			if obj:IsA("Model")and obj~=char and string.find(string.lower(obj.Name),"qingyun")and obj:FindFirstChild("HumanoidRootPart")then
				hrp.CFrame=obj.HumanoidRootPart.CFrame+Vector3.new(0,5,0)
				break
			end
		end
	end
end,})

T_Teleport:CreateButton({Name="West Region",Callback=function()
	local char=plr.Character
	local hrp=char and char:FindFirstChild("HumanoidRootPart")
	if hrp then hrp.CFrame=hrp.CFrame+Vector3.new(18000,5,0)end
end,})

T_Teleport:CreateButton({Name="Eastfield Shrine",Callback=function()
	local char=plr.Character
	local hrp=char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
			if obj.Name=="QiSpot_EastfieldShrine"and obj:FindFirstChild("Position")then
				hrp.CFrame=CFrame.new(obj.Position.Value)+Vector3.new(0,5,0)
				break
			end
		end
	end
end,})

T_Teleport:CreateButton({Name="Southbrook Shrine",Callback=function()
	local char=plr.Character
	local hrp=char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
			if obj.Name=="QiSpot_SouthbrookShrine"and obj:FindFirstChild("Position")then
				hrp.CFrame=CFrame.new(obj.Position.Value)+Vector3.new(0,5,0)
				break
			end
		end
	end
end,})

-- Chain Farm Loop
local function chainLoop(toggleKey, selectedVar, keyword)
	task.spawn(function()
		local harvestedLocations={}
		while true do
			if _G[toggleKey]then
				local char=plr.Character
				local hrp=char and char:FindFirstChild("HumanoidRootPart")
				if hrp then
					local targetPrompt, targetPart, minDist = nil, nil, math.huge
					local selected=_G[selectedVar]or "All"
					for _, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
						if v:IsA("ProximityPrompt")and string.find(string.lower(v.ActionText),keyword)then
							local model=v:FindFirstAncestorOfClass("Model")or v.Parent
							local objName=v.ObjectText~=""and v.ObjectText or model.Name
							if selected:find("All")or string.lower(objName):find(string.lower(selected))then
								local part=v.Parent:IsA("BasePart")and v.Parent or model:FindFirstChildWhichIsA("BasePart")
								if part then
									local locKey=tostring(part.Position)
									if not harvestedLocations[locKey]then
										local dist=(hrp.Position-part.Position).Magnitude
										if dist<minDist then minDist=dist; targetPrompt=v; targetPart=part end
									end
								end
							end
						end
					end
					if targetPrompt and targetPart then
						local locKey=tostring(targetPart.Position)
						hrp.CFrame=targetPart.CFrame+Vector3.new(0,3,0)
						task.wait(0.2)
						if fireproximityprompt then fireproximityprompt(targetPrompt)
						else pcall(function() game:GetService("ReplicatedStorage").Remotes.Interact:FireServer(targetPrompt.Parent)end)end
						task.wait(targetPrompt.HoldDuration+0.5)
						harvestedLocations[locKey]=true
					else
						harvestedLocations={}
						task.wait(0.5)
					end
				end
			else harvestedLocations={}end
			task.wait(0.1)
		end
	end)
end

chainLoop("autoMine","SelectedMine","mine")
chainLoop("autoGather","SelectedGather","gather")
chainLoop("autoPick","SelectedPick","pick")




-- Kill Aura Loop (Float 8.5 + Target Lock + Safe Zone, No Auto Attack)
task.spawn(function()
	local lockedTarget=nil
	while true do
		if _G.fk then
			local char=plr.Character
			local hrp=char and char:FindFirstChild("HumanoidRootPart")
			if hrp and char:FindFirstChild("Humanoid")then
				char.Humanoid.PlatformStand=true
				hrp.AssemblyLinearVelocity=Vector3.zero
				
				if lockedTarget and lockedTarget:FindFirstChild("Humanoid")and lockedTarget.Humanoid.Health>0 then
				elseif lockedTarget and (not lockedTarget:FindFirstChild("Humanoid")or lockedTarget.Humanoid.Health<=0) then
					hrp.CFrame=hrp.CFrame+Vector3.new(0,50,0)
					task.wait(1)
					lockedTarget=nil
				else
					local wantBoss=_G.SelectedBoss~="All Bosses"
					local wantMob=_G.SelectedMob~="All Mobs"
					if wantBoss then
						for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
							if obj:IsA("Model")and obj~=char and obj.Name==_G.SelectedBoss and obj:FindFirstChild("Humanoid")and obj.Humanoid.Health>0 then
								lockedTarget=obj; break
							end
						end
					elseif wantMob then
						for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
							if obj:IsA("Model")and obj~=char and obj.Name==_G.SelectedMob and obj:FindFirstChild("Humanoid")and obj.Humanoid.Health>0 then
								lockedTarget=obj; break
							end
						end
					else
						local minDist=math.huge
						for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
							if obj:IsA("Model")and obj~=char and obj:FindFirstChild("Humanoid")and obj:FindFirstChild("HumanoidRootPart")and obj.Humanoid.Health>0 then
								local d=(hrp.Position-obj.HumanoidRootPart.Position).Magnitude
								if d<minDist then minDist=d; lockedTarget=obj end
							end
						end
					end
				end
				
				if lockedTarget and lockedTarget:FindFirstChild("HumanoidRootPart")then
					hrp.CFrame=CFrame.lookAt(lockedTarget.HumanoidRootPart.Position+Vector3.new(0,8.5,0),lockedTarget.HumanoidRootPart.Position)
				end
			end
		else
			lockedTarget=nil
			local char=plr.Character
			if char and char:FindFirstChild("Humanoid")then char.Humanoid.PlatformStand=false end
		end
		task.wait(0.05)
	end
end)

-- Auto Attack Loop (Separate from Kill Aura)
task.spawn(function()
	local lockedTarget=nil
	while true do
		if _G.autoAttack then
			local char=plr.Character
			local hrp=char and char:FindFirstChild("HumanoidRootPart")
			if hrp and char:FindFirstChild("Humanoid")then
				
				if lockedTarget and lockedTarget:FindFirstChild("Humanoid")and lockedTarget.Humanoid.Health>0 then
				elseif lockedTarget and (not lockedTarget:FindFirstChild("Humanoid")or lockedTarget.Humanoid.Health<=0) then
					lockedTarget=nil
				else
					local wantBoss=_G.SelectedBoss~="All Bosses"
					local wantMob=_G.SelectedMob~="All Mobs"
					if wantBoss then
						for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
							if obj:IsA("Model")and obj~=char and obj.Name==_G.SelectedBoss and obj:FindFirstChild("Humanoid")and obj.Humanoid.Health>0 then
								lockedTarget=obj; break
							end
						end
					elseif wantMob then
						for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
							if obj:IsA("Model")and obj~=char and obj.Name==_G.SelectedMob and obj:FindFirstChild("Humanoid")and obj.Humanoid.Health>0 then
								lockedTarget=obj; break
							end
						end
					else
						local minDist=math.huge
						for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
							if obj:IsA("Model")and obj~=char and obj:FindFirstChild("Humanoid")and obj:FindFirstChild("HumanoidRootPart")and obj.Humanoid.Health>0 then
								local d=(hrp.Position-obj.HumanoidRootPart.Position).Magnitude
								if d<minDist then minDist=d; lockedTarget=obj end
							end
						end
					end
				end
				
				if lockedTarget and lockedTarget:FindFirstChild("HumanoidRootPart")then
					pcall(function()
						game:GetService("ReplicatedStorage").Remotes.CombatInput:FireServer()
					end)
					
					for k,v in pairs(_G.Skills)do
						if v then
							VIM:SendKeyEvent(true,Enum.KeyCode[k],false,game)
							task.wait(0.05)
							VIM:SendKeyEvent(false,Enum.KeyCode[k],false,game)
						end
					end
				end
			end
		else
			lockedTarget=nil
		end
		task.wait(0.1)
	end
end)

print("[AKIW] Hub v1.2 Loaded - Rayfield UI")