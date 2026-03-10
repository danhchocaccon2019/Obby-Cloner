if game.Players.LocalPlayer.PlayerGui:FindFirstChild("sscriptrOC") then
    game.Players.LocalPlayer.PlayerGui.sscriptrOC:Destroy()
    for _, obj in ipairs(workspace.Obbies:GetDescendants()) do
        if obj:IsA("BoxHandleAdornment") then
            obj:Destroy()
        end
    end
    return
end

warn("-+-------=-s͘c͘r͘i͘p͘t͘-b͘e͘g͘i͘n͘-=-------+-")
print("Thanks Skelly Friend, BLOCKE, gord for inspiring me :> Also thanks sno3iku for supporting me through out the journey :3")
print("Remember to get 100M Cash before Cloning.")

local EffectModule = nil
pcall(function()
    EffectModule = require(game:GetService("ReplicatedStorage").EffectModule)
end)

local GetModelProps = nil
pcall(function()
    GetModelProps = require(game:GetService("ReplicatedStorage").ModelProps)
end)

local function getModelDefaults(partName)
    if not GetModelProps then return nil end
    local ok, result = pcall(GetModelProps, partName)
    if ok then return result end
    return nil
end

-- [[ GUI SETUP ]]
local ui = Instance.new("ScreenGui")
ui.Parent = game.Players.LocalPlayer.PlayerGui
ui.ResetOnSpawn = false
ui.IgnoreGuiInset = true
ui.Name = "sscriptrOC"

local mainFrame = Instance.new("Frame")
mainFrame.Parent = ui
mainFrame.Size = UDim2.new(0.3, 0, 0.2, 0)
mainFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
mainFrame.BorderSizePixel = 1
mainFrame.Name = "MainFrame"

local infoBar = Instance.new("Frame")
infoBar.Parent = mainFrame
infoBar.Size = UDim2.new(1, 0, 0, 40)
infoBar.Position = UDim2.new(0, 0, 1, 0)
infoBar.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
infoBar.BorderSizePixel = 1

local header = Instance.new("Frame")
header.Parent = mainFrame
header.Size = UDim2.new(1, 0, 0.2, 0)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
header.BorderSizePixel = 1

local headerText = Instance.new("TextLabel")
headerText.Parent = header
headerText.Size = UDim2.new(1, 0, 1, 0)
headerText.Text = "Obby Stealer Script"
headerText.Font = Enum.Font.SourceSans
headerText.TextScaled = true
headerText.TextColor3 = Color3.fromRGB(0, 0, 0)
headerText.BackgroundTransparency = 1

local exitButton = Instance.new("TextButton")
exitButton.Parent = header
exitButton.Size = UDim2.new(0, 20, 0, 20)
exitButton.Position = UDim2.new(1, -25, 0, 5)
exitButton.Text = "X"
exitButton.Font = Enum.Font.SourceSansBold
exitButton.TextScaled = true
exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
exitButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
exitButton.BorderSizePixel = 1

exitButton.MouseButton1Click:Connect(function()
    ui:Destroy()
end)

local textBox = Instance.new("TextBox")
textBox.Parent = mainFrame
textBox.Size = UDim2.new(0.8, 0, 0.4, 0)
textBox.Position = UDim2.new(0.1, 0, 0.3, 0)
textBox.PlaceholderText = "Enter Player Name or Display Name"
textBox.Font = Enum.Font.SourceSans
textBox.Text = ""
textBox.TextScaled = true
textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textBox.BorderSizePixel = 1

local submitButton = Instance.new("TextButton")
submitButton.Parent = mainFrame
submitButton.Size = UDim2.new(0.5, 0, 0.2, 0)
submitButton.Position = UDim2.new(0.25, 0, 0.75, 0)
submitButton.Text = "Copy"
submitButton.Font = Enum.Font.SourceSansBold
submitButton.TextScaled = true
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
submitButton.BorderSizePixel = 1

-- [[ DRAG LOGIC ]]
local dragging = false
local dragStart, startPos, dragInput

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- [[ RESIZE LOGIC ]]
local resizeHandle = Instance.new("Frame")
resizeHandle.Parent = mainFrame
resizeHandle.Size = UDim2.new(0, 10, 0, 10)
resizeHandle.Position = UDim2.new(1, -10, 1, -10)
resizeHandle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
resizeHandle.BorderSizePixel = 0
resizeHandle.Name = "ResizeHandle"

local resizing = false
local resizeStart, startSize

resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        resizeStart = input.Position
        startSize = mainFrame.Size
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                resizing = false
            end
        end)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - resizeStart
        local newWidth = math.max(startSize.X.Offset + delta.X, -200)
        local newHeight = math.max(startSize.Y.Offset + delta.Y, -100)
        mainFrame.Size = UDim2.new(startSize.X.Scale, newWidth, startSize.Y.Scale, newHeight)
    end
end)

-- [[ INFO BAR LABELS ]]
local Input = textBox
local SelectText = Instance.new("TextLabel")
SelectText.Parent = infoBar
SelectText.Size = UDim2.new(1, -20, 0.5, 0)
SelectText.Position = UDim2.new(0, 10, 0, 0)
SelectText.Font = Enum.Font.SourceSansSemibold
SelectText.TextScaled = false
SelectText.TextSize = 16
SelectText.TextXAlignment = Enum.TextXAlignment.Left
SelectText.TextYAlignment = Enum.TextYAlignment.Center
SelectText.TextColor3 = Color3.fromRGB(20, 20, 20)
SelectText.BackgroundTransparency = 1
SelectText.Text = "Selecting:"

