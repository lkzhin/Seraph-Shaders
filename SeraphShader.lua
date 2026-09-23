--========================================================--
--                  SERAPH SHADERS 2.1                   --
--========================================================--
-- Para a sua própria experiência Roblox
-- Chuva sem som
-- Poças finas
-- Neve
-- Real Time
-- Botão SH para minimizar
-- Borda RGB
--========================================================--

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--========================================================--
-- CONFIG
--========================================================--

local GUI_NAME = "SERAPH_SHADER_GUI"

local RAIN_COLOR = Color3.fromRGB(175, 225, 255)

local RAIN_AMOUNT = 85
local SNOW_AMOUNT = 55

local RAIN_HEIGHT = 38
local RAIN_SPEED_MIN = 90
local RAIN_SPEED_MAX = 125

local SNOW_HEIGHT = 35
local SNOW_SPEED_MIN = 5
local SNOW_SPEED_MAX = 10

local PUDDLE_DISTANCE = 28
local MAX_PUDDLES = 14

--========================================================--
-- ESTADO
--========================================================--

local rainEnabled = false
local snowEnabled = false
local realTimeEnabled = false

local rainDrops = {}
local snowFlakes = {}
local puddles = {}

local rainFolder
local snowFolder
local puddleFolder
local shaderFolder

local rgbObjects = {}

--========================================================--
-- REMOVE GUI ANTIGO
--========================================================--

local oldGui = playerGui:FindFirstChild(GUI_NAME)

if oldGui then
	oldGui:Destroy()
end

--========================================================--
-- AMBIENTE ORIGINAL
--========================================================--

local originalLighting = {
	ClockTime = Lighting.ClockTime,
	Brightness = Lighting.Brightness,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	FogColor = Lighting.FogColor,
	FogStart = Lighting.FogStart,
	FogEnd = Lighting.FogEnd,
	ExposureCompensation = Lighting.ExposureCompensation,
	GlobalShadows = Lighting.GlobalShadows
}

--========================================================--
-- RGB
--========================================================--

local function getRGB(offset)
	local hue = (os.clock() * 0.12 + offset) % 1

	return Color3.fromHSV(
		hue,
		0.9,
		1
	)
end

local function registerRGB(object)
	table.insert(rgbObjects, object)
end

RunService.RenderStepped:Connect(function()

	for i = #rgbObjects, 1, -1 do

		local object = rgbObjects[i]

		if object and object.Parent then
			object.Color = getRGB(i * 0.025)
		else
			table.remove(rgbObjects, i)
		end
	end
end)

--========================================================--
-- GUI
--========================================================--

local gui = Instance.new("ScreenGui")
gui.Name = GUI_NAME
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent = playerGui

--========================================================--
-- PAINEL
--========================================================--

local panel = Instance.new("Frame")
panel.Name = "ShaderPanel"

panel.Size = UDim2.new(0, 470, 0, 385)

panel.AnchorPoint = Vector2.new(0.5, 0.5)
panel.Position = UDim2.new(0.5, 0, 0.5, 0)

panel.BackgroundColor3 = Color3.fromRGB(24, 17, 36)
panel.BackgroundTransparency = 0.06
panel.BorderSizePixel = 0

panel.Parent = gui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 16)
panelCorner.Parent = panel

local panelStroke = Instance.new("UIStroke")
panelStroke.Thickness = 3
panelStroke.Parent = panel

registerRGB(panelStroke)

--========================================================--
-- HEADER
--========================================================--

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 68)
header.BackgroundTransparency = 1
header.Parent = panel

local title = Instance.new("TextLabel")
title.Name = "Title"
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 25, 0, 10)
title.Size = UDim2.new(1, -145, 0, 28)

title.Font = Enum.Font.GothamBold
title.Text = "Seraph Shaders"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left

title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 25, 0, 38)
subtitle.Size = UDim2.new(1, -145, 0, 18)

