warn(pcall(function()
local buttons = game:GetService("CollectionService"):GetTagged("Button")
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
            
local player = game:GetService("Players").LocalPlayer
local playerData = game:GetService("ReplicatedStorage").PlayerData[player.UserId].Stats

local eternity = require(game:GetService("ReplicatedStorage").GameModules.EternityNum.EternityNum)

--local leftLeg = player.Character["Left Leg"]

local character = player.Character
local primaryPart = character.PrimaryPart

local highestAvailableStats = {}

local priorityList = {
    ["Cash"] = 1,
    ["Multiplier"] = 2,
    ["Gems"] = 3,
    ["Event Power"] = 4,
    ["Leaf"] = 5,
}

local Window = Library.CreateLib("TITLE", "DarkTheme")
            
local connect
connect = game:GetService("RunService").Stepped:Connect(function()
    --temporary
    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.E) then
        connect:Disconnect()
    end
    
    for _,button in ipairs(buttons) do
        local statNeeded = button:GetAttribute("StatNeeded")
        if statNeeded then
            local data = playerData:FindFirstChild(statNeeded)
            local statAmount = button:GetAttribute("StatAmount")
            
            if eternity.meeq(data.Value,statAmount) then
                if highestAvailableStats[statNeeded] then
                    if highestAvailableStats[statNeeded]:GetAttribute("StatAmount") < statAmount then
                        highestAvailableStats[statNeeded] = button
                    end
                else
                    highestAvailableStats[statNeeded] = button
                end
            end
        end
    end
    
    --local availableStatsArray = {}
    local highestButton
    local highestValue = 0
    
    for statNeeded,button in pairs(highestAvailableStats) do
        --print(statNeeded,priorityList[statNeeded])
        if priorityList[statNeeded] > highestValue then
            highestButton = button
            highestValue = priorityList[statNeeded]
        end
        --table.insert(availableStatsArray,{statNeeded,button})
    end
    
    --[[table.sort(availableStatsArray,function(a,b)
        return priorityList[a[1] > priorityList[b[1]
    end)]]
    
    if highestButton then
        character:PivotTo(highestButton.PrimaryPart.CFrame + Vector3.new(0,3.5,0))
        --task.wait(0.5)
    end
    
    --[[for _,stats in ipairs(availableStatsArray) do
        character:PivotTo(stats[2].PrimaryPart.CFrame + Vector3.new(0,3.5,0))
        task.wait(0.5)
    end]]
end)
end))
