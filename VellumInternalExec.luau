--   _    __________    __    __  ____  ___
--  | |  / / ____/ /   / /   / / / /  |/  /
--  | | / / __/ / /   / /   / / / / /|_/ / 
--  | |/ / /___/ /___/ /___/ /_/ / /  / /  
--  |___/_____/_____/_____/\____/_/  /_/   
--            

--// References
local players = game:GetService("Players")
local uis = game:GetService("UserInputService")
local tweenserv = game:GetService("TweenService")
local playergui = players.LocalPlayer:WaitForChild("PlayerGui")
local logoAsset = ""

--// Themes
local themes = {
	Amethyst = {
		bgTop = Color3.fromRGB(62, 10, 100), bgBottom = Color3.fromRGB(32, 4, 56),
		side = Color3.fromRGB(22, 2, 40), card = Color3.fromRGB(28, 4, 50),
		edge = Color3.fromRGB(96, 36, 140),
		accent = Color3.fromRGB(196, 92, 255), accent2 = Color3.fromRGB(136, 0, 190),
		text = Color3.fromRGB(246, 240, 255), muted = Color3.fromRGB(184, 158, 214),
		good = Color3.fromRGB(126, 232, 176), bad = Color3.fromRGB(255, 107, 139),
		kw = Color3.fromRGB(255, 125, 200), str = Color3.fromRGB(166, 235, 150), num = Color3.fromRGB(255, 184, 108), com = Color3.fromRGB(130, 110, 160),
		fn = Color3.fromRGB(130, 190, 255), bi = Color3.fromRGB(120, 230, 235), op = Color3.fromRGB(200, 170, 235),
	},
	Midnight = {
		bgTop = Color3.fromRGB(16, 36, 82), bgBottom = Color3.fromRGB(6, 14, 38),
		side = Color3.fromRGB(4, 10, 28), card = Color3.fromRGB(8, 18, 46),
		edge = Color3.fromRGB(40, 76, 140),
		accent = Color3.fromRGB(86, 160, 255), accent2 = Color3.fromRGB(34, 96, 226),
		text = Color3.fromRGB(236, 244, 255), muted = Color3.fromRGB(150, 174, 212),
		good = Color3.fromRGB(126, 232, 176), bad = Color3.fromRGB(255, 120, 130),
		kw = Color3.fromRGB(199, 146, 255), str = Color3.fromRGB(152, 224, 166), num = Color3.fromRGB(255, 196, 120), com = Color3.fromRGB(96, 120, 164),
		fn = Color3.fromRGB(110, 200, 255), bi = Color3.fromRGB(90, 225, 215), op = Color3.fromRGB(150, 180, 230),
	},
	Ember = {
		bgTop = Color3.fromRGB(88, 26, 14), bgBottom = Color3.fromRGB(40, 8, 6),
		side = Color3.fromRGB(28, 4, 4), card = Color3.fromRGB(38, 8, 6),
		edge = Color3.fromRGB(134, 54, 32),
		accent = Color3.fromRGB(255, 146, 64), accent2 = Color3.fromRGB(216, 72, 30),
		text = Color3.fromRGB(255, 242, 234), muted = Color3.fromRGB(216, 168, 148),
		good = Color3.fromRGB(150, 232, 150), bad = Color3.fromRGB(255, 110, 120),
		kw = Color3.fromRGB(255, 112, 112), str = Color3.fromRGB(190, 232, 140), num = Color3.fromRGB(255, 184, 96), com = Color3.fromRGB(156, 112, 96),
		fn = Color3.fromRGB(255, 210, 130), bi = Color3.fromRGB(255, 150, 110), op = Color3.fromRGB(230, 170, 150),
	},
	Forest = {
		bgTop = Color3.fromRGB(14, 72, 52), bgBottom = Color3.fromRGB(4, 34, 24),
		side = Color3.fromRGB(2, 24, 16), card = Color3.fromRGB(4, 32, 22),
		edge = Color3.fromRGB(30, 112, 82),
		accent = Color3.fromRGB(76, 220, 146), accent2 = Color3.fromRGB(18, 152, 102),
		text = Color3.fromRGB(234, 255, 244), muted = Color3.fromRGB(148, 206, 178),
		good = Color3.fromRGB(150, 240, 190), bad = Color3.fromRGB(255, 120, 130),
		kw = Color3.fromRGB(255, 170, 110), str = Color3.fromRGB(230, 236, 140), num = Color3.fromRGB(150, 210, 255), com = Color3.fromRGB(96, 150, 124),
		fn = Color3.fromRGB(130, 224, 170), bi = Color3.fromRGB(110, 214, 230), op = Color3.fromRGB(150, 206, 180),
	},
	Paper = {
		bgTop = Color3.fromRGB(252, 247, 238), bgBottom = Color3.fromRGB(238, 228, 212),
		side = Color3.fromRGB(234, 224, 208), card = Color3.fromRGB(255, 253, 248),
		edge = Color3.fromRGB(208, 192, 166),
		accent = Color3.fromRGB(214, 110, 72), accent2 = Color3.fromRGB(178, 72, 50),
		text = Color3.fromRGB(44, 38, 34), muted = Color3.fromRGB(124, 110, 92),
		good = Color3.fromRGB(46, 130, 80), bad = Color3.fromRGB(196, 56, 56),
		kw = Color3.fromRGB(176, 56, 120), str = Color3.fromRGB(40, 126, 70), num = Color3.fromRGB(190, 100, 20), com = Color3.fromRGB(150, 136, 116),
		fn = Color3.fromRGB(30, 100, 180), bi = Color3.fromRGB(0, 128, 140), op = Color3.fromRGB(110, 96, 80),
	},
}
local themeorder = { "Amethyst", "Midnight", "Ember", "Forest", "Paper" }