subtitle.Font = Enum.Font.Gotham
subtitle.Text = "Shaders • Environment"
subtitle.TextColor3 = Color3.fromRGB(165, 155, 180)
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left

subtitle.Parent = header

--========================================================--
-- BOTÃO MINIMIZAR
--========================================================--

local minimize = Instance.new("TextButton")

minimize.Name = "Minimize"

minimize.Size = UDim2.new(0, 42, 0, 42)
minimize.Position = UDim2.new(1, -102, 0, 12)

minimize.BackgroundColor3 = Color3.fromRGB(34, 23, 48)
minimize.BorderSizePixel = 0

minimize.Text = "SH"
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.TextSize = 13
minimize.Font = Enum.Font.GothamBold

minimize.AutoButtonColor = false

minimize.Parent = panel

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 11)
minimizeCorner.Parent = minimize

local minimizeStroke = Instance.new("UIStroke")
minimizeStroke.Thickness = 1.8
minimizeStroke.Parent = minimize

registerRGB(minimizeStroke)

--========================================================--
-- BOTÃO X
--========================================================--

local close = Instance.new("TextButton")

close.Name = "Close"

close.Size = UDim2.new(0, 42, 0, 42)
close.Position = UDim2.new(1, -54, 0, 12)

close.BackgroundColor3 = Color3.fromRGB(34, 23, 48)
close.BorderSizePixel = 0

close.Text = "×"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextSize = 25
close.Font = Enum.Font.GothamBold

close.AutoButtonColor = false

close.Parent = panel

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 11)
closeCorner.Parent = close

local closeStroke = Instance.new("UIStroke")
closeStroke.Thickness = 1.8
closeStroke.Parent = close

registerRGB(closeStroke)

--========================================================--
-- BOTÃO FLUTUANTE SH
--========================================================--

local floating = Instance.new("TextButton")

floating.Name = "SH_Floating"

floating.Size = UDim2.new(0, 58, 0, 58)

floating.Position = UDim2.new(
	0.08,
	0,
	0.25,
	0
)

floating.AnchorPoint = Vector2.new(0.5, 0.5)

floating.BackgroundColor3 =
	Color3.fromRGB(27, 20, 38)

floating.BackgroundTransparency = 0.04

floating.BorderSizePixel = 0

floating.Text = "SH"

floating.TextColor3 =
	Color3.fromRGB(255, 255, 255)

floating.TextSize = 17

floating.Font =
	Enum.Font.GothamBold

floating.AutoButtonColor = false

floating.Visible = false

floating.ZIndex = 100

floating.Parent = gui

local floatingCorner = Instance.new("UICorner")
floatingCorner.CornerRadius = UDim.new(0, 15)
floatingCorner.Parent = floating

local floatingStroke = Instance.new("UIStroke")
floatingStroke.Thickness = 3
floatingStroke.Parent = floating

registerRGB(floatingStroke)

--========================================================--
-- SH ABRE O PAINEL
--========================================================--

floating.MouseButton1Click:Connect(function()

	panel.Visible = true
	floating.Visible = false

end)

--========================================================--
-- MINIMIZAR
--========================================================--

minimize.MouseButton1Click:Connect(function()

	panel.Visible = false
	floating.Visible = true

end)

--========================================================--
-- FECHAR
--========================================================--

close.MouseButton1Click:Connect(function()

	panel.Visible = false
	floating.Visible = false

end)

--========================================================--
-- ARRASTAR PAINEL
--========================================================--

local draggingPanel = false
local panelDragStart
local panelStartPosition

header.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		draggingPanel = true

		panelDragStart = input.Position
		panelStartPosition = panel.Position

	end
end)

header.InputEnded:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		draggingPanel = false

	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not draggingPanel then
		return
	end

	if input.UserInputType ~=
		Enum.UserInputType.MouseMovement
		and input.UserInputType ~=
		Enum.UserInputType.Touch then

		return
	end

	local delta =
		input.Position - panelDragStart

	panel.Position = UDim2.new(
		panelStartPosition.X.Scale,
		panelStartPosition.X.Offset + delta.X,

		panelStartPosition.Y.Scale,
		panelStartPosition.Y.Offset + delta.Y
	)