local StatusText = Instance.new("TextLabel")
StatusText.Parent = infoBar
StatusText.Size = UDim2.new(0.7, -10, 0.5, 0)
StatusText.Position = UDim2.new(0, 10, 0.5, 0)
StatusText.AnchorPoint = Vector2.new(0, 0)
StatusText.Font = Enum.Font.SourceSans
StatusText.TextScaled = false
StatusText.TextWrapped = false
StatusText.TextSize = 15
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.TextYAlignment = Enum.TextYAlignment.Center
StatusText.TextColor3 = Color3.fromRGB(40, 40, 40)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Status: Idle   "

local ETAText = Instance.new("TextLabel")
ETAText.Parent = infoBar
ETAText.Size = UDim2.new(0.3, -10, 0.5, 0)
ETAText.Position = UDim2.new(0.7, 0, 0.5, 0)
ETAText.AnchorPoint = Vector2.new(0, 0)
ETAText.Font = Enum.Font.SourceSans
ETAText.TextScaled = false
ETAText.TextWrapped = false
ETAText.TextSize = 15
ETAText.TextXAlignment = Enum.TextXAlignment.Right
ETAText.TextYAlignment = Enum.TextYAlignment.Center
ETAText.TextColor3 = Color3.fromRGB(40, 40, 40)
ETAText.BackgroundTransparency = 1
ETAText.Text = ""

local statusBase = ""
local statusActive = false
local totalRemoteCalls = 0
local completedRemoteCalls = 0

-- [[ STATUS DOT ANIMATION ]]
task.spawn(function()
    local dotStates = {".  ", ".. ", "..."}
    local index = 1

    while StatusText and StatusText.Parent do
        if statusActive then
            index = index % 3 + 1
            StatusText.Text = statusBase .. dotStates[index]
            local remaining = math.max(0, totalRemoteCalls - completedRemoteCalls)
            if totalRemoteCalls > 0 then
                ETAText.Text = "Estimate: " .. remaining .. "s"
            else
                ETAText.Text = ""
            end
        else
            ETAText.Text = ""
        end
        task.wait(0.5)
    end
end)

-- [[ HIGHLIGHT LOGIC ]]
local selectionBox

local function clearHighlight()
    if selectionBox then
        selectionBox:Destroy()
        selectionBox = nil
    end
end

local function highlightArea(areaPart)
    clearHighlight()

    if not areaPart or not areaPart:IsA("BasePart") then
        return
    end

    selectionBox = Instance.new("BoxHandleAdornment")
    selectionBox.Adornee = areaPart
    selectionBox.AlwaysOnTop = false
    selectionBox.ZIndex = 10
    selectionBox.Size = areaPart.Size
    selectionBox.Color3 = Color3.fromRGB(0, 170, 255)
    selectionBox.Transparency = 0.6
    selectionBox.Parent = areaPart
end

