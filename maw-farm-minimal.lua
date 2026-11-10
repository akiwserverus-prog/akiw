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

local BossList = {"All Bosses", "Abbot Wuxin", "Black Tiger King", "Crimson Moon Priestess", "Suanni, the Dragon King's Fifth Son"}
local MobList = {"All Mobs", "Bandit Captain Ma", "Black Bear", "Dire Wolf", "Mountain Tiger"}

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