end)

--========================================================--
-- ARRASTAR SH NO CELULAR
--========================================================--

local draggingSH = false
local shDragStart
local shStartPosition

floating.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		draggingSH = true

		shDragStart = input.Position
		shStartPosition = floating.Position

	end
end)

floating.InputEnded:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		draggingSH = false

	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not draggingSH then
		return
	end

	if input.UserInputType ~=
		Enum.UserInputType.MouseMovement
		and input.UserInputType ~=
		Enum.UserInputType.Touch then

		return
	end

	local delta =
		input.Position - shDragStart

	floating.Position = UDim2.new(
		shStartPosition.X.Scale,
		shStartPosition.X.Offset + delta.X,

		shStartPosition.Y.Scale,
		shStartPosition.Y.Offset + delta.Y
	)

end)

--========================================================--
-- CONTAINER DOS BOTÕES
--========================================================--

local container = Instance.new("Frame")

container.Name = "Buttons"

container.Position = UDim2.new(
	0,
	22,
	0,
	78
)

container.Size = UDim2.new(
	1,
	-44,
	1,
	-92
)

container.BackgroundTransparency = 1
container.Parent = panel

local grid = Instance.new("UIGridLayout")

grid.CellSize =
	UDim2.new(0.5, -6, 0, 48)

grid.CellPadding =
	UDim2.new(0, 10, 0, 9)

grid.FillDirectionMaxCells = 2

grid.SortOrder =
	Enum.SortOrder.LayoutOrder

grid.Parent = container

--========================================================--
-- CRIAR BOTÃO
--========================================================--

local function createButton(text, order)

	local button = Instance.new("TextButton")

	button.Name =
		text:gsub("%s+", "")

	button.LayoutOrder = order

	button.BackgroundColor3 =
		Color3.fromRGB(30, 21, 48)

	button.BackgroundTransparency = 0.04

	button.BorderSizePixel = 0

	button.Text = text

	button.TextColor3 =
		Color3.fromRGB(245, 240, 250)

	button.TextSize = 14

	button.Font =
		Enum.Font.GothamSemibold

	button.AutoButtonColor = false

	button.Parent = container

	local corner = Instance.new("UICorner")

	corner.CornerRadius =
		UDim.new(0, 12)

	corner.Parent = button

	local stroke = Instance.new("UIStroke")

	stroke.Thickness = 1.5
	stroke.Transparency = 0.05

	stroke.Parent = button

	registerRGB(stroke)

	button.MouseEnter:Connect(function()

		button.BackgroundColor3 =
			Color3.fromRGB(48, 30, 70)

	end)

	button.MouseLeave:Connect(function()

		button.BackgroundColor3 =
			Color3.fromRGB(30, 21, 48)

	end)

	return button
end

--========================================================--
-- BOTÕES
--========================================================--

local noonButton =
	createButton("Noon", 1)

local sunriseButton =
	createButton("Sunrise", 2)

local sunsetButton =
	createButton("Sunset", 3)

local nightButton =
	createButton("Night", 4)

local rainButton =
	createButton("Rain", 5)

local snowButton =
	createButton("Snowfall", 6)

local realButton =
	createButton("Real Time: OFF", 7)

local restoreButton =
	createButton("Restore Shader", 8)

local defaultButton =
	createButton("Padrão", 9)

--========================================================--
-- SHADER FOLDER
--========================================================--

shaderFolder = Instance.new("Folder")
shaderFolder.Name = "SeraphShaderEffects"
shaderFolder.Parent = Lighting

--========================================================--
-- LIMPA SHADERS
--========================================================--

local function clearShaderEffects()

	for _, object in ipairs(shaderFolder:GetChildren()) do
		object:Destroy()
	end