local fonts = {
	{ "Nunito", Enum.Font.Nunito },
	{ "Ubuntu", Enum.Font.Ubuntu },
	{ "Roboto", Enum.Font.Roboto },
	{ "Gotham", Enum.Font.Gotham },
}
local sizes = { { "Small", 0.92 }, { "Medium", 1 }, { "Large", 1.16 } }
local brand = Enum.Font.Merriweather

--// Defaults
local defaults = {
	theme = "Amethyst",
	scale = 1.16,
	font = Enum.Font.Roboto,
	lineNum = true,
	glass = false,
	anim = true,
}
local S = table.clone(defaults)
local C = table.clone(themes.Amethyst)

--// Hook
local function onRun(source)
	local okload, fn = pcall(function()
		return loadstring(source)
	end)
	if not okload or type(fn) ~= "function" then
		return false, "Error."
	end
	local okrun, err = pcall(fn)
	if not okrun then
		return false, tostring(err)
	end
	return true, "script has ran! no issues."
end

--// Registries
local paints, sized, uifonts, hooks = {}, {}, {}, {}
local function new(class, props, parent)
	local inst = Instance.new(class)
	for k, v in pairs(props) do
		if k == "paint" then
			for prop, key in pairs(v) do
				inst[prop] = C[key]
				table.insert(paints, { inst, prop, key })
			end
		elseif k == "fs" then
			inst.TextSize = math.floor(v * S.scale + 0.5)
			table.insert(sized, { inst, v })
		elseif k == "ui" then
			inst.Font = S.font
			table.insert(uifonts, inst)
		else
			inst[k] = v
		end
	end
	inst.Parent = parent
	return inst
end

local function ontheme(fn)
	fn()
	table.insert(hooks, fn)
end

local function tween(inst, time, props, style)
	local t = tweenserv:Create(
		inst,
		TweenInfo.new(S.anim and time or 0, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		props
	)
	t:Play()
	return t
end

local function round(parent, r)
	return new("UICorner", { CornerRadius = UDim.new(0, r) }, parent)
end

local function stroke(parent, key, thickness, transparency)
	return new("UIStroke", {
		Thickness = thickness or 1,
		Transparency = transparency or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		paint = { Color = key },
	}, parent)
end

local function accent(parent, rotation)
	local g = new("UIGradient", { Rotation = rotation or 0 }, parent)
	ontheme(function()
		g.Color = ColorSequence.new(C.accent, C.accent2)
	end)
	return g
end

local function applytheme(name)
	S.theme = name
	for k, v in pairs(themes[name]) do
		C[k] = v
	end
	for _, p in ipairs(paints) do
		if p[1].Parent then
			tween(p[1], 0.3, { [p[2]] = C[p[3]] })
		end
	end
	for _, fn in ipairs(hooks) do
		fn()
	end
end

local function feel(button, hoverScale)
	local s = new("UIScale", { Scale = 1 }, button)
	button.MouseEnter:Connect(function()
		tween(s, 0.15, { Scale = hoverScale or 1.03 })
	end)
	button.MouseLeave:Connect(function()
		tween(s, 0.2, { Scale = 1 })
	end)
	button.MouseButton1Down:Connect(function()
		tween(s, 0.08, { Scale = 0.96 })
	end)
	button.MouseButton1Up:Connect(function()
		tween(s, 0.15, { Scale = hoverScale or 1.03 })
	end)
end

local function pill(parent, text, filled, size, pos)
	local b = new("TextButton", {
		Size = size,
		Position = pos,
		AutoButtonColor = false,
		BackgroundTransparency = filled and 1 or 0.88,
		BorderSizePixel = 0,
		Text = filled and "" or text,
		fs = 15,
		ui = true,
		paint = filled and { BackgroundColor3 = "accent" } or { BackgroundColor3 = "accent", TextColor3 = "text" },
	}, parent)
	round(b, 999)
	if filled then
		local fill = new("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
		}, b)
		round(fill, 999)
		accent(fill, 35)
		new("TextLabel", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = text,
			TextColor3 = Color3.new(1, 1, 1),
			fs = 16,
			ui = true,
			ZIndex = 2,
		}, b)
	else
		stroke(b, "edge", 1)
		b.MouseEnter:Connect(function()
			tween(b, 0.15, { BackgroundTransparency = 0.76 })
		end)
		b.MouseLeave:Connect(function()
			tween(b, 0.2, { BackgroundTransparency = 0.88 })
		end)
	end
	feel(b)
	return b
end

--// Main GUI
local gui = new("ScreenGui", {
	Name = "VellumGui",
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playergui)

local root = new("Frame", {
	Name = "Root",
	Size = UDim2.fromOffset(660, 400),
	Position = UDim2.new(0.5, -330, 0.5, -200),
	BackgroundTransparency = 1,
}, gui)
local rootScale = new("UIScale", { Scale = 0.9 }, root)

local window = new("Frame", {
	Name = "Window",
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0,
	ClipsDescendants = true,
}, root)
round(window, 18)
local winGrad = new("UIGradient", { Rotation = 60 }, window)
ontheme(function()
	winGrad.Color = ColorSequence.new(C.bgTop, C.bgBottom)
end)
stroke(window, "accent", 1.5, 0.55)

local sidebar = new("Frame", {
	Size = UDim2.new(0, 150, 1, -20),
	Position = UDim2.fromOffset(10, 10),
	BackgroundTransparency = 0.2,
	BorderSizePixel = 0,
	paint = { BackgroundColor3 = "side" },
}, window)
round(sidebar, 12)
stroke(sidebar, "edge", 1, 0.4)

local logo = new("Frame", {
	Size = UDim2.fromOffset(42, 42),
	Position = UDim2.fromOffset(18, 20),
	BorderSizePixel = 0,
	paint = { BackgroundColor3 = "card" },
}, sidebar)
round(logo, 11)
local logoStroke = new("UIStroke", {
	Color = Color3.new(1, 1, 1),
	Thickness = 3,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
}, logo)
accent(logoStroke, 45)
if logoAsset ~= "" then
	new("ImageLabel", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = logoAsset,
		ScaleType = Enum.ScaleType.Fit,
	}, logo)
