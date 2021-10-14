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
local isactive = false
local window = library.CreateLib("Button Pressor", "DarkTheme")
local tab = window:NewTab("Main")
local section = tab:NewSection("Commands")
local togglebutton
local speed = 100
local runNumber = 0
togglebutton = section:NewButton("Toggle bot (inactive)", "les go", function()   
    isactive = not isactive
    local newtext = isactive and " (active)" or " (inactive)"
    togglebutton:UpdateButton("Toggle bot"..newtext) 
    print(newtext)
end)
section:NewSlider("Bot speed", "higher is better", 100, 0, function(s)
    speed = s
end)



local connect
connect = game:GetService("RunService").Stepped:Connect(function()
    if isactive and runNumber < speed then
        
        runNumber = runNumber + 1 
        
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
        else
            runNumber = 0
        end
    end)
end))