end

--========================================================--
-- ATMOSFERA
--========================================================--

local function createAtmosphere(
	density,
	haze,
	color,
	decay
)

	clearShaderEffects()

	local atmosphere =
		Instance.new("Atmosphere")

	atmosphere.Name =
		"Atmosphere"

	atmosphere.Density =
		density

	atmosphere.Haze =
		haze

	atmosphere.Color =
		color

	atmosphere.Decay =
		decay

	atmosphere.Glare = 0

	atmosphere.Parent =
		shaderFolder

	return atmosphere

end

--========================================================--
-- COLOR CORRECTION
--========================================================--

local function createColorCorrection(
	brightness,
	contrast,
	saturation,
	tint
)

	local effect =
		Instance.new("ColorCorrectionEffect")

	effect.Name =
		"ColorCorrection"

	effect.Brightness =
		brightness

	effect.Contrast =
		contrast

	effect.Saturation =
		saturation

	effect.TintColor =
		tint

	effect.Parent =
		shaderFolder

	return effect

end

--========================================================--
-- BLOOM
--========================================================--

local function createBloom()

	local bloom =
		Instance.new("BloomEffect")

	bloom.Name =
		"Bloom"

	bloom.Intensity =
		0.12

	bloom.Size =
		18

	bloom.Threshold =
		1.2

	bloom.Parent =
		shaderFolder

end

--========================================================--
-- SUNRAYS
--========================================================--

local function createSunRays(strength)

	local rays =
		Instance.new("SunRaysEffect")

	rays.Name =
		"SunRays"

	rays.Intensity =
		strength

	rays.Spread =
		0.8

	rays.Parent =
		shaderFolder

end

--========================================================--
-- REMOVE RAIN
--========================================================--

local function removeRain()

	rainEnabled = false

	for _, drop in ipairs(rainDrops) do

		if drop and drop.Parent then
			drop:Destroy()
		end

	end

	table.clear(rainDrops)

	if rainFolder then
		rainFolder:Destroy()
		rainFolder = nil
	end

end

--========================================================--
-- REMOVE SNOW
--========================================================--

local function removeSnow()

	snowEnabled = false

	for _, flake in ipairs(snowFlakes) do

		if flake and flake.Parent then
			flake:Destroy()
		end

	end

	table.clear(snowFlakes)

	if snowFolder then
		snowFolder:Destroy()
		snowFolder = nil
	end

end

--========================================================--
-- REMOVE PUDDLES
--========================================================--

local function removePuddles()

	if puddleFolder then
		puddleFolder:Destroy()
		puddleFolder = nil
	end

	table.clear(puddles)

end

--========================================================--
-- CLEAR WEATHER
--========================================================--

local function clearWeather()

	removeRain()
	removeSnow()
	removePuddles()

end

--========================================================--
-- NOON
--========================================================--

local function noon()

	realTimeEnabled = false

	clearWeather()

	Lighting.ClockTime = 12
	Lighting.Brightness = 3

	Lighting.Ambient =
		Color3.fromRGB(155, 155, 155)

	Lighting.OutdoorAmbient =
		Color3.fromRGB(190, 190, 190)

	Lighting.ExposureCompensation =
		0.15

	createAtmosphere(
		0.15,
		0.04,
		Color3.fromRGB(205, 225, 255),
		Color3.fromRGB(255, 255, 255)
	)

	createColorCorrection(
		0.02,
		0.05,
		0.05,
		Color3.fromRGB(255, 255, 255)
	)

	createBloom()
	createSunRays(0.08)

end

--========================================================--
-- SUNRISE
--========================================================--

