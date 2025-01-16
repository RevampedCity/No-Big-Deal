local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local buildings = {
    {
        name = "Bergmann",
        position = Vector3.new(715.705383, 283.882843, 519.359497),
        orientation = CFrame.new(
            715.705383, 283.882843, 519.359497,
            0.0867670774, -0.00766775012, 0.996199131,
            0.992413282, -0.0867670774, -0.0871051848,
            0.0871051848, 0.996199131, 8.10623169e-05
        )
    },
    {
        name = "Alamont",
        position = Vector3.new(-446.889099, 213.742462, 708.361633),
        orientation = CFrame.new(
            -446.889099, 213.742462, 708.361633,
            0.0867670774, -0.00766775012, 0.996199131,
            0.992413282, -0.0867670774, -0.0871051848,
            0.0871051848, 0.996199131, 8.10623169e-05
        )
    },
    {
        name = "Halfwell",
        position = Vector3.new(674.047119, 344.903564, -1254.74316),
        orientation = CFrame.new(
            674.047119, 344.903564, -1254.74316,
            -0.996191859, -0.0871884301, 0,
            -0.0871884301, 0.996191859, 0,
            0, 0, -1
        )
    }
}

local heightOffset = 5
local leftOffset = -15
local fontWeight = Enum.FontWeight.SemiBold
local fontStyle = Enum.FontStyle.Normal
local textColor = Color3.fromRGB(70, 255, 49)
local outlineColor = Color3.fromRGB(0, 0, 0)

local function createBillboard(building)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 100, 0, 25)
    billboardGui.AlwaysOnTop = true
    billboardGui.Adornee = nil
    billboardGui.StudsOffset = Vector3.new(leftOffset, heightOffset, 0)

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = building.name
    textLabel.FontFace = Font.new(
        "rbxasset://fonts/families/TitilliumWeb.json",
        fontWeight,
        fontStyle
    )
    textLabel.TextColor3 = textColor
    textLabel.TextScaled = false
    textLabel.TextSize = 25
    textLabel.TextStrokeColor3 = outlineColor
    textLabel.TextStrokeTransparency = 0
    textLabel.Parent = billboardGui

    local attachment = Instance.new("Attachment")
    attachment.WorldPosition = building.position
    attachment.WorldCFrame = building.orientation
    attachment.Parent = workspace.Terrain

    billboardGui.Adornee = attachment
    billboardGui.Parent = workspace.Terrain
end

local function createTextAboveDisk()
    local disk = workspace:FindFirstChild("Disk")
    if disk then
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Size = UDim2.new(0, 100, 0, 25)
        billboardGui.AlwaysOnTop = true
        billboardGui.StudsOffset = Vector3.new(0, 5, 0)

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "Disk"
        textLabel.Font = Enum.Font.TitilliumWeb
        textLabel.TextColor3 = Color3.fromRGB(70, 255, 49)
        textLabel.TextStrokeColor3 = outlineColor
        textLabel.TextStrokeTransparency = 0
        textLabel.Parent = billboardGui

        billboardGui.Adornee = disk
        billboardGui.Parent = disk
    end
end

for _, building in ipairs(buildings) do
    createBillboard(building)
end

createTextAboveDisk()

local a = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Dialga156b/Summit_UI-Library/main/source.lua')))()
local b = a:CreateWindow({Name = "Revamped.City", AccentColor3 = Color3.new(0.678, 0.847, 0.902)})
local c = b:CreateTab({Name = "Highlights", Icon = 'rbxassetid://7743875962'})
local d = b:CreateTab({Name = "Visuals", Icon = 'rbxassetid://7743876142'})
local e = b:CreateTab({Name = "Misc", Icon = 'rbxassetid://7733920644'})

local function f(g, h, i)
    -- Check if highlight already exists, if not, create one
    if g:FindFirstChild("Highlight") then g.Highlight:Destroy() end
    local j = Instance.new("Highlight", g)
    j.FillColor = h
    j.OutlineColor = h
    j.FillTransparency = i
end

local function k(l, m, n)
    for _, o in pairs(workspace:GetChildren()) do
        for _, p in ipairs(l) do
            if o.Name == p then
                f(o, m, n)
            end
        end
    end
end

local toggleStates = {}

local function createToggle(tab, text, itemList, color, transparency)
    toggleStates[text] = false
    return tab:CreateToggle({
        Text = text, 
        Default = false,
        Callback = function(state)
            toggleStates[text] = state -- Store the toggle state
            if state then
                k(itemList, color, transparency)
            else
                for _, s in pairs(workspace:GetChildren()) do
                    if s:IsA("Part") and s:FindFirstChildOfClass("Highlight") and table.find(itemList, s.Name) then
                        s:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                end
            end
        end
    })
end

local importantItemsToggle = createToggle(c, "Important Items", {"Briefcase", "Disk", "Cash"}, Color3.fromRGB(255, 165, 0), 0.5)
local weaponsToggle = createToggle(c, "Weapons", {"MP5", "AK47", "AceCarbine", "DB", "Deagle", "MAGNUM", "Pistol", "Snub", "Sniper"}, Color3.fromRGB(0, 0, 255), 0.5)
local ammoToggle = createToggle(c, "Ammo", {"MP5Mag", "PistolMag", "MagnumRound", "MAC10MAG", "AceMag", "AKMag", "Bullet2", "SnubCylinder"}, Color3.fromRGB(173, 216, 230), 0.5)
local fakeCashToggle = createToggle(c, "Fake Cash", {"FakeCash"}, Color3.fromRGB(255, 0, 0), 0.5)
local disguiseSuitToggle = createToggle(c, "Disguise Suit", {"DisguiseSuit"}, Color3.fromRGB(255, 255, 0), 0.5)
local grenadesToggle = createToggle(c, "Grenades", {"Grenade", "ExplosionAsset"}, Color3.fromRGB(255, 0, 0), 0.5)

