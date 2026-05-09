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

-- [[ ATTRIBUTE-AWARE VALUE READER ]]
local function getActualValue(instance, propName)
    local attrMap = {
        ["Rate"]                   = "ActualRate",
        ["Texture"]                = "ActualImage",
        ["Image"]                  = "ActualImage",
        ["VideoId"]                = "ActualImage",
        ["ObjectText"]             = "OriginalTextObjectText",
        ["ActionText"]             = "OriginalTextActionText",
        ["Text"]                   = "OriginalText",
        ["BackgroundColor"]        = "BackgroundColor",
        ["BackgroundTransparency"] = "BackgroundTransparency",
    }
    local attrName = attrMap[propName]
    if attrName then
        local attrVal = instance:GetAttribute(attrName)
        if attrVal ~= nil then
            return attrVal, true
        end
    end
    local ok, val = pcall(function() return instance[propName] end)
    if ok then return val, false end
    return nil, false
end

-- [[ SERVICES ]]
local RS = game:GetService("ReplicatedStorage")

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

-- [[ EFFECTS TOGGLE BUTTON ]]
local effectsEnabled = true

local effectsToggle = Instance.new("TextButton")
effectsToggle.Parent = header
effectsToggle.Size = UDim2.new(0, 18, 0, 18)
effectsToggle.Position = UDim2.new(1, -25, 0, 40)
effectsToggle.Text = ""
effectsToggle.Font = Enum.Font.SourceSansBold
effectsToggle.TextScaled = true
effectsToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
effectsToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
effectsToggle.BorderSizePixel = 1

local effectsTooltip = Instance.new("TextLabel")
effectsTooltip.Parent = ui
effectsTooltip.Size = UDim2.new(0, 220, 0, 36)
effectsTooltip.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
effectsTooltip.BorderSizePixel = 0
effectsTooltip.TextColor3 = Color3.fromRGB(255, 255, 255)
effectsTooltip.Font = Enum.Font.SourceSans
effectsTooltip.TextSize = 13
effectsTooltip.TextWrapped = true
effectsTooltip.Text = "Enable to copy Text & Prompt effects.\nWarning: adds ~10s per unique value."
effectsTooltip.BackgroundTransparency = 0.2
effectsTooltip.Visible = false
effectsTooltip.ZIndex = 20

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 4)
uiCorner.Parent = effectsTooltip

effectsToggle.MouseEnter:Connect(function()
    local absPos = effectsToggle.AbsolutePosition
    effectsTooltip.Position = UDim2.new(0, absPos.X - 148, 0, absPos.Y + 15)
    effectsTooltip.Visible = true
end)

effectsToggle.MouseLeave:Connect(function()
    effectsTooltip.Visible = false
end)

local effectsInner = Instance.new("Frame")
effectsInner.Parent = effectsToggle
effectsInner.Size = UDim2.new(0, 10, 0, 10)
effectsInner.Position = UDim2.new(0.5, -5, 0.5, -5)
effectsInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
effectsInner.BorderSizePixel = 0