local function sunrise()

	realTimeEnabled = false

	clearWeather()

	Lighting.ClockTime = 6.1
	Lighting.Brightness = 2.2

	Lighting.Ambient =
		Color3.fromRGB(125, 100, 100)

	Lighting.OutdoorAmbient =
		Color3.fromRGB(170, 125, 105)

	createAtmosphere(
		0.25,
		0.12,
		Color3.fromRGB(255, 190, 155),
		Color3.fromRGB(255, 125, 90)
	)

	createColorCorrection(
		0.02,
		0.08,
		0.08,
		Color3.fromRGB(255, 225, 205)
	)

	createBloom()
	createSunRays(0.12)

end

--========================================================--
-- SUNSET
--========================================================--

local function sunset()

	realTimeEnabled = false

	clearWeather()

	Lighting.ClockTime = 18.1
	Lighting.Brightness = 1.8

	Lighting.Ambient =
		Color3.fromRGB(110, 70, 85)

	Lighting.OutdoorAmbient =
		Color3.fromRGB(155, 80, 60)

	createAtmosphere(
		0.3,
		0.24,
		Color3.fromRGB(255, 140, 105),
		Color3.fromRGB(125, 75, 135)
	)

	createColorCorrection(
		0,
		0.1,
		0.12,
		Color3.fromRGB(255, 215, 190)
	)

	createBloom()
	createSunRays(0.09)

end

--========================================================--
-- NIGHT
--========================================================--

local function night()

	realTimeEnabled = false

	clearWeather()

	Lighting.ClockTime = 0
	Lighting.Brightness = 0.45

	Lighting.Ambient =
		Color3.fromRGB(25, 30, 65)

	Lighting.OutdoorAmbient =
		Color3.fromRGB(12, 18, 45)

	Lighting.ExposureCompensation =
		-0.25

	createAtmosphere(
		0.38,
		0.3,
		Color3.fromRGB(65, 85, 150),
		Color3.fromRGB(20, 25, 70)
	)

	createColorCorrection(
		-0.03,
		0.12,
		-0.05,
		Color3.fromRGB(185, 200, 255)
	)

	createBloom()

end

--========================================================--
-- CRIA GOTA
--========================================================--

local function createRainDrop()

	local character =
		player.Character

	local root =
		character
		and character:FindFirstChild(
			"HumanoidRootPart"
		)

	if not root then
		return
	end

	local drop =
		Instance.new("Part")

	drop.Name =
		"RainDrop"

	drop.Size =
		Vector3.new(
			0.045,
			math.random(55, 100) / 100,
			0.045
		)

	drop.Material =
		Enum.Material.Neon

	drop.Color =
		RAIN_COLOR

	drop.Transparency =
		0.28

	drop.Anchored =
		true

	drop.CanCollide =
		false

	drop.CanTouch =
		false

	drop.CanQuery =
		false

	drop.CastShadow =
		false

	local x =
		math.random(-280, 280) / 10

	local z =
		math.random(-280, 280) / 10

	local y =
		math.random(
			RAIN_HEIGHT * 10,
			(RAIN_HEIGHT + 20) * 10
		) / 10

	drop.Position =
		root.Position
		+ Vector3.new(
			x,
			y,
			z
		)

	drop.Parent =
		rainFolder

	table.insert(
		rainDrops,
		{
			part = drop,

			speed =
				math.random(
					RAIN_SPEED_MIN,
					RAIN_SPEED_MAX
				)
		}
	)

end

--========================================================--
-- POÇA FINA
--========================================================--

