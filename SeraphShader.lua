--[[ Made with love, https://bobloscript.com/obfuscator ]]
local C = game:GetService("Players");
local w = game:GetService("Lighting");
local E = game:GetService("RunService");
local S = game:GetService("UserInputService");
local Z = game:GetService("Workspace");
local U = game:GetService("TweenService");
local q = C.LocalPlayer;
local O = q:WaitForChild("PlayerGui");
local n = "SERAPH_SHADER_GUI";
local W = Color3.fromRGB(175, 225, 255);
local G = 85;
local Y = 55;
local B = 38;
local X = 90;
local o = 125;
local c = 35;
local m = 5;
local P = 10;
local g = 28;
local v = 14;
local Q = false;
local D = false;
local H = false;
local r = {};
local b = {};
local a = {};
local V;
local d;
local R;
local K;
local I = {};
local j = O:FindFirstChild(n);
if j then
	j:Destroy();
end;
local h = {
		ClockTime = w.ClockTime,
		Brightness = w.Brightness,
		Ambient = w.Ambient,
		OutdoorAmbient = w.OutdoorAmbient,
		FogColor = w.FogColor,
		FogStart = w.FogStart,
		FogEnd = w.FogEnd,
		ExposureCompensation = w.ExposureCompensation,
		GlobalShadows = w.GlobalShadows,
	};
local function s(C)
	local w = ((os.clock() * .12 + C)) % 1;
	return Color3.fromHSV(w, .9, 1);
end;
local function L(C)
	table.insert(I, C);
end;
E.RenderStepped:Connect(function()
	for C = #I, 1, -1 do
		local w = I[C];
		if w and w.Parent then
			w.Color = s(C * .025);
		else
			table.remove(I, C);
		end;
	end;
end);
local x = Instance.new("ScreenGui");
x.Name = n;
x.ResetOnSpawn = false;
x.IgnoreGuiInset = true;
x.DisplayOrder = 999;
x.ZIndexBehavior = Enum.ZIndexBehavior.Global;
x.Parent = O;
local F = Instance.new("Frame");
F.Name = "ShaderPanel";
F.Size = UDim2.new(0, 470, 0, 385);
F.AnchorPoint = Vector2.new(.5, .5);
F.Position = UDim2.new(.5, 0, .5, 0);
F.BackgroundColor3 = Color3.fromRGB(24, 17, 36);
F.BackgroundTransparency = .06;
F.BorderSizePixel = 0;
F.Parent = x;
local u = Instance.new("UICorner");
u.CornerRadius = UDim.new(0, 16);
u.Parent = F;
local y = Instance.new("UIStroke");
y.Thickness = 3;
y.Parent = F;
L(y);
local i = Instance.new("Frame");
i.Name = "Header";
i.Size = UDim2.new(1, 0, 0, 68);
i.BackgroundTransparency = 1;
i.Parent = F;
local A = Instance.new("TextLabel");
A.Name = "Title";
A.BackgroundTransparency = 1;
A.Position = UDim2.new(0, 25, 0, 10);
A.Size = UDim2.new(1, -145, 0, 28);
A.Font = Enum.Font.GothamBold;
A.Text = "Seraph Shaders";
A.TextColor3 = Color3.fromRGB(255, 255, 255);
A.TextSize = 20;
A.TextXAlignment = Enum.TextXAlignment.Left;
A.Parent = i;
local p = Instance.new("TextLabel");
p.Name = "Subtitle";
p.BackgroundTransparency = 1;
p.Position = UDim2.new(0, 25, 0, 38);
p.Size = UDim2.new(1, -145, 0, 18);
p.Font = Enum.Font.Gotham;
p.Text = "Shaders \226\128\162 Environment";
p.TextColor3 = Color3.fromRGB(165, 155, 180);
p.TextSize = 11;
p.TextXAlignment = Enum.TextXAlignment.Left;
p.Parent = i;
local k = Instance.new("TextButton");
k.Name = "Minimize";
k.Size = UDim2.new(0, 42, 0, 42);
k.Position = UDim2.new(1, -102, 0, 12);
k.BackgroundColor3 = Color3.fromRGB(34, 23, 48);
k.BorderSizePixel = 0;
k.Text = "SH";
k.TextColor3 = Color3.fromRGB(255, 255, 255);
k.TextSize = 13;
k.Font = Enum.Font.GothamBold;
k.AutoButtonColor = false;
k.Parent = F;
local f = Instance.new("UICorner");
f.CornerRadius = UDim.new(0, 11);
f.Parent = k;
local z = Instance.new("UIStroke");
z.Thickness = 1.8;
z.Parent = k;
L(z);
local e = Instance.new("TextButton");
e.Name = "Close";
e.Size = UDim2.new(0, 42, 0, 42);
e.Position = UDim2.new(1, -54, 0, 12);
e.BackgroundColor3 = Color3.fromRGB(34, 23, 48);
e.BorderSizePixel = 0;
e.Text = "\195\151";
e.TextColor3 = Color3.fromRGB(255, 255, 255);
e.TextSize = 25;
e.Font = Enum.Font.GothamBold;
e.AutoButtonColor = false;
e.Parent = F;
local M = Instance.new("UICorner");
M.CornerRadius = UDim.new(0, 11);
M.Parent = e;
local l = Instance.new("UIStroke");
l.Thickness = 1.8;
l.Parent = e;
L(l);
local t = Instance.new("TextButton");
t.Name = "SH_Floating";
t.Size = UDim2.new(0, 58, 0, 58);
t.Position = UDim2.new(.08, 0, .25, 0);
t.AnchorPoint = Vector2.new(.5, .5);
t.BackgroundColor3 = Color3.fromRGB(27, 20, 38);
t.BackgroundTransparency = .04;
t.BorderSizePixel = 0;
t.Text = "SH";
t.TextColor3 = Color3.fromRGB(255, 255, 255);
t.TextSize = 17;
t.Font = Enum.Font.GothamBold;
t.AutoButtonColor = false;
t.Visible = false;
t.ZIndex = 100;
t.Parent = x;
local T = Instance.new("UICorner");
T.CornerRadius = UDim.new(0, 15);
T.Parent = t;
local J = Instance.new("UIStroke");
J.Thickness = 3;
J.Parent = t;
L(J);
t.MouseButton1Click:Connect(function()
	F.Visible = true;
	t.Visible = false;
end);
k.MouseButton1Click:Connect(function()
	F.Visible = false;
	t.Visible = true;
end);
e.MouseButton1Click:Connect(function()
	F.Visible = false;
	t.Visible = false;
end);
local N = false;
local CN;
local wN;
i.InputBegan:Connect(function(C)
	if C.UserInputType == Enum.UserInputType.MouseButton1 or C.UserInputType == Enum.UserInputType.Touch then
		N = true;
		CN = C.Position;
		wN = F.Position;
	end;
end);
i.InputEnded:Connect(function(C)
	if C.UserInputType == Enum.UserInputType.MouseButton1 or C.UserInputType == Enum.UserInputType.Touch then
		N = false;
	end;
end);
S.InputChanged:Connect(function(C)
	if not N then
		return;
	end;
	if C.UserInputType ~= Enum.UserInputType.MouseMovement and C.UserInputType ~= Enum.UserInputType.Touch then
		return;
	end;
	local w = C.Position - CN;
	F.Position = UDim2.new(wN.X.Scale, wN.X.Offset + w.X, wN.Y.Scale, wN.Y.Offset + w.Y);
end);
local EN = false;
local SN;
local ZN;
t.InputBegan:Connect(function(C)
	if C.UserInputType == Enum.UserInputType.MouseButton1 or C.UserInputType == Enum.UserInputType.Touch then
		EN = true;
		SN = C.Position;
		ZN = t.Position;
	end;
end);
t.InputEnded:Connect(function(C)
	if C.UserInputType == Enum.UserInputType.MouseButton1 or C.UserInputType == Enum.UserInputType.Touch then
		EN = false;
	end;
end);
S.InputChanged:Connect(function(C)
	if not EN then
		return;
	end;
	if C.UserInputType ~= Enum.UserInputType.MouseMovement and C.UserInputType ~= Enum.UserInputType.Touch then
		return;
	end;
	local w = C.Position - SN;
	t.Position = UDim2.new(ZN.X.Scale, ZN.X.Offset + w.X, ZN.Y.Scale, ZN.Y.Offset + w.Y);
end);
local UN = Instance.new("Frame");
UN.Name = "Buttons";
UN.Position = UDim2.new(0, 22, 0, 78);
UN.Size = UDim2.new(1, -44, 1, -92);
UN.BackgroundTransparency = 1;
UN.Parent = F;
local qN = Instance.new("UIGridLayout");
qN.CellSize = UDim2.new(.5, -6, 0, 48);
qN.CellPadding = UDim2.new(0, 10, 0, 9);
qN.FillDirectionMaxCells = 2;
qN.SortOrder = Enum.SortOrder.LayoutOrder;
qN.Parent = UN;
local function ON(C, w)
	local E = Instance.new("TextButton");
	E.Name = C:gsub("%s+", "");
	E.LayoutOrder = w;
	E.BackgroundColor3 = Color3.fromRGB(30, 21, 48);
	E.BackgroundTransparency = .04;
	E.BorderSizePixel = 0;
	E.Text = C;
	E.TextColor3 = Color3.fromRGB(245, 240, 250);
	E.TextSize = 14;
	E.Font = Enum.Font.GothamSemibold;
	E.AutoButtonColor = false;
	E.Parent = UN;
	local S = Instance.new("UICorner");
	S.CornerRadius = UDim.new(0, 12);
	S.Parent = E;
	local Z = Instance.new("UIStroke");
	Z.Thickness = 1.5;
	Z.Transparency = .05;
	Z.Parent = E;
	L(Z);
	E.MouseEnter:Connect(function()
		E.BackgroundColor3 = Color3.fromRGB(48, 30, 70);
	end);
	E.MouseLeave:Connect(function()
		E.BackgroundColor3 = Color3.fromRGB(30, 21, 48);
	end);
	return E;
end;
local nN = ON("Noon", 1);
local WN = ON("Sunrise", 2);
local GN = ON("Sunset", 3);
local YN = ON("Night", 4);
local BN = ON("Rain", 5);
local XN = ON("Snowfall", 6);
local oN = ON("Real Time: OFF", 7);
local cN = ON("Restore Shader", 8);
local mN = ON("Padr\195\163o", 9);
K = Instance.new("Folder");
K.Name = "SeraphShaderEffects";
K.Parent = w;
local function PN()
	for C, w in ipairs(K:GetChildren()) do
		w:Destroy();
	end;
end;
local function gN(C, w, E, S)
	PN();
	local Z = Instance.new("Atmosphere");
	Z.Name = "Atmosphere";
	Z.Density = C;
	Z.Haze = w;
	Z.Color = E;
	Z.Decay = S;
	Z.Glare = 0;
	Z.Parent = K;
	return Z;
end;
local function vN(C, w, E, S)
	local Z = Instance.new("ColorCorrectionEffect");
	Z.Name = "ColorCorrection";
	Z.Brightness = C;
	Z.Contrast = w;
	Z.Saturation = E;
	Z.TintColor = S;
	Z.Parent = K;
	return Z;
end;
local function QN()
	local C = Instance.new("BloomEffect");
	C.Name = "Bloom";
	C.Intensity = .12;
	C.Size = 18;
	C.Threshold = 1.2;
	C.Parent = K;
end;
local function DN(C)
	local w = Instance.new("SunRaysEffect");
	w.Name = "SunRays";
	w.Intensity = C;
	w.Spread = .8;
	w.Parent = K;
end;
local function HN()
	Q = false;
	for C, w in ipairs(r) do
		if w and w.Parent then
			w:Destroy();
		end;
	end;
	table.clear(r);
	if V then
		V:Destroy();
		V = nil;
	end;
end;
local function rN()
	D = false;
	for C, w in ipairs(b) do
		if w and w.Parent then
			w:Destroy();
		end;
	end;
	table.clear(b);
	if d then
		d:Destroy();
		d = nil;
	end;
end;
local function bN()
	if R then
		R:Destroy();
		R = nil;
	end;
	table.clear(a);
end;
local function aN()
	HN();
	rN();
	bN();
end;
local function VN()
	H = false;
	aN();
	w.ClockTime = 12;
	w.Brightness = 3;
	w.Ambient = Color3.fromRGB(155, 155, 155);
	w.OutdoorAmbient = Color3.fromRGB(190, 190, 190);
	w.ExposureCompensation = .15;
	gN(.15, .04, Color3.fromRGB(205, 225, 255), Color3.fromRGB(255, 255, 255));
	vN(.02, .05, .05, Color3.fromRGB(255, 255, 255));
	QN();
	DN(.08);
end;
local function dN()
	H = false;
	aN();
	w.ClockTime = 6.1;
	w.Brightness = 2.2;
	w.Ambient = Color3.fromRGB(125, 100, 100);
	w.OutdoorAmbient = Color3.fromRGB(170, 125, 105);
	gN(.25, .12, Color3.fromRGB(255, 190, 155), Color3.fromRGB(255, 125, 90));
	vN(.02, .08, .08, Color3.fromRGB(255, 225, 205));
	QN();
	DN(.12);
end;
local function RN()
	H = false;
	aN();
	w.ClockTime = 18.1;
	w.Brightness = 1.8;
	w.Ambient = Color3.fromRGB(110, 70, 85);
	w.OutdoorAmbient = Color3.fromRGB(155, 80, 60);
	gN(.3, .24, Color3.fromRGB(255, 140, 105), Color3.fromRGB(125, 75, 135));
	vN(0, .1, .12, Color3.fromRGB(255, 215, 190));
	QN();
	DN(.09);
end;
local function KN()
	H = false;
	aN();
	w.ClockTime = 0;
	w.Brightness = .45;
	w.Ambient = Color3.fromRGB(25, 30, 65);
	w.OutdoorAmbient = Color3.fromRGB(12, 18, 45);
	w.ExposureCompensation = -0.25;
	gN(.38, .3, Color3.fromRGB(65, 85, 150), Color3.fromRGB(20, 25, 70));
	vN(-0.03, .12, -0.05, Color3.fromRGB(185, 200, 255));
	QN();
end;
local function IN()
	local C = q.Character;
	local w = C and C:FindFirstChild("HumanoidRootPart");
	if not w then
		return;
	end;
	local E = Instance.new("Part");
	E.Name = "RainDrop";
	E.Size = Vector3.new(.045, math.random(55, 100) / 100, .045);
	E.Material = Enum.Material.Neon;
	E.Color = W;
	E.Transparency = .28;
	E.Anchored = true;
	E.CanCollide = false;
	E.CanTouch = false;
	E.CanQuery = false;
	E.CastShadow = false;
	local S = math.random(-280, 280) / 10;
	local Z = math.random(-280, 280) / 10;
	local U = math.random(B * 10, ((B + 20)) * 10) / 10;
	E.Position = w.Position + Vector3.new(S, U, Z);
	E.Parent = V;
	table.insert(r, { part = E, speed = math.random(X, o) });
end;
local function jN(C)
	if not R then
		return;
	end;
	if #a >= v then
		local C = table.remove(a, 1);
		if C and C.Parent then
			C:Destroy();
		end;
	end;
	local w = Instance.new("Part");
	w.Name = "WaterPuddle";
	w.Shape = Enum.PartType.Cylinder;
	local E = math.random(25, 45) / 10;
	w.Size = Vector3.new(.035, E, E);
	w.CFrame = CFrame.new(C + Vector3.new(0, .025, 0)) * CFrame.Angles(0, 0, math.rad(90));
	w.Material = Enum.Material.Glass;
	w.Color = Color3.fromRGB(145, 205, 235);
	w.Transparency = .38;
	w.Reflectance = .18;
	w.Anchored = true;
	w.CanCollide = false;
	w.CanTouch = false;
	w.CanQuery = false;
	w.CastShadow = false;
	w.Parent = R;
	table.insert(a, w);
	w.Size = Vector3.new(.035, .2, .2);
	local S = Vector3.new(.035, E, E);
	local Z = U:Create(w, TweenInfo.new(.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = S });
	Z:Play();
end;
local hN = 0;
local function sN(C)
	if not Q then
		return;
	end;
	local w = q.Character;
	local E = w and w:FindFirstChild("HumanoidRootPart");
	if not E then
		return;
	end;
	hN += C;
	if hN < .65 then
		return;
	end;
	hN = 0;
	local S = RaycastParams.new();
	S.FilterType = Enum.RaycastFilterType.Exclude;
	S.FilterDescendantsInstances = { w, V, R };
	local U = (math.random() * math.pi) * 2;
	local O = math.random(6, g);
	local n = Vector3.new(math.cos(U) * O, 0, math.sin(U) * O);
	local W = (E.Position + n) + Vector3.new(0, 30, 0);
	local G = Z:Raycast(W, Vector3.new(0, -70, 0), S);
	if not G then
		return;
	end;
	if G.Normal.Y < .75 then
		return;
	end;
	jN(G.Position);
end;
local function LN()
	H = false;
	HN();
	rN();
	bN();
	Q = true;
	w.ClockTime = 15;
	w.Brightness = 1.05;
	w.Ambient = Color3.fromRGB(75, 88, 105);
	w.OutdoorAmbient = Color3.fromRGB(85, 100, 120);
	w.ExposureCompensation = -0.1;
	gN(.43, .58, Color3.fromRGB(150, 175, 200), Color3.fromRGB(75, 90, 115));
	vN(-0.03, .1, -0.12, Color3.fromRGB(205, 225, 255));
	QN();
	V = Instance.new("Folder");
	V.Name = "SeraphRain";
	V.Parent = Z;
	for C = 1, G, 1 do
		IN();
	end;
	R = Instance.new("Folder");
	R.Name = "SeraphPuddles";
	R.Parent = Z;
end;
local function xN()
	local C = q.Character;
	local w = C and C:FindFirstChild("HumanoidRootPart");
	if not w then
		return;
	end;
	local E = Instance.new("Part");
	E.Name = "SnowFlake";
	E.Shape = Enum.PartType.Ball;
	E.Size = Vector3.new(.12, .12, .12);
	E.Material = Enum.Material.SmoothPlastic;
	E.Color = Color3.fromRGB(255, 255, 255);
	E.Transparency = .12;
	E.Anchored = true;
	E.CanCollide = false;
	E.CanTouch = false;
	E.CanQuery = false;
	E.CastShadow = false;
	local S = math.random(-250, 250) / 10;
	local Z = math.random(-250, 250) / 10;
	local U = math.random(20, 55);
	E.Position = w.Position + Vector3.new(S, U, Z);
	E.Parent = d;
	table.insert(b, { part = E, speed = math.random(m, P) });
end;
local function FN()
	H = false;
	aN();
	D = true;
	w.ClockTime = 12;
	w.Brightness = 1.65;
	w.Ambient = Color3.fromRGB(175, 185, 205);
	w.OutdoorAmbient = Color3.fromRGB(190, 200, 220);
	gN(.32, .42, Color3.fromRGB(210, 225, 255), Color3.fromRGB(185, 205, 240));
	vN(.02, .03, -0.05, Color3.fromRGB(225, 235, 255));
	QN();
	d = Instance.new("Folder");
	d.Name = "SeraphSnow";
	d.Parent = Z;
	for C = 1, Y, 1 do
		xN();
	end;
end;
local function uN()
	H = false;
	aN();
	PN();
	w.ClockTime = h.ClockTime;
	w.Brightness = h.Brightness;
	w.Ambient = h.Ambient;
	w.OutdoorAmbient = h.OutdoorAmbient;
	w.FogColor = h.FogColor;
	w.FogStart = h.FogStart;
	w.FogEnd = h.FogEnd;
	w.ExposureCompensation = h.ExposureCompensation;
	w.GlobalShadows = h.GlobalShadows;
end;
local function yN()
	H = false;
	aN();
	PN();
	w.ClockTime = 12;
	w.Brightness = 2;
	w.Ambient = Color3.fromRGB(128, 128, 128);
	w.OutdoorAmbient = Color3.fromRGB(128, 128, 128);
	w.ExposureCompensation = 0;
end;
local function iN()
	H = not H;
	if H then
		aN();
		PN();
		oN.Text = "Real Time: ON";
	else
		oN.Text = "Real Time: OFF";
	end;
end;
E.Heartbeat:Connect(function()
	if not H then
		return;
	end;
	local C = os.date("*t");
	w.ClockTime = (C.hour + C.min / 60) + C.sec / 3600;
end);
E.Heartbeat:Connect(function(C)
	if not Q then
		return;
	end;
	local w = q.Character;
	local E = w and w:FindFirstChild("HumanoidRootPart");
	if not E then
		return;
	end;
	for w = #r, 1, -1 do
		local S = r[w];
		local Z = S.part;
		if not Z or not Z.Parent then
			table.remove(r, w);
			continue;
		end;
		Z.Position -= Vector3.new(0, S.speed * C, 0);
		if Z.Position.Y < E.Position.Y - 4 then
			local C = math.random(-280, 280) / 10;
			local w = math.random(-280, 280) / 10;
			Z.Position = E.Position + Vector3.new(C, B + math.random(0, 20), w);
		end;
	end;
	sN(C);
end);
E.Heartbeat:Connect(function(C)
	if not D then
		return;
	end;
	local w = q.Character;
	local E = w and w:FindFirstChild("HumanoidRootPart");
	if not E then
		return;
	end;
	for w = #b, 1, -1 do
		local S = b[w];
		local Z = S.part;
		if not Z or not Z.Parent then
			table.remove(b, w);
			continue;
		end;
		Z.Position -= Vector3.new(0, S.speed * C, 0);
		Z.Position += Vector3.new(math.sin(os.clock() + w) * .01, 0, math.cos(os.clock() + w) * .01);
		if Z.Position.Y < E.Position.Y - 3 then
			local C = math.random(-250, 250) / 10;
			local w = math.random(-250, 250) / 10;
			Z.Position = E.Position + Vector3.new(C, c, w);
		end;
	end;
end);
nN.MouseButton1Click:Connect(function()
	VN();
end);
WN.MouseButton1Click:Connect(function()
	dN();
end);
GN.MouseButton1Click:Connect(function()
	RN();
end);
YN.MouseButton1Click:Connect(function()
	KN();
end);
BN.MouseButton1Click:Connect(function()
	LN();
end);
XN.MouseButton1Click:Connect(function()
	FN();
end);
oN.MouseButton1Click:Connect(function()
	iN();
end);
cN.MouseButton1Click:Connect(function()
	uN();
	oN.Text = "Real Time: OFF";
end);
mN.MouseButton1Click:Connect(function()
	yN();
	oN.Text = "Real Time: OFF";
end);
yN();
print("================================");
print("SERAPH SHADERS 2.1");
print("SH MINIMIZE: OK");
print("RAIN: OK");
print("PUDDLES: OK");
print("SNOWFALL: OK");
print("RESTORE: OK");
print("DEFAULT: OK");
print("RGB: OK");
print("================================");
