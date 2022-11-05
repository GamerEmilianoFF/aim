

local Settings = {
    AimLock = {
        Enabled = true,
        Aimlockkey = "q",
        Prediction = 0.37764398,
        Aimpart = 'HumanoidRootPart',
        Notifications = true
	},
}

local CurrentCamera = game:GetService("Workspace").CurrentCamera
local Inset = game:GetService("GuiService"):GetGuiInset().Y
local RunService = game:GetService("RunService")

local Mouse = game.Players.LocalPlayer:GetMouse()
local LocalPlayer = game.Players.LocalPlayer


      local placemarker = Instance.new("Part", game.Workspace)

    function makemarker(Parent, Adornee, Color, Size, Size2)
        local e = Instance.new("BillboardGui", Parent)
        e.Name = "PP"
        e.Adornee = Adornee
        e.Size = UDim2.new(Size, Size2, Size, Size2)
        e.AlwaysOnTop = true
        local a = Instance.new("Frame", e)
        a.Size = UDim2.new(2, 0, 2, 0)
        a.BackgroundTransparency = 0
        a.BackgroundColor3 = Color
        local g = Instance.new("UICorner", a)
        g.CornerRadius = UDim.new(50, 50)
        return(e)
    end

    
    local data = game.Players:GetPlayers()
    function noob(player)
        local character
        repeat wait() until player.Character
        local handler = makemarker(guimain, player.Character[Settings.AimLock.Aimpart], Color3.fromRGB(107, 184, 255), 0.3, 3)
        handler.Name = player.Name
        player.CharacterAdded:connect(function(Char) handler.Adornee = Char[Settings.AimLock.Aimpart] end)


        spawn(function()
            while wait() do
                if player.Character then
                    TextLabel.Text = player.Name..tostring(player:WaitForChild("leaderstats").Wanted.Value).." | "..tostring(math.floor(player.Character:WaitForChild("Humanoid").Health))
                end
            end
        end)
    end

    for i = 1, #data do
        if data[i] ~= game.Players.LocalPlayer then
            noob(data[i])
        end
    end

    game.Players.PlayerAdded:connect(function(Player)
        noob(Player)
    end)

    spawn(function()
        placemarker.Anchored = true
        placemarker.CanCollide = false
        placemarker.Size = Vector3.new(8, 8, 8)
        placemarker.Transparency = 0.60
        makemarker(placemarker, placemarker, Color3.fromRGB(82, 112, 234), 0.40, 0)
    end)    

local Plr = game.Players.LocalPlayer

Mouse.KeyDown:Connect(function(KeyPressed)
    if KeyPressed == (Settings.AimLock.Aimlockkey) then
        if Settings.AimLock.Enabled == true then
            Settings.AimLock.Enabled = false
            if Settings.AimLock.Notifications == true then
                Plr = FindClosestPlayer()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "p",
                    Text = "Unlocked"
                })
            end
        else
            Plr = FindClosestPlayer()
            Settings.AimLock.Enabled = true
            if Settings.AimLock.Notifications == true then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "p",
                    Text = "Locked On :  " .. tostring(Plr.Character.Humanoid.DisplayName)
                })
            end
        end
    end
end)

function FindClosestPlayer()
    local ClosestDistance, ClosestPlayer = math.huge, nil;
    for _, Player in next, game:GetService("Players"):GetPlayers() do
        if Player ~= LocalPlayer then
            local Character = Player.Character
            if Character and Character.Humanoid.Health > 1 then 
                local Position, IsVisibleOnViewPort = CurrentCamera:WorldToViewportPoint(Character.HumanoidRootPart
                                                                                             .Position)
                if IsVisibleOnViewPort then
                    local Distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Position.X, Position.Y)).Magnitude
                    if Distance < ClosestDistance then
                        ClosestPlayer = Player
                        ClosestDistance = Distance
                    end
                end
            end
        end
    end
    return ClosestPlayer, ClosestDistance
end





	 game:GetService"RunService".Stepped:connect(function()
        if  Settings.AimLock.Enabled == true and Plr.Character and Plr.Character[Settings.AimLock.Aimpart] then
            placemarker.CFrame = CFrame.new(Plr.Character[Settings.AimLock.Aimpart].Position +
			(Plr.Character[Settings.AimLock.Aimpart].Velocity *
			 Settings.AimLock.Prediction))
        else
            placemarker.CFrame = CFrame.new(0, 9999, 0)
        
    
	
	end
	
end)


local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if Settings.AimLock.Enabled and getnamecallmethod() == "FireServer" and args[2] == "MousePos" then
        args[3] = Plr.Character[Settings.AimLock.Aimpart].Position +
                      (Plr.Character[Settings.AimLock.Aimpart].Velocity * Settings.AimLock.Prediction)

        return old(unpack(args))
    end
    return old(...)
end)





--Toggle Aim

local ToggleAim = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextButtonxd = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")

--Properties:

ToggleAim.Name = "ToggleAim"
ToggleAim.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ToggleAim.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleAim.ResetOnSpawn = false

Frame.Parent = ToggleAim
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BackgroundTransparency = 0.250
Frame.Position = UDim2.new(0.49045527, 0, 0.0698254332, 0)
Frame.Size = UDim2.new(0, 123, 0, 64)
Frame.Active = true
Frame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame

TextButtonxd.Parent = Frame
TextButtonxd.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TextButtonxd.BackgroundTransparency = 0.560
TextButtonxd.Position = UDim2.new(0.121813267, 0, 0.170098543, 0)
TextButtonxd.Size = UDim2.new(0, 93, 0, 41)
TextButtonxd.Font = Enum.Font.SourceSans
TextButtonxd.Text = "Hit Box"
TextButtonxd.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButtonxd.TextScaled = true
TextButtonxd.TextSize = 14.000
TextButtonxd.TextWrapped = true

local script = Instance.new('LocalScript', TextButtonxd)

local state = true
script.Parent.MouseButton1Down:Connect(function()
	print"By Space#0234"
	state = not state
	if not state then
		script.Parent.Text = "off"

		for i, v in pairs(script.Parent.Parent.Parent:GetChildren()) do
			if v:IsA("TextButton") then 




				v.Visible = false
				v.TextLabel.Visible = false
			end
		end


Settings.AimLock.Enabled = false
            if Settings.AimLock.Notifications == true then
                Plr = FindClosestPlayer()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "AimLock",
                    Text = "Unlocked"
                })
            end



	else
		script.Parent.Text = "on"
		--script
		for i, v in pairs(script.Parent.Parent.Parent:GetChildren()) do
			if v:IsA("TextButton") then 

				v.Visible = true
				v.TextLabel.Visible = true




			end
		end

	Plr = FindClosestPlayer()
            Settings.AimLock.Enabled = true
            if Settings.AimLock.Notifications == true then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "AimLock",
                    Text = "Locked On :  " .. tostring(Plr.Character.Humanoid.DisplayName)
                })
            
        end

	end
end)



UICorner_2.CornerRadius = UDim.new(0, 15)
UICorner_2.Parent = TextButtonxd