local function createPuddle(position)

	if not puddleFolder then
		return
	end

	if #puddles >= MAX_PUDDLES then

		local old =
			table.remove(
				puddles,
				1
			)

		if old and old.Parent then
			old:Destroy()
		end
	end

	local puddle =
		Instance.new("Part")

	puddle.Name =
		"WaterPuddle"

	puddle.Shape =
		Enum.PartType.Cylinder

	local size =
		math.random(25, 45) / 10

	-- O cilindro do Roblox tem o eixo
	-- longitudinal no X.
	-- Giramos 90° no Z para deixá-lo
	-- DEITADO no chão.

	puddle.Size =
		Vector3.new(
			0.035,
			size,
			size
		)

	puddle.CFrame =
		CFrame.new(
			position
			+ Vector3.new(
				0,
				0.025,
				0
			)
		)
		* CFrame.Angles(
			0,
			0,
			math.rad(90)
		)

	puddle.Material =
		Enum.Material.Glass

	puddle.Color =
		Color3.fromRGB(
			145,
			205,
			235
		)

	puddle.Transparency =
		0.38

	puddle.Reflectance =
		0.18

	puddle.Anchored =
		true

	puddle.CanCollide =
		false

	puddle.CanTouch =
		false

	puddle.CanQuery =
		false

	puddle.CastShadow =
		false

	puddle.Parent =
		puddleFolder

	table.insert(
		puddles,
		puddle
	)

	-- Efeito de crescimento da poça
	puddle.Size =
		Vector3.new(
			0.035,
			0.2,
			0.2
		)

	local finalSize =
		Vector3.new(
			0.035,
			size,
			size
		)

	local tween =
		TweenService:Create(
			puddle,

			TweenInfo.new(
				0.45,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			),

			{
				Size = finalSize
			}
		)

	tween:Play()

end

--========================================================--
-- ATUALIZA POÇAS
--========================================================--

local puddleTimer = 0

local function updatePuddles(dt)

	if not rainEnabled then
		return
	end

	local character =
		player.Character

	local root =
		character
		and character:FindFirstChild(
			"HumanoidRootPart"
		)

	if not root then
		return
	end

	puddleTimer += dt

	if puddleTimer < 0.65 then
		return
	end

	puddleTimer = 0

	local rayParams =
		RaycastParams.new()

	rayParams.FilterType =
		Enum.RaycastFilterType.Exclude

	rayParams.FilterDescendantsInstances = {
		character,
		rainFolder,
		puddleFolder
	}

	local angle =
		math.random()
		* math.pi
		* 2

	local distance =
		math.random(
			6,
			PUDDLE_DISTANCE
		)

	local offset =
		Vector3.new(
			math.cos(angle) * distance,
			0,
			math.sin(angle) * distance
		)

	local origin =
		root.Position
		+ offset
		+ Vector3.new(
			0,
			30,
			0
		)

	local result =
		Workspace:Raycast(
			origin,
			Vector3.new(
				0,
				-70,
				0
			),
			rayParams
		)

	if not result then
		return
	end

	-- Evita criar poça em parede
	-- ou superfície muito inclinada.

	if result.Normal.Y < 0.75 then
		return
	end

	createPuddle(
		result.Position
	)

end

--========================================================--
-- CHUVA
--========================================================--

local function createRain()

	realTimeEnabled = false

	removeRain()
	removeSnow()
	removePuddles()

	rainEnabled = true

	Lighting.ClockTime = 15
	Lighting.Brightness = 1.05

	Lighting.Ambient =
		Color3.fromRGB(
			75,
			88,
			105
		)

	Lighting.OutdoorAmbient =
		Color3.fromRGB(
			85,
			100,
			120
		)

	Lighting.ExposureCompensation =
		-0.1

	createAtmosphere(
		0.43,
		0.58,
		Color3.fromRGB(
			150,
			175,
			200
		),
		Color3.fromRGB(
			75,
			90,
			115
		)
	)

	createColorCorrection(
		-0.03,
		0.1,
		-0.12,
		Color3.fromRGB(
			205,
			225,
			255
		)
	)

	createBloom()

	rainFolder =
		Instance.new("Folder")

	rainFolder.Name =
		"SeraphRain"

	rainFolder.Parent =
		Workspace

	for i = 1, RAIN_AMOUNT do
		createRainDrop()
	end

	puddleFolder =
		Instance.new("Folder")

	puddleFolder.Name =
		"SeraphPuddles"

	puddleFolder.Parent =
		Workspace

end

--========================================================--
-- SNOW
--========================================================--

