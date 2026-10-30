local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local W = Rayfield:CreateWindow({Name="MAW Auto Farm",KeySystem=false,ConfigurationSaving={Enabled=false}})
local T = W:CreateTab("Main")

T:CreateButton({Name="Hapus UI",Callback=function()Rayfield:Destroy()end})
T:CreateToggle({Name="Float Kill Aura",CurrentValue=false,Flag="fk",Callback=function(v)_G.fk=v end})
T:CreateToggle({Name="Plant ESP",CurrentValue=false,Flag="esp",Callback=function(v)_G.esp=v end})

pcall(function() W.Enabled = true; Rayfield.Enabled = true end)

Rayfield:Notify({Title="OK",Content="Nyalakan Float Kill Aura atau Plant ESP.",Duration=6})

_G.TargetNPC = ""
_G.ESPObjects = {}

-- FLOAT KILL AURA LOOP
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

-- PLANT ESP LOOP
task.spawn(function()
    while true do
        if _G.esp then
            local plr = game:GetService("Players").LocalPlayer
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                if obj:IsA("Model") and not obj:FindFirstChild("Humanoid") and not _G.ESPObjects[obj] then
                    local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "PlantESP"
                        bb.Adornee = part
                        bb.Size = UDim2.new(0, 100, 0, 50)
                        bb.StudsOffset = Vector3.new(0, 2, 0)
                        bb.AlwaysOnTop = true
                        
                        local txt = Instance.new("TextLabel")
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.Text = obj.Name
                        txt.TextColor3 = Color3.fromRGB(0, 255, 100)
                        txt.TextStrokeTransparency = 0
                        txt.TextSize = 14
                        txt.Font = Enum.Font.SourceSansBold
                        txt.Parent = bb
                        
                        bb.Parent = part
                        _G.ESPObjects[obj] = bb
                        
                        task.spawn(function()
                            while bb and bb.Parent and hrp do
                                if not _G.esp then break end
                                local d = (hrp.Position - part.Position).Magnitude
                                txt.Text = obj.Name .. "\n[" .. math.floor(d) .. " studs]"
                                task.wait(0.5)
                            end
                        end)
                    end
                end
            end
        else
            for obj, bb in pairs(_G.ESPObjects) do
                if bb then bb:Destroy() end
            end
            _G.ESPObjects = {}
        end
        task.wait(2)
    end
end)