workspace.ChildAdded:Connect(function(B)
    if B:IsA("Part") then
        local isHighlighted = false
        if toggleStates["Important Items"] and (B.Name == "Briefcase" or B.Name == "Disk" or B.Name == "Cash") then
            f(B, Color3.fromRGB(255, 165, 0), 0.5)
            isHighlighted = true
        elseif toggleStates["Weapons"] and table.find({"MP5", "AK47", "AceCarbine", "DB", "Deagle", "MAGNUM", "Pistol", "Snub", "Sniper"}, B.Name) then
            f(B, Color3.fromRGB(0, 0, 255), 0.5)
            isHighlighted = true
        elseif toggleStates["Ammo"] and table.find({"MP5Mag", "PistolMag", "MagnumRound", "MAC10MAG", "AceMag", "AKMag", "Bullet2", "SnubCylinder"}, B.Name) then
            f(B, Color3.fromRGB(173, 216, 230), 0.5)
            isHighlighted = true
        elseif toggleStates["Fake Cash"] and B.Name == "FakeCash" then
            f(B, Color3.fromRGB(255, 0, 0), 0.5)
            isHighlighted = true
        elseif toggleStates["Disguise Suit"] and B.Name == "DisguiseSuit" then
            f(B, Color3.fromRGB(255, 255, 0), 0.5)
            isHighlighted = true
        elseif toggleStates["Grenades"] and table.find({"Grenade", "ExplosionAsset"}, B.Name) then
            f(B, Color3.fromRGB(255, 0, 0), 0.5)
            isHighlighted = true
        end
        
        -- Now check if a Highlight was applied or not
        if not isHighlighted then
            -- If it wasn't highlighted and had an existing Highlight, remove it
            if B:FindFirstChildOfClass("Highlight") then
                B.Highlight:Destroy()
            end
        end
    end
end)



local deleteEnabled = false
local deletedParts = {}
local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()

local function RecreateDeletedParts()
    for _, partData in ipairs(deletedParts) do
        local newPart = Instance.new(partData.ClassName)
        newPart.Size = partData.Size
        newPart.Position = partData.Position
        newPart.BrickColor = partData.BrickColor
        newPart.Material = partData.Material
        newPart.Anchored = partData.Anchored
        newPart.Parent = workspace
    end
end

Mouse.Button1Down:Connect(function()
    if deleteEnabled and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.C) and Mouse.Target then
        local target = Mouse.Target
        table.insert(deletedParts, {
            ClassName = target.ClassName,
            Size = target.Size,
            Position = target.Position,
            BrickColor = target.BrickColor,
            Material = target.Material,
            Anchored = target.Anchored
        })
        target:Destroy()
    end
end)

e:CreateToggle({
    Text = "C Delete", 
    Default = false, 
    Callback = function(toggleState)
        deleteEnabled = toggleState
        if not deleteEnabled then
            RecreateDeletedParts()
        end
    end
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = game.Workspace.CurrentCamera
local espEnabled = false
local espThickness = 1
local EspList = {}

local function createESP(Player)
    local Box = Drawing.new("Square")
    Box.Thickness = espThickness
    Box.Filled = false
    Box.Color = Color3.fromRGB(44, 84, 212)

    local function update()
        local Character = Player.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid and Humanoid.Health > 0 then
                local Pos, OnScreen = Camera:WorldToViewportPoint(Character.Head.Position)
                if OnScreen then
                    local X = Pos.X
                    local Y = Pos.Y
                    Box.Size = Vector2.new(2450 / Pos.Z, 3850 / Pos.Z)
                    Box.Position = Vector2.new(X - Box.Size.X / 2, Y - Box.Size.Y / 9)
                    Box.Visible = espEnabled
                    return
                end
            end
        end
        Box.Visible = false
    end

    update()

    local Connection1 = Player.CharacterAdded:Connect(function()
        update()
    end)

    local Connection2 = Player.CharacterRemoving:Connect(function()
        Box.Visible = false
    end)

    return {
        update = update,
        disconnect = function()
            Box:Remove()
            Connection1:Disconnect()
            Connection2:Disconnect()
        end,
        setThickness = function(newThickness)
            Box.Thickness = newThickness
        end
    }
end

local function toggleESP(enabled)
    espEnabled = enabled
    for _, espInstance in ipairs(EspList) do
        espInstance.update()
    end
end

local function createAllESP()
    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= Players.LocalPlayer then
            table.insert(EspList, createESP(Player))
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= Players.LocalPlayer then
        table.insert(EspList, createESP(player))
    end
end)

createAllESP()

game:GetService("RunService").RenderStepped:Connect(function()
    for _, espInstance in ipairs(EspList) do
        espInstance.update()
    end
end)

local boxesToggle = d:CreateToggle({
    Text = "Boxes",
    Default = false,
    Callback = function(state)
        toggleESP(state)
    end
})
