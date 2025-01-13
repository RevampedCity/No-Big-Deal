local a = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Dialga156b/Summit_UI-Library/main/source.lua')))()
local b = a:CreateWindow({Name = "Revamped.City", AccentColor3 = Color3.new(0.678, 0.847, 0.902)})
local c = b:CreateTab({Name = "Highlights", Icon = 'rbxassetid://7743875962'})
local d = b:CreateTab({Name = "Player", Icon = 'rbxassetid://7743876142'})
local e = b:CreateTab({Name = "Misc", Icon = 'rbxassetid://7733920644'})

local function f(g, h, i)
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
        Callback = function(r)
            if r then
                k(itemList, color, transparency)
            else
                for _, s in pairs(workspace:GetChildren()) do
                    if s:FindFirstChildOfClass("Highlight") and table.find(itemList, s.Name) then
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
    if importantItemsToggle then
        if B.Name == "Briefcase" or B.Name == "Disk" or B.Name == "Cash" then
            f(B, Color3.fromRGB(255, 165, 0), 0.5)
        end
    end
    if weaponsToggle then
        if table.find({"MP5", "AK47", "AceCarbine", "DB", "Deagle", "MAGNUM", "Pistol", "Snub", "Sniper"}, B.Name) then
            f(B, Color3.fromRGB(0, 0, 255), 0.5)
        end
    end
    if ammoToggle then
        if table.find({"MP5Mag", "PistolMag", "MagnumRound", "MAC10MAG", "AceMag", "AKMag", "Bullet2", "SnubCylinder"}, B.Name) then
            f(B, Color3.fromRGB(173, 216, 230), 0.5)
        end
    end
    if fakeCashToggle then
        if B.Name == "FakeCash" then
            f(B, Color3.fromRGB(255, 0, 0), 0.5)
        end
    end
    if disguiseSuitToggle then
        if B.Name == "DisguiseSuit" then
            f(B, Color3.fromRGB(255, 255, 0), 0.5)
        end
    end
    if grenadesToggle then
        if table.find({"Grenade", "ExplosionAsset"}, B.Name) then
            f(B, Color3.fromRGB(255, 0, 0), 0.5)
        end
    end
end)

local deleteEnabled = false
local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()

Mouse.Button1Down:Connect(function()
    if deleteEnabled and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.C) and Mouse.Target then
        Mouse.Target:Destroy()
    end
end)

e:CreateToggle({
    Text = "C Delete", 
    Default = false, 
    Callback = function(toggleState)
        deleteEnabled = toggleState
    end
})

local function SpawnBaseplateAtPosition(position)
    local baseplate = Instance.new("Part")
    baseplate.Size = Vector3.new(10000000, 0, 10000000)
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
local Camera = game.Workspace.CurrentCamera -- Assuming Camera is accessible from this context
local espEnabled = false
local espThickness = 1
local EspList = {}

local function createESP(Player)
    local Box = Drawing.new("Square")
    Box.Thickness = espThickness
    Box.Filled = false
    Box.Color = Color3.fromRGB(44, 84, 212) -- Baby blue color

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

-- Add toggle and slider to the misc tab
local boxesToggle = d:CreateToggle({
    Text = "Boxes", -- Text for the toggle button
    Default = false, -- Default state is off (disabled)
    Callback = function(state)
        toggleESP(state)
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
        MovePlayer(5) -- Move the player up by 5 studs
    end
})

e:CreateButton({
    Text = "Move Down",
    Callback = function()
        MovePlayer(-5) -- Move the player down by 5 studs
    end
})

local espEnabled = false
local espThickness = 1
local EspList = {}
local Camera = workspace.CurrentCamera 

local function createESP(Player)
    local Box = Drawing.new("Square")
    Box.Thickness = espThickness
    Box.Filled = false
    Box.Color = Color3.fromRGB(44, 84, 212) -- Baby blue color

    local function update()
        local Character = Player.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid and Humanoid.Health > 0 then
                local Pos, OnScreen = Camera:WorldToViewportPoint(Character.Head.Position)
                if OnScreen then
                    Box.Size = Vector2.new(2450 / Pos.Z, 3850 / Pos.Z)
                    Box.Position = Vector2.new(Pos.X - Box.Size.X / 2, Pos.Y - Box.Size.Y / 9)
                    Box.Visible = espEnabled
                    return
                end
            end
        end
        Box.Visible = false
    end

    update()

    Player.CharacterAdded:Connect(update)
    Player.CharacterRemoving:Connect(function() Box.Visible = false end)

    return {
        update = update,
        disconnect = function() Box:Remove() end,
        setThickness = function(newThickness) Box.Thickness = newThickness end
    }
end

local function toggleESP(enabled)
    espEnabled = enabled
    for _, espInstance in ipairs(EspList) do
        espInstance.update()
    end
end

local function createAllESP()
    for _, Player in pairs(game.Players:GetPlayers()) do
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


-- Highlight logic
local highlightEnabled = false
local highlightedParts = {}

local function createHighlight(part)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = part
    highlight.FillColor = Color3.fromRGB(255, 255, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0.8
    highlight.Parent = part
    return highlight
end

local function removeHighlight(part)
    if part:FindFirstChild("Highlight") then
        part.Highlight:Destroy()
    end
end

local function toggleHighlight()
    highlightEnabled = not highlightEnabled

    if highlightEnabled then
        -- Highlight all players' characters
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        table.insert(highlightedParts, createHighlight(part))
                    end
                end
            end
        end
    else
        -- Remove highlights
        for _, part in ipairs(highlightedParts) do
            removeHighlight(part)
        end
        highlightedParts = {}
    end
end


-- Function to spawn a ramp in front of the player
local function SpawnRampInFrontOfPlayer()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Create the ramp
    local ramp = Instance.new("Part")
    ramp.Size = Vector3.new(10, 1, 10)  -- Ramp dimensions (adjustable)
    ramp.Position = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 5  -- Position the ramp in front of the player
    ramp.Anchored = true
    ramp.CanCollide = true
    ramp.BrickColor = BrickColor.new("Bright blue")
    ramp.Material = Enum.Material.SmoothPlastic
    ramp.Parent = workspace

    -- Add ramp incline (rotate to make it slanted)
    ramp.CFrame = ramp.CFrame * CFrame.Angles(math.rad(-30), 0, 0)  -- Adjust the angle for the ramp
end

-- Add a button to the "Misc" tab to spawn the ramp
e:CreateButton({
    Text = "Spawn Ramp",
    Callback = function()
        SpawnRampInFrontOfPlayer()  -- Call the function to spawn the ramp
    end
})
