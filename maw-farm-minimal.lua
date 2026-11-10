-- AKIW HUB v1.3 (Rayfield Minimal)
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local W = Rayfield:CreateWindow({Name="Akiw HUB 1.3",KeySystem=false,ConfigurationSaving={Enabled=false}})
local T = W:CreateTab("Main")

-- Global Variables
_G.autoAttack = false
_G.autoDodge = false
_G.fk = false

local plr = game.Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

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