else
	new("TextLabel", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "V",
		Font = brand,
		TextSize = 26,
		paint = { TextColor3 = "text" },
	}, logo)
end

new("TextLabel", {
	Size = UDim2.new(1, -36, 0, 28),
	Position = UDim2.fromOffset(18, 70),
	BackgroundTransparency = 1,
	Text = "Vellum",
	Font = brand,
	fs = 22,
	TextXAlignment = Enum.TextXAlignment.Left,
	paint = { TextColor3 = "text" },
}, sidebar)
new("TextLabel", {
	Size = UDim2.new(1, -36, 0, 16),
	Position = UDim2.fromOffset(18, 98),
	BackgroundTransparency = 1, 
	Text = "made by cytrix",
	fs = 12,
	ui = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	paint = { TextColor3 = "muted" },
}, sidebar)

local tab_H, tab_GAP = 38, 6
local tabHolder = new("Frame", {
	Size = UDim2.new(1, -24, 0, 170),
	Position = UDim2.fromOffset(12, 138),
	BackgroundTransparency = 1,
}, sidebar)

local indicator = new("Frame", {
	Size = UDim2.new(1, 0, 0, tab_H),
	BackgroundColor3 = Color3.new(1, 1, 1),
	BorderSizePixel = 0,
}, tabHolder)
round(indicator, 10)
accent(indicator, 20)

new("TextLabel", {
	Size = UDim2.new(1, -36, 0, 14),
	Position = UDim2.new(0, 18, 1, -28),
	BackgroundTransparency = 1,
	Text = "v1.0",
	TextTransparency = 0.4,
	fs = 12,
	ui = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	paint = { TextColor3 = "muted" },
}, sidebar)

--// Content
local content = new("Frame", {
	Size = UDim2.new(1, -170, 1, 0),
	Position = UDim2.fromOffset(170, 0),
	BackgroundTransparency = 1,
}, window)

local dragStrip = new("Frame", {
	Size = UDim2.new(1, 0, 0, 52),
	BackgroundTransparency = 1,
}, content)

local pageTitle = new("TextLabel", {
	Size = UDim2.new(1, -110, 1, 0),
	Position = UDim2.fromOffset(20, 0),
	BackgroundTransparency = 1,
	Text = "Script",
	fs = 20,
	ui = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	paint = { TextColor3 = "text" },
}, dragStrip)

local function ctrl(xFromRight, glyph)
	local b = new("TextButton", {
		Size = UDim2.fromOffset(28, 28),
		Position = UDim2.new(1, -xFromRight, 0.5, -14),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = glyph,
		fs = 20,
		ui = true,
		BorderSizePixel = 0,
		paint = { BackgroundColor3 = "accent", TextColor3 = "muted" },
	}, dragStrip)
	round(b, 999)
	b.MouseEnter:Connect(function()
		tween(b, 0.15, { BackgroundTransparency = 0.8, TextColor3 = C.text })
	end)
	b.MouseLeave:Connect(function()
		tween(b, 0.2, { BackgroundTransparency = 1, TextColor3 = C.muted })
	end)
	return b
end
local closebt = ctrl(40, "×")
local foldbt = ctrl(72, "–")

local pages = new("Frame", {
	Size = UDim2.new(1, -40, 1, -72),
	Position = UDim2.fromOffset(20, 54),
	BackgroundTransparency = 1,
}, content)

local function makepage(visible)
	return new("CanvasGroup", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		GroupTransparency = visible and 0 or 1,
		Visible = visible,
	}, pages)
end

local welcomepage = makepage(true)
local scriptpage = makepage(false)
local consolepage = makepage(false)
local settingspage = makepage(false)

local function card(parent)
	local f = new("Frame", {
		Size = UDim2.new(1, 0, 1, -50),
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
		paint = { BackgroundColor3 = "card" },
	}, parent)
	round(f, 12)
	stroke(f, "edge", 1, 0.3)
	return f
end

--// Script Tab
local editorcard = card(scriptpage)

local scroll = new("ScrollingFrame", {
	Size = UDim2.new(1, -10, 1, -10),
	Position = UDim2.fromOffset(5, 5),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 3,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.XY,
	paint = { ScrollBarImageColor3 = "accent" },
}, editorcard)

local gutter = new("Frame", {
	Size = UDim2.new(0, 36, 0, 0),
	Position = UDim2.fromOffset(2, 7),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
}, scroll)

local codebox = new("TextBox", {
	Size = UDim2.new(1, -52, 0, 0),
	Position = UDim2.fromOffset(46, 7),
	BackgroundTransparency = 1,
	MultiLine = true,
	ClearTextOnFocus = false,
	Text = "",
	PlaceholderText = "write something...",
	Font = Enum.Font.Code,
	fs = 16,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
	paint = { TextColor3 = "text", PlaceholderColor3 = "muted" },
}, scroll)

--// Syntax highlighting
local KEYWORDS, BUILTINS = {}, {}
for w in ("and break continue do else elseif end false for function if in local nil not or repeat return then true until while"):gmatch("%S+") do
	KEYWORDS[w] = true