-- [[ PLAYER SEARCH & SELECTION ]]
Input:GetPropertyChangedSignal("Text"):Connect(function()
    local Text = Input.Text
    T = nil
    sourceFolder = nil

    if Text ~= "" then
        local lower = string.lower(Text)

        for _, p in ipairs(game.Players:GetChildren()) do
            if string.lower(p.Name):sub(1,#Text) == lower
            or string.lower(p.DisplayName):sub(1,#Text) == lower then
                T = p
                sourceFolder = workspace.Obbies:FindFirstChild(p.Name)
                break
            end
        end

        if not T then
            for _, f in ipairs(workspace:WaitForChild("Featured"):GetChildren()) do
                if string.lower(f.Name):sub(1,#Text) == lower then
                    T = f
                    sourceFolder = f
                    break
                end
            end
        end
    end

    if T then
        SelectText.Text = "Selecting: " .. T.Name
        if sourceFolder and sourceFolder:FindFirstChild("Area") then
            local areaPart = sourceFolder.Area:FindFirstChild("Area")
            highlightArea(areaPart)
        end
    else
        SelectText.Text = "Selecting:"
        clearHighlight()
    end
end)

local cancelCopying = false

-- [[ CANCEL BUTTON ]]
local cancelButton = Instance.new("TextButton")
cancelButton.Parent = mainFrame
cancelButton.Size = submitButton.Size
cancelButton.Position = submitButton.Position
cancelButton.Text = "Cancel"
cancelButton.Font = Enum.Font.SourceSansBold
cancelButton.TextScaled = true
cancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
cancelButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
cancelButton.BorderSizePixel = 1
cancelButton.Visible = false

cancelButton.MouseButton1Click:Connect(function()
    cancelCopying = true
    statusActive = false
    totalRemoteCalls = 0
    completedRemoteCalls = 0
    ETAText.Text = ""
    cancelButton.Visible = false
    submitButton.Visible = true
end)

-- [[ RESET HELPER ]]
local function resetIdle()
    cancelButton.Visible = false
    submitButton.Visible = true
    StatusText.Text = "Status: Idle   "
    statusActive = false
    ETAText.Text = ""
    totalRemoteCalls = 0
    completedRemoteCalls = 0
end

-- [[ MAIN COPY LOGIC ]]
submitButton.MouseButton1Click:Connect(function()
    completedRemoteCalls = 0
    totalRemoteCalls = 0
    cancelCopying = false
    submitButton.Visible = false
    cancelButton.Visible = true
    statusBase = "Status: Starting"
    statusActive = true

    if T then
        -- [[ CLEAR OBBY ]]
        repeat
            if cancelCopying then
                resetIdle()
                return
            end
            statusBase = "Status: Clearing Obby"
            statusActive = true
            stop = game:GetService("ReplicatedStorage").Events.ClearObby:InvokeServer()
            if game.Players.LocalPlayer.PlayerGui.GetMeObby:Invoke().Name ~= game.Players.LocalPlayer.Name then
                return
            end
        until stop == true

        local currentObby = game.Players.LocalPlayer.PlayerGui.GetMeObby:Invoke().Name
        local myArea = workspace.Obbies[currentObby].Area.Area
        local playerObby = sourceFolder
        local localPlayerObby = workspace:WaitForChild("Obbies"):WaitForChild(currentObby)
        local tGateCF = playerObby.GetObby.Gate.CFrame
        local myGateCF = localPlayerObby.GetObby.Gate.CFrame

        -- [[ SAVED DATA TABLES ]]
        local savedTransforms = {}
        local savedProperties = {}
        local savedBehaviours = {}
        local savedButtonLinks = {}

        local hasAdvancedTools = workspace.Gamepasses.AdvancedTools:FindFirstChild(currentObby) ~= nil and workspace.Gamepasses.AdvancedTools:FindFirstChild(game.Players.LocalPlayer.Name) ~= nil

        local advancedToolsParts = {
            ["Advanced Tools Part"] = true,
            ["Music Part"] = true,
            ["Music Zone"] = true
        }

        local function isAdvancedPart(name)
            return advancedToolsParts[name] and not hasAdvancedTools
        end

        -- [[ COLLECT SOURCE PARTS ]]
        if playerObby and playerObby.Items and playerObby.Items.Parts and localPlayerObby then
            local obbyParts = {}
            for _, folder in ipairs(playerObby.Items:GetChildren()) do
                if folder:IsA("Folder") then
                    for _, obj in ipairs(folder:GetChildren()) do
                        if obj:IsA("BasePart") then
                            table.insert(obbyParts, obj)
                        elseif obj:IsA("Model") then
                            local part = obj:FindFirstChild(obj.Name)
                            if part and part:IsA("BasePart") then
                                local modelProps = getModelDefaults(obj.Name)
                                if modelProps ~= nil then
                                    table.insert(obbyParts, part)
                                end
                            end
                        end
                    end
                end
            end

            local partCounts = {}
        
            for _, part in ipairs(obbyParts) do
                savedTransforms[part.Name] = savedTransforms[part.Name] or {}
                savedProperties[part.Name] = savedProperties[part.Name] or {}
                savedBehaviours[part.Name] = savedBehaviours[part.Name] or {}
                savedButtonLinks[part.Name] = savedButtonLinks[part.Name] or {}

                local movementData = nil

                if part.Name:lower():find("moving") then
                    movementData = {
                        part.m1.Value,
                        part.m2.Value
                    }
                end

                local partCFrame = part.CFrame
                if part.Name:lower():find("push") then
                    partCFrame = part.OrigCFrame.Value
                elseif part.Name:lower():find("spin") then
                    partCFrame = CFrame.new(part.CFrame.Position) * part.OrigRotation.Value.Rotation
                end

                table.insert(savedTransforms[part.Name], {
                    relative = tGateCF:Inverse() * partCFrame,
                    size = part.Size,
                    movement = movementData,
                    originalInst = part
                })

                table.insert(savedProperties[part.Name], {
                    Color = part.Color,
                    Material = part.Material,
                    CanCollide = part.CanCollide,
                    CastShadow = part.CastShadow,
                    Reflectance = part.Reflectance,
                    Transparency = part.Transparency,
                    Surface = part.FrontSurface,
                    Shape = part:IsA("Part") and part.Shape or nil,
                    Slipperiness = part.CustomPhysicalProperties and part.CustomPhysicalProperties.FrictionWeight or 0,
                    Water = part:FindFirstChild("AttributeLinks") and part.AttributeLinks:FindFirstChild("Water") ~= nil,
                    Style = part:IsA("TrussPart") and part.Style or nil
                })

                local instanceBehaviours = {}

                -- resolve gating value for special parts
                local gearProps = nil
                local advProps = nil
                local gblProps = nil

                if part.Name == "Gear Part" and EffectModule then
                    local gnChild = part:FindFirstChild("Gn")
                    if gnChild then
                        local gearTable = EffectModule.GetGearProperties()
                        if gearTable then
                            gearProps = gearTable[gnChild.Value]
                        end
                    end
                elseif part.Name == "Advanced Tools Part" and EffectModule then
                    local attChild = part:FindFirstChild("ATT")
                    if attChild then
                        local advTable = EffectModule.GetAdvancedToolsProperties()
                        if advTable then
                            advProps = advTable[attChild.Value]
                        end
                    end
                elseif part.Name == "Global Properties Part" and EffectModule then
                    local gptChild = part:FindFirstChild("GPT")
                    if gptChild then
                        local cat, key = gptChild.Value:match("^(.-)%-(.+)$")
                        if cat and key then
                            local defaults = EffectModule.GetGlobalDefaults()
                            if defaults and defaults[cat] and defaults[cat][key] ~= nil then
                                local val = defaults[cat][key]
                                if type(val) == "boolean" then
                                    gblProps = "BoolValue"
                                elseif type(val) == "number" then
                                    gblProps = "NumberValue"
                                elseif type(val) == "table" then
                                    gblProps = "Color3Value"
                                end
                            end
                        end
                    end
                end

                for _, child in ipairs(part:GetChildren()) do
                    if child:IsA("BoolValue") or child:IsA("Color3Value") or child:IsA("NumberValue") or child:IsA("StringValue") or child:IsA("Vector3Value") then
                        local cname = child.Name:lower()
                        if cname == "active" or cname == "m1" or cname == "m2" then continue end

                        -- for special parts, filter Default* children by what the gating value allows
                        if part.Name == "Gear Part" and child.Name:sub(1, 7) == "Default" then
                            if not gearProps then continue end
                            -- map className to what gear props uses
                            local typeMap = {
                                BoolValue = "BoolValue",
                                NumberValue = "NumberValue",
                                Color3Value = "Color3Value"
                            }
                            -- check if any key in gearProps matches this value type
                            local allowed = false
                            for propName, propDef in pairs(gearProps) do
                                if type(propDef) == "boolean" and child.ClassName == "BoolValue" then
                                    allowed = true break
                                elseif type(propDef) == "table" and propDef[1] == nil then
                                    -- color range table
                                    if child.ClassName == "Color3Value" then allowed = true break end
                                elseif type(propDef) == "table" then
                                    if child.ClassName == "NumberValue" then allowed = true break end
                                end
                            end
                            if not allowed then continue end

                        elseif part.Name == "Advanced Tools Part" and child.Name:sub(1, 7) == "Default" then
                            if not advProps then continue end
                            local expectedClass = advProps[1]
                            if child.ClassName ~= expectedClass then continue end

                        elseif part.Name == "Global Properties Part" and child.Name:sub(1, 7) == "Default" then
                            if not gblProps then continue end
                            if child.ClassName ~= gblProps then continue end
                        end

                        local extraArg = nil
                        if part.Name == "Gear Part" and child.Name:sub(1, 7) == "Default" and gearProps then
                            local classToType = {
                                BoolValue    = "boolean",
                                NumberValue  = "number",
                                Color3Value  = "color",
                            }
                            local childType = classToType[child.ClassName]
                            for propName, propDef in pairs(gearProps) do
                                local matches = false
                                if childType == "boolean" and type(propDef) == "boolean" then
                                    matches = true
                                elseif childType == "color" and type(propDef) == "table" and propDef[1] == nil then
                                    matches = true
                                elseif childType == "number" and type(propDef) == "table" and propDef[1] ~= nil then
                                    matches = true
                                end
                                if matches then
                                    extraArg = propName
                                    break
                                end
                            end
                        end

                        table.insert(instanceBehaviours, {
                            valueName = child.Name,
                            value = child.Value,
                            valueType = child.ClassName,
                            extraArg = extraArg
                        })
                    end
                end
                table.insert(savedBehaviours[part.Name], instanceBehaviours)

                local actualInst = part.Parent:IsA("Model") and part.Parent or part
                local buttonsFolder = actualInst:FindFirstChild("Buttons")
                if buttonsFolder then
                    for _, objVal in ipairs(buttonsFolder:GetChildren()) do
                        if objVal:IsA("ObjectValue") and objVal.Value then
                            local buttonPart = objVal.Value
                            savedButtonLinks[buttonPart] = savedButtonLinks[buttonPart] or {}
                            table.insert(savedButtonLinks[buttonPart], part)
                        end
                    end
                end

                if part:IsA("BasePart") then
                    partCounts[part.Name] = (partCounts[part.Name] or 0) + 1
                end
            end

            -- [[ SORT PARTS ]]
            local sortedParts = {}
            for name, count in pairs(partCounts) do
                table.insert(sortedParts, {
                    name = name,
                    count = count
                })
            end

            table.sort(sortedParts, function(a, b)
                if a.count ~= b.count then
                    return a.count > b.count
                end
                return a.name < b.name
            end)
        
            -- Debug: print all unique properties and behaviours
            print("=== Unique Properties ===")
            local propCounts = {}
            for _, part in ipairs(obbyParts) do
                local props = {
                    Color = tostring(part.Color),
                    Material = part.Material.Name,
                    CanCollide = tostring(part.CanCollide),
                    CastShadow = tostring(part.CastShadow),
                    Reflectance = tostring(part.Reflectance),
                    Transparency = tostring(part.Transparency),
                    Surface = part.FrontSurface.Name,
                    Shape = part:IsA("Part") and part.Shape.Name or "N/A",
                    Slipperiness = tostring(part.CustomPhysicalProperties and part.CustomPhysicalProperties.FrictionWeight or 0),
                }
                for propName, propVal in pairs(props) do
                    local key = propName .. " = " .. propVal
                    propCounts[key] = (propCounts[key] or 0) + 1
                end
            end
            local sortedProps = {}
            for key, count in pairs(propCounts) do
                local propType = key:match("^(.-)%s*=")
                table.insert(sortedProps, {key = key, count = count, propType = propType or key})
            end
            table.sort(sortedProps, function(a, b)
                if a.propType ~= b.propType then return a.propType < b.propType end
                if a.count ~= b.count then return a.count > b.count end
                return a.key < b.key
            end)
            for _, entry in ipairs(sortedProps) do
                print(entry.key .. " | x" .. entry.count)
            end

            print("=== Unique Behaviours ===")
            local behavCounts = {}
            for partName, list in pairs(savedBehaviours) do
                for _, instanceBehaviours in ipairs(list) do
                    for _, entry in ipairs(instanceBehaviours) do
                        local key = entry.valueName .. " = " .. tostring(entry.value)
                        behavCounts[key] = (behavCounts[key] or 0) + 1
                    end
                end
            end
            local sortedBehavDebug = {}
            for key, count in pairs(behavCounts) do
                local behavType = key:match("^(.-)%s*=")
                table.insert(sortedBehavDebug, {key = key, count = count, behavType = behavType or key})
            end
            table.sort(sortedBehavDebug, function(a, b)
                if a.behavType ~= b.behavType then return a.behavType < b.behavType end
                if a.count ~= b.count then return a.count > b.count end
                return a.key < b.key
            end)
            for _, entry in ipairs(sortedBehavDebug) do
                print(entry.key .. " | x" .. entry.count)
            end

            local totalPropBatches = 0
            for _ in pairs(propCounts) do
                totalPropBatches += 1
            end

            local totalBehavBatches = 0
            for _ in pairs(behavCounts) do
                totalBehavBatches += 1
            end

            print("=== Total Property Batches: " .. totalPropBatches .. " ===")
            print("=== Total Behaviour Batches: " .. totalBehavBatches .. " ===")

            -- estimate total remote calls
            local MAX_BATCH = 1000
            local estimatedCalls = 0
            for _, entry in ipairs(sortedParts) do
                estimatedCalls = estimatedCalls + 1 -- AddObject
                estimatedCalls = estimatedCalls + math.ceil(entry.count / MAX_BATCH) -- CloneObject
            end
            estimatedCalls = estimatedCalls + 1 -- DeleteObject pass
            -- MoveObject batches
            for _, entry in ipairs(sortedParts) do
                estimatedCalls = estimatedCalls + math.ceil(entry.count / MAX_BATCH)
            end
            -- Property batches
            estimatedCalls = estimatedCalls + totalPropBatches
            -- Behaviour batches
            estimatedCalls = estimatedCalls + totalBehavBatches
            totalRemoteCalls = estimatedCalls
            print("=== Estimated Remote Calls: " .. estimatedCalls .. " ===")

            for _, entry in ipairs(sortedParts) do
                print(entry.name .. ": " .. entry.count)
            end
            
            print("=== End Debug ===")
            -- Debug: print all unique properties and behaviours

            -- [[ ADD OBJECT ]]
            statusBase = "Status: Placing Base Parts"
            statusActive = true
            for _, entry in ipairs(sortedParts) do
                local partName = entry.name
                if isAdvancedPart(partName) then continue end
                if cancelCopying then
                    resetIdle()
                    return
                end
                statusBase = "Placing: " .. partName
                statusActive = true
        
                local spawnX = math.random(myArea.Position.X - (myArea.Size.X / 2 - 10), myArea.Position.X + (myArea.Size.X / 2 - 10))
                local spawnY = math.random(myArea.Position.Y - (myArea.Size.Y / 2 - 10), myArea.Position.Y + (myArea.Size.Y / 2 - 10))
                local spawnZ = math.random(myArea.Position.Z - (myArea.Size.Z / 2 - 10), myArea.Position.Z + (myArea.Size.Z / 2 - 10))
        
                local args = {
                    [1] = partName,
                    [2] = CFrame.new(spawnX, spawnY, spawnZ)
                }
        
                local partMade = game:GetService("ReplicatedStorage").Events.AddObject:InvokeServer(unpack(args))
                while partMade ~= true do
                    if cancelCopying then
                        resetIdle()
                        return
                    end
                    partMade = game:GetService("ReplicatedStorage").Events.AddObject:InvokeServer(unpack(args))
                end
                completedRemoteCalls = completedRemoteCalls + 1
            end

            -- [[ CLONE OBJECT ]]
            statusBase = "Status: Cloning Parts"
            statusActive = true
            local MAX_BATCH = 1000
            for _, entry in ipairs(sortedParts) do
                local name = entry.name
                local count = entry.count
                if isAdvancedPart(name) then continue end
                if cancelCopying then
                    resetIdle()
                    return
                end

                local partInst = nil

                for _, folder in ipairs(localPlayerObby.Items:GetChildren()) do
                    if folder:IsA("Folder") then
                        local found = folder:FindFirstChild(name)
                        if found then
                            if found:IsA("Model") then
                                partInst = found:FindFirstChild(name)
                            else
                                partInst = found
                            end
                            break
                        end
                    end
                end

                if not partInst then continue end

                local left = count - 1
                if left <= 0 then
                    completedRemoteCalls = completedRemoteCalls + 1
                    continue
                end

                statusBase = "Cloning: " .. name .. " x" .. count
                statusActive = true
                while left > 0 do
                    if cancelCopying then
                        resetIdle()
                        return
                    end
                    statusBase = "Cloning: " .. name .. " | Remaining: " .. left
                    statusActive = true

                    local batch = math.min(left, MAX_BATCH)
                    local args = {
                        {}
                    }

                    for i = 1, batch do
                        local spawnX = math.random(myArea.Position.X - (myArea.Size.X / 2 - 10), myArea.Position.X + (myArea.Size.X / 2 - 10))
                        local spawnY = math.random(myArea.Position.Y - (myArea.Size.Y / 2 - 10), myArea.Position.Y + (myArea.Size.Y / 2 - 10))
                        local spawnZ = math.random(myArea.Position.Z - (myArea.Size.Z / 2 - 10), myArea.Position.Z + (myArea.Size.Z / 2 - 10))

                        local movementData = nil

                        -- detect moving parts
                        if partInst:FindFirstChild("m1") and partInst:FindFirstChild("m2") then
                            movementData = {
                                partInst.m1.Value,
                                partInst.m2.Value
                            }
                        end

                        if movementData then
                            table.insert(args[1], {
                                partInst,
                                CFrame.new(spawnX, spawnY, spawnZ),
                                Vector3.new(1,1,1),
                                movementData
                            })
                        else
                            table.insert(args[1], {
                                partInst,
                                CFrame.new(spawnX, spawnY, spawnZ),
                                Vector3.new(1,1,1)
                            })
                        end
                    end

                    local cloneMade = game:GetService("ReplicatedStorage").Events.CloneObject:InvokeServer(unpack(args))
                    while cloneMade ~= true do
                        if cancelCopying then
                            resetIdle()
                            return
                        end
                        cloneMade = game:GetService("ReplicatedStorage").Events.CloneObject:InvokeServer(unpack(args))
                    end
                    completedRemoteCalls = completedRemoteCalls + 1

                    left -= batch
                end
            end

            -- [[ INSIDE AREA CHECK ]]
            local function isInsideArea(cf, size, area)
                local half = size / 2

                local corners = {
                    Vector3.new(-half.X, -half.Y, -half.Z),
                    Vector3.new(-half.X, -half.Y,  half.Z),
                    Vector3.new(-half.X,  half.Y, -half.Z),
                    Vector3.new(-half.X,  half.Y,  half.Z),
                    Vector3.new( half.X, -half.Y, -half.Z),
                    Vector3.new( half.X, -half.Y,  half.Z),
                    Vector3.new( half.X,  half.Y, -half.Z),
                    Vector3.new( half.X,  half.Y,  half.Z)
                }

                local halfArea = area.Size / 2
                local areaMin = area.Position - halfArea
                local areaMax = area.Position + halfArea

                for _, offset in ipairs(corners) do
                    local worldPoint = (cf * CFrame.new(offset)).Position

                    if worldPoint.X < areaMin.X or worldPoint.X > areaMax.X
                    or worldPoint.Y < areaMin.Y or worldPoint.Y > areaMax.Y
                    or worldPoint.Z < areaMin.Z or worldPoint.Z > areaMax.Z then
                        return false
                    end
                end

                return true
            end

            -- [[ ORIGINAL -> CLONE MAP ]]
            local originalToClone = {}
            do
                local cloneIndexByName = {}
                for _, folder in ipairs(localPlayerObby.Items:GetChildren()) do
                    if folder:IsA("Folder") then
                        for _, inst in ipairs(folder:GetChildren()) do
                            local resolvedInst = inst
                            if inst:IsA("Model") then
                                resolvedInst = inst:FindFirstChild(inst.Name)
                            end
                            if resolvedInst then
                                local name = resolvedInst.Name
                                cloneIndexByName[name] = cloneIndexByName[name] or {}
                                table.insert(cloneIndexByName[name], resolvedInst)
                            end
                        end
                    end
                end

                for partName, list in pairs(savedTransforms) do
                    local cloneList = cloneIndexByName[partName] or {}
                    for i, transformData in ipairs(list) do
                        if cloneList[i] and transformData.originalInst then
                            originalToClone[transformData.originalInst] = cloneList[i]
                        end
                    end
                end
            end

            -- [[ ALL MOVES TABLE ]]
            statusBase = "Status: Preparing Move"
            statusActive = true
            local allMoves = {}
            for partName, list in pairs(savedTransforms) do
                if isAdvancedPart(partName) then continue end
                local index = 1

                allMoves[partName] = allMoves[partName] or {}

                for _, folder in ipairs(localPlayerObby.Items:GetChildren()) do
                    if folder:IsA("Folder") then
                        for _, inst in ipairs(folder:GetChildren()) do
                            local resolvedInst = inst
                            if inst:IsA("Model") then
                                resolvedInst = inst:FindFirstChild(inst.Name)
                            end
                            if resolvedInst and resolvedInst.Name == partName and list[index] then
                                local transformData = savedTransforms[partName][index]
                                local propertyData = savedProperties[partName][index]

                                local targetCF = myGateCF * transformData.relative
                                local movement = transformData.movement
                                local finalCF = targetCF

                                if movement then
                                    local transformedM1 = myGateCF * (tGateCF:Inverse() * CFrame.new(movement[1]))
                                    finalCF = transformedM1
                                end

                                local behaviourData = savedBehaviours[partName][index] or {}

                                table.insert(allMoves[partName], {
                                    clone = resolvedInst,
                                    originalInst = transformData.originalInst,
                                    targetCF = finalCF,
                                    size = transformData.size,
                                    movement = movement,
                                    properties = propertyData,
                                    behaviours = behaviourData
                                })

                                index += 1
                            end
                        end
                    end
                end
            end

            local sortedMoveGroups = {}

            for partName, group in pairs(allMoves) do
                if group and #group > 0 then
                    table.insert(sortedMoveGroups, {
                        name = partName,
                        group = group,
                        count = #group
                    })
                end
            end

            table.sort(sortedMoveGroups, function(a, b)
                if a.count ~= b.count then
                    return a.count > b.count
                end
                return a.name < b.name
            end)

            -- [[ PAINT OBJECT ]]
            statusBase = "Status: Syncing Properties"
            statusActive = true

            local PaintRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PaintObject")

            local MAX_BATCH = 1000

            local propertyBatches = {
                Color = {},
                Material = {},
                CanCollide = {},
                CastShadow = {},
                Reflectance = {},
                Transparency = {},
                Surface = {},
                Shape = {},
                Slipperiness = {},
                Water = {},
                Style = {}
            }

            local propertyOrder = {
                "Color",
                "Material",
                "CanCollide",
                "CastShadow",
                "Reflectance",
                "Transparency",
                "Surface",
                "Shape",
                "Slipperiness",
                "Water",
                "Style"
            }

            -- Build per-property batches with exact mapping
            for _, group in pairs(allMoves) do
                for _, data in ipairs(group) do
                    local clone = data.clone
                    local props = data.properties

                    for property, value in pairs(props) do

                        local key = value

                        if property == "Color" then
                            key = string.format("%d_%d_%d",
                                math.floor(value.R*255),
                                math.floor(value.G*255),
                                math.floor(value.B*255)
                            )
                        elseif property == "Material" or property == "Surface" or property == "Shape" or property == "Style" then
                            key = value.Name
                        end

                        propertyBatches[property][key] =
                            propertyBatches[property][key] or {
                                value = value,
                                parts = {}
                            }

                        table.insert(propertyBatches[property][key].parts, clone)
                    end
                end
            end

            for _, property in ipairs(propertyOrder) do

                local groups = propertyBatches[property]
                local entries = {}

                for key, data in pairs(groups) do
                    table.insert(entries, {
                        key = key,
                        data = data,
                        count = #data.parts
                    })
                end

                table.sort(entries, function(a, b)
                    if a.count ~= b.count then
                        return a.count > b.count
                    end
                    return tostring(a.key) < tostring(b.key)
                end)

                for _, entry in ipairs(entries) do
                    local data = entry.data
                    local value = data.value
                    local parts = data.parts
                    local total = #parts
                    local processed = 0

                    local i = 1
                    while i <= total do
                        if cancelCopying then
                            resetIdle()
                            return
                        end

                        local batch = {}
                        for j = i, math.min(i + MAX_BATCH - 1, total) do
                            table.insert(batch, parts[j])
                        end

                        local sendValue = value
                        if property == "Material" or property == "Surface" or property == "Shape" or property == "Style" then
                            sendValue = value.Name
                        end

                        local displayValue = sendValue
                        if property == "Color" then
                            displayValue = string.format(
                                "RGB(%d,%d,%d)",
                                math.floor(value.R * 255),
                                math.floor(value.G * 255),
                                math.floor(value.B * 255)
                            )
                        end

                        statusBase =
                            "Properties: " ..
                            property ..
                            " = " ..
                            tostring(displayValue) ..
                            " | " ..
                            processed ..
                            "/" ..
                            total

                        statusActive = true

                        local result = PaintRemote:InvokeServer(batch, property, sendValue)

                        while result ~= true do
                            if cancelCopying then
                                resetIdle()
                                return
                            end
                            result = PaintRemote:InvokeServer(batch, property, sendValue)
                        end
                        completedRemoteCalls = completedRemoteCalls + 1

                        processed += #batch
                        i += MAX_BATCH
                    end
                end
            end

            -- [[ BEHAVIOUR OBJECT ]]
            local behaviourBatches = {}

            for _, group in pairs(allMoves) do
                for _, data in ipairs(group) do
                    local clone = data.clone
                    local instanceBehaviours = data.behaviours
                    if instanceBehaviours then
                        for _, entry in ipairs(instanceBehaviours) do
                            local valueType = entry.valueType
                            local value = entry.value

                            local keyValue
                            if valueType == "Color3Value" then
                                keyValue = string.format("%d_%d_%d",
                                    math.floor(value.R*255),
                                    math.floor(value.G*255),
                                    math.floor(value.B*255)
                                )
                            elseif valueType == "Vector3Value" then
                                keyValue = string.format("%.3f_%.3f_%.3f", value.X, value.Y, value.Z)
                            else
                                keyValue = tostring(value)
                            end

                            local key = tostring(entry.valueName) .. "|" .. keyValue
                            if not behaviourBatches[key] then
                                behaviourBatches[key] = {
                                    valueName = entry.valueName,
                                    value = value,
                                    valueType = valueType,
                                    extraArg = entry.extraArg,
                                    parts = {}
                                }
                            end
                            table.insert(behaviourBatches[key].parts, clone)
                        end
                    end
                end
            end

            local sortedBehaviours = {}
            for key, data in pairs(behaviourBatches) do
                table.insert(sortedBehaviours, {
                    key = key,
                    data = data,
                    count = #data.parts
                })
            end

            local valueNameTotals = {}
            for _, entry in ipairs(sortedBehaviours) do
                local vName = entry.data.valueName
                valueNameTotals[vName] = (valueNameTotals[vName] or 0) + entry.count
            end

            local gatingNames = { ["Gn"] = true, ["ATT"] = true, ["GPT"] = true }

            table.sort(sortedBehaviours, function(a, b)
                local aIsGate = gatingNames[a.data.valueName] and true or false
                local bIsGate = gatingNames[b.data.valueName] and true or false
                if aIsGate ~= bIsGate then
                    return aIsGate
                end
                if a.data.valueName ~= b.data.valueName then
                    return a.data.valueName < b.data.valueName
                end
                local totalA = valueNameTotals[a.data.valueName]
                local totalB = valueNameTotals[b.data.valueName]
                if totalA ~= totalB then
                    return totalA > totalB
                end
                return tostring(a.data.value) < tostring(b.data.value)
            end)

            statusBase = "Status: Syncing Behaviours"
            statusActive = true

            local BehaviourRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("BehaviourObject")

            for _, entry in ipairs(sortedBehaviours) do
                local valueName = entry.data.valueName
                local value = entry.data.value
                local parts = entry.data.parts
                local total = #parts
                local i = 1

                while i <= total do
                    if cancelCopying then
                        resetIdle()
                        return
                    end

                    local batch = {}
                    for j = i, math.min(i + MAX_BATCH - 1, total) do
                        table.insert(batch, parts[j])
                    end

                    local vType = entry.data.valueType
                    local sendValue = value
                    if vType == "Vector3Value" then
                        local transformed = myGateCF * (tGateCF:Inverse() * CFrame.new(value))
                        sendValue = vector.create(transformed.X, transformed.Y, transformed.Z)
                    elseif vType == "Color3Value" then
                        sendValue = Color3.new(value.R, value.G, value.B)
                    end

                    statusBase = "Behaviours: " .. valueName .. " = " .. tostring(sendValue) .. " | " .. i .. "/" .. total
                    statusActive = true

                    local extraArg = entry.data.extraArg
                    local result = extraArg
                        and BehaviourRemote:InvokeServer(batch, valueName, sendValue, extraArg)
                        or  BehaviourRemote:InvokeServer(batch, valueName, sendValue)
                    while result ~= true do
                        if cancelCopying then
                            resetIdle()
                            return
                        end
                        result = extraArg
                            and BehaviourRemote:InvokeServer(batch, valueName, sendValue, extraArg)
                            or  BehaviourRemote:InvokeServer(batch, valueName, sendValue)
                    end
                    completedRemoteCalls = completedRemoteCalls + 1

                    i += MAX_BATCH
                end
            end

            -- [[ UPDATE BUTTON ]]
            statusBase = "Status: Syncing Button Links"
            statusActive = true

            local UpdateButton = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UpdateButton")

            for originalButton, linkedOriginals in pairs(savedButtonLinks) do
                if cancelCopying then
                    resetIdle()
                    return
                end

                local clonedButton = originalToClone[originalButton]
                if not clonedButton then continue end

                local linkedClones = {}
                for _, origPart in ipairs(linkedOriginals) do
                    local cloned = originalToClone[origPart]
                    if cloned then
                        table.insert(linkedClones, cloned)
                    end
                end

                if #linkedClones == 0 then continue end

                statusBase = "Button: " .. clonedButton.Name .. " -> " .. #linkedClones .. " parts"
                statusActive = true

                UpdateButton:FireServer(clonedButton, linkedClones)
            end

            -- [[ MOVE OBJECT ]]
            statusBase = "Status: Moving Parts"
            statusActive = true
            local MAX_BATCH = 1000
            local DeleteRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DeleteObject")

            for _, entry in ipairs(sortedMoveGroups) do
                local partName = entry.name
                local group = entry.group
                local i = 1

                while i <= #group do
                    if cancelCopying then
                        resetIdle()
                        return
                    end

                    local batch = {}
                    local deleteBatch = {}
                    for j = i, math.min(i + MAX_BATCH - 1, #group) do
                        local data = group[j]
                        local targetCF = data.targetCF
                        local size = data.size

                        local inside = true

                        -- Check main position
                        if not isInsideArea(targetCF, size, myArea) then
                            inside = false
                        end

                        -- If moving part, check both movement CFrames
                        if inside and data.movement then
                            for _, movePos in ipairs(data.movement) do
                                local moveCF

                                if typeof(movePos) == "Vector3" then
                                    moveCF = myGateCF * (tGateCF:Inverse() * CFrame.new(movePos))
                                else
                                    moveCF = myGateCF * (tGateCF:Inverse() * movePos)
                                end

                                if not isInsideArea(moveCF, size, myArea) then
                                    inside = false
                                    break
                                end
                            end
                        end

                        if inside then
                            if data.movement then
                                local convertedMovement = {}
                                for _, v in ipairs(data.movement) do
                                    local transformed = myGateCF * (tGateCF:Inverse() * CFrame.new(v))
                                    table.insert(convertedMovement, vector.create(transformed.X, transformed.Y, transformed.Z))
                                end
                                table.insert(batch, {
                                    data.clone,
                                    CFrame.new(convertedMovement[1].x, convertedMovement[1].y, convertedMovement[1].z),
                                    vector.create(data.size.X, data.size.Y, data.size.Z),
                                    convertedMovement
                                })
                            else
                                table.insert(batch, {
                                    data.clone,
                                    data.targetCF,
                                    vector.create(data.size.X, data.size.Y, data.size.Z)
                                })
                            end
                        else
                            table.insert(deleteBatch, data.clone)
                            print("Skipped (outside area):", partName)
                        end

                        statusBase = "Moving: " .. partName .. " | " .. j .. "/" .. #group
                        statusActive = true
                    end

                    if #batch == 0 then
                        i += MAX_BATCH
                        continue
                    end

                    local MoveObject = game:GetService("ReplicatedStorage").Events.MoveObject:InvokeServer(batch)
                    while MoveObject ~= true do
                        if cancelCopying then
                            resetIdle()
                            return
                        end
                        MoveObject = game:GetService("ReplicatedStorage").Events.MoveObject:InvokeServer(batch)
                    end
                    completedRemoteCalls = completedRemoteCalls + 1

                    i += MAX_BATCH

                    -- Batch delete OOB parts safely
                    if #deleteBatch > 0 then
                        local dIndex = 1

                        while dIndex <= #deleteBatch do
                            local dBatch = {}

                            for j = dIndex, math.min(dIndex + MAX_BATCH - 1, #deleteBatch) do
                                table.insert(dBatch, deleteBatch[j])
                            end

                            local result = DeleteRemote:InvokeServer(dBatch)

                            while result ~= true do
                                result = DeleteRemote:InvokeServer(dBatch)
                            end

                            dIndex += MAX_BATCH
                        end
                    end
                end
            end
        end
    end
    resetIdle()
end)