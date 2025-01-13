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

local function createToggle(tab, text, itemList, color, transparency)
    return tab:CreateToggle({
        Text = text, 
        Default = false,
        Callback = function(state)
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
    -- Modify here to ignore unwanted parts like walls or certain items
    if B:IsA("Part") then
        if importantItemsToggle and (B.Name == "Briefcase" or B.Name == "Disk" or B.Name == "Cash") then
            f(B, Color3.fromRGB(255, 165, 0), 0.5)
        elseif weaponsToggle and table.find({"MP5", "AK47", "AceCarbine", "DB", "Deagle", "MAGNUM", "Pistol", "Snub", "Sniper"}, B.Name) then
            f(B, Color3.fromRGB(0, 0, 255), 0.5)
        elseif ammoToggle and table.find({"MP5Mag", "PistolMag", "MagnumRound", "MAC10MAG", "AceMag", "AKMag", "Bullet2", "SnubCylinder"}, B.Name) then
            f(B, Color3.fromRGB(173, 216, 230), 0.5)
        elseif fakeCashToggle and B.Name == "FakeCash" then
            f(B, Color3.fromRGB(255, 0, 0), 0.5)
        elseif disguiseSuitToggle and B.Name == "DisguiseSuit" then
            f(B, Color3.fromRGB(255, 255, 0), 0.5)
        elseif grenadesToggle and table.find({"Grenade", "ExplosionAsset"}, B.Name) then
            f(B, Color3.fromRGB(255, 0, 0), 0.5)
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

local function SpawnBaseplateAtPosition(position)
    local baseplate = Instance.new("Part")
    baseplate.Size = Vector3.new(10000000, 1, 10000000)
    baseplate.Position = position
    baseplate.Anchored = true
    baseplate.CanCollide = true
    baseplate.Parent = game.Workspace
    baseplate.BrickColor = BrickColor.new("Bright blue")
    baseplate.Material = Enum.Material.Concrete
end

e:CreateButton({
    Text = "Floor Fix",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        SpawnBaseplateAtPosition(humanoidRootPart.Position + Vector3.new(0, -10.9, 0))
        SpawnBaseplateAtPosition(Vector3.new(0, 0, 0))
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

local decalToggle = d:CreateToggle({
    Text = "Display 💿 Above Disk",
    Default = false,
    Callback = function(state)
        if state then
            local function addDecal(diskPart)
                if diskPart and diskPart:IsA("Part") then
                    local textLabel = Instance.new("BillboardGui")
                    textLabel.Adornee = diskPart
                    textLabel.Size = UDim2.new(0, 100, 0, 50)
                    textLabel.StudsOffset = Vector3.new(0, diskPart.Size.Y / 2 + 1, 0)
                    textLabel.AlwaysOnTop = true
                    textLabel.Parent = diskPart

                    local label = Instance.new("TextLabel")
                    label.Text = "💿"
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.TextScaled = true
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    label.BackgroundTransparency = 1
                    label.Parent = textLabel
                end
            end

            local diskPart = game.Workspace:FindFirstChild("Disk")
            if diskPart then
                addDecal(diskPart)
            else
                game.Workspace.ChildAdded:Connect(function(child)
                    if child.Name == "Disk" then
                        addDecal(child)
                    end
                end)
            end
        else
            local diskPart = game.Workspace:FindFirstChild("Disk")
            if diskPart then
                local textLabel = diskPart:FindFirstChildOfClass("BillboardGui")
                if textLabel then
                    textLabel:Destroy()
                end
            end
        end
    end
})

local function MovePlayer(distance)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.Position = humanoidRootPart.Position + Vector3.new(0, distance, 0)
end

e:CreateButton({
    Text = "Move Up",
    Callback = function()
        MovePlayer(5)
    end
})

e:CreateButton({
    Text = "Move Down",
    Callback = function()
        MovePlayer(-5)
    end
})

local function CreateLadder()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local ladderHeight = 10
    local ladderWidth = 2
    local ladderDepth = 1
    local ladderPosition = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 5

    local ladder = Instance.new("Model")
    ladder.Name = "Ladder"
    ladder.Parent = workspace

    for i = 1, ladderHeight do
        local step = Instance.new("Part")
        step.Size = Vector3.new(ladderWidth, 1, ladderDepth)
        step.Anchored = true
        step.Position = ladderPosition + Vector3.new(0, i * ladderDepth, 0)
        step.BrickColor = BrickColor.new("Bright blue")
        step.Material = Enum.Material.SmoothPlastic
        step.Parent = ladder
    end
end

local function CreateFloorCovering()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local floorWidth = 1000
    local floorLength = 1000
    local floorHeight = 1
    local floorPosition = humanoidRootPart.Position - Vector3.new(0, humanoidRootPart.Position.Y, 0)

    local floorPart = Instance.new("Part")
    floorPart.Size = Vector3.new(floorWidth, floorHeight, floorLength)
    floorPart.Anchored = true
    floorPart.Position = floorPosition
    floorPart.BrickColor = BrickColor.new("Bright green")
    floorPart.Material = Enum.Material.SmoothPlastic
    floorPart.Parent = workspace
end

e:CreateButton({
    Text = "Place Ladder",
    Callback = function()
        CreateLadder()
    end
})

e:CreateButton({
    Text = "Place Floor",
    Callback = function()
        CreateFloorCovering()
    end
})