end
for w in ("print warn error assert pcall xpcall select type typeof tostring tonumber pairs ipairs next require loadstring setmetatable getmetatable rawget rawset rawequal rawlen unpack game workspace script task wait spawn delay tick time os math string table coroutine bit32 utf8 debug buffer self shared Instance Vector2 Vector3 CFrame Color3 UDim UDim2 Enum Random TweenInfo Ray Rect BrickColor NumberRange NumberSequence ColorSequence Players _G _VERSION"):gmatch("%S+") do
	BUILTINS[w] = true
end
local MAXHL = 20000

local function esc(s)
	return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"):gsub("'", "&apos;"))
end

local function highlight(src)
	src = src:gsub("\r", "")
	if #src > MAXHL then
		return esc(src)
	end
	local col = {
		kw = C.kw:ToHex(), str = C.str:ToHex(), num = C.num:ToHex(), com = C.com:ToHex(),
		fn = C.fn:ToHex(), bi = C.bi:ToHex(), op = C.op:ToHex(),
	}
	local out, len = {}, #src
	local i, plainFrom = 1, 1
	local prev, prevWord = "", ""
	
	local function emit(from, to, color)
		if from > plainFrom then
			out[#out + 1] = esc(src:sub(plainFrom, from - 1))
		end
		local open = '<font color="#' .. color .. '">'
		out[#out + 1] = open .. (esc(src:sub(from, to)):gsub("\n", "</font>\n" .. open)) .. "</font>"
		plainFrom = to + 1
	end
	
	while i <= len do
		local c = src:sub(i, i)
		local two = src:sub(i, i + 1)
		
		if two == "--" then
			local eq = src:match("^%-%-%[(=*)%[", i)
			local j
			if eq then
				local _, e = src:find("]" .. eq .. "]", i, true)
				j = e or len
			else
				j = (src:find("\n", i, true) or (len + 1)) - 1
			end
			emit(i, j, col.com)
			i, prev, prevWord = j + 1, "", ""
			
		elseif c == '"' or c == "'" or c == "`" then
			local j = i + 1
			while j <= len do
				local d = src:sub(j, j)
				if d == "\\" then
					j = j + 2
				elseif d == c then
					break
				elseif d == "\n" and c ~= "`" then
					break
				else
					j = j + 1
				end
			end
			local last
			if j <= len and src:sub(j, j) == c then
				last = j
			elseif j <= len then
				last = j - 1
			else
				last = len
			end
			emit(i, last, col.str)
			i, prev, prevWord = last + 1, "", ""
			
		elseif c == "[" and src:match("^%[=*%[", i) then
			local eq = src:match("^%[(=*)%[", i)
			local _, e = src:find("]" .. eq .. "]", i, true)
			local j = e or len
			emit(i, j, col.str)
			i, prev, prevWord = j + 1, "", ""
			
		elseif c:match("%d") or (c == "." and src:match("^%.%d", i)) then
			local num = src:match("^0[xX][%x_]+", i)
				or src:match("^0[bB][01_]+", i)
				or src:match("^%d[%d_]*%.?[%d_]*[eE][%+%-]?%d+", i)
				or src:match("^%d[%d_]*%.?[%d_]*", i)
				or src:match("^%.%d[%d_]*", i)
			emit(i, i + #num - 1, col.num)
			i, prev, prevWord = i + #num, "", ""
			
		elseif c:match("[%a_]") then
			local word = src:match("^[%a_][%w_]*", i)
			local e = i + #word - 1
			local afterAccess = prev == "." or prev == ":"
			local color
			if not afterAccess and KEYWORDS[word] then
				color = col.kw
			elseif not afterAccess and BUILTINS[word] then
				color = col.bi
			elseif prevWord == "function" or src:match("^%s*%(", e + 1) then
				color = col.fn
			end
			if color then
				emit(i, e, color)
			end
			i, prev, prevWord = e + 1, word:sub(-1), word
			
		elseif two == ".." then
			local dots = src:match("^%.%.%.?", i)
			emit(i, i + #dots - 1, col.op)
			i, prev, prevWord = i + #dots, "", ""
			
		elseif c:match("[%+%-%*/%%%^#=~<>]") then
			local op = src:match("^[%+%-%*/%%%^#=~<>]=?", i)
			emit(i, i + #op - 1, col.op)
			i, prev, prevWord = i + #op, "", ""
			
		else
			if not c:match("%s") then
				prev, prevWord = c, ""
			end
			i = i + 1
		end
	end
	
	if plainFrom <= len then
		out[#out + 1] = esc(src:sub(plainFrom))
	end
	return table.concat(out)
end

local highlightlabel = new("Frame", {
	Size = UDim2.new(1, -52, 0, 0),
	Position = UDim2.fromOffset(46, 7),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ZIndex = 1,
}, scroll)

local placeholder = new("TextLabel", {
	Size = UDim2.new(1, -52, 0, 0),
	AutomaticSize = Enum.AutomaticSize.Y,
	Position = UDim2.fromOffset(46, 7),
	BackgroundTransparency = 1,
	Text = "write something...",
	Font = Enum.Font.Code,
	fs = 16,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
	ZIndex = 1,
	paint = { TextColor3 = "muted" },
}, scroll)

codebox.ZIndex = 2
codebox.TextTransparency = 1
codebox.PlaceholderText = ""

local textserv = game:GetService("TextService")
local CHUNK = 80
local hlPool, gutPool = {}, {}
local richLines, lastGutN = { "" }, -1

local function newChunk(parent, gut)
	if gut then
		return new("TextLabel", {
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			Text = "",
			TextTransparency = 0.3,
			Font = Enum.Font.Code,
			fs = 16,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextYAlignment = Enum.TextYAlignment.Top,
			paint = { TextColor3 = "muted" },
		}, parent)
	end
	return new("TextLabel", {
		Size = UDim2.new(1, 0, 0, 0),
		BackgroundTransparency = 1,
		RichText = true,
		Text = "",
		Font = Enum.Font.Code,
		fs = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ZIndex = 1,
		paint = { TextColor3 = "text" },
	}, parent)
end

local function lineHeight()
	local fs = math.floor(16 * S.scale + 0.5)
	local ok, h = pcall(function()
		local huge = Vector2.new(100000, 100000)
		local one = textserv:GetTextSize("Ag", fs, Enum.Font.Code, huge).Y
		local two = textserv:GetTextSize("Ag\nAg", fs, Enum.Font.Code, huge).Y
		return (two - one) > 0 and (two - one) or one
	end)
	return (ok and h and h > 0) and h or fs
end

local function relayout()
	local n = #richLines
	local lh = lineHeight()
	local total = n * lh
	codebox.Size = UDim2.new(codebox.Size.X.Scale, codebox.Size.X.Offset, 0, total)
	highlightlabel.Size = UDim2.new(highlightlabel.Size.X.Scale, highlightlabel.Size.X.Offset, 0, total)
	gutter.Size = UDim2.new(0, 36, 0, total)
	
	local rebuildGutter = n ~= lastGutN
	lastGutN = n
	local count = math.ceil(n / CHUNK)
	for c = 1, count do
		local first, last = (c - 1) * CHUNK + 1, math.min(n, c * CHUNK)
		local y, h = (first - 1) * lh, (last - first + 1) * lh
		
		local hl = hlPool[c]
		if not hl then
			hl = newChunk(highlightlabel, false)
			hlPool[c] = hl
		end
		hl.Position, hl.Size = UDim2.fromOffset(0, y), UDim2.new(1, 0, 0, h)
		local text = table.concat(richLines, "\n", first, last)
		if hl.Text ~= text then
			hl.Text = text
		end
		hl.Visible = true
		
		local g = gutPool[c]
		if not g then
			g = newChunk(gutter, true)
			gutPool[c] = g
		end
		g.Position, g.Size = UDim2.fromOffset(0, y), UDim2.new(1, 0, 0, h)
		if rebuildGutter or g.Text == "" then
			local nums = table.create(last - first + 1)
			for k = first, last do
				nums[k - first + 1] = k
			end
			g.Text = table.concat(nums, "\n")
		end
		g.Visible = true
	end
	for c = count + 1, math.max(#hlPool, #gutPool) do
		if hlPool[c] then
			hlPool[c].Visible = false
		end
		if gutPool[c] then
			gutPool[c].Visible = false
		end
	end
end

local function rehighlight()
	richLines = string.split(highlight(codebox.Text), "\n")
	placeholder.Visible = codebox.Text == ""
	relayout()
end
codebox:GetPropertyChangedSignal("Text"):Connect(rehighlight)
ontheme(rehighlight)

local editorstroke = editorcard:FindFirstChildOfClass("UIStroke")
codebox.Focused:Connect(function()
	tween(editorstroke, 0.2, { Color = C.accent, Transparency = 0 })
end)
codebox.FocusLost:Connect(function()
	tween(editorstroke, 0.25, { Color = C.edge, Transparency = 0.3 })
end)

local status = new("TextLabel", {
	Size = UDim2.new(0.4, 0, 0, 36),
	Position = UDim2.new(0, 4, 1, -43),
	BackgroundTransparency = 1,
	Text = "0 lines · 0 chars",
	fs = 13,
	ui = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	paint = { TextColor3 = "muted" },
}, scriptpage)

local runbt = pill(scriptpage, "Execute", true, UDim2.fromOffset(116, 36), UDim2.new(1, -122, 1, -43))
local clearbt = pill(scriptpage, "Clear", false, UDim2.fromOffset(84, 36), UDim2.new(1, -216, 1, -43))

--// Console Tab
local consolecard = card(consolepage)
local logScroll = new("ScrollingFrame", {
	Size = UDim2.new(1, -20, 1, -20),
	Position = UDim2.fromOffset(10, 10),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 3,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	paint = { ScrollBarImageColor3 = "accent" },
}, consolecard)
new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, logScroll)

local emptyNote = new("TextLabel", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	Text = "nothing run yet",
	TextTransparency = 0.4,
	fs = 15,
	ui = true,
	paint = { TextColor3 = "muted" },
}, consolecard)

local clearLogBtn = pill(consolepage, "Clear log", false, UDim2.fromOffset(104, 36), UDim2.new(1, -110, 1, -43))

local logorder = 0
local function log(message, ok)
	logorder += 1
	emptyNote.Visible = false
	local row = new("TextLabel", {
		LayoutOrder = logorder,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		TextWrapped = true,
		RichText = true,
		Text = string.format('<font color="#%s">●</font>  %s', (ok and C.good or C.bad):ToHex(), message),
		TextTransparency = 1,
		Font = Enum.Font.Code,
		fs = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
		paint = { TextColor3 = "text" },
	}, logScroll)
	tween(row, 0.25, { TextTransparency = 0 })
end

--// Apply Functions (Settings)
local function applysizes()
	for _, e in ipairs(sized) do
		e[1].TextSize = math.floor(e[2] * S.scale + 0.5)
	end
	relayout()
end

local function applyfonts()
	for _, i in ipairs(uifonts) do
		i.Font = S.font
	end
end

local function applyeditorlayout()
	local show = S.lineNum
	gutter.Visible = show
	local pos = UDim2.fromOffset(show and 46 or 12, 7)
	local x = show and -52 or -18
	codebox.Position, highlightlabel.Position, placeholder.Position = pos, pos, pos
	codebox.Size = UDim2.new(1, x, 0, codebox.Size.Y.Offset)
	highlightlabel.Size = UDim2.new(1, x, 0, highlightlabel.Size.Y.Offset)
	placeholder.Size = UDim2.new(1, x, 0, 0)
end

local function applywindow()
	tween(window, 0.3, { BackgroundTransparency = S.glass and 0.18 or 0 })
end

local controls = {}

local function segmented(parent, options, get, set)
	local n = #options
	local holder = new("Frame", {
		Size = UDim2.new(1, 0, 0, 36),
		Position = UDim2.new(0, 0, 0.5, -18),
		BackgroundTransparency = 0.88,
		BorderSizePixel = 0,
		paint = { BackgroundColor3 = "accent" },
	}, parent)
	round(holder, 999)
	stroke(holder, "edge", 1, 0.3)
	
	local hi = new("Frame", {
		Size = UDim2.new(1 / n, -6, 1, -6),
		Position = UDim2.new(0, 3, 0, 3),
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderSizePixel = 0,
	}, holder)
	round(hi, 999)
	accent(hi, 20)
	
	local buttons = {}
	local function refresh(instant)
		local idx = 1
		for i, o in ipairs(options) do
			if o[2] == get() then
				idx = i
			end
		end
		local pos = UDim2.new((idx - 1) / n, 3, 0, 3)
		if instant then
			hi.Position = pos
		else
			tween(hi, 0.3, { Position = pos }, Enum.EasingStyle.Back)
		end
		for i, b in ipairs(buttons) do
			tween(b, 0.2, { TextColor3 = i == idx and Color3.new(1, 1, 1) or C.muted })
		end
	end
	for i, o in ipairs(options) do
		local b = new("TextButton", {
			Size = UDim2.new(1 / n, 0, 1, 0),
			Position = UDim2.new((i - 1) / n, 0, 0, 0),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Text = o[1],
			TextColor3 = C.muted,
			fs = 14,
			ui = true,
			BorderSizePixel = 0,
			ZIndex = 2,
		}, holder)
		b.MouseButton1Click:Connect(function()
			set(o[2])
			refresh()
		end)
		buttons[i] = b
	end
	refresh(true)
	table.insert(hooks, function()
		refresh(true)
	end)
	table.insert(controls, { refresh = function()
		refresh(true)
	end })
end

local function toggle(parent, get, set)
	local track = new("TextButton", {
		Size = UDim2.fromOffset(54, 30),
		Position = UDim2.new(1, -54, 0.5, -15),
		AutoButtonColor = false,
		Text = "",
		BorderSizePixel = 0,
		BackgroundColor3 = C.edge,
	}, parent)
	round(track, 999)
	local knob = new("Frame", {
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.fromOffset(3, 3),
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderSizePixel = 0,
	}, track)
	round(knob, 999)
	local function refresh()
		local on = get()
		tween(track, 0.2, { BackgroundColor3 = on and C.accent or C.edge })
		tween(knob, 0.28, { Position = UDim2.fromOffset(on and 27 or 3, 3) }, Enum.EasingStyle.Back)
	end
	track.MouseButton1Click:Connect(function()
		set(not get())
		refresh()
	end)
	refresh()
	table.insert(hooks, refresh)
	table.insert(controls, { refresh = refresh })
end

--// Settings Tab
local settingscard = card(settingspage)
local settingsScroll = new("ScrollingFrame", {
	Size = UDim2.new(1, -8, 1, -8),
	Position = UDim2.fromOffset(4, 4),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 3,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	paint = { ScrollBarImageColor3 = "accent" },
}, settingscard)
new("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, settingsScroll)
new("UIPadding", {
	PaddingLeft = UDim.new(0, 14),
	PaddingRight = UDim.new(0, 14),
	PaddingTop = UDim.new(0, 4),
	PaddingBottom = UDim.new(0, 4),
}, settingsScroll)

local function row(order, title, sub)
	local r = new("Frame", {
		LayoutOrder = order,
		Size = UDim2.new(1, 0, 0, 64),
		BackgroundTransparency = 1,
	}, settingsScroll)
	new("TextLabel", {
		Size = UDim2.new(0.4, 0, 0, 24),
		Position = UDim2.fromOffset(0, 10),
		BackgroundTransparency = 1,
		Text = title,
		fs = 17,
		ui = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		paint = { TextColor3 = "text" },
	}, r)
	local subLabel = new("TextLabel", {
		Size = UDim2.new(0.4, 0, 0, 18),
		Position = UDim2.fromOffset(0, 34),
		BackgroundTransparency = 1,
		Text = sub,
		fs = 13,
		ui = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		paint = { TextColor3 = "muted" },
	}, r)
	new("Frame", {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, -1),
		BackgroundTransparency = 0.75,
		BorderSizePixel = 0,
		paint = { BackgroundColor3 = "edge" },
	}, r)
	local ctl = new("Frame", {
		Size = UDim2.new(0.58, 0, 1, 0),
		Position = UDim2.fromScale(0.42, 0),
		BackgroundTransparency = 1,
	}, r)
	return ctl, subLabel
end

--// 1) Theme swatches
do
	local ctl, subLabel = row(1, "Theme", S.theme)
	local list = new("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 }, ctl)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, list)
	local rings = {}
	for i, name in ipairs(themeorder) do
		local t = themes[name]
		local sw = new("TextButton", {
			LayoutOrder = i,
			Size = UDim2.fromOffset(32, 32),
			BackgroundColor3 = Color3.new(1, 1, 1),
			AutoButtonColor = false,
			Text = "",
			BorderSizePixel = 0,
		}, list)
		round(sw, 999)
		new("UIGradient", { Color = ColorSequence.new(t.accent, t.accent2), Rotation = 45 }, sw)
		rings[name] = new("UIStroke", {
			Thickness = 2.5,
			Transparency = 1,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			paint = { Color = "text" },
		}, sw)
		feel(sw, 1.1)
		sw.MouseButton1Click:Connect(function()
			applytheme(name)
		end)
	end
	ontheme(function()
		subLabel.Text = S.theme
		for name, ring in pairs(rings) do
			tween(ring, 0.2, { Transparency = name == S.theme and 0 or 1 })
		end
	end)
end

--// 2) Text size
do
	local ctl = row(2, "Text size", "Interface and editor")
	segmented(ctl, sizes, function()
		return S.scale
	end, function(v)
		S.scale = v
		applysizes()
	end)
end

--// 3) Font
do
	local ctl = row(3, "Font", "Interface typeface")
	segmented(ctl, fonts, function()
		return S.font
	end, function(v)
		S.font = v
		applyfonts()
	end)
end

--// 4) Line numbers
do
	local ctl = row(4, "Line numbers", "Show editor gutter")
	toggle(ctl, function()
		return S.lineNum
	end, function(v)
		S.lineNum = v
		applyeditorlayout()
	end)
end

--// 5) Translucent window
do
	local ctl = row(5, "Glass window", "See through the panel")
	toggle(ctl, function()
		return S.glass
	end, function(v)
		S.glass = v
		applywindow()
	end)
end

--// 6) Animations
do
	local ctl = row(6, "Animations", "Smooth motion")
	toggle(ctl, function()
		return S.anim
	end, function(v)
		S.anim = v
	end)
end

new("TextLabel", {
	Size = UDim2.new(0.5, 0, 0, 36),
	Position = UDim2.new(0, 4, 1, -43),
	BackgroundTransparency = 1,
	Text = "changes apply instantly",
	fs = 13,
	ui = true,
	TextXAlignment = Enum.TextXAlignment.Left,
	paint = { TextColor3 = "muted" },
}, settingspage)

local resetBtn = pill(settingspage, "Reset defaults", false, UDim2.fromOffset(140, 36), UDim2.new(1, -146, 1, -43))
resetBtn.MouseButton1Click:Connect(function()
	S.scale, S.font, S.lineNum, S.glass, S.anim =
		defaults.scale, defaults.font, defaults.lineNum, defaults.glass, defaults.anim
	applytheme(defaults.theme)
	applysizes()
	applyfonts()
	applyeditorlayout()
	applywindow()
	for _, c in ipairs(controls) do
		c.refresh()
	end
end)

--// Welcome Tab
local welcomecard = card(welcomepage)
welcomecard.Size = UDim2.fromScale(1, 1)
local wscroll = new("ScrollingFrame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	ScrollBarThickness = 3,
	ScrollingDirection = Enum.ScrollingDirection.Y,
	paint = { ScrollBarImageColor3 = "accent" },
}, welcomecard)
new("UIPadding", {
	PaddingTop = UDim.new(0, 16), PaddingBottom = UDim.new(0, 16),
	PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 18),
}, wscroll)
new("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }, wscroll)

local worder = 0
local function wlabel(text, fsz, key, transparency)
	worder += 1
	return new("TextLabel", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text = text,
		fs = fsz,
		ui = true,
		TextWrapped = true,
		TextTransparency = transparency or 0,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		LayoutOrder = worder,
		paint = { TextColor3 = key },
	}, wscroll)
end

local wname = players.LocalPlayer.DisplayName
local greet = wlabel("Welcome, " .. wname, 24, "text")
greet.Font = brand
wlabel("Welcome to the vellum internal executor! I made this for fun so enjoy :3", 15, "muted")

local welcomeRows = {}
local function featureRow(title, desc, target)
	worder += 1
	local row = new("TextButton", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		AutoButtonColor = false,
		BackgroundTransparency = 0.9,
		BorderSizePixel = 0,
		Text = "",
		LayoutOrder = worder,
		paint = { BackgroundColor3 = "accent" },
	}, wscroll)
	round(row, 10)
	stroke(row, "edge", 1, 0.4)
	new("UIPadding", {
		PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14),
	}, row)
	new("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }, row)
	new("TextLabel", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1, Text = title, fs = 16, ui = true,
		TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = 1,
		paint = { TextColor3 = "accent" },
	}, row)
	new("TextLabel", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1, Text = desc, fs = 14, ui = true, TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = 2,
		paint = { TextColor3 = "muted" },
	}, row)
	row.MouseEnter:Connect(function()
		tween(row, 0.15, { BackgroundTransparency = 0.8 })
	end)
	row.MouseLeave:Connect(function()
		tween(row, 0.2, { BackgroundTransparency = 0.9 })
	end)
	table.insert(welcomeRows, { row, target })
end
featureRow("Script", "Put ur script here and execute it!", "Script")
featureRow("Console", "See if ur script ran or had an error, its usually the script your pasting that has issues.", "Console")
featureRow("Settings", "The gui options and all that good stuff >w<", "Settings")

--// Tabs
local tabs, current = {}, "Welcome"
local pageOf = { Welcome = welcomepage, Script = scriptpage, Console = consolepage, Settings = settingspage }
local switchToken = 0

local function refreshTabs()
	for n, t in pairs(tabs) do
		tween(t.button, 0.2, { TextColor3 = n == current and Color3.new(1, 1, 1) or C.muted })
	end
end
table.insert(hooks, refreshTabs)

local function selectTab(name, instant)
	local previous = current
	current = name
	pageTitle.Text = name
	refreshTabs()
	
	local y = (tabs[name].index - 1) * (tab_H + tab_GAP)
	if instant then
		indicator.Position = UDim2.fromOffset(0, y)
	else
		tween(indicator, 0.3, { Position = UDim2.fromOffset(0, y) }, Enum.EasingStyle.Back)
	end
	
	if previous == name and not instant then
		return
	end
	switchToken += 1
	local token = switchToken
	local into = pageOf[name]
	for n, p in pairs(pageOf) do
		if n ~= name then
			tween(p, 0.12, { GroupTransparency = 1 })
		end
	end
	task.delay(S.anim and 0.12 or 0, function()
		if token ~= switchToken then
			return
		end
		for n, p in pairs(pageOf) do
			p.Visible = n == name
		end
		into.GroupTransparency = 1
		tween(into, 0.2, { GroupTransparency = 0 })
	end)
end

local function addTab(name, index)
	local b = new("TextButton", {
		Size = UDim2.new(1, 0, 0, tab_H),
		Position = UDim2.fromOffset(0, (index - 1) * (tab_H + tab_GAP)),
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = name,
		TextColor3 = C.muted,
		fs = 16,
		ui = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 2,
	}, tabHolder)
	new("UIPadding", { PaddingLeft = UDim.new(0, 14) }, b)
	b.MouseButton1Click:Connect(function()
		selectTab(name)
	end)
	tabs[name] = { button = b, index = index }
end
addTab("Welcome", 1)
addTab("Script", 2)
addTab("Console", 3)
addTab("Settings", 4)
selectTab("Welcome", true)
for _, r in ipairs(welcomeRows) do
	r[1].MouseButton1Click:Connect(function()
		selectTab(r[2])
	end)
end

--// Behaviour
local function refresh()
	local _, nl = string.gsub(codebox.Text, "\n", "\n")
	local empty = codebox.Text == ""
	local count = empty and 0 or nl + 1
	status.Text = string.format("%d line%s · %d chars", count, count == 1 and "" or "s", #codebox.Text)
end
codebox:GetPropertyChangedSignal("Text"):Connect(refresh)
refresh()

runbt.MouseButton1Click:Connect(function()
	local ok, msg = onRun(codebox.Text)
	log(msg, ok)
end)
clearbt.MouseButton1Click:Connect(function()
	codebox.Text = ""
end)
clearLogBtn.MouseButton1Click:Connect(function()
	for _, child in ipairs(logScroll:GetChildren()) do
		if child:IsA("TextLabel") then
			child:Destroy()
		end
	end
	emptyNote.Visible = true
end)

--// Resize grip
local resizeGrip = new("TextButton", {
	Name = "ResizeGrip",
	Size = UDim2.fromOffset(24, 24),
	Position = UDim2.new(1, -24, 1, -24),
	BackgroundTransparency = 1,
	AutoButtonColor = false,
	Text = "",
	BorderSizePixel = 0,
	ZIndex = 20,
}, root)
local gripLines = {}
for _, l in ipairs({ { 5, 3 }, { 9, 6 }, { 13, 9 } }) do
	local line = new("Frame", {
		Size = UDim2.fromOffset(l[1], 2),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromOffset(18 - l[2], 18 - l[2]),
		Rotation = -45,
		BackgroundTransparency = 0.45,
		BorderSizePixel = 0,
		ZIndex = 21,
		paint = { BackgroundColor3 = "muted" },
	}, resizeGrip)
	round(line, 999)
	table.insert(gripLines, line)
end
resizeGrip.MouseEnter:Connect(function()
	for _, line in ipairs(gripLines) do
		tween(line, 0.15, { BackgroundTransparency = 0 })
	end
end)
resizeGrip.MouseLeave:Connect(function()
	for _, line in ipairs(gripLines) do
		tween(line, 0.2, { BackgroundTransparency = 0.45 })
	end
end)

--// Fold and close
local folded = false
local fullSize = root.Size
foldbt.MouseButton1Click:Connect(function()
	folded = not folded
	resizeGrip.Visible = not folded
	tween(root, 0.3, { Size = folded and UDim2.fromOffset(fullSize.X.Offset, 52) or fullSize })
end)
closebt.MouseButton1Click:Connect(function()
	tween(rootScale, 0.2, { Scale = 0.92 })
	task.delay(0.2, function()
		gui:Destroy()
	end)
end)

--// Open animation
tween(rootScale, 0.45, { Scale = 1 }, Enum.EasingStyle.Back)

--// Dragging
local dragging, dragstart, startPos = false, nil, nil
dragStrip.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging, dragstart, startPos = true, input.Position, root.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
uis.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local d = input.Position - dragstart
		tweenserv:Create(root, TweenInfo.new(0.06, Enum.EasingStyle.Quad), {
			Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y),
		}):Play()
	end
end)

--// Resizing
local MIN_W, MIN_H = 520, 360
local resizing, resizeStart, resizeFrom = false, nil, nil
resizeGrip.InputBegan:Connect(function(input)
	if folded then
		return
	end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing, resizeStart, resizeFrom = true, input.Position, root.Size
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				resizing = false
			end
		end)
	end
end)
uis.InputChanged:Connect(function(input)
	if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local scale = rootScale.Scale
		local d = input.Position - resizeStart
		local maxW = math.max(MIN_W, (gui.AbsoluteSize.X - root.AbsolutePosition.X) / scale)
		local maxH = math.max(MIN_H, (gui.AbsoluteSize.Y - root.AbsolutePosition.Y) / scale)
		local w = math.clamp(resizeFrom.X.Offset + d.X / scale, MIN_W, maxW)
		local h = math.clamp(resizeFrom.Y.Offset + d.Y / scale, MIN_H, maxH)
		root.Size = UDim2.fromOffset(w, h)
		fullSize = root.Size
	end
end)