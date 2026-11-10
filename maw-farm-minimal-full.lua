-- AKIW HUB v1.3 Minimal Full (No UI - Command Based)
local plr = game.Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

-- Global Controls (Change via console)
_G.SelectedBoss = "All Bosses"
_G.SelectedMob = "All Mobs"
_G.fk = false
_G.autoAttack = false
_G.autoDodge = false
_G.autoFarm = false
_G.Skills = {Z=false, X=false, C=false, V=false}

print("=== AKIW HUB v1.3 Minimal ===")
print("Commands:")
print("_G.autoAttack = true -- Toggle auto attack")
print("_G.autoDodge = true -- Toggle auto dodge")
print("_G.fk = true -- Toggle float kill")
print("_G.Skills.Z = true -- Toggle skill Z")
print("_G.autoFarm = true -- Farm selected mob")

-- Helper
local function getTp(name)
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name == name and obj:FindFirstChild("HumanoidRootPart") then
			return obj.HumanoidRootPart.CFrame
		end
	end
end

-- Wild Qi Teleport
local visitedWildQi = {}
local wildQiTypes = {"Purple Wild Qi"}

function _G.TeleportWildQi()
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and table.find(wildQiTypes, obj.Name) and obj:FindFirstChild("HumanoidRootPart") then
			if not visitedWildQi[obj] then
				hrp.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
				visitedWildQi[obj] = true
				print("[WildQi] Teleported to", obj.Name)
				return
			end
		end
	end
	print("[WildQi] All visited. Resetting...")
	visitedWildQi = {}
end

function _G.ResetWildQi()
	visitedWildQi = {}
	print("[WildQi] Visited list reset")
end

-- Float Kill
task.spawn(function()
	while true do
		if _G.fk then
			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChild("Humanoid")
			
			if hrp and hum then
				for _, obj in ipairs(workspace:GetDescendants()) do
					if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
						local objHum = obj.Humanoid
						local objHrp = obj.HumanoidRootPart
						
						if objHum.Health > 0 then
							local match = false
							if _G.SelectedBoss == "All Bosses" or obj.Name == _G.SelectedBoss then match = true end
							if _G.SelectedMob == "All Mobs" or obj.Name == _G.SelectedMob then match = true end
							
							if match then
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
		end
		task.wait(0.05)
	end
end)

-- Auto Attack
task.spawn(function()
	local lockedTarget = nil
	while true do
		if _G.autoAttack or _G.autoFarm then
			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hrp and char:FindFirstChild("Humanoid") then
				
				if lockedTarget and lockedTarget:FindFirstChild("Humanoid") and lockedTarget.Humanoid.Health > 0 then
				elseif lockedTarget and (not lockedTarget:FindFirstChild("Humanoid") or lockedTarget.Humanoid.Health <= 0) then
					lockedTarget = nil
				else
					local minDist = math.huge
					for _, obj in ipairs(workspace:GetDescendants()) do
						if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") and obj.Humanoid.Health > 0 then
							local match = false
							if _G.autoFarm then
								if _G.SelectedMob == "All Mobs" or obj.Name == _G.SelectedMob then match = true end
							else
								match = true
							end
							
							if match then
								local d = (hrp.Position - obj.HumanoidRootPart.Position).Magnitude
								if d < minDist then minDist = d; lockedTarget = obj end
							end
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
		else
			lockedTarget = nil
		end
		task.wait(0.1)
	end
end)

-- Auto Dodge
task.spawn(function()
	while true do
		if _G.autoDodge then
			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChild("Humanoid")
			
			if hrp and hum then
				for _, obj in ipairs(workspace:GetDescendants()) do
					if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
						local objHum = obj.Humanoid
						local objHrp = obj.HumanoidRootPart
						
						if objHum.Health > 0 then
							local dist = (hrp.Position - objHrp.Position).Magnitude
							if dist < 12 then
								local toEnemy = (objHrp.Position - hrp.Position).Unit
								local right = hrp.CFrame.RightVector
								local dodgeDir = right * (math.random() > 0.5 and 1 or -1)
								hrp.CFrame = hrp.CFrame + dodgeDir * 8
								task.wait(0.3)
								break
							end
						end
					end
				end
			end
		end
		task.wait(0.2)
	end
end)

print("[AKIW] Ready! Use _G commands to control")