local function createSnowFlake()

	local character =
		player.Character

	local root =
		character
		and character:FindFirstChild(
			"HumanoidRootPart"
		)

	if not root then
		return
	end

	local flake =
		Instance.new("Part")

	flake.Name =
		"SnowFlake"

	flake.Shape =
		Enum.PartType.Ball

	flake.Size =
		Vector3.new(
			0.12,
			0.12,
			0.12
		)

	flake.Material =
		Enum.Material.SmoothPlastic

	flake.Color =
		Color3.fromRGB(
			255,
			255,
			255
		)

	flake.Transparency =
		0.12

	flake.Anchored =
		true

	flake.CanCollide =
		false

	flake.CanTouch =
		false

	flake.CanQuery =
		false

	flake.CastShadow =
		false

	local x =
		math.random(
			-250,
			250
		) / 10

	local z =
		math.random(
			-250,
			250
		) / 10

	local y =
		math.random(
			20,
			55
		)

	flake.Position =
		root.Position
		+ Vector3.new(
			x,
			y,
			z
		)

	flake.Parent =
		snowFolder

	table.insert(
		snowFlakes,
		{
			part = flake,

			speed =
				math.random(
					SNOW_SPEED_MIN,
					SNOW_SPEED_MAX
				)
		}
	)

end

--========================================================--
-- SNOWFALL
--========================================================--

local function snowfall()

	realTimeEnabled = false

	clearWeather()

	snowEnabled = true

	Lighting.ClockTime = 12
	Lighting.Brightness = 1.65

	Lighting.Ambient =
		Color3.fromRGB(
			175,
			185,
			205
		)

	Lighting.OutdoorAmbient =
		Color3.fromRGB(
			190,
			200,
			220
		)

	createAtmosphere(
		0.32,
		0.42,
		Color3.fromRGB(
			210,
			225,
			255
		),
		Color3.fromRGB(
			185,
			205,
			240
		)
	)

	createColorCorrection(
		0.02,
		0.03,
		-0.05,
		Color3.fromRGB(
			225,
			235,
			255
		)
	)

	createBloom()

	snowFolder =
		Instance.new("Folder")

	snowFolder.Name =
		"SeraphSnow"

	snowFolder.Parent =
		Workspace

	for i = 1, SNOW_AMOUNT do
		createSnowFlake()
	end

end

--========================================================--
-- RESTORE SHADER
--========================================================--

local function restoreShader()

	realTimeEnabled = false

	clearWeather()
	clearShaderEffects()

	Lighting.ClockTime =
		originalLighting.ClockTime

	Lighting.Brightness =
		originalLighting.Brightness

	Lighting.Ambient =
		originalLighting.Ambient

	Lighting.OutdoorAmbient =
		originalLighting.OutdoorAmbient

	Lighting.FogColor =
		originalLighting.FogColor

	Lighting.FogStart =
		originalLighting.FogStart

	Lighting.FogEnd =
		originalLighting.FogEnd

	Lighting.ExposureCompensation =
		originalLighting.ExposureCompensation

	Lighting.GlobalShadows =
		originalLighting.GlobalShadows

end

--========================================================--
-- PADRÃO
--========================================================--

local function defaultShader()

	realTimeEnabled = false

	clearWeather()
	clearShaderEffects()

	Lighting.ClockTime = 12

	Lighting.Brightness = 2

	Lighting.Ambient =
		Color3.fromRGB(
			128,
			128,
			128
		)

	Lighting.OutdoorAmbient =
		Color3.fromRGB(
			128,
			128,
			128
		)

	Lighting.ExposureCompensation = 0

end

--========================================================--
-- REAL TIME
--========================================================--

local function toggleRealTime()

	realTimeEnabled =
		not realTimeEnabled

	if realTimeEnabled then

		clearWeather()
		clearShaderEffects()

		realButton.Text =
			"Real Time: ON"

	else

		realButton.Text =
			"Real Time: OFF"

	end