effectsToggle.MouseButton1Click:Connect(function()
    effectsEnabled = not effectsEnabled
    if effectsEnabled then
        effectsToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        effectsInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    else
        effectsToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        effectsInner.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end)

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
            if totalRemoteCalls > 0 then
                local remaining = math.max(0, totalRemoteCalls - completedRemoteCalls)
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
local function reset()
    -- clean up any leftover snapshots
    for _, child in ipairs(RS:GetChildren()) do
        if child.Name:sub(1, 13) == "ObbySnapshot_" then
            child:Destroy()
        end
    end
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
        -- [[ SNAPSHOT SOURCE OBBY TO REPLICATED STORAGE ]]
        local snapshotFolder = Instance.new("Folder")
        snapshotFolder.Name = "ObbySnapshot_" .. T.Name
        snapshotFolder.Parent = RS

        -- Deep-clone the source folder into the snapshot
        if sourceFolder then
            local clonedSource = sourceFolder:Clone()
            clonedSource.Name = sourceFolder.Name
            clonedSource.Parent = snapshotFolder
        end

        -- Store player name
        local nameVal = Instance.new("StringValue")
        nameVal.Name = "PlayerName"
        nameVal.Value = T.Name
        nameVal.Parent = snapshotFolder

        -- Redirect sourceFolder to snapshot
        sourceFolder = snapshotFolder:FindFirstChild(sourceFolder and sourceFolder.Name or "")
        playerObby = sourceFolder  -- used later in copy logic

        -- Print selected player obby information
        print("=== Selected Player Obby Info ===")
        print("Player Name  : " .. tostring(T.Name))
        if sourceFolder then
            local obbyNameVal = sourceFolder:FindFirstChild("ObbyNameVAL")
            local idVal       = sourceFolder:FindFirstChild("IdVAL")
            local ownerVal    = sourceFolder:FindFirstChild("OwnerNameVAL")
            print("Obby Name  : " .. tostring(obbyNameVal and obbyNameVal.Value or "N/A"))
            print("Obby ID    : " .. tostring(idVal       and idVal.Value       or "N/A"))
            print("Owner Name : " .. tostring(ownerVal    and ownerVal.Value    or "N/A"))
        else
            print("Source folder not found for: " .. T.Name)
        end
        print("=================================")

        -- [[ CLEAR OBBY (FOR NON-OWNER EDITING) ]]
        local function clearObbyManually(obbyName)
            statusBase = "Status: Clearing Obby (Manual)"
            statusActive = true
            
            local obbyFolder = workspace.Obbies:FindFirstChild(obbyName)
            if not obbyFolder or not obbyFolder:FindFirstChild("Items") then
                return false
            end
            
            local partsToDelete = {}
            
            -- Scan all parts in the obby
            for _, folder in ipairs(obbyFolder.Items:GetChildren()) do
                if folder:IsA("Folder") then
                    for _, obj in ipairs(folder:GetChildren()) do
                        if obj:IsA("BasePart") then
                            table.insert(partsToDelete, obj)
                        elseif obj:IsA("Model") then
                            -- For models, find the main part
                            local mainPart = obj:FindFirstChild(obj.Name)
                            if mainPart and mainPart:IsA("BasePart") then
                                table.insert(partsToDelete, mainPart)
                            end
                        end
                    end
                end
            end
            
            if #partsToDelete == 0 then
                return true
            end
            
            -- Delete in batches of 1000
            local DeleteRemote = game:GetService("ReplicatedStorage").Events.DeleteObject
            local MAX_BATCH = 1000
            local i = 1
            
            while i <= #partsToDelete do
                if cancelCopying then
                    return false
                end
                
                local batch = {}
                for j = i, math.min(i + MAX_BATCH - 1, #partsToDelete) do
                    table.insert(batch, partsToDelete[j])
                end
                
                statusBase = "Clearing: " .. i .. "/" .. #partsToDelete
                statusActive = true
                
                local result = DeleteRemote:InvokeServer(batch)
                while result ~= true do
                    if cancelCopying then
                        return false
                    end
                    result = DeleteRemote:InvokeServer(batch)
                end
                
                i += MAX_BATCH
            end
            
            return true
        end

        -- [[ CLEAR OBBY ]]
        local currentObby = game.Players.LocalPlayer.PlayerGui.GetMeObby:Invoke().Name
        
        -- Try normal clear first (if you're the owner)
        local isOwner = (currentObby == game.Players.LocalPlayer.Name)

        if isOwner then
            -- Original clear method
            repeat
                if cancelCopying then
                    reset()
                    return
                end
                statusBase = "Status: Clearing Obby"
                statusActive = true
                stop = game:GetService("ReplicatedStorage").Events.ClearObby:InvokeServer()
                if game.Players.LocalPlayer.PlayerGui.GetMeObby:Invoke().Name ~= currentObby then
                    return
                end
            until stop == true
        else
            -- Manual clear for non-owner editing
            local cleared = clearObbyManually(currentObby)
            if not cleared then
                reset()
                return
            end
        end

        -- [[ GET 100M CASH ]]
        local function get100MCash()
            local lp = game:GetService("Players"):FindFirstChild(currentObby)
            local DeleteRemote = RS.Events.DeleteObject
            local AddRemote = RS.Events.AddObject
            local localObby = workspace.Obbies:FindFirstChild(currentObby)
            local TARGET = 100_000_000

            local function getCash()
                local ls = lp:FindFirstChild("leaderstats")
                if ls and ls:FindFirstChild("Cash") then
                    return ls.Cash.Value
                end
                return 0
            end

            local function placeDummy()
                local myArea = workspace.Obbies[currentObby].Area.Area

                -- clamp size so part never exceeds area bounds
                local cash = getCash()
                local s = math.max(1, math.floor(cash ^ (1/3)))
                local maxSafe = math.floor(math.min(myArea.Size.X, myArea.Size.Y, myArea.Size.Z) - 2)
                s = math.min(s, maxSafe)

                -- always spawn at center so large parts don't clip out
                local spawnCF = CFrame.new(myArea.Position)
                local placed = AddRemote:InvokeServer("Part", spawnCF)
                while placed ~= true do
                    if cancelCopying then return nil end
                    placed = AddRemote:InvokeServer("Part", spawnCF)
                end
                local found = nil
                for _, folder in ipairs(localObby.Items:GetChildren()) do
                    if folder:IsA("Folder") then
                        for _, obj in ipairs(folder:GetChildren()) do
                            local candidate = obj:IsA("Model") and obj:FindFirstChild(obj.Name) or obj
                            if candidate and candidate:IsA("BasePart") and candidate.Name == "Part" then
                                found = candidate
                                break
                            end
                        end
                        if found then break end
                    end
                end
                if not found then return nil end

                -- Resize to clamped size to maximise cash reward without OOB
                local sizeVec = vector.create(s, s, s)
                local moveBatch = {{
                    found,
                    found.CFrame,
                    sizeVec
                }}
                local moveResult = RS.Events.MoveObject:InvokeServer(moveBatch)
                while moveResult ~= true do
                    if cancelCopying then return nil end
                    moveResult = RS.Events.MoveObject:InvokeServer(moveBatch)
                end

                return found
            end

            while getCash() < TARGET do
                if cancelCopying then return end

                statusBase = "Cash: Placing Part..."
                statusActive = true
                local dummy = placeDummy()

                if not dummy then
                    warn("get100MCash: failed to place dummy, retrying...")
                    task.wait(1)
                    continue
                end

                local cash = getCash()
                local remaining = TARGET - cash
                local deletesNeeded = math.max(1, math.floor(remaining ^ (1/3)))
                statusBase = "Cash: $" .. math.floor(cash) .. " / $100M (~" .. deletesNeeded .. " left)"
                statusActive = true

                local pl = table.create(1000, dummy)
                local result = DeleteRemote:InvokeServer(pl)
                while result ~= true do
                    if cancelCopying then return end
                    result = DeleteRemote:InvokeServer(pl)
                end

                task.wait(0.1)
            end

            statusBase = "Cash: Done! $" .. math.floor(getCash())
            statusActive = true
            task.wait(1)
        end

        statusBase = "Status: Getting 100M Cash"
        statusActive = true
        get100MCash()
        if cancelCopying then reset() return end

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

            local validBehaviourNames = nil
            local validBehaviourTypes = {}
            if EffectModule then
                local vals = EffectModule.GetValues()
                if vals then
                    validBehaviourNames = {}
                    for k, def in pairs(vals) do
                        validBehaviourNames[k] = true
                        if type(def) == "table" and type(def[1]) == "string" then
                            validBehaviourTypes[def[1]] = true
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

                -- remap legacy "spinning" parts → treat as "Spin Part"
                local isSpinningPart = part.Name:lower():find("spinning") ~= nil

                local partCFrame = part.CFrame
                if part.Name:lower():find("push") then
                    partCFrame = part.OrigCFrame.Value
                elseif part.Name:lower():find("spin") then
                    local origPos
                    local origPosAttr = part:GetAttribute("OrigPosition")
                    if origPosAttr then
                        origPos = Vector3.new(origPosAttr.X, origPosAttr.Y, origPosAttr.Z)
                    elseif part:FindFirstChild("OrigCFrame") and part.OrigCFrame:IsA("CFrameValue") then
                        origPos = part.OrigCFrame.Value.Position
                    else
                        origPos = part.CFrame.Position
                    end
                    local origRot = part:FindFirstChild("OrigRotation") and part.OrigRotation.Value.Rotation or CFrame.identity.Rotation
                    partCFrame = CFrame.new(origPos) * origRot
                end

                local recordedName = isSpinningPart and "Spin Part" or part.Name
                savedTransforms[recordedName] = savedTransforms[recordedName] or {}
                savedProperties[recordedName] = savedProperties[recordedName] or {}
                savedBehaviours[recordedName] = savedBehaviours[recordedName] or {}
                savedButtonLinks[recordedName] = savedButtonLinks[recordedName] or {}

                -- read sD and A directly for spinning parts before inserting transform
                local spinningPartSD = 0
                local spinningPartAxis = nil
                if isSpinningPart then
                    local sdChild = part:FindFirstChild("sD")
                    local aChild = part:FindFirstChild("A")
                    if sdChild then spinningPartSD = tonumber(sdChild.Value) or 0 end
                    if aChild then spinningPartAxis = tostring(aChild.Value) end
                end

                table.insert(savedTransforms[recordedName], {
                    relative = tGateCF:Inverse() * partCFrame,
                    size = part.Size,
                    movement = movementData,
                    originalInst = part,
                    spinningSD = isSpinningPart and spinningPartSD or nil,
                    spinningAxis = isSpinningPart and spinningPartAxis or nil
                })

                table.insert(savedProperties[recordedName], {
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
                    if attChild and attChild.Value ~= "ColorEffect" then
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
                    local passFilter
                    if validBehaviourNames then
                        passFilter = validBehaviourNames[child.Name] and validBehaviourTypes[child.ClassName]
                    else
                        -- fallback: EffectModule unavailable, use manual checks
                        local cname = child.Name:lower()
                        passFilter = (child:IsA("BoolValue") or child:IsA("Color3Value") or child:IsA("NumberValue") or child:IsA("IntValue") or child:IsA("StringValue") or child:IsA("Vector3Value"))
                            and cname ~= "active"
                            and cname:sub(1,8) ~= "original"
                            and cname ~= "m1"
                            and cname ~= "m2"
                    end
                    if passFilter then

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

                table.insert(savedBehaviours[recordedName], isSpinningPart and {} or instanceBehaviours)

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
                    partCounts[recordedName] = (partCounts[recordedName] or 0) + 1
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
            local function printDebugInfo()
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
                print("=== End Debug ===")
            end
            -- printDebugInfo() -- uncomment to run debug

            for _, entry in ipairs(sortedParts) do
                print(entry.name .. ": " .. entry.count)
            end

            -- [[ ADD OBJECT ]]
            statusBase = "Status: Placing Base Parts"
            statusActive = true
            for _, entry in ipairs(sortedParts) do
                local partName = entry.name
                if isAdvancedPart(partName) then continue end
                if cancelCopying then
                    reset()
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
                        reset()
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
                    reset()
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
                        reset()
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
                            reset()
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
                                local part = inst:FindFirstChild(inst.Name)
                                if part and part:IsA("BasePart") then
                                    resolvedInst = part
                                end
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

                                local spinDist = 0
                                local spinAxis = nil
                                if partName:lower():find("spin") then
                                    -- for legacy spinning parts, sD and A were read directly
                                    -- since their behaviours are skipped to avoid breaking remotes
                                    if transformData.spinningSD ~= nil then
                                        spinDist = transformData.spinningSD
                                        spinAxis = transformData.spinningAxis
                                    else
                                        for _, b in ipairs(behaviourData) do
                                            if b.valueName == "sD" then
                                                spinDist = tonumber(b.value) or 0
                                            elseif b.valueName == "A" then
                                                spinAxis = tostring(b.value)
                                            end
                                        end
                                    end
                                end

                                table.insert(allMoves[partName], {
                                    clone = resolvedInst,
                                    originalInst = transformData.originalInst,
                                    targetCF = finalCF,
                                    size = transformData.size,
                                    movement = movement,
                                    properties = propertyData,
                                    behaviours = behaviourData,
                                    spinDist = spinDist,
                                    spinAxis = spinAxis
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

            -- [[ PRE-COLLECT EFFECTS ]]
            statusBase = "Status: Analysing Effects"
            statusActive = true

            local effectBatches = {}
            local effectMap = EffectModule and EffectModule.InstanceToEffect() or {}
            local guiObjects = EffectModule and EffectModule.GetGuiObjects() or {
                ["TextLabel"] = true, ["ImageLabel"] = true, ["VideoFrame"] = true
            }
            local defaults = EffectModule and EffectModule.GetDefaultEffects() or {}

            -- properties stored per instance
            local effectProps = {}

            for _, part in ipairs(obbyParts) do
                if part.Parent:IsA("Model") then continue end

                local clonePart = originalToClone[part]
                if not clonePart then continue end

                for _, child in ipairs(part:GetChildren()) do
                    -- GUI container (SurfaceGui / BillboardGui):
                    -- Face lives on the container, the actual effect type
                    -- is determined by its GuiObject child
                    if child:IsA("SurfaceGui") or child:IsA("BillboardGui") then
                        local guiChild = child:FindFirstChildWhichIsA("GuiObject")
                        if not guiChild then continue end

                        local effectType = effectMap[guiChild.ClassName]
                        if not effectType then continue end

                        -- Add the effect itself
                        local key = effectType .. "|Default"
                        if not effectBatches[key] then
                            effectBatches[key] = {
                                effectType = effectType,
                                preset = "Default",
                                extraVal = nil,
                                parts = {}
                            }
                        end
                        table.insert(effectBatches[key].parts, clonePart)

                        -- Face is on the container, not the gui child
                        local effectPropList = effectProps[guiChild] or {}
                        local defaultFace = "Front"
                        local faceStr = tostring(child.Face):match("%.([^%.]+)$") or tostring(child.Face)
                        if faceStr ~= defaultFace then
                            table.insert(effectPropList, {
                                instance = guiChild,
                                effectType = effectType,
                                propName = "Face",
                                value = faceStr
                            })
                        end

                        -- Non-default properties live on the GuiObject child
                        local effectDefaults = defaults[effectType] or {}
                        for propName, defaultVal in pairs(effectDefaults) do
                            if propName == "Face" then continue end
                            local actualVal, fromAttr = getActualValue(guiChild, propName)
                            if actualVal == nil then continue end

                            local differs = false
                            if type(defaultVal) == "number" then
                                differs = actualVal ~= defaultVal
                            elseif type(defaultVal) == "boolean" then
                                differs = actualVal ~= defaultVal
                            elseif typeof(defaultVal) == "Color3" then
                                differs = actualVal ~= defaultVal
                            else
                                differs = tostring(actualVal) ~= tostring(defaultVal)
                            end

                            if differs then
                                local sendVal = actualVal
                                if typeof(actualVal) == "Color3" then
                                    -- keep as Color3, remote expects it natively
                                elseif typeof(actualVal) == "ColorSequence" then
                                    -- keep as ColorSequence, remote expects it natively
                                elseif typeof(actualVal) == "NumberSequence" then
                                    -- keep as NumberSequence, remote expects it natively
                                elseif typeof(actualVal) == "NumberRange" then
                                    -- keep as NumberRange, remote expects it natively
                                elseif typeof(actualVal) == "Vector2" then
                                    -- keep as Vector2, remote expects it natively
                                elseif typeof(actualVal) == "UDim2" then
                                    -- keep as UDim2, remote expects it natively
                                elseif typeof(actualVal) == "Vector3" then
                                    -- keep as Vector3, remote expects it natively
                                elseif typeof(actualVal) == "Font" then
                                    sendVal = actualVal.Family:match("rbxasset://(.+)") or tostring(actualVal.Family)
                                elseif type(actualVal) == "userdata" then
                                    if typeof(actualVal) == "EnumItem" then
                                        sendVal = actualVal.Name
                                    else
                                        local s = tostring(actualVal)
                                        sendVal = s:match("%.([^%.]+)$") or s
                                    end
                                end
                                table.insert(effectPropList, {
                                    instance = guiChild,
                                    effectType = effectType,
                                    propName = propName,
                                    value = sendVal
                                })
                            end
                        end

                        if #effectPropList > 0 then
                            effectProps[guiChild] = effectPropList
                        end

                    else
                        -- Regular effect (Fire, Smoke, PointLight, Texture, ProximityPrompt, etc.)
                        local effectType = effectMap[child.ClassName]
                        if not effectType then continue end

                        local key = effectType .. "|Default"
                        if not effectBatches[key] then
                            effectBatches[key] = {
                                effectType = effectType,
                                preset = "Default",
                                extraVal = nil,
                                parts = {}
                            }
                        end
                        table.insert(effectBatches[key].parts, clonePart)

                        local effectDefaults = defaults[effectType] or {}
                        local effectPropList = effectProps[child] or {}

                        for propName, defaultVal in pairs(effectDefaults) do
                            local actualVal, fromAttr = getActualValue(child, propName)
                            if actualVal == nil then continue end

                            local differs = false
                            if type(defaultVal) == "number" then
                                differs = actualVal ~= defaultVal
                            elseif type(defaultVal) == "boolean" then
                                differs = actualVal ~= defaultVal
                            elseif typeof(defaultVal) == "Color3" then
                                differs = actualVal ~= defaultVal
                            else
                                differs = tostring(actualVal) ~= tostring(defaultVal)
                            end

                            if differs then
                                local sendVal = actualVal
                                if typeof(actualVal) == "Color3" then
                                    -- keep as Color3, remote expects it natively
                                elseif typeof(actualVal) == "ColorSequence" then
                                    -- keep as ColorSequence, remote expects it natively
                                elseif typeof(actualVal) == "NumberSequence" then
                                    -- keep as NumberSequence, remote expects it natively
                                elseif typeof(actualVal) == "NumberRange" then
                                    -- keep as NumberRange, remote expects it natively
                                elseif typeof(actualVal) == "Vector2" then
                                    -- keep as Vector2, remote expects it natively
                                elseif typeof(actualVal) == "Vector3" then
                                    -- keep as Vector3, remote expects it natively
                                elseif typeof(actualVal) == "UDim2" then
                                    -- keep as UDim2, remote expects it natively
                                elseif typeof(actualVal) == "Font" then
                                    sendVal = actualVal.Family:match("rbxasset://(.+)") or tostring(actualVal.Family)
                                elseif type(actualVal) == "userdata" then
                                    if typeof(actualVal) == "EnumItem" then
                                        sendVal = actualVal.Name
                                    else
                                        local s = tostring(actualVal)
                                        sendVal = s:match("%.([^%.]+)$") or s
                                    end
                                end
                                table.insert(effectPropList, {
                                    instance = child,
                                    effectType = effectType,
                                    propName = propName,
                                    value = sendVal
                                })
                            end
                        end

                        if #effectPropList > 0 then
                            effectProps[child] = effectPropList
                        end
                    end
                end
            end

            -- [[ ESTIMATE TOTAL REMOTE CALLS ]]
            do
                local est = 0

                -- AddObject
                for _, entry in ipairs(sortedParts) do
                    if not isAdvancedPart(entry.name) then
                        est += 1
                    end
                end

                -- CloneObject
                for _, entry in ipairs(sortedParts) do
                    if not isAdvancedPart(entry.name) then
                        est += math.ceil(entry.count / 1000)
                    end
                end

                -- PaintObject: 1 call per unique (property, value) group (all ≤1000 parts each)
                for _, property in ipairs({"Color","Material","CanCollide","CastShadow","Reflectance","Transparency","Surface","Shape","Slipperiness","Water","Style"}) do
                    local seen = {}
                    for _, group in pairs(allMoves) do
                        for _, data in ipairs(group) do
                            local value = data.properties[property]
                            if value == nil then continue end
                            local key
                            if property == "Color" then
                                key = string.format("%d_%d_%d", math.floor(value.R*255), math.floor(value.G*255), math.floor(value.B*255))
                            elseif property == "Material" or property == "Surface" or property == "Shape" or property == "Style" then
                                key = value.Name
                            elseif type(value) == "number" and value ~= value then
                                key = "NaN"
                            else
                                key = tostring(value)
                            end
                            seen[key] = (seen[key] or 0) + 1
                        end
                    end
                    for _, count in pairs(seen) do
                        est += math.ceil(count / 1000)
                    end
                end

                -- BehaviourObject
                local behavUniques = {}
                for _, group in pairs(allMoves) do
                    for _, data in ipairs(group) do
                        for _, entry in ipairs(data.behaviours or {}) do
                            local keyVal
                            if entry.valueType == "Color3Value" then
                                keyVal = string.format("%d_%d_%d", math.floor(entry.value.R*255), math.floor(entry.value.G*255), math.floor(entry.value.B*255))
                            elseif entry.valueType == "Vector3Value" then
                                keyVal = string.format("%.3f_%.3f_%.3f", entry.value.X, entry.value.Y, entry.value.Z)
                            else
                                keyVal = tostring(entry.value)
                            end
                            local key = tostring(entry.valueName).."|"..keyVal
                            behavUniques[key] = (behavUniques[key] or 0) + 1
                        end
                    end
                end
                for _, count in pairs(behavUniques) do
                    est += math.ceil(count / 1000)
                end

                -- EffectObject
                for _, data in pairs(effectBatches) do
                    est += math.ceil(#data.parts / 1000)
                end

                -- EffectObject props
                local slowTextFieldsEst = {
                    ["text"]   = { ["Text"] = true },
                    ["prompt"] = { ["ObjectText"] = true, ["ActionText"] = true }
                }
                local tempPropBatches = {}
                for instance, propList in pairs(effectProps) do
                    for _, entry in ipairs(propList) do
                        local keyVal
                        if typeof(entry.value) == "Color3" then
                            keyVal = string.format("%d_%d_%d", math.floor(entry.value.R*255), math.floor(entry.value.G*255), math.floor(entry.value.B*255))
                        elseif type(entry.value) == "number" and entry.value ~= entry.value then
                            keyVal = "NaN"
                        else
                            keyVal = tostring(entry.value)
                        end
                        local key = entry.effectType.."|"..entry.propName.."|"..keyVal
                        tempPropBatches[key] = tempPropBatches[key] or { count = 0, effectType = entry.effectType, propName = entry.propName }
                        tempPropBatches[key].count += 1
                    end
                end
                for _, data in pairs(tempPropBatches) do
                    local fieldMap = slowTextFieldsEst[data.effectType]
                    local cost = (fieldMap and fieldMap[data.propName]) and 10 or 1
                    est += math.ceil(data.count / 1000) * cost
                end

                -- MoveObject
                for _, entry in ipairs(sortedMoveGroups) do
                    est += math.ceil(entry.count / 1000)
                end

                -- DeleteObject
                est += 1

                totalRemoteCalls = est
            end

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
                        if value == nil then continue end

                        local key = value

                        if property == "Color" then
                            key = string.format("%d_%d_%d",
                                math.floor(value.R*255),
                                math.floor(value.G*255),
                                math.floor(value.B*255)
                            )
                        elseif property == "Material" or property == "Surface" or property == "Shape" or property == "Style" then
                            key = value.Name
                        elseif type(value) == "number" and value ~= value then
                            key = "NaN"
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
                            reset()
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
                                reset()
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

                            -- [[ OUT OF BOUNDS CHECK FOR VECTOR3VALUE ]]
                            if valueType == "Vector3Value" then
                                local transformedVec = myGateCF * (tGateCF:Inverse() * CFrame.new(value))
                                local checkCF = CFrame.new(transformedVec.X, transformedVec.Y, transformedVec.Z)
                                if not isInsideArea(checkCF, Vector3.new(0.001, 0.001, 0.001), myArea) then
                                    continue
                                end
                            end

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
            local deferredSpinD = {}

            for _, entry in ipairs(sortedBehaviours) do
                local valueName = entry.data.valueName
                local value = entry.data.value
                local parts = entry.data.parts
                local total = #parts
                local i = 1

                while i <= total do
                    if cancelCopying then
                        reset()
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

                    -- defer sD for spin parts until after MoveObject
                    if valueName == "sD" then
                        local isSpinBatch = false
                        for _, p in ipairs(batch) do
                            if p.Name:lower():find("spin") then
                                isSpinBatch = true
                                break
                            end
                        end
                        if isSpinBatch then
                            table.insert(deferredSpinD, { parts = batch, value = sendValue })
                            i += MAX_BATCH
                            continue
                        end
                    end

                    local extraArg = entry.data.extraArg
                    local result = extraArg
                        and BehaviourRemote:InvokeServer(batch, valueName, sendValue, extraArg)
                        or  BehaviourRemote:InvokeServer(batch, valueName, sendValue)
                    while result ~= true do
                        if cancelCopying then
                            reset()
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
                    reset()
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

            -- [[ EFFECT OBJECT ]]
            statusBase = "Status: Syncing Effects"
            statusActive = true

            local EffectRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("EffectObject")
            local MAX_BATCH = 1000

            local sortedEffects = {}

            for key,data in pairs(effectBatches) do
                table.insert(sortedEffects,{
                    key = key,
                    data = data,
                    count = #data.parts
                })
            end

            table.sort(sortedEffects,function(a,b)
                if a.count ~= b.count then
                    return a.count > b.count
                end
                return a.key < b.key
            end)

            for _,entry in ipairs(sortedEffects) do
                local effectType = entry.data.effectType
                local preset = entry.data.preset
                local extraVal = entry.data.extraVal
                local parts = entry.data.parts

                local total = #parts
                local i = 1

                while i <= total do
                    if cancelCopying then reset() return end

                    local batch = {}

                    for j = i,math.min(i + MAX_BATCH - 1,total) do
                        table.insert(batch,parts[j])
                    end

                    statusBase = "Effects: "..effectType.." | "..i.."/"..total
                    statusActive = true

                    local result

                    if extraVal ~= nil then
                        result = EffectRemote:InvokeServer(batch,effectType,preset,extraVal)
                    else
                        result = EffectRemote:InvokeServer(batch,effectType,preset)
                    end

                    while result ~= true do
                        if cancelCopying then reset() return end

                        if extraVal ~= nil then
                            result = EffectRemote:InvokeServer(batch,effectType,preset,extraVal)
                        else
                            result = EffectRemote:InvokeServer(batch,effectType,preset)
                        end
                    end

                    completedRemoteCalls += 1
                    i += MAX_BATCH
                end
            end

            -- [[ EFFECT PROPERTIES ]]
            statusBase = "Status: Syncing Effect Properties"
            statusActive = true

            local effectPropBatches = {}

            for instance,propList in pairs(effectProps) do
                for _,entry in ipairs(propList) do

                    local keyVal

                    if typeof(entry.value) == "Color3" then
                        keyVal = string.format("%d_%d_%d",
                            math.floor(entry.value.R*255),
                            math.floor(entry.value.G*255),
                            math.floor(entry.value.B*255)
                        )
                    elseif type(entry.value) == "number" and entry.value ~= entry.value then
                        keyVal = "NaN"
                    else
                        keyVal = tostring(entry.value)
                    end

                    local key = entry.effectType.."|"..entry.propName.."|"..keyVal

                    if not effectPropBatches[key] then
                        effectPropBatches[key] = {
                            effectType = entry.effectType,
                            propName = entry.propName,
                            value = entry.value,
                            parts = {}
                        }
                    end

                    local root = instance
                    while root and not originalToClone[root] do
                        root = root.Parent
                    end

                    local targetPart = originalToClone[root] or instance

                    table.insert(effectPropBatches[key].parts,targetPart)
                end
            end

            local sortedEffectProps = {}

            for key,data in pairs(effectPropBatches) do
                table.insert(sortedEffectProps,{
                    key = key,
                    data = data,
                    count = #data.parts
                })
            end

            local slowTextFields = {
                ["text"] = { ["Text"] = true },
                ["prompt"] = { ["ObjectText"] = true, ["ActionText"] = true }
            }

            local function getCallCost(entry)
                local fieldMap = slowTextFields[entry.data.effectType]
                if fieldMap and fieldMap[entry.data.propName] then
                    return 10
                end
                return 1
            end

            local function isSlow(entry)
                return getCallCost(entry) > 1
            end

            table.sort(sortedEffectProps,function(a,b)

                local aSlow = isSlow(a)
                local bSlow = isSlow(b)

                if aSlow ~= bSlow then
                    return not aSlow
                end

                if a.count ~= b.count then
                    return a.count > b.count
                end

                return a.key < b.key
            end)

            -- [[ CLEAR SLOW FIELDS IF EFFECTS DISABLED ]]
            if not effectsEnabled then
                local clearBatches = {}

                for _, entry in ipairs(sortedEffectProps) do
                    if not isSlow(entry) then continue end

                    local effectType = entry.data.effectType
                    local propName = entry.data.propName
                    local parts = entry.data.parts
                    local key = effectType .. "|" .. propName

                    if not clearBatches[key] then
                        clearBatches[key] = {
                            effectType = effectType,
                            propName = propName,
                            parts = {}
                        }
                    end
                    for _, p in ipairs(parts) do
                        table.insert(clearBatches[key].parts, p)
                    end
                end

                for _, data in pairs(clearBatches) do
                    local total = #data.parts
                    local i = 1
                    while i <= total do
                        if cancelCopying then reset() return end
                        local batch = {}
                        for j = i, math.min(i + MAX_BATCH - 1, total) do
                            table.insert(batch, data.parts[j])
                        end
                        statusBase = "Clearing: " .. data.effectType .. "." .. data.propName
                        statusActive = true
                        local result = EffectRemote:InvokeServer(batch, data.effectType, data.propName, "")
                        while result ~= true do
                            if cancelCopying then reset() return end
                            result = EffectRemote:InvokeServer(batch, data.effectType, data.propName, "")
                        end
                        completedRemoteCalls += 1
                        i += MAX_BATCH
                    end
                end
            end

            for _,entry in ipairs(sortedEffectProps) do
                -- skip text/prompt slow fields if effects disabled
                if not effectsEnabled and isSlow(entry) then
                    completedRemoteCalls += math.ceil(#entry.data.parts / 1000) * 10
                    continue
                end

                local effectType = entry.data.effectType
                local propName = entry.data.propName
                local value = entry.data.value
                local parts = entry.data.parts

                local total = #parts
                local i = 1

                statusBase = "Effects: "..effectType.." ("..propName..")"
                statusActive = true

                while i <= total do
                    if cancelCopying then reset() return end

                    local valueStr

                    if typeof(value) == "Color3" then
                        valueStr = string.format("(%d,%d,%d)",
                            math.floor(value.R*255),
                            math.floor(value.G*255),
                            math.floor(value.B*255)
                        )
                    else
                        valueStr = tostring(value)
                    end

                    statusBase = "Effects: "..effectType.."."..propName.." = "..valueStr.." | "..i.."/"..total
                    statusActive = true

                    local batch = {}

                    for j = i,math.min(i + MAX_BATCH - 1,total) do
                        table.insert(batch,parts[j])
                    end

                    local result
                    if isSlow(entry) then
                        -- send one at a time for slow text fields to test server acceptance
                        result = true
                        for _, p in ipairs(batch) do
                            local r = EffectRemote:InvokeServer({p}, effectType, propName, value)
                            if r ~= true then result = nil break end
                        end
                    else
                        result = EffectRemote:InvokeServer(batch, effectType, propName, value)
                    end

                    while result ~= true do
                        if cancelCopying then reset() return end
                        result = EffectRemote:InvokeServer(batch,effectType,propName,value)
                    end

                    completedRemoteCalls += 1
                    if isSlow(entry) then
                        task.wait(10)
                        completedRemoteCalls += 9
                    end
                    i += MAX_BATCH
                end
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
                        reset()
                        return
                    end

                    local batch = {}
                    local deleteBatch = {}
                    for j = i, math.min(i + MAX_BATCH - 1, #group) do
                        local data = group[j]
                        local targetCF = data.targetCF
                        local size = data.size

                        local inside = true

                        -- Check main position (spin parts use swept circle check)
                        if partName:lower():find("spin") then
                            local r = data.spinDist or 0
                            local spinAxis = data.spinAxis -- nil if not set, no default assumption

                            do
                                -- always use sweep check regardless of sD
                                -- sD=0 means rotate in place, effectiveR = halfDiag only
                                local pos = targetCF.Position
                                local halfArea = myArea.Size / 2
                                local areaMin = myArea.Position - halfArea
                                local areaMax = myArea.Position + halfArea

                                -- normalize axis: X stays X, Y stays Y, anything else defaults to Z
                                local checkAxis
                                if spinAxis == "X" then
                                    checkAxis = "X"
                                elseif spinAxis == "Y" then
                                    checkAxis = "Y"
                                else
                                    -- Z or any weird value defaults to Z
                                    checkAxis = "Z"
                                end

                                local halfDiag
                                if checkAxis == "X" then
                                    -- sweeps on Y/Z plane
                                    halfDiag = math.sqrt((size.Y/2)^2 + (size.Z/2)^2)
                                elseif checkAxis == "Y" then
                                    -- sweeps on X/Z plane
                                    halfDiag = math.sqrt((size.X/2)^2 + (size.Z/2)^2)
                                else
                                    -- Z or any weird value, sweeps on X/Y plane
                                    halfDiag = math.sqrt((size.X/2)^2 + (size.Y/2)^2)
                                end

                                local effectiveR = r + halfDiag

                                local rX = (checkAxis == "X") and (size.X / 2) or effectiveR
                                local rY = (checkAxis == "Y") and (size.Y / 2) or effectiveR
                                local rZ = (checkAxis == "Z") and (size.Z / 2) or effectiveR

                                if pos.X - rX < areaMin.X or pos.X + rX > areaMax.X
                                or pos.Y - rY < areaMin.Y or pos.Y + rY > areaMax.Y
                                or pos.Z - rZ < areaMin.Z or pos.Z + rZ > areaMax.Z then
                                    inside = false
                                end
                            end
                        elseif not isInsideArea(targetCF, size, myArea) then
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
                            reset()
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
            -- [[ DEFERRED SPIN DISTANCE ]]
            if #deferredSpinD > 0 then
                statusBase = "Status: Syncing Spin Distance"
                statusActive = true
                for _, entry in ipairs(deferredSpinD) do
                    if cancelCopying then reset() return end
                    local result = BehaviourRemote:InvokeServer(entry.parts, "sD", entry.value)
                    while result ~= true do
                        if cancelCopying then reset() return end
                        result = BehaviourRemote:InvokeServer(entry.parts, "sD", entry.value)
                    end
                    completedRemoteCalls += 1
                end
            end
        end
    end
    reset()
end)