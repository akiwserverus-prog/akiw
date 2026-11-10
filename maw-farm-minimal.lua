-- AKIW HUB v1.2 Minimal (No Rayfield)
local plr = game.Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

-- Global Variables
_G.SelectedBoss = "All Bosses"
_G.SelectedMob = "All Mobs"
_G.fk = false
_G.autoAttack = false
_G.autoDodge = false
_G.Skills = {Z=false, X=false, C=false, V=false}

print("[AKIW] Minimal script loaded - No UI")

-- Auto Attack Loop
task.spawn(function()
	local lockedTarget = nil
	while true do
		if _G.autoAttack then
			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hrp and char:FindFirstChild("Humanoid") then
				
				if lockedTarget and lockedTarget:FindFirstChild("Humanoid") and lockedTarget.Humanoid.Health > 0 then
				elseif lockedTarget and (not lockedTarget:FindFirstChild("Humanoid") or lockedTarget.Humanoid.Health <= 0) then
					lockedTarget = nil
				else
					local minDist = math.huge
					for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
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
		else
			lockedTarget = nil
		end
		task.wait(0.1)
	end
end)

print("[AKIW] Auto Attack ready - toggle _G.autoAttack = true")