end

--========================================================--
-- LOOP REAL TIME
--========================================================--

RunService.Heartbeat:Connect(function()

	if not realTimeEnabled then
		return
	end

	local date =
		os.date("*t")

	Lighting.ClockTime =
		date.hour
		+ date.min / 60
		+ date.sec / 3600

end)

--========================================================--
-- LOOP CHUVA
--========================================================--

RunService.Heartbeat:Connect(function(dt)

	if not rainEnabled then
		return
	end

	local character =
		player.Character

	local root =
		character
		and character:FindFirstChild(
			"HumanoidRootPart"
		)

	if not root then
		return
	end

	for i = #rainDrops, 1, -1 do

		local data =
			rainDrops[i]

		local drop =
			data.part

		if not drop or not drop.Parent then

			table.remove(
				rainDrops,
				i
			)

			continue
		end

		drop.Position -=
			Vector3.new(
				0,
				data.speed * dt,
				0
			)

		if drop.Position.Y <
			root.Position.Y - 4 then

			local x =
				math.random(
					-280,
					280
				) / 10

			local z =
				math.random(
					-280,
					280
				) / 10

			drop.Position =
				root.Position
				+ Vector3.new(
					x,
					RAIN_HEIGHT
						+ math.random(
							0,
							20
						),
					z
				)

		end
	end

	updatePuddles(dt)

end)

--========================================================--
-- LOOP NEVE
--========================================================--

RunService.Heartbeat:Connect(function(dt)

	if not snowEnabled then
		return
	end

	local character =
		player.Character

	local root =
		character
		and character:FindFirstChild(
			"HumanoidRootPart"
		)

	if not root then
		return
	end

	for i = #snowFlakes, 1, -1 do

		local data =
			snowFlakes[i]

		local flake =
			data.part

		if not flake or not flake.Parent then

			table.remove(
				snowFlakes,
				i
			)

			continue
		end

		flake.Position -=
			Vector3.new(
				0,
				data.speed * dt,
				0
			)

		flake.Position +=
			Vector3.new(
				math.sin(
					os.clock() + i
				) * 0.01,
				0,
				math.cos(
					os.clock() + i
				) * 0.01
			)

		if flake.Position.Y <
			root.Position.Y - 3 then

			local x =
				math.random(
					-250,
					250
				) / 10

			local z =
				math.random(
					-250,
					250
				) / 10

			flake.Position =
				root.Position
				+ Vector3.new(
					x,
					SNOW_HEIGHT,
					z
				)

		end
	end

end)

--========================================================--
-- CONECTA BOTÕES
--========================================================--

noonButton.MouseButton1Click:Connect(
	function()
		noon()
	end
)

sunriseButton.MouseButton1Click:Connect(
	function()
		sunrise()
	end
)

sunsetButton.MouseButton1Click:Connect(
	function()
		sunset()
	end
)

nightButton.MouseButton1Click:Connect(
	function()
		night()
	end
)

rainButton.MouseButton1Click:Connect(
	function()
		createRain()
	end
)

snowButton.MouseButton1Click:Connect(
	function()
		snowfall()
	end
)

realButton.MouseButton1Click:Connect(
	function()
		toggleRealTime()
	end
)

restoreButton.MouseButton1Click:Connect(
	function()

		restoreShader()

		realButton.Text =
			"Real Time: OFF"

	end
)

defaultButton.MouseButton1Click:Connect(
	function()

		defaultShader()

		realButton.Text =
			"Real Time: OFF"

	end
)

--========================================================--
-- INICIALIZA
--========================================================--

defaultShader()

print("================================")
print("SERAPH SHADERS 2.1")
print("SH MINIMIZE: OK")
print("RAIN: OK")
print("PUDDLES: OK")
print("SNOWFALL: OK")
print("RESTORE: OK")
print("DEFAULT: OK")
print("RGB: OK")
print("================================")
