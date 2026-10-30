local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local W = Rayfield:CreateWindow({Name="MAW Auto Farm",KeySystem=false,ConfigurationSaving={Enabled=false}})
local T = W:CreateTab("Main")

T:CreateButton({Name="Hapus UI",Callback=function()Rayfield:Destroy()end})
T:CreateToggle({Name="Float Kill Aura",CurrentValue=false,Flag="fk",Callback=function(v)_G.fk=v end})
T:CreateToggle({Name="Auto Collect Plant",CurrentValue=false,Flag="plant",Callback=function(v)_G.plant=v end})

pcall(function() W.Enabled = true; Rayfield.Enabled = true end)

Rayfield:Notify({Title="OK",Content="Nyalakan Float Kill Aura atau Auto Collect Plant.",Duration=6})

_G.TargetNPC = ""
_G.PlantCollecting = false

task.spawn(function()
    while true do
        if _G.fk then
            local plr = game:GetService("Players").LocalPlayer
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            local ws = game:GetService("Workspace")

            if hrp and hum then
                hum.PlatformStand = true
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero

                local target = nil
                local minDist = math.huge
                local targetName = _G.TargetNPC or ""

                for _, obj in ipairs(ws:GetDescendants()) do
                    if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                        local h = obj.Humanoid
                        local tHrp = obj.HumanoidRootPart
                        if h and h.Health > 0 and tHrp then
                            local match = true
                            if targetName ~= "" then
                                match = string.lower(obj.Name):find(string.lower(targetName)) ~= nil
                            end
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
            local plr = game:GetService("Players").LocalPlayer
            local char = plr.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum then hum.PlatformStand = false end
            task.wait(1)
        end
        task.wait(0.03)
    end
end)

task.spawn(function()
    while true do
        if _G.plant and not _G.PlantCollecting then
            local plr = game:GetService("Players").LocalPlayer
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if hrp then
                local target = nil
                local minDist = math.huge

                for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if obj:IsA("Model") and not obj:FindFirstChild("Humanoid") then
                        local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                        if part then
                            local d = (hrp.Position - part.Position).Magnitude
                            if d < minDist then
                                minDist = d
                                target = obj
                            end
                        end
                    end
                end

                if target then
                    local part = target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")
                    if part then
                        _G.PlantCollecting = true
                        hrp.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                        task.wait(0.2)

                        for i = 1, 30 do
                            if not _G.plant then break end
                            pcall(function()
                                local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                                if remotes and remotes:FindFirstChild("Interact") then
                                    remotes.Interact:FireServer(target)
                                end
                            end)
                            task.wait(0.1)
                        end

                        _G.PlantCollecting = false
                    end
                end
            end
        end
        task.wait(0.3)
    end
end)
