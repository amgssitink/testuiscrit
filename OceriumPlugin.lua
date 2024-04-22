<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">
	<External>null</External>
	<External>nil</External>
	<Item class="Folder" referent="RBXD2F62ED8C4E44A6BB24109534B53F90F">
		<Properties>
			<BinaryString name="AttributesSerialize"></BinaryString>
			<string name="Name">ConsolePlugin</string>
			<int64 name="SourceAssetId">-1</int64>
			<BinaryString name="Tags"></BinaryString>
		</Properties>
		<Item class="Script" referent="RBX1C3C61C3AC644AA1BF0C244C334A14BA">
			<Properties>
				<BinaryString name="AttributesSerialize"></BinaryString>
				<bool name="Disabled">false</bool>
				<Content name="LinkedSource"><null></null></Content>
				<string name="Name">Plugin</string>
				<token name="RunContext">0</token>
				<string name="ScriptGuid">{5DA90BBD-0A47-4F25-AB47-AAD66A5CEFBF}</string>
				<ProtectedString name="Source"><![CDATA[local Toolbar = plugin:CreateToolbar("Editor")
local NotesButton = Toolbar:CreateButton("Ocerium Utilities", "Edit Some Scripts", "rbxassetid://9799490325", "Ocerium Utilities")
local Opened = false

local NotesWidgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Left,
	false,   -- Widget will be initially enabled
	false,  -- Don't override the previous enabled state
	200,    -- Default width of the floating window
	300,    -- Default height of the floating window
	350,    -- Minimum width of the floating window (optional)
	300     -- Minimum height of the floating window (optional)
)

local NotesWidget = plugin:CreateDockWidgetPluginGui("Editor", NotesWidgetInfo)
NotesWidget.Title = "Editor"
local NotesGui = script.Parent.Main
NotesGui.Parent = NotesWidget

local isOpened = false
NotesButton.Click:Connect(function()
	isOpened = not isOpened
	
	NotesWidget.Enabled = isOpened
end)

]]></ProtectedString>
				<int64 name="SourceAssetId">-1</int64>
				<BinaryString name="Tags"></BinaryString>
			</Properties>
		</Item>
		<Item class="Script" referent="RBXE255422DBFA04332AE7475CCDB91FE69">
			<Properties>
				<BinaryString name="AttributesSerialize"></BinaryString>
				<bool name="Disabled">false</bool>
				<Content name="LinkedSource"><null></null></Content>
				<string name="Name">Converter</string>
				<token name="RunContext">0</token>
				<string name="ScriptGuid">{1C86544A-82D3-4BF6-A131-F56F7B7DF938}</string>
				<ProtectedString name="Source"><![CDATA[-- made by corewave (from aztup's public repo) [THIS IS NOT MY CODE]

type = typeof or type
local str_types = {
	['boolean'] = true,
	['table'] = true,
	['userdata'] = true,
	['table'] = true,
	['function'] = true,
	['number'] = true,
	['nil'] = true
}

local rawequal = rawequal or function(a, b)
	return a == b
end

local function count_table(t)
	local c = 0
	for i, v in next, t do
		c = c + 1
	end

	return c
end

local function string_ret(o, typ)
	local ret, mt, old_func
	if not (typ == 'table' or typ == 'userdata') then
		return tostring(o)
	end
	mt = (getrawmetatable or getmetatable)(o)
	if not mt then 
		return tostring(o)
	end

	old_func = rawget(mt, '__tostring')
	rawset(mt, '__tostring', nil)
	ret = tostring(o)
	rawset(mt, '__tostring', old_func)
	return ret
end

local function format_value(v)
	local typ = type(v)

	if str_types[typ] then
		return string_ret(v, typ)
	elseif typ == 'string' then
		return ''..v..''
	elseif typ == 'Instance' then
		return v.GetFullName(v)
	else
		return typ..'.new(' .. tostring(v) .. ')'
	end
end

local function serialize_table(t, p, c, s)
	local str = ""
	local n = count_table(t)
	local ti = 1
	local e = n > 0

	c = c or {}
	p = p or 1
	s = s or string.rep

	local function localized_format(v, is_table)
		return is_table and (c[v][2] >= p) and serialize_table(v, p + 1, c, s) or format_value(v)
	end

	c[t] = {t, 0}

	for i, v in next, t do
		local typ_i, typ_v = type(i) == 'table', type(v) == 'table'
		c[i], c[v] = (not c[i] and typ_i) and {i, p} or c[i], (not c[v] and typ_v) and {v, p} or c[v]
		str = str .. s('	', p) .. '' .. localized_format(i, typ_i) .. ' = '  .. localized_format(v, typ_v) .. (ti < n and ';' or '') .. '\n'
		ti = ti + 1
	end

	return ('{' .. (e and '\n' or '')) .. str .. (e and s('  ', p - 1) or '') .. '}'
end


local version = "3.3" 
local counter = 0

local Gui;

local convert_ui;

local Folder = script.Parent

local convert_module_scripts = true
local convert_scripts = true


local referencedump = [[
BillboardGui
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ LayerCollector ]
	bool Enabled
	ZIndexBehavior ZIndexBehavior
-	[ BillboardGui ]
	bool Active
	Object Adornee
	bool AlwaysOnTop
	Vector3 ExtentsOffset
	Vector3 ExtentsOffsetWorldSpace
	float LightInfluence
	float MaxDistance
	Object PlayerToHideFrom
	UDim2 Size
	Vector2 SizeOffset
	Vector3 StudsOffset
	Vector3 StudsOffsetWorldSpace
Frame
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ GuiObject ]
	bool Active
	Vector2 AnchorPoint
	Color3 BackgroundColor3
	float BackgroundTransparency
	Color3 BorderColor3
	int BorderSizePixel
	bool ClipsDescendants
	bool Draggable
	int LayoutOrder
	Object NextSelectionDown
	Object NextSelectionLeft
	Object NextSelectionRight
	Object NextSelectionUp
	UDim2 Position
	float Rotation
	bool Selectable
	Object SelectionImageObject
	UDim2 Size
	SizeConstraint SizeConstraint
	bool Visible
	int ZIndex
-	[ Frame ]
	FrameStyle Style
ImageButton
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ GuiObject ]
	bool Active
	Vector2 AnchorPoint
	Color3 BackgroundColor3
	float BackgroundTransparency
	Color3 BorderColor3
	int BorderSizePixel
	bool ClipsDescendants
	bool Draggable
	int LayoutOrder
	Object NextSelectionDown
	Object NextSelectionLeft
	Object NextSelectionRight
	Object NextSelectionUp
	UDim2 Position
	float Rotation
	bool Selectable
	Object SelectionImageObject
	UDim2 Size
	SizeConstraint SizeConstraint
	bool Visible
	int ZIndex
-	[ GuiButton ]
	bool AutoButtonColor
	bool Modal
	bool Selected
	ButtonStyle Style
-	[ ImageButton ]
	Content Image
	Color3 ImageColor3
	Vector2 ImageRectOffset
	Vector2 ImageRectSize
	float ImageTransparency
	ScaleType ScaleType
	Rect2D SliceCenter
	float SliceScale
	UDim2 TileSize
ImageLabel
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ GuiObject ]
	bool Active
	Vector2 AnchorPoint
	Color3 BackgroundColor3
	float BackgroundTransparency
	Color3 BorderColor3
	int BorderSizePixel
	bool ClipsDescendants
	bool Draggable
	int LayoutOrder
	Object NextSelectionDown
	Object NextSelectionLeft
	Object NextSelectionRight
	Object NextSelectionUp
	UDim2 Position
	float Rotation
	bool Selectable
	Object SelectionImageObject
	UDim2 Size
	SizeConstraint SizeConstraint
	bool Visible
	int ZIndex
-	[ ImageLabel ]
	Content Image
	Color3 ImageColor3
	Vector2 ImageRectOffset
	Vector2 ImageRectSize
	float ImageTransparency
	ScaleType ScaleType
	Rect2D SliceCenter
	float SliceScale
	UDim2 TileSize
ScreenGui
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ LayerCollector ]
	bool Enabled
	ZIndexBehavior ZIndexBehavior
-	[ ScreenGui ]
	int DisplayOrder
	bool ResetOnSpawn
ScrollingFrame
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ GuiObject ]
	bool Active
	Vector2 AnchorPoint
	Color3 BackgroundColor3
	float BackgroundTransparency
	Color3 BorderColor3
	int BorderSizePixel
	bool ClipsDescendants
	bool Draggable
	int LayoutOrder
	Object NextSelectionDown
	Object NextSelectionLeft
	Object NextSelectionRight
	Object NextSelectionUp
	UDim2 Position
	float Rotation
	bool Selectable
	Object SelectionImageObject
	UDim2 Size
	SizeConstraint SizeConstraint
	bool Visible
	int ZIndex
-	[ ScrollingFrame ]
	Content BottomImage
	Vector2 CanvasPosition
	UDim2 CanvasSize
	ScrollBarInset HorizontalScrollBarInset
	Content MidImage
	int ScrollBarThickness
	bool ScrollingEnabled
	Content TopImage
	ScrollBarInset VerticalScrollBarInset
	VerticalScrollBarPosition VerticalScrollBarPosition
SurfaceGui
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ LayerCollector ]
	bool Enabled
	ZIndexBehavior ZIndexBehavior
-	[ SurfaceGui ]
	bool Active
	Object Adornee
	bool AlwaysOnTop
	Vector2 CanvasSize
	NormalId Face
	float LightInfluence
	float ToolPunchThroughDistance
	float ZOffset
TextBox
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ GuiObject ]
	bool Active
	Vector2 AnchorPoint
	Color3 BackgroundColor3
	float BackgroundTransparency
	Color3 BorderColor3
	int BorderSizePixel
	bool ClipsDescendants
	bool Draggable
	int LayoutOrder
	Object NextSelectionDown
	Object NextSelectionLeft
	Object NextSelectionRight
	Object NextSelectionUp
	UDim2 Position
	float Rotation
	bool Selectable
	Object SelectionImageObject
	UDim2 Size
	SizeConstraint SizeConstraint
	bool Visible
	int ZIndex
-	[ TextBox ]
	bool ClearTextOnFocus
	Font Font
	float LineHeight
	bool MultiLine
	Color3 PlaceholderColor3
	string PlaceholderText
	bool ShowNativeInput
	string Text
	Color3 TextColor3
	bool TextScaled
	float TextSize
	Color3 TextStrokeColor3
	float TextStrokeTransparency
	float TextTransparency
	bool TextWrapped
	TextXAlignment TextXAlignment
	TextYAlignment TextYAlignment
TextButton
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ GuiObject ]
	bool Active
	Vector2 AnchorPoint
	Color3 BackgroundColor3
	float BackgroundTransparency
	Color3 BorderColor3
	int BorderSizePixel
	bool ClipsDescendants
	bool Draggable
	int LayoutOrder
	Object NextSelectionDown
	Object NextSelectionLeft
	Object NextSelectionRight
	Object NextSelectionUp
	UDim2 Position
	float Rotation
	bool Selectable
	Object SelectionImageObject
	UDim2 Size
	SizeConstraint SizeConstraint
	bool Visible
	int ZIndex
-	[ GuiButton ]
	bool AutoButtonColor
	bool Modal
	bool Selected
	ButtonStyle Style
-	[ TextButton ]
	Font Font
	float LineHeight
	string Text
	Color3 TextColor3
	bool TextScaled
	float TextSize
	Color3 TextStrokeColor3
	float TextStrokeTransparency
	float TextTransparency
	bool TextWrapped
	TextXAlignment TextXAlignment
	TextYAlignment TextYAlignment
TextLabel
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ GuiObject ]
	bool Active
	Vector2 AnchorPoint
	Color3 BackgroundColor3
	float BackgroundTransparency
	Color3 BorderColor3
	int BorderSizePixel
	bool ClipsDescendants
	bool Draggable
	int LayoutOrder
	Object NextSelectionDown
	Object NextSelectionLeft
	Object NextSelectionRight
	Object NextSelectionUp
	UDim2 Position
	float Rotation
	bool Selectable
	Object SelectionImageObject
	UDim2 Size
	SizeConstraint SizeConstraint
	bool Visible
	int ZIndex
-	[ TextLabel ]
	Font Font
	float LineHeight
	string Text
	Color3 TextColor3
	bool TextScaled
	float TextSize
	Color3 TextStrokeColor3
	float TextStrokeTransparency
	float TextTransparency
	bool TextWrapped
	TextXAlignment TextXAlignment
	TextYAlignment TextYAlignment
UIAspectRatioConstraint
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ UIAspectRatioConstraint ]
	float AspectRatio
	AspectType AspectType
	DominantAxis DominantAxis
UIGridLayout
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ UIGridStyleLayout ]
	FillDirection FillDirection
	HorizontalAlignment HorizontalAlignment
	SortOrder SortOrder
	VerticalAlignment VerticalAlignment
-	[ UIGridLayout ]
	UDim2 CellPadding
	UDim2 CellSize
	int FillDirectionMaxCells
	StartCorner StartCorner
UIListLayout
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ UIGridStyleLayout ]
	FillDirection FillDirection
	HorizontalAlignment HorizontalAlignment
	SortOrder SortOrder
	VerticalAlignment VerticalAlignment
-	[ UIListLayout ]
	UDim Padding
UIPadding
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ UIPadding ]
	UDim PaddingBottom
	UDim PaddingLeft
	UDim PaddingRight
	UDim PaddingTop
UIPageLayout
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ UIGridStyleLayout ]
	FillDirection FillDirection
	HorizontalAlignment HorizontalAlignment
	SortOrder SortOrder
	VerticalAlignment VerticalAlignment
-	[ UIPageLayout ]
	bool Animated
	bool Circular
	EasingDirection EasingDirection
	EasingStyle EasingStyle
	bool GamepadInputEnabled
	UDim Padding
	bool ScrollWheelInputEnabled
	bool TouchInputEnabled
	float TweenTime
UIScale
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ UIScale ]
	float Scale
UISizeConstraint
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ UISizeConstraint ]
	Vector2 MaxSize
	Vector2 MinSize
UITableLayout
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ UIGridStyleLayout ]
	FillDirection FillDirection
	HorizontalAlignment HorizontalAlignment
	SortOrder SortOrder
	VerticalAlignment VerticalAlignment
-	[ UITableLayout ]
	bool FillEmptySpaceColumns
	bool FillEmptySpaceRows
	TableMajorAxis MajorAxis
	UDim2 Padding
UITextSizeConstraint
-	[ Instance ]
	bool Archivable
	string Name
	Object Parent
-	[ UITextSizeConstraint ]
	int MaxTextSize
	int MinTextSize
Folder
	bool Archivable
	string Name
	Object Parent
Configuration
	bool Archivable
	string Name
	Object Parent
ViewportFrame
	Color3 Ambient
	Color3 LightColor
	Vector3 LightDirection
	Object SelectionImageObject
	float BackgroundTransparency
	Vector2 AnchorPoint
	Color3 BackgroundColor3
	int BorderSizePixel
	Color3 BorderColor3
	Object CurrentCamera
	int LayoutOrder
	string Name
	Object Parent
	UDim2 Position
	int Rotation
	bool Visible
	int ZIndex
	bool ClipsDescendants
	Color3 ImageColor3
	float ImageTransparency
UIGradient
	ColorSequence Color
	Vector2 Offset
	int Rotation
	NumberSequence Transparency
	string Name
	Object Parent
	bool Archivable
UICorner
	UDim CornerRadius
	string Name
	Object Parent
	bool Archivable
UIStroke
	Object Parent
	string Name
	Color3 Color
	int Thickness
	ApplyStrokeMode ApplyStrokeMode
	LineJoinMode LineJoinMode
BoolValue
	Object Parent
	string Name
	bool Value
IntValue
	Object Parent
	string Name
	int Value
Color3Value
	Object Parent
	string Name
	Color3 Value
StringValue
	Object Parent
	string Name
	string Value
NumberValue
	Object Parent
	string Name
	int Value
]]



-- An interator function that iterates through the given object and its ancestors
local function ancestorsAndSelf(object)
	local currentObject = nil

	local function getNextParent()
		if not currentObject then
			currentObject = object
		else
			currentObject = currentObject.Parent
		end
		return currentObject
	end

	return getNextParent
end

-- convert scripts
local function create_id()
	local id = ""
	for i = 1, math.random(4, 7) do
		id = id .. string.char(math.random(65,90))
	end
	return id
end

local function indent_all(txt)
	local final_source = ''
	local last = 0
	for i = 1, #txt do
		if txt:sub(i, i) == '\n' then
			local beforeSplit = txt:sub(last, i-1)
			local afterSplit = txt:sub(i)
			local new = beforeSplit .. '\n	'
			final_source = final_source .. new
			last = i+1
		end
	end
	final_source = '	' .. final_source .. txt:sub(last)
	return final_source
end

local function create_module_script(script, realParent)
	if not (script and script:IsA("ModuleScript") and convert_module_scripts) then
		return ""
	end

	local script_source = script.Source
	local final_source = indent_all(script_source)

	local safe_name = script.Name:gsub("[\"\\]", "\\%1"):gsub("\n", "\\\\n")

	local data = [[local script = Instance.new(']]..script.ClassName..[[', ]]..realParent..[[)]]
	if safe_name ~= "ModuleScript" then 
		data = data .. "\nscript.Name = \"" .. safe_name .. "\"" 
	end
	data = data .. "\nlocal function module_script()\n"
	data = data .. final_source

	data = data .. "\nend\nfake_module_scripts[script] = module_script"

	data = "do -- "..realParent..".".. script.Name.."\n" .. indent_all(data) .. "\nend"

	return data
end

local function createFakeScript(script, realParent, Nmodulescripts)
	if not( script and (script:IsA("LocalScript") or script:IsA("Script")) and convert_scripts) then
		return '' 
	end
	if script.Disabled then
		return "-- " .. realParent .. "." .. script.Name .. " is disabled."
	end
	local id = create_id()

	local scriptSource = script.Source
	local finalSource = ''
	local last = 0
	for i = 1, #scriptSource do
		if scriptSource:sub(i, i) == '\n' then
			local beforeSplit = scriptSource:sub(last, i-1)
			local afterSplit = scriptSource:sub(i)
			local new = beforeSplit .. '\n	'
			finalSource = finalSource .. new
			last = i+1
		end
	end
	finalSource = '	' .. finalSource .. scriptSource:sub(last)
	local code = [[local function ]]..id..[[_fake_script() -- ]]..realParent..'.'.. script.Name..[[ 
	local script = Instance.new(']]..script.ClassName..[[', ]]..realParent..[[)]]
	if convert_module_scripts and Nmodulescripts ~= 0 then  
		code = code .. "\n\tlocal req = require\n\tlocal require = function(obj)\n\t"
		code = code .. "\tlocal fake = fake_module_scripts[obj]\n\t"
		code = code .. "\tif fake then\n\t"
		code = code .. "\t\treturn fake()\n\t\tend\n\t\treturn req(obj)\n\tend"
	end 
	code = code .. "\n\n" .. finalSource.. "\nend\ncoroutine.wrap("..id.."_fake_script)()"
	return code or ''
end

-- Safe Datas

local safe_data = {}

safe_data["bool"] = function(value)
	return tostring(value)
end
safe_data["float"] = function(value) return ("%.3f"):format(tostring(value)) end
safe_data["int"] = safe_data["bool"]
safe_data["string"] = function(value)
	return "\"" .. value:gsub("[\"\\]", "\\%1"):gsub("\n", "\\\\n") .. "\""
end
safe_data["AspectType"] = safe_data["bool"]
safe_data["ButtonStyle"] = safe_data["bool"]
safe_data["Color3"] = function(value)
	return ("Color3.fromRGB(%d, %d, %d)"):format(value.r * 255, value.g * 255, value.b * 255);
end
safe_data["Content"] = safe_data["string"]
safe_data["DominantAxis"] = safe_data["bool"]
safe_data["EasingDirection"] = safe_data["bool"]
safe_data["EasingStyle"] = safe_data["bool"]
safe_data["FillDirection"] = safe_data["bool"]
safe_data["Font"] = safe_data["bool"]
safe_data["FrameStyle"] = safe_data["bool"]
safe_data["HorizontalAlignment"] = safe_data["bool"]
safe_data["NormalId"] = safe_data["bool"]
safe_data["Object"] = function(value)
	local hierarchy = ""
	local isFirstObject = true
	local previousObjectUsedBrackets = true

	for object in ancestorsAndSelf(value) do
		local safeName = ""
		local shouldUseBrackets = false

		if #object.Name == 0 then
			shouldUseBrackets = true
		else
			if object.Name:match("[%a_ ]+")  ~= object.Name then
				shouldUseBrackets = true
			end
		end

		if shouldUseBrackets then
			safeName = object.Name:gsub("[\"\\]", "\\%1"):gsub("\n", "\\\\n")
		end

		if object == game and previousObjectUsedBrackets then
			hierarchy = "game" .. hierarchy
			break
		elseif object == game and not previousObjectUsedBrackets then
			if hierarchy == 'StarterGui' then
				hierarchy = 'Players.LocalPlayer:WaitForChild("PlayerGui")'
			end
			hierarchy = "game." .. hierarchy
			break
		elseif shouldUseBrackets and previousObjectUsedBrackets then
			previousObjectUsedBrackets = true
			hierarchy = "[\"" .. safeName .. "\"]" .. hierarchy
		elseif shouldUseBrackets and not previousObjectUsedBrackets then
			previousObjectUsedBrackets = true
			hierarchy = "[\"" .. safeName .. "\"]" .. "." .. hierarchy
		elseif (not shouldUseBrackets) and previousObjectUsedBrackets then
			previousObjectUsedBrackets = false
			hierarchy = object.Name .. hierarchy
		elseif (not shouldUseBrackets) and (not previousObjectUsedBrackets) then
			previousObjectUsedBrackets = false
			hierarchy = object.Name .. "." .. hierarchy
		end
	end

	return hierarchy
end
safe_data["Rect2D"] = function(value)
	return "Rect.new(" .. tostring(value) .. ")"
end
safe_data["ScaleType"] = safe_data["bool"]
safe_data["ScrollBarInset"] = safe_data["bool"]
safe_data["SizeConstraint"] = safe_data["bool"]
safe_data["SortOrder"] = safe_data["bool"]
safe_data["StartCorner"] = safe_data["bool"]
safe_data["TableMajorAxis"] = safe_data["bool"]
safe_data["TextXAlignment"] = safe_data["bool"]
safe_data["TextYAlignment"] = safe_data["bool"]
safe_data["UDim"] = function(value)
	return "UDim.new(" .. tostring(value) .. ")"
end
safe_data["UDim2"] = function(value)
	return "UDim2.new(" .. tostring(value.X) .. ", " .. tostring(value.Y) .. ")"
end
safe_data["Vector2"] = function(value)
	return "Vector2.new(" .. tostring(value) .. ")"
end
safe_data["Vector3"] = function(value)
	return "Vector3.new(" .. tostring(value) .. ")"
end
safe_data["VerticalAlignment"] = safe_data["bool"]
safe_data["VerticalScrollBarPosition"] = safe_data["bool"]
safe_data["ZIndexBehavior"] = safe_data["bool"]
safe_data["InlineAlignment"] = safe_data["bool"]
safe_data["ColorSequenceKeypoint"] = function(value)
	return ("ColorSequenceKeypoint.new(%.2f, %s), "):format(value.Time, safe_data["Color3"](value.Value));
end
safe_data["NumberSequenceKeypoint"] = function(value)
	return ("NumberSequenceKeypoint.new(%.2f, %.2f), "):format(value.Time, value.Value);
end
safe_data["ColorSequence"] = function(value)
	local str = "";
	for _, color in pairs(value.Keypoints) do
		str = str .. safe_data["ColorSequenceKeypoint"](color);
	end
	return ("ColorSequence.new{%s}"):format(str:sub(1, -3));
end
safe_data["NumberSequence"] = function(value)
	local str = "";
	for _, val in pairs(value.Keypoints) do
		str = str .. safe_data["NumberSequenceKeypoint"](val);
	end
	return ("NumberSequence.new{%s}"):format(str:sub(1, -3));
end

-- An iterator function that iterates through each line of a string
local function lines(txt)
	local last_break = 0

	local function nextLine()
		if last_break == #txt then
			return nil
		end

		local line
		local next_break = string.find(txt, "\n", last_break + 1)			

		if next_break then
			line = txt:sub(last_break + 1, next_break - 1)
			last_break = next_break
		else
			line = txt:sub(last_break + 1, #txt)
			last_break = #txt
		end

		return line
	end

	return nextLine
end

--[[ Turn referencedump into a table (GUIClasses), and fill
	 RegisteredClasses with the names of each class from referencedump]]
local GUIClasses = {}
local RegisteredClasses = {}
local currentClass, temp_object

delay(1, function() -- delay so it doesn't hurt studio on startup as much

	for line in lines(referencedump) do
		if string.sub(line, 1, 1) ~= "-" then -- Skip lines that start with a minus sign
			local continue = false

			if string.sub(line,1,1) == "	" then -- Property line
				if temp_object then
					local space = string.find(line, " ")
					local datatype = string.sub(line, 2, space - 1)
					local property = string.sub(line, space + 1, #line)

					if safe_data[datatype] == nil then
						warn("Unhandled data type \"" .. datatype .. "\"; " .. currentClass .. "." .. property .. " will be ignored.")
						continue = true
					end

					if not pcall(function() return temp_object[property] end) then
						warn("Unknown property " .. currentClass .. "." .. property .. " will be ignored.")
						continue = true
					end

					if not continue then
						GUIClasses[currentClass][property] = {
							dataType = datatype,
							defaultValue = temp_object[property]
						}

						table.insert(GUIClasses[currentClass], property)
					end
				end
			else -- Object line
				if temp_object then
					temp_object:Destroy()
				end
				temp_object = nil
				currentClass = nil

				if not pcall(function() Instance.new(line):Destroy() end) then
					warn("Unknown class \"" .. line .. "\"; ignoring.")
					continue = true
				end

				if not continue then
					currentClass = line
					table.insert(RegisteredClasses, line)
					temp_object = Instance.new(currentClass)
					GUIClasses[currentClass] = {}
				end
			end
		end
	end

	if temp_object then
		temp_object:Destroy()
		temp_object = nil
	end

	referencedump = nil
end)

-- Checks if the inputted class name is in RegisteredClasses
local function isRegisteredClass(className)
	for i, currentName in pairs(RegisteredClasses) do
		if className == currentName then
			return true
		end
	end
	return false
end

-- An iterator function for GUIClasses (example: for propertyName, property in properties(GUIClasses.Frame) do)
local function properties(class)
	local counter = 0

	local function nextProperty()
		counter = counter + 1

		if class[counter] then
			return class[counter], class[class[counter]]
		end
	end

	return nextProperty
end

-- Terribly coded functions that magically work

local function processObjects(processOrder, variableList, scriptObj, module_scripts)
	local scriptObjects = ""
	local scriptProperties = ""
	local scriptCode = ""
	local moduleCode = ""

	local isFirstObject = true
	local isFirstEverProperty = true
	local isFirstProperty = true
	local createInTable = false

	local tableName = "Gui"

	-- pre process for checks --

	for _, object in ipairs(processOrder) do
		if object:IsA("ScreenGui") or object:IsA("SurfaceGui") or object:IsA("BillboardGui") then
			tableName = variableList[object]
		end
	end

	if #processOrder >= 200 then
		createInTable, scriptObjects = true, ("local %s = {\n"):format(tableName)
	end

	-- process --

	for i,object in ipairs(processOrder) do
		if isFirstObject then
			isFirstObject = false
		else
			scriptObjects = scriptObjects .. "\n"
		end

		local name, class = variableList[object], object.ClassName
		if createInTable then
			local props = {}
			local objseqesd = ("local %s = maker(\"%s\",%s)"):format(name, class, serialize_table(props))
			for propertyName, property in properties(GUIClasses[object.ClassName]) do
				if property.defaultValue ~= object[propertyName] then
					props[propertyName] = safe_data[property.dataType](object[propertyName])
					--print(propertyName, safe_data[property.dataType](object[propertyName]))
					objseqesd = ("local %s = maker(\"%s\",%s)"):format(name, class, serialize_table(props))
				end
			end
			scriptObjects = scriptObjects .. objseqesd
		else
			local props = {}
			local objseqesd = ("local %s = maker(\"%s\",%s)"):format(name, class, serialize_table(props))
			for propertyName, property in properties(GUIClasses[object.ClassName]) do
				if property.defaultValue ~= object[propertyName] then
					props[propertyName] = safe_data[property.dataType](object[propertyName])
					--print(propertyName, safe_data[property.dataType](object[propertyName]))
					objseqesd = ("local %s = maker(\"%s\",%s)"):format(name, class, serialize_table(props))
				end
			end
			scriptObjects = scriptObjects .. objseqesd .. "\n\n"
		end

		for propertyName, property in properties(GUIClasses[object.ClassName]) do
			if property.defaultValue ~= object[propertyName] then
				if isFirstEverProperty and isFirstProperty then
					isFirstEverProperty = false
					isFirstProperty = false
				elseif isFirstProperty then
					isFirstProperty = false
					scriptProperties = scriptProperties .. "\n\n"
				else
					scriptProperties = scriptProperties .. "\n"
				end

				if createInTable then
					if property.dataType == "Object" and variableList[object[propertyName]] then
						scriptProperties = scriptProperties .. ("%s.%s.%s = %s.%s"):format(tableName, name, propertyName, tableName, variableList[object[propertyName]])
					else
						scriptProperties = scriptProperties .. ("%s.%s.%s = %s"):format(tableName, name, propertyName, safe_data[property.dataType](object[propertyName]))
					end
				else
					if property.dataType == "Object" and variableList[object[propertyName]] then
						scriptProperties = scriptProperties .. ("%s = %s;"):format(propertyName, variableList[object[propertyName]])
					else
						scriptProperties = scriptProperties .. ("%s = %s;"):format(propertyName, safe_data[property.dataType](object[propertyName]))
					end
				end

			end
		end

		isFirstProperty = true
	end
	if convert_module_scripts and #module_scripts > 0 then
		moduleCode = 'local fake_module_scripts = {}\n\n'
		for i,script in ipairs(module_scripts) do	
			local Script = script[1]
			local realParent = tostring(variableList[script[1]['Parent']])
			if createInTable then realParent = tableName .. "." .. realParent end
			local fakeScript = create_module_script(Script, realParent)
			if fakeScript then
				moduleCode = (moduleCode or '')..(fakeScript or '')..'\n'
			end
		end
	end
	if convert_scripts and #scriptObj > 0 then
		warn('Converting large scripts may error.')
		scriptCode = ''
		for i,script in ipairs(scriptObj) do	
			local Script = script[1]
			local realParent = tostring(variableList[script[1]['Parent']])
			if createInTable then realParent = tableName .. "." .. realParent end
			local fakeScript = createFakeScript(Script, realParent, #module_scripts)
			if fakeScript then
				scriptCode = (scriptCode or '')..(fakeScript or '')..'\n'
			end
		end
	end

	if createInTable then scriptObjects = scriptObjects .. "\n}" end

	return scriptObjects, scriptProperties,scriptCode,moduleCode
end

local function createVariableName(object, variableList)
	local name = object.Name

	-- Remove special symbols
	local nameWithoutSymbols = ""
	for v in string.gmatch(name,"[%w_]") do
		nameWithoutSymbols = nameWithoutSymbols .. v
	end

	local baseVariableName
	if #nameWithoutSymbols == 0 then
		baseVariableName = object.ClassName
	elseif string.find(string.sub(nameWithoutSymbols,1,1), "%d") then
		baseVariableName = "_" .. nameWithoutSymbols
	else
		baseVariableName = nameWithoutSymbols
	end

	-- Check for duplicates
	local baseDuplicate = false
	for i,v in pairs(variableList) do
		if v == baseVariableName then
			baseDuplicate = true
			break
		end
	end
	if not baseDuplicate then
		variableList[object] = baseVariableName
		return
	end

	local counter = 2	
	while true do
		local duplicate = false
		for i,v in pairs(variableList) do
			if v == baseVariableName .. "_" .. counter then
				duplicate = true
				break
			end
		end
		if not duplicate then
			variableList[object] = baseVariableName .. "_" .. counter
			return
		end
		counter = counter + 1
	end
end

local function search(coreObjects, processOrder, variableList,scriptObjects, modulescripts)
	for i,v in ipairs(coreObjects) do
		if isRegisteredClass(v.ClassName) then
			createVariableName(v, variableList)
			table.insert(processOrder, v)

			if #v:GetChildren() > 0 then
				search(v:GetChildren(), processOrder, variableList, scriptObjects, modulescripts)
			end
		elseif v:IsA("Script") or v:IsA("LocalScript") then
			table.insert(scriptObjects,{v, v.Parent})
			if #v:GetChildren() > 0 then
				search(v:GetChildren(), processOrder, variableList, scriptObjects, modulescripts)
			end
		elseif v:IsA("ModuleScript") then
			table.insert(modulescripts, {v, v.Parent})
			if #v:GetChildren() > 0 then
				search(v:GetChildren(), processOrder, variableList, scriptObjects, modulescripts)
			end
		end
	end
end

function convert_ui()

	local variableList = {}
	local legalObjects = {}
	local coreObjects = {}
	local processOrder = {}
	local scriptObjects = {}
	local module_scripts = {}

	for i,v in ipairs(game:GetService("Selection"):Get()) do
		if isRegisteredClass(v.ClassName) or v:IsA("ModuleScript") then
			table.insert(legalObjects, v)
		end
	end

	for i,v in ipairs(legalObjects) do
		local flagAlreadyIncluded = false

		for i2,v2 in ipairs(legalObjects) do
			if v:IsDescendantOf(v2) and v:IsA("ModuleScript") == false then
				flagAlreadyIncluded = true
				break
			end
		end

		if not flagAlreadyIncluded then
			table.insert(coreObjects, v)
		end
	end

	if #coreObjects == 0 then
		return
	end
	search(coreObjects, processOrder, variableList, scriptObjects, module_scripts)
	local scriptObjects, scriptProperties, scriptCode, moduleCode = processObjects(
		processOrder, 
		variableList, 
		scriptObjects, 
		module_scripts
	)

	local newScript = Instance.new('LocalScript')

	local s =''
	s = s .. '\n\nlocal maker = loadstring(game:HttpGet("https://github.com/slf0Dev/my-ui-library-making-utility/raw/main/InstanceMaker.lua"))().Instance;\n\n'
	s = s .. tostring(scriptObjects)

	if convert_module_scripts and moduleCode ~= "" then
		s = s .. '\n\n-- Module Scripts:\n\n'
		s = s .. tostring(moduleCode)
	end
	if convert_scripts and scriptCode ~= "" then
		s = s .. '\n\n-- Scripts:\n\n'
		s = s .. tostring(scriptCode)
	end

	newScript.Source = s

	counter = counter + 1
	newScript.Name = 'Converted ui'.. tostring(counter)
	newScript.Parent = game:GetService("StarterGui")

	game:GetService("Selection"):Set({newScript})
	plugin:OpenScript(newScript)
end

local ConvertButton = script.Parent.Main.Pages.UtilityPage.List.GuiToluaConvertButton.MouseButton1Click:Connect(function()
	convert_ui()
end)]]></ProtectedString>
				<int64 name="SourceAssetId">-1</int64>
				<BinaryString name="Tags"></BinaryString>
			</Properties>
		</Item>
		<Item class="Frame" referent="RBXF2FB46B28A9E433EA257E655F3E6D734">
			<Properties>
				<bool name="Active">false</bool>
				<Vector2 name="AnchorPoint">
					<X>0</X>
					<Y>0</Y>
				</Vector2>
				<BinaryString name="AttributesSerialize"></BinaryString>
				<bool name="AutoLocalize">true</bool>
				<token name="AutomaticSize">0</token>
				<Color3 name="BackgroundColor3">
					<R>0.105882354</R>
					<G>0.105882354</G>
					<B>0.105882354</B>
				</Color3>
				<float name="BackgroundTransparency">0</float>
				<Color3 name="BorderColor3">
					<R>0.105882362</R>
					<G>0.164705887</G>
					<B>0.207843155</B>
				</Color3>
				<token name="BorderMode">0</token>
				<int name="BorderSizePixel">0</int>
				<bool name="ClipsDescendants">true</bool>
				<bool name="Draggable">false</bool>
				<int name="LayoutOrder">0</int>
				<string name="Name">Main</string>
				<Ref name="NextSelectionDown">null</Ref>
				<Ref name="NextSelectionLeft">null</Ref>
				<Ref name="NextSelectionRight">null</Ref>
				<Ref name="NextSelectionUp">null</Ref>
				<UDim2 name="Position">
					<XS>0</XS>
					<XO>0</XO>
					<YS>0</YS>
					<YO>0</YO>
				</UDim2>
				<Ref name="RootLocalizationTable">null</Ref>
				<float name="Rotation">0</float>
				<bool name="Selectable">false</bool>
				<token name="SelectionBehaviorDown">0</token>
				<token name="SelectionBehaviorLeft">0</token>
				<token name="SelectionBehaviorRight">0</token>
				<token name="SelectionBehaviorUp">0</token>
				<bool name="SelectionGroup">false</bool>
				<Ref name="SelectionImageObject">null</Ref>
				<int name="SelectionOrder">0</int>
				<UDim2 name="Size">
					<XS>1</XS>
					<XO>0</XO>
					<YS>1</YS>
					<YO>0</YO>
				</UDim2>
				<token name="SizeConstraint">0</token>
				<int64 name="SourceAssetId">-1</int64>
				<token name="Style">0</token>
				<BinaryString name="Tags"></BinaryString>
				<bool name="Visible">true</bool>
				<int name="ZIndex">-10</int>
			</Properties>
			<Item class="Frame" referent="RBX65D27A15F2434C0D800F2DD06A363248">
				<Properties>
					<bool name="Active">false</bool>
					<Vector2 name="AnchorPoint">
						<X>0</X>
						<Y>0</Y>
					</Vector2>
					<BinaryString name="AttributesSerialize"></BinaryString>
					<bool name="AutoLocalize">true</bool>
					<token name="AutomaticSize">0</token>
					<Color3 name="BackgroundColor3">
						<R>0.117647067</R>
						<G>0.117647067</G>
						<B>0.117647067</B>
					</Color3>
					<float name="BackgroundTransparency">1</float>
					<Color3 name="BorderColor3">
						<R>0.105882362</R>
						<G>0.164705887</G>
						<B>0.207843155</B>
					</Color3>
					<token name="BorderMode">0</token>
					<int name="BorderSizePixel">0</int>
					<bool name="ClipsDescendants">false</bool>
					<bool name="Draggable">false</bool>
					<int name="LayoutOrder">0</int>
					<string name="Name">PageButtons</string>
					<Ref name="NextSelectionDown">null</Ref>
					<Ref name="NextSelectionLeft">null</Ref>
					<Ref name="NextSelectionRight">null</Ref>
					<Ref name="NextSelectionUp">null</Ref>
					<UDim2 name="Position">
						<XS>0</XS>
						<XO>0</XO>
						<YS>0.0173913036</YS>
						<YO>0</YO>
					</UDim2>
					<Ref name="RootLocalizationTable">null</Ref>
					<float name="Rotation">0</float>
					<bool name="Selectable">false</bool>
					<token name="SelectionBehaviorDown">0</token>
					<token name="SelectionBehaviorLeft">0</token>
					<token name="SelectionBehaviorRight">0</token>
					<token name="SelectionBehaviorUp">0</token>
					<bool name="SelectionGroup">false</bool>
					<Ref name="SelectionImageObject">null</Ref>
					<int name="SelectionOrder">0</int>
					<UDim2 name="Size">
						<XS>0.998000085</XS>
						<XO>0</XO>
						<YS>0.0889998525</YS>
						<YO>0</YO>
					</UDim2>
					<token name="SizeConstraint">0</token>
					<int64 name="SourceAssetId">-1</int64>
					<token name="Style">0</token>
					<BinaryString name="Tags"></BinaryString>
					<bool name="Visible">true</bool>
					<int name="ZIndex">1</int>
				</Properties>
				<Item class="UIListLayout" referent="RBXEB2ED4E2E1CE449882AE7EF1030663E9">
					<Properties>
						<BinaryString name="AttributesSerialize"></BinaryString>
						<token name="FillDirection">0</token>
						<token name="HorizontalAlignment">1</token>
						<string name="Name">UIListLayout</string>
						<UDim name="Padding">
							<S>0</S>
							<O>5</O>
						</UDim>
						<token name="SortOrder">2</token>
						<int64 name="SourceAssetId">-1</int64>
						<BinaryString name="Tags"></BinaryString>
						<token name="VerticalAlignment">0</token>
					</Properties>
				</Item>
				<Item class="TextButton" referent="RBX606CF5D0B6EC4C3DB07EBBE15E88086A">
					<Properties>
						<bool name="Active">true</bool>
						<Vector2 name="AnchorPoint">
							<X>0</X>
							<Y>0</Y>
						</Vector2>
						<BinaryString name="AttributesSerialize"></BinaryString>
						<bool name="AutoButtonColor">false</bool>
						<bool name="AutoLocalize">true</bool>
						<token name="AutomaticSize">0</token>
						<Color3 name="BackgroundColor3">
							<R>0.105882362</R>
							<G>0.105882362</G>
							<B>0.105882362</B>
						</Color3>
						<float name="BackgroundTransparency">0</float>
						<Color3 name="BorderColor3">
							<R>0.105882362</R>
							<G>0.164705887</G>
							<B>0.207843155</B>
						</Color3>
						<token name="BorderMode">0</token>
						<int name="BorderSizePixel">1</int>
						<bool name="ClipsDescendants">false</bool>
						<bool name="Draggable">false</bool>
						<token name="Font">18</token>
						<Font name="FontFace">
							<Family><url>rbxasset://fonts/families/GothamSSm.json</url></Family>
							<Weight>500</Weight>
							<Style>Normal</Style>
							<CachedFaceId><url>rbxasset://fonts/GothamSSm-Medium.otf</url></CachedFaceId>
						</Font>
						<int name="LayoutOrder">0</int>
						<float name="LineHeight">1</float>
						<int name="MaxVisibleGraphemes">-1</int>
						<bool name="Modal">false</bool>
						<string name="Name">EditorButton</string>
						<Ref name="NextSelectionDown">null</Ref>
						<Ref name="NextSelectionLeft">null</Ref>
						<Ref name="NextSelectionRight">null</Ref>
						<Ref name="NextSelectionUp">null</Ref>
						<UDim2 name="Position">
							<XS>0.0288248342</XS>
							<XO>0</XO>
							<YS>0.901490867</YS>
							<YO>0</YO>
						</UDim2>
						<bool name="RichText">false</bool>
						<Ref name="RootLocalizationTable">null</Ref>
						<float name="Rotation">0</float>
						<bool name="Selectable">true</bool>
						<bool name="Selected">false</bool>
						<token name="SelectionBehaviorDown">0</token>
						<token name="SelectionBehaviorLeft">0</token>
						<token name="SelectionBehaviorRight">0</token>
						<token name="SelectionBehaviorUp">0</token>
						<bool name="SelectionGroup">false</bool>
						<Ref name="SelectionImageObject">null</Ref>
						<int name="SelectionOrder">0</int>
						<UDim2 name="Size">
							<XS>0.193333328</XS>
							<XO>0</XO>
							<YS>0.857142866</YS>
							<YO>0</YO>
						</UDim2>
						<token name="SizeConstraint">0</token>
						<int64 name="SourceAssetId">-1</int64>
						<token name="Style">0</token>
						<BinaryString name="Tags"></BinaryString>
						<string name="Text">Editor</string>
						<Color3 name="TextColor3">
							<R>0.619607866</R>
							<G>0.619607866</G>
							<B>0.619607866</B>
						</Color3>
						<bool name="TextScaled">false</bool>
						<float name="TextSize">14</float>
						<Color3 name="TextStrokeColor3">
							<R>0</R>
							<G>0</G>
							<B>0</B>
						</Color3>
						<float name="TextStrokeTransparency">1</float>
						<float name="TextTransparency">0</float>
						<token name="TextTruncate">0</token>
						<bool name="TextWrapped">false</bool>
						<token name="TextXAlignment">2</token>
						<token name="TextYAlignment">1</token>
						<bool name="Visible">true</bool>
						<int name="ZIndex">1</int>
					</Properties>
					<Item class="UICorner" referent="RBXDD564D92469F4F51AD8A5CE46221ED41">
						<Properties>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<UDim name="CornerRadius">
								<S>0</S>
								<O>5</O>
							</UDim>
							<string name="Name">Corner</string>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
						</Properties>
					</Item>
					<Item class="UIStroke" referent="RBX1F564B4C5F2E405D9F8487D1F1E72B9B">
						<Properties>
							<token name="ApplyStrokeMode">1</token>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<Color3 name="Color">
								<R>0.152941182</R>
								<G>0.152941182</G>
								<B>0.152941182</B>
							</Color3>
							<bool name="Enabled">true</bool>
							<token name="LineJoinMode">0</token>
							<string name="Name">Stroke</string>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
							<float name="Thickness">1</float>
							<float name="Transparency">0</float>
						</Properties>
					</Item>
					<Item class="LocalScript" referent="RBXBBEF7C9DE503453FB80D0C56C78060DA">
						<Properties>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<bool name="Disabled">false</bool>
							<Content name="LinkedSource"><null></null></Content>
							<string name="Name">LocalScript</string>
							<token name="RunContext">0</token>
							<string name="ScriptGuid">{82791C04-AE50-4E81-91F9-B467090BB141}</string>
							<ProtectedString name="Source"><![CDATA[local Pages = script.Parent.Parent.Parent.Pages:GetDescendants()
local PageJumper = script.Parent.Parent.Parent.Pages.UIPageLayout

local Page

for i,v in next,Pages do
	if v.Name == "PageNa" and v.Value and v.Value == script.Parent.Name then
		Page = v.Parent
	end
end


script.Parent.MouseButton1Click:Connect(function()
	PageJumper:JumpTo(Page)
end)]]></ProtectedString>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
						</Properties>
					</Item>
				</Item>
				<Item class="Frame" referent="RBX4B0250A4F19243A595959868B1BE8E51">
					<Properties>
						<bool name="Active">false</bool>
						<Vector2 name="AnchorPoint">
							<X>0</X>
							<Y>0</Y>
						</Vector2>
						<BinaryString name="AttributesSerialize"></BinaryString>
						<bool name="AutoLocalize">true</bool>
						<token name="AutomaticSize">0</token>
						<Color3 name="BackgroundColor3">
							<R>1</R>
							<G>1</G>
							<B>1</B>
						</Color3>
						<float name="BackgroundTransparency">1</float>
						<Color3 name="BorderColor3">
							<R>0.105882362</R>
							<G>0.164705887</G>
							<B>0.207843155</B>
						</Color3>
						<token name="BorderMode">0</token>
						<int name="BorderSizePixel">0</int>
						<bool name="ClipsDescendants">false</bool>
						<bool name="Draggable">false</bool>
						<int name="LayoutOrder">-9999</int>
						<string name="Name">ignore</string>
						<Ref name="NextSelectionDown">null</Ref>
						<Ref name="NextSelectionLeft">null</Ref>
						<Ref name="NextSelectionRight">null</Ref>
						<Ref name="NextSelectionUp">null</Ref>
						<UDim2 name="Position">
							<XS>0</XS>
							<XO>0</XO>
							<YS>0</YS>
							<YO>0</YO>
						</UDim2>
						<Ref name="RootLocalizationTable">null</Ref>
						<float name="Rotation">0</float>
						<bool name="Selectable">false</bool>
						<token name="SelectionBehaviorDown">0</token>
						<token name="SelectionBehaviorLeft">0</token>
						<token name="SelectionBehaviorRight">0</token>
						<token name="SelectionBehaviorUp">0</token>
						<bool name="SelectionGroup">false</bool>
						<Ref name="SelectionImageObject">null</Ref>
						<int name="SelectionOrder">0</int>
						<UDim2 name="Size">
							<XS>0.0199999996</XS>
							<XO>0</XO>
							<YS>0</YS>
							<YO>0</YO>
						</UDim2>
						<token name="SizeConstraint">0</token>
						<int64 name="SourceAssetId">-1</int64>
						<token name="Style">0</token>
						<BinaryString name="Tags"></BinaryString>
						<bool name="Visible">true</bool>
						<int name="ZIndex">1</int>
					</Properties>
				</Item>
				<Item class="TextButton" referent="RBX36E7A36C2B594A2488A930F0FF3433F8">
					<Properties>
						<bool name="Active">true</bool>
						<Vector2 name="AnchorPoint">
							<X>0</X>
							<Y>0</Y>
						</Vector2>
						<BinaryString name="AttributesSerialize"></BinaryString>
						<bool name="AutoButtonColor">false</bool>
						<bool name="AutoLocalize">true</bool>
						<token name="AutomaticSize">0</token>
						<Color3 name="BackgroundColor3">
							<R>0.105882362</R>
							<G>0.105882362</G>
							<B>0.105882362</B>
						</Color3>
						<float name="BackgroundTransparency">0</float>
						<Color3 name="BorderColor3">
							<R>0.105882362</R>
							<G>0.164705887</G>
							<B>0.207843155</B>
						</Color3>
						<token name="BorderMode">0</token>
						<int name="BorderSizePixel">1</int>
						<bool name="ClipsDescendants">false</bool>
						<bool name="Draggable">false</bool>
						<token name="Font">18</token>
						<Font name="FontFace">
							<Family><url>rbxasset://fonts/families/GothamSSm.json</url></Family>
							<Weight>500</Weight>
							<Style>Normal</Style>
							<CachedFaceId><url>rbxasset://fonts/GothamSSm-Medium.otf</url></CachedFaceId>
						</Font>
						<int name="LayoutOrder">0</int>
						<float name="LineHeight">1</float>
						<int name="MaxVisibleGraphemes">-1</int>
						<bool name="Modal">false</bool>
						<string name="Name">UtilityButton</string>
						<Ref name="NextSelectionDown">null</Ref>
						<Ref name="NextSelectionLeft">null</Ref>
						<Ref name="NextSelectionRight">null</Ref>
						<Ref name="NextSelectionUp">null</Ref>
						<UDim2 name="Position">
							<XS>0.0288248342</XS>
							<XO>0</XO>
							<YS>0.901490867</YS>
							<YO>0</YO>
						</UDim2>
						<bool name="RichText">false</bool>
						<Ref name="RootLocalizationTable">null</Ref>
						<float name="Rotation">0</float>
						<bool name="Selectable">true</bool>
						<bool name="Selected">false</bool>
						<token name="SelectionBehaviorDown">0</token>
						<token name="SelectionBehaviorLeft">0</token>
						<token name="SelectionBehaviorRight">0</token>
						<token name="SelectionBehaviorUp">0</token>
						<bool name="SelectionGroup">false</bool>
						<Ref name="SelectionImageObject">null</Ref>
						<int name="SelectionOrder">0</int>
						<UDim2 name="Size">
							<XS>0.193333328</XS>
							<XO>0</XO>
							<YS>0.857142866</YS>
							<YO>0</YO>
						</UDim2>
						<token name="SizeConstraint">0</token>
						<int64 name="SourceAssetId">-1</int64>
						<token name="Style">0</token>
						<BinaryString name="Tags"></BinaryString>
						<string name="Text">Utility</string>
						<Color3 name="TextColor3">
							<R>0.619607866</R>
							<G>0.619607866</G>
							<B>0.619607866</B>
						</Color3>
						<bool name="TextScaled">false</bool>
						<float name="TextSize">14</float>
						<Color3 name="TextStrokeColor3">
							<R>0</R>
							<G>0</G>
							<B>0</B>
						</Color3>
						<float name="TextStrokeTransparency">1</float>
						<float name="TextTransparency">0</float>
						<token name="TextTruncate">0</token>
						<bool name="TextWrapped">false</bool>
						<token name="TextXAlignment">2</token>
						<token name="TextYAlignment">1</token>
						<bool name="Visible">true</bool>
						<int name="ZIndex">1</int>
					</Properties>
					<Item class="UICorner" referent="RBX586608128F10489E893CA0C412163370">
						<Properties>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<UDim name="CornerRadius">
								<S>0</S>
								<O>5</O>
							</UDim>
							<string name="Name">Corner</string>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
						</Properties>
					</Item>
					<Item class="UIStroke" referent="RBX70D214C00DE9453E8BC51E75BDCD0B8F">
						<Properties>
							<token name="ApplyStrokeMode">1</token>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<Color3 name="Color">
								<R>0.152941182</R>
								<G>0.152941182</G>
								<B>0.152941182</B>
							</Color3>
							<bool name="Enabled">true</bool>
							<token name="LineJoinMode">0</token>
							<string name="Name">Stroke</string>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
							<float name="Thickness">1</float>
							<float name="Transparency">0</float>
						</Properties>
					</Item>
					<Item class="LocalScript" referent="RBXA532DDAFCBB741F2A1064C155056A6F1">
						<Properties>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<bool name="Disabled">false</bool>
							<Content name="LinkedSource"><null></null></Content>
							<string name="Name">LocalScript</string>
							<token name="RunContext">0</token>
							<string name="ScriptGuid">{6780CED3-2F27-4CF6-9B46-94A9B51C22F7}</string>
							<ProtectedString name="Source"><![CDATA[local Pages = script.Parent.Parent.Parent.Pages:GetDescendants()
local PageJumper = script.Parent.Parent.Parent.Pages.UIPageLayout

local Page

for i,v in next,Pages do
	if v.Name == "PageNa" and v.Value and v.Value == script.Parent.Name then
		Page = v.Parent
	end
end


script.Parent.MouseButton1Click:Connect(function()
	PageJumper:JumpTo(Page)
end)]]></ProtectedString>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
						</Properties>
					</Item>
				</Item>
				<Item class="TextButton" referent="RBXD9AA2A86D6904FFA88A6F8F73C420273">
					<Properties>
						<bool name="Active">true</bool>
						<Vector2 name="AnchorPoint">
							<X>0</X>
							<Y>0</Y>
						</Vector2>
						<BinaryString name="AttributesSerialize"></BinaryString>
						<bool name="AutoButtonColor">false</bool>
						<bool name="AutoLocalize">true</bool>
						<token name="AutomaticSize">0</token>
						<Color3 name="BackgroundColor3">
							<R>0.105882362</R>
							<G>0.105882362</G>
							<B>0.105882362</B>
						</Color3>
						<float name="BackgroundTransparency">0</float>
						<Color3 name="BorderColor3">
							<R>0.105882362</R>
							<G>0.164705887</G>
							<B>0.207843155</B>
						</Color3>
						<token name="BorderMode">0</token>
						<int name="BorderSizePixel">1</int>
						<bool name="ClipsDescendants">false</bool>
						<bool name="Draggable">false</bool>
						<token name="Font">18</token>
						<Font name="FontFace">
							<Family><url>rbxasset://fonts/families/GothamSSm.json</url></Family>
							<Weight>500</Weight>
							<Style>Normal</Style>
							<CachedFaceId><url>rbxasset://fonts/GothamSSm-Medium.otf</url></CachedFaceId>
						</Font>
						<int name="LayoutOrder">0</int>
						<float name="LineHeight">1</float>
						<int name="MaxVisibleGraphemes">-1</int>
						<bool name="Modal">false</bool>
						<string name="Name">SettingsButton</string>
						<Ref name="NextSelectionDown">null</Ref>
						<Ref name="NextSelectionLeft">null</Ref>
						<Ref name="NextSelectionRight">null</Ref>
						<Ref name="NextSelectionUp">null</Ref>
						<UDim2 name="Position">
							<XS>0.0288248342</XS>
							<XO>0</XO>
							<YS>0.901490867</YS>
							<YO>0</YO>
						</UDim2>
						<bool name="RichText">false</bool>
						<Ref name="RootLocalizationTable">null</Ref>
						<float name="Rotation">0</float>
						<bool name="Selectable">true</bool>
						<bool name="Selected">false</bool>
						<token name="SelectionBehaviorDown">0</token>
						<token name="SelectionBehaviorLeft">0</token>
						<token name="SelectionBehaviorRight">0</token>
						<token name="SelectionBehaviorUp">0</token>
						<bool name="SelectionGroup">false</bool>
						<Ref name="SelectionImageObject">null</Ref>
						<int name="SelectionOrder">0</int>
						<UDim2 name="Size">
							<XS>0.193333328</XS>
							<XO>0</XO>
							<YS>0.857142866</YS>
							<YO>0</YO>
						</UDim2>
						<token name="SizeConstraint">0</token>
						<int64 name="SourceAssetId">-1</int64>
						<token name="Style">0</token>
						<BinaryString name="Tags"></BinaryString>
						<string name="Text">Settings</string>
						<Color3 name="TextColor3">
							<R>0.619607866</R>
							<G>0.619607866</G>
							<B>0.619607866</B>
						</Color3>
						<bool name="TextScaled">false</bool>
						<float name="TextSize">14</float>
						<Color3 name="TextStrokeColor3">
							<R>0</R>
							<G>0</G>
							<B>0</B>
						</Color3>
						<float name="TextStrokeTransparency">1</float>
						<float name="TextTransparency">0</float>
						<token name="TextTruncate">0</token>
						<bool name="TextWrapped">false</bool>
						<token name="TextXAlignment">2</token>
						<token name="TextYAlignment">1</token>
						<bool name="Visible">true</bool>
						<int name="ZIndex">1</int>
					</Properties>
					<Item class="UICorner" referent="RBXF0F7B8CB0FEF4B519B336A2EC2757FF8">
						<Properties>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<UDim name="CornerRadius">
								<S>0</S>
								<O>5</O>
							</UDim>
							<string name="Name">Corner</string>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
						</Properties>
					</Item>
					<Item class="UIStroke" referent="RBX99029BA01F60426C85A863E6002E1F24">
						<Properties>
							<token name="ApplyStrokeMode">1</token>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<Color3 name="Color">
								<R>0.152941182</R>
								<G>0.152941182</G>
								<B>0.152941182</B>
							</Color3>
							<bool name="Enabled">true</bool>
							<token name="LineJoinMode">0</token>
							<string name="Name">Stroke</string>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
							<float name="Thickness">1</float>
							<float name="Transparency">0</float>
						</Properties>
					</Item>
					<Item class="LocalScript" referent="RBX2076E06637AF4788AC987E6D1C279CFA">
						<Properties>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<bool name="Disabled">false</bool>
							<Content name="LinkedSource"><null></null></Content>
							<string name="Name">LocalScript</string>
							<token name="RunContext">0</token>
							<string name="ScriptGuid">{8CD8341F-93AD-4EAD-A01D-D9B05C4756C8}</string>
							<ProtectedString name="Source"><![CDATA[local Pages = script.Parent.Parent.Parent.Pages:GetDescendants()
local PageJumper = script.Parent.Parent.Parent.Pages.UIPageLayout

local Page

for i,v in next,Pages do
	if v.Name == "PageNa" and v.Value and v.Value == script.Parent.Name then
		Page = v.Parent
	end
end


script.Parent.MouseButton1Click:Connect(function()
	PageJumper:JumpTo(Page)
end)]]></ProtectedString>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
						</Properties>
					</Item>
				</Item>
			</Item>
			<Item class="Frame" referent="RBXF9BBEC82608F4F8F85843D5A780A156A">
				<Properties>
					<bool name="Active">false</bool>
					<Vector2 name="AnchorPoint">
						<X>0</X>
						<Y>0</Y>
					</Vector2>
					<BinaryString name="AttributesSerialize"></BinaryString>
					<bool name="AutoLocalize">true</bool>
					<token name="AutomaticSize">0</token>
					<Color3 name="BackgroundColor3">
						<R>1</R>
						<G>1</G>
						<B>1</B>
					</Color3>
					<float name="BackgroundTransparency">1</float>
					<Color3 name="BorderColor3">
						<R>0.105882362</R>
						<G>0.164705887</G>
						<B>0.207843155</B>
					</Color3>
					<token name="BorderMode">0</token>
					<int name="BorderSizePixel">0</int>
					<bool name="ClipsDescendants">false</bool>
					<bool name="Draggable">false</bool>
					<int name="LayoutOrder">0</int>
					<string name="Name">Pages</string>
					<Ref name="NextSelectionDown">null</Ref>
					<Ref name="NextSelectionLeft">null</Ref>
					<Ref name="NextSelectionRight">null</Ref>
					<Ref name="NextSelectionUp">null</Ref>
					<UDim2 name="Position">
						<XS>0</XS>
						<XO>0</XO>
						<YS>0.135376647</YS>
						<YO>0</YO>
					</UDim2>
					<Ref name="RootLocalizationTable">null</Ref>
					<float name="Rotation">0</float>
					<bool name="Selectable">false</bool>
					<token name="SelectionBehaviorDown">0</token>
					<token name="SelectionBehaviorLeft">0</token>
					<token name="SelectionBehaviorRight">0</token>
					<token name="SelectionBehaviorUp">0</token>
					<bool name="SelectionGroup">false</bool>
					<Ref name="SelectionImageObject">null</Ref>
					<int name="SelectionOrder">0</int>
					<UDim2 name="Size">
						<XS>1</XS>
						<XO>0</XO>
						<YS>0.864623427</YS>
						<YO>0</YO>
					</UDim2>
					<token name="SizeConstraint">0</token>
					<int64 name="SourceAssetId">-1</int64>
					<token name="Style">0</token>
					<BinaryString name="Tags"></BinaryString>
					<bool name="Visible">true</bool>
					<int name="ZIndex">1</int>
				</Properties>
				<Item class="Frame" referent="RBX69FB12F1AAB647A18F12E2CFF8CD73AD">
					<Properties>
						<bool name="Active">false</bool>
						<Vector2 name="AnchorPoint">
							<X>0</X>
							<Y>0</Y>
						</Vector2>
						<BinaryString name="AttributesSerialize"></BinaryString>
						<bool name="AutoLocalize">true</bool>
						<token name="AutomaticSize">0</token>
						<Color3 name="BackgroundColor3">
							<R>1</R>
							<G>1</G>
							<B>1</B>
						</Color3>
						<float name="BackgroundTransparency">1</float>
						<Color3 name="BorderColor3">
							<R>0.105882362</R>
							<G>0.164705887</G>
							<B>0.207843155</B>
						</Color3>
						<token name="BorderMode">0</token>
						<int name="BorderSizePixel">1</int>
						<bool name="ClipsDescendants">false</bool>
						<bool name="Draggable">false</bool>
						<int name="LayoutOrder">0</int>
						<string name="Name">EditorPage</string>
						<Ref name="NextSelectionDown">null</Ref>
						<Ref name="NextSelectionLeft">null</Ref>
						<Ref name="NextSelectionRight">null</Ref>
						<Ref name="NextSelectionUp">null</Ref>
						<UDim2 name="Position">
							<XS>0</XS>
							<XO>0</XO>
							<YS>0.109289616</YS>
							<YO>0</YO>
						</UDim2>
						<Ref name="RootLocalizationTable">null</Ref>
						<float name="Rotation">0</float>
						<bool name="Selectable">false</bool>
						<token name="SelectionBehaviorDown">0</token>
						<token name="SelectionBehaviorLeft">0</token>
						<token name="SelectionBehaviorRight">0</token>
						<token name="SelectionBehaviorUp">0</token>
						<bool name="SelectionGroup">false</bool>
						<Ref name="SelectionImageObject">null</Ref>
						<int name="SelectionOrder">0</int>
						<UDim2 name="Size">
							<XS>1</XS>
							<XO>0</XO>
							<YS>1</YS>
							<YO>0</YO>
						</UDim2>
						<token name="SizeConstraint">0</token>
						<int64 name="SourceAssetId">-1</int64>
						<token name="Style">0</token>
						<BinaryString name="Tags"></BinaryString>
						<bool name="Visible">true</bool>
						<int name="ZIndex">1</int>
					</Properties>
					<Item class="Frame" referent="RBX5A6C5FDC462644C680FA3FD887E5DF1D">
						<Properties>
							<bool name="Active">false</bool>
							<Vector2 name="AnchorPoint">
								<X>0</X>
								<Y>0</Y>
							</Vector2>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<bool name="AutoLocalize">true</bool>
							<token name="AutomaticSize">0</token>
							<Color3 name="BackgroundColor3">
								<R>1</R>
								<G>1</G>
								<B>1</B>
							</Color3>
							<float name="BackgroundTransparency">1</float>
							<Color3 name="BorderColor3">
								<R>0.105882362</R>
								<G>0.164705887</G>
								<B>0.207843155</B>
							</Color3>
							<token name="BorderMode">0</token>
							<int name="BorderSizePixel">0</int>
							<bool name="ClipsDescendants">false</bool>
							<bool name="Draggable">false</bool>
							<int name="LayoutOrder">0</int>
							<string name="Name">Buttons</string>
							<Ref name="NextSelectionDown">null</Ref>
							<Ref name="NextSelectionLeft">null</Ref>
							<Ref name="NextSelectionRight">null</Ref>
							<Ref name="NextSelectionUp">null</Ref>
							<UDim2 name="Position">
								<XS>0.0289999992</XS>
								<XO>0</XO>
								<YS>0.910000026</YS>
								<YO>0</YO>
							</UDim2>
							<Ref name="RootLocalizationTable">null</Ref>
							<float name="Rotation">0</float>
							<bool name="Selectable">false</bool>
							<token name="SelectionBehaviorDown">0</token>
							<token name="SelectionBehaviorLeft">0</token>
							<token name="SelectionBehaviorRight">0</token>
							<token name="SelectionBehaviorUp">0</token>
							<bool name="SelectionGroup">false</bool>
							<Ref name="SelectionImageObject">null</Ref>
							<int name="SelectionOrder">0</int>
							<UDim2 name="Size">
								<XS>0.944567621</XS>
								<XO>0</XO>
								<YS>0.0920245051</YS>
								<YO>0</YO>
							</UDim2>
							<token name="SizeConstraint">0</token>
							<int64 name="SourceAssetId">-1</int64>
							<token name="Style">0</token>
							<BinaryString name="Tags"></BinaryString>
							<bool name="Visible">true</bool>
							<int name="ZIndex">1</int>
						</Properties>
						<Item class="UIListLayout" referent="RBX202342C0A46744F2B493CF7250BE0493">
							<Properties>
								<BinaryString name="AttributesSerialize"></BinaryString>
								<token name="FillDirection">0</token>
								<token name="HorizontalAlignment">1</token>
								<string name="Name">UIListLayout</string>
								<UDim name="Padding">
									<S>0</S>
									<O>5</O>
								</UDim>
								<token name="SortOrder">2</token>
								<int64 name="SourceAssetId">-1</int64>
								<BinaryString name="Tags"></BinaryString>
								<token name="VerticalAlignment">1</token>
							</Properties>
						</Item>
						<Item class="TextButton" referent="RBX7D8FA747F9EA49999F466E7068BF5BA4">
							<Properties>
								<bool name="Active">true</bool>
								<Vector2 name="AnchorPoint">
									<X>0</X>
									<Y>0</Y>
								</Vector2>
								<BinaryString name="AttributesSerialize"></BinaryString>
								<bool name="AutoButtonColor">false</bool>
								<bool name="AutoLocalize">true</bool>
								<token name="AutomaticSize">0</token>
								<Color3 name="BackgroundColor3">
									<R>0.105882362</R>
									<G>0.105882362</G>
									<B>0.105882362</B>
								</Color3>
								<float name="BackgroundTransparency">0</float>
								<Color3 name="BorderColor3">
									<R>0.105882362</R>
									<G>0.164705887</G>
									<B>0.207843155</B>
								</Color3>
								<token name="BorderMode">0</token>
								<int name="BorderSizePixel">1</int>
								<bool name="ClipsDescendants">false</bool>
								<bool name="Draggable">false</bool>
								<token name="Font">18</token>
								<Font name="FontFace">
									<Family><url>rbxasset://fonts/families/GothamSSm.json</url></Family>
									<Weight>500</Weight>
									<Style>Normal</Style>
									<CachedFaceId><url>rbxasset://fonts/GothamSSm-Medium.otf</url></CachedFaceId>
								</Font>
								<int name="LayoutOrder">0</int>
								<float name="LineHeight">1</float>
								<int name="MaxVisibleGraphemes">-1</int>
								<bool name="Modal">false</bool>
								<string name="Name">RunButton</string>
								<Ref name="NextSelectionDown">null</Ref>
								<Ref name="NextSelectionLeft">null</Ref>
								<Ref name="NextSelectionRight">null</Ref>
								<Ref name="NextSelectionUp">null</Ref>
								<UDim2 name="Position">
									<XS>0.0288248342</XS>
									<XO>0</XO>
									<YS>0.901490867</YS>
									<YO>0</YO>
								</UDim2>
								<bool name="RichText">false</bool>
								<Ref name="RootLocalizationTable">null</Ref>
								<float name="Rotation">0</float>
								<bool name="Selectable">true</bool>
								<bool name="Selected">false</bool>
								<token name="SelectionBehaviorDown">0</token>
								<token name="SelectionBehaviorLeft">0</token>
								<token name="SelectionBehaviorRight">0</token>
								<token name="SelectionBehaviorUp">0</token>
								<bool name="SelectionGroup">false</bool>
								<Ref name="SelectionImageObject">null</Ref>
								<int name="SelectionOrder">0</int>
								<UDim2 name="Size">
									<XS>0.204225346</XS>
									<XO>0</XO>
									<YS>0.810810804</YS>
									<YO>0</YO>
								</UDim2>
								<token name="SizeConstraint">0</token>
								<int64 name="SourceAssetId">-1</int64>
								<token name="Style">0</token>
								<BinaryString name="Tags"></BinaryString>
								<string name="Text">Run</string>
								<Color3 name="TextColor3">
									<R>0.619607866</R>
									<G>0.619607866</G>
									<B>0.619607866</B>
								</Color3>
								<bool name="TextScaled">false</bool>
								<float name="TextSize">14</float>
								<Color3 name="TextStrokeColor3">
									<R>0</R>
									<G>0</G>
									<B>0</B>
								</Color3>
								<float name="TextStrokeTransparency">1</float>
								<float name="TextTransparency">0</float>
								<token name="TextTruncate">0</token>
								<bool name="TextWrapped">false</bool>
								<token name="TextXAlignment">2</token>
								<token name="TextYAlignment">1</token>
								<bool name="Visible">true</bool>
								<int name="ZIndex">1</int>
							</Properties>
							<Item class="UICorner" referent="RBX630E6BD7293E4FB2B5E4F081401223E1">
								<Properties>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<UDim name="CornerRadius">
										<S>0</S>
										<O>5</O>
									</UDim>
									<string name="Name">Corner</string>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
								</Properties>
							</Item>
							<Item class="UIStroke" referent="RBXBDCAB14D68264A85AE4EA5CAA4D8064E">
								<Properties>
									<token name="ApplyStrokeMode">1</token>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<Color3 name="Color">
										<R>0.152941182</R>
										<G>0.152941182</G>
										<B>0.152941182</B>
									</Color3>
									<bool name="Enabled">true</bool>
									<token name="LineJoinMode">0</token>
									<string name="Name">Stroke</string>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
									<float name="Thickness">1</float>
									<float name="Transparency">0</float>
								</Properties>
							</Item>
							<Item class="ImageButton" referent="RBX9A09080F7334405FBC258E6C21C49A3B">
								<Properties>
									<bool name="Active">true</bool>
									<Vector2 name="AnchorPoint">
										<X>0</X>
										<Y>0</Y>
									</Vector2>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<bool name="AutoButtonColor">true</bool>
									<bool name="AutoLocalize">true</bool>
									<token name="AutomaticSize">0</token>
									<Color3 name="BackgroundColor3">
										<R>0.639215708</R>
										<G>0.635294139</G>
										<B>0.647058845</B>
									</Color3>
									<float name="BackgroundTransparency">1</float>
									<Color3 name="BorderColor3">
										<R>0.105882362</R>
										<G>0.164705887</G>
										<B>0.207843155</B>
									</Color3>
									<token name="BorderMode">0</token>
									<int name="BorderSizePixel">1</int>
									<bool name="ClipsDescendants">false</bool>
									<bool name="Draggable">false</bool>
									<Content name="HoverImage"><null></null></Content>
									<Content name="Image"><url>rbxassetid://3926305904</url></Content>
									<Color3 name="ImageColor3">
										<R>0.619607866</R>
										<G>0.619607866</G>
										<B>0.619607866</B>
									</Color3>
									<Vector2 name="ImageRectOffset">
										<X>364</X>
										<Y>524</Y>
									</Vector2>
									<Vector2 name="ImageRectSize">
										<X>36</X>
										<Y>36</Y>
									</Vector2>
									<float name="ImageTransparency">0</float>
									<int name="LayoutOrder">23</int>
									<bool name="Modal">false</bool>
									<string name="Name">Icon</string>
									<Ref name="NextSelectionDown">null</Ref>
									<Ref name="NextSelectionLeft">null</Ref>
									<Ref name="NextSelectionRight">null</Ref>
									<Ref name="NextSelectionUp">null</Ref>
									<UDim2 name="Position">
										<XS>0</XS>
										<XO>0</XO>
										<YS>0</YS>
										<YO>0</YO>
									</UDim2>
									<Content name="PressedImage"><null></null></Content>
									<token name="ResampleMode">0</token>
									<Ref name="RootLocalizationTable">null</Ref>
									<float name="Rotation">0</float>
									<token name="ScaleType">3</token>
									<bool name="Selectable">true</bool>
									<bool name="Selected">false</bool>
									<token name="SelectionBehaviorDown">0</token>
									<token name="SelectionBehaviorLeft">0</token>
									<token name="SelectionBehaviorRight">0</token>
									<token name="SelectionBehaviorUp">0</token>
									<bool name="SelectionGroup">false</bool>
									<Ref name="SelectionImageObject">null</Ref>
									<int name="SelectionOrder">0</int>
									<UDim2 name="Size">
										<XS>0.237793952</XS>
										<XO>0</XO>
										<YS>0.899999976</YS>
										<YO>0</YO>
									</UDim2>
									<token name="SizeConstraint">0</token>
									<Rect2D name="SliceCenter">
										<min>
											<X>0</X>
											<Y>0</Y>
										</min>
										<max>
											<X>0</X>
											<Y>0</Y>
										</max>
									</Rect2D>
									<float name="SliceScale">1</float>
									<int64 name="SourceAssetId">-1</int64>
									<token name="Style">0</token>
									<BinaryString name="Tags"></BinaryString>
									<UDim2 name="TileSize">
										<XS>1</XS>
										<XO>0</XO>
										<YS>1</YS>
										<YO>0</YO>
									</UDim2>
									<bool name="Visible">true</bool>
									<int name="ZIndex">2</int>
								</Properties>
							</Item>
							<Item class="LocalScript" referent="RBXEC61C6D8CF534D96A479ADD8C0021758">
								<Properties>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<bool name="Disabled">false</bool>
									<Content name="LinkedSource"><null></null></Content>
									<string name="Name">LocalScript</string>
									<token name="RunContext">0</token>
									<string name="ScriptGuid">{E0C70D56-7FE5-470E-8FF9-78136AF4D0BA}</string>
									<ProtectedString name="Source"><![CDATA[local sourcecode = script.Parent.Parent.Parent.EdText:WaitForChild("IDE").Input
script.Parent.MouseButton1Click:Connect(function()
	loadstring(sourcecode.Text)()
end)]]></ProtectedString>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
								</Properties>
							</Item>
						</Item>
						<Item class="TextButton" referent="RBXDD24BB34F04D45C58B7B458029E7EE6C">
							<Properties>
								<bool name="Active">true</bool>
								<Vector2 name="AnchorPoint">
									<X>0</X>
									<Y>0</Y>
								</Vector2>
								<BinaryString name="AttributesSerialize"></BinaryString>
								<bool name="AutoButtonColor">false</bool>
								<bool name="AutoLocalize">true</bool>
								<token name="AutomaticSize">0</token>
								<Color3 name="BackgroundColor3">
									<R>0.105882362</R>
									<G>0.105882362</G>
									<B>0.105882362</B>
								</Color3>
								<float name="BackgroundTransparency">0</float>
								<Color3 name="BorderColor3">
									<R>0.105882362</R>
									<G>0.164705887</G>
									<B>0.207843155</B>
								</Color3>
								<token name="BorderMode">0</token>
								<int name="BorderSizePixel">1</int>
								<bool name="ClipsDescendants">false</bool>
								<bool name="Draggable">false</bool>
								<token name="Font">18</token>
								<Font name="FontFace">
									<Family><url>rbxasset://fonts/families/GothamSSm.json</url></Family>
									<Weight>500</Weight>
									<Style>Normal</Style>
									<CachedFaceId><url>rbxasset://fonts/GothamSSm-Medium.otf</url></CachedFaceId>
								</Font>
								<int name="LayoutOrder">0</int>
								<float name="LineHeight">1</float>
								<int name="MaxVisibleGraphemes">-1</int>
								<bool name="Modal">false</bool>
								<string name="Name">&#208;&#161;learButton</string>
								<Ref name="NextSelectionDown">null</Ref>
								<Ref name="NextSelectionLeft">null</Ref>
								<Ref name="NextSelectionRight">null</Ref>
								<Ref name="NextSelectionUp">null</Ref>
								<UDim2 name="Position">
									<XS>0.0288248342</XS>
									<XO>0</XO>
									<YS>0.901490867</YS>
									<YO>0</YO>
								</UDim2>
								<bool name="RichText">false</bool>
								<Ref name="RootLocalizationTable">null</Ref>
								<float name="Rotation">0</float>
								<bool name="Selectable">true</bool>
								<bool name="Selected">false</bool>
								<token name="SelectionBehaviorDown">0</token>
								<token name="SelectionBehaviorLeft">0</token>
								<token name="SelectionBehaviorRight">0</token>
								<token name="SelectionBehaviorUp">0</token>
								<bool name="SelectionGroup">false</bool>
								<Ref name="SelectionImageObject">null</Ref>
								<int name="SelectionOrder">0</int>
								<UDim2 name="Size">
									<XS>0.204225346</XS>
									<XO>0</XO>
									<YS>0.810810804</YS>
									<YO>0</YO>
								</UDim2>
								<token name="SizeConstraint">0</token>
								<int64 name="SourceAssetId">-1</int64>
								<token name="Style">0</token>
								<BinaryString name="Tags"></BinaryString>
								<string name="Text">Clear</string>
								<Color3 name="TextColor3">
									<R>0.619607866</R>
									<G>0.619607866</G>
									<B>0.619607866</B>
								</Color3>
								<bool name="TextScaled">false</bool>
								<float name="TextSize">14</float>
								<Color3 name="TextStrokeColor3">
									<R>0</R>
									<G>0</G>
									<B>0</B>
								</Color3>
								<float name="TextStrokeTransparency">1</float>
								<float name="TextTransparency">0</float>
								<token name="TextTruncate">0</token>
								<bool name="TextWrapped">false</bool>
								<token name="TextXAlignment">2</token>
								<token name="TextYAlignment">1</token>
								<bool name="Visible">true</bool>
								<int name="ZIndex">1</int>
							</Properties>
							<Item class="UICorner" referent="RBXF7D9412CEBE247C89A731DC38F03B48B">
								<Properties>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<UDim name="CornerRadius">
										<S>0</S>
										<O>5</O>
									</UDim>
									<string name="Name">Corner</string>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
								</Properties>
							</Item>
							<Item class="UIStroke" referent="RBX5F86F5B96822413C8EABD884F59A47CE">
								<Properties>
									<token name="ApplyStrokeMode">1</token>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<Color3 name="Color">
										<R>0.152941182</R>
										<G>0.152941182</G>
										<B>0.152941182</B>
									</Color3>
									<bool name="Enabled">true</bool>
									<token name="LineJoinMode">0</token>
									<string name="Name">Stroke</string>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
									<float name="Thickness">1</float>
									<float name="Transparency">0</float>
								</Properties>
							</Item>
							<Item class="ImageButton" referent="RBX268175B569EF41E7AC252955EF32BBA2">
								<Properties>
									<bool name="Active">true</bool>
									<Vector2 name="AnchorPoint">
										<X>0</X>
										<Y>0</Y>
									</Vector2>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<bool name="AutoButtonColor">true</bool>
									<bool name="AutoLocalize">true</bool>
									<token name="AutomaticSize">0</token>
									<Color3 name="BackgroundColor3">
										<R>0.639215708</R>
										<G>0.635294139</G>
										<B>0.647058845</B>
									</Color3>
									<float name="BackgroundTransparency">1</float>
									<Color3 name="BorderColor3">
										<R>0.105882362</R>
										<G>0.164705887</G>
										<B>0.207843155</B>
									</Color3>
									<token name="BorderMode">0</token>
									<int name="BorderSizePixel">1</int>
									<bool name="ClipsDescendants">false</bool>
									<bool name="Draggable">false</bool>
									<Content name="HoverImage"><null></null></Content>
									<Content name="Image"><url>rbxassetid://3926305904</url></Content>
									<Color3 name="ImageColor3">
										<R>0.619607866</R>
										<G>0.619607866</G>
										<B>0.619607866</B>
									</Color3>
									<Vector2 name="ImageRectOffset">
										<X>924</X>
										<Y>724</Y>
									</Vector2>
									<Vector2 name="ImageRectSize">
										<X>36</X>
										<Y>36</Y>
									</Vector2>
									<float name="ImageTransparency">0</float>
									<int name="LayoutOrder">23</int>
									<bool name="Modal">false</bool>
									<string name="Name">Icon</string>
									<Ref name="NextSelectionDown">null</Ref>
									<Ref name="NextSelectionLeft">null</Ref>
									<Ref name="NextSelectionRight">null</Ref>
									<Ref name="NextSelectionUp">null</Ref>
									<UDim2 name="Position">
										<XS>0</XS>
										<XO>0</XO>
										<YS>0</YS>
										<YO>0</YO>
									</UDim2>
									<Content name="PressedImage"><null></null></Content>
									<token name="ResampleMode">0</token>
									<Ref name="RootLocalizationTable">null</Ref>
									<float name="Rotation">0</float>
									<token name="ScaleType">3</token>
									<bool name="Selectable">true</bool>
									<bool name="Selected">false</bool>
									<token name="SelectionBehaviorDown">0</token>
									<token name="SelectionBehaviorLeft">0</token>
									<token name="SelectionBehaviorRight">0</token>
									<token name="SelectionBehaviorUp">0</token>
									<bool name="SelectionGroup">false</bool>
									<Ref name="SelectionImageObject">null</Ref>
									<int name="SelectionOrder">0</int>
									<UDim2 name="Size">
										<XS>0.237793952</XS>
										<XO>0</XO>
										<YS>0.899999976</YS>
										<YO>0</YO>
									</UDim2>
									<token name="SizeConstraint">0</token>
									<Rect2D name="SliceCenter">
										<min>
											<X>0</X>
											<Y>0</Y>
										</min>
										<max>
											<X>0</X>
											<Y>0</Y>
										</max>
									</Rect2D>
									<float name="SliceScale">1</float>
									<int64 name="SourceAssetId">-1</int64>
									<token name="Style">0</token>
									<BinaryString name="Tags"></BinaryString>
									<UDim2 name="TileSize">
										<XS>1</XS>
										<XO>0</XO>
										<YS>1</YS>
										<YO>0</YO>
									</UDim2>
									<bool name="Visible">true</bool>
									<int name="ZIndex">2</int>
								</Properties>
							</Item>
							<Item class="LocalScript" referent="RBXE27B1763406F4C3DB59552787E3D088A">
								<Properties>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<bool name="Disabled">false</bool>
									<Content name="LinkedSource"><null></null></Content>
									<string name="Name">LocalScript</string>
									<token name="RunContext">0</token>
									<string name="ScriptGuid">{E16FCA88-2A44-4F08-AC1C-E5F700480131}</string>
									<ProtectedString name="Source"><![CDATA[local sourcecode = script.Parent.Parent.Parent.EdText:WaitForChild("IDE").Input
script.Parent.MouseButton1Click:Connect(function()
	sourcecode.Text = ""
end)]]></ProtectedString>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
								</Properties>
							</Item>
						</Item>
					</Item>
					<Item class="StringValue" referent="RBX74DC0E52B31F42D1AC98603719DCBCD5">
						<Properties>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<string name="Name">PageNa</string>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
							<string name="Value">EditorButton</string>
						</Properties>
					</Item>
					<Item class="Frame" referent="RBX2BD1A4359AD34D4DA8126835B604A69B">
						<Properties>
							<bool name="Active">false</bool>
							<Vector2 name="AnchorPoint">
								<X>0</X>
								<Y>0</Y>
							</Vector2>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<bool name="AutoLocalize">true</bool>
							<token name="AutomaticSize">0</token>
							<Color3 name="BackgroundColor3">
								<R>0.164705887</R>
								<G>0.164705887</G>
								<B>0.164705887</B>
							</Color3>
							<float name="BackgroundTransparency">1</float>
							<Color3 name="BorderColor3">
								<R>0.105882362</R>
								<G>0.164705887</G>
								<B>0.207843155</B>
							</Color3>
							<token name="BorderMode">0</token>
							<int name="BorderSizePixel">0</int>
							<bool name="ClipsDescendants">false</bool>
							<bool name="Draggable">false</bool>
							<int name="LayoutOrder">0</int>
							<string name="Name">EdText</string>
							<Ref name="NextSelectionDown">null</Ref>
							<Ref name="NextSelectionLeft">null</Ref>
							<Ref name="NextSelectionRight">null</Ref>
							<Ref name="NextSelectionUp">null</Ref>
							<UDim2 name="Position">
								<XS>0</XS>
								<XO>0</XO>
								<YS>-0.0206173584</YS>
								<YO>0</YO>
							</UDim2>
							<Ref name="RootLocalizationTable">null</Ref>
							<float name="Rotation">0</float>
							<bool name="Selectable">false</bool>
							<token name="SelectionBehaviorDown">0</token>
							<token name="SelectionBehaviorLeft">0</token>
							<token name="SelectionBehaviorRight">0</token>
							<token name="SelectionBehaviorUp">0</token>
							<bool name="SelectionGroup">false</bool>
							<Ref name="SelectionImageObject">null</Ref>
							<int name="SelectionOrder">0</int>
							<UDim2 name="Size">
								<XS>1</XS>
								<XO>0</XO>
								<YS>0.91539228</YS>
								<YO>0</YO>
							</UDim2>
							<token name="SizeConstraint">0</token>
							<int64 name="SourceAssetId">-1</int64>
							<token name="Style">0</token>
							<BinaryString name="Tags"></BinaryString>
							<bool name="Visible">true</bool>
							<int name="ZIndex">1</int>
						</Properties>
						<Item class="LocalScript" referent="RBXED9F1585B87C4292BDA73E8151BAB68B">
							<Properties>
								<BinaryString name="AttributesSerialize"></BinaryString>
								<bool name="Disabled">false</bool>
								<Content name="LinkedSource"><null></null></Content>
								<string name="Name">high</string>
								<token name="RunContext">0</token>
								<string name="ScriptGuid">{4CDD1D37-50A1-42BD-9717-8D523F4EDB64}</string>
								<ProtectedString name="Source"><![CDATA[local highlighter = require(script.IDE_Stripped)

highlighter.new(script.Parent)]]></ProtectedString>
								<int64 name="SourceAssetId">-1</int64>
								<BinaryString name="Tags"></BinaryString>
							</Properties>
							<Item class="ModuleScript" referent="RBXB92EE270313F466D91148797D82DD690">
								<Properties>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<Content name="LinkedSource"><null></null></Content>
									<string name="Name">IDE_Stripped</string>
									<string name="ScriptGuid">{1E45190C-61FB-4573-B3F9-63488DE3BD8C}</string>
									<ProtectedString name="Source"><![CDATA[local IDEModule = {}

local TS = game:GetService("TextService")
local RS = game:GetService("RunService")
local Highlighter = require(script.HighlighterModule)

-- Weird Luau VM optimizations
local ipairs	= ipairs
local pairs		= pairs

function IDEModule.new(ParentFrame)

	local IDE = {Content = ""; OnCanvasSizeChanged = Instance.new "BindableEvent"}

	local TextSize = 16

	local Theme = settings().Studio.Theme

	local Scroller = Instance.new("ScrollingFrame")

	Scroller.Name						= "IDE"
	Scroller.BackgroundColor3			= Color3.fromRGB(34, 34, 34)
	Scroller.Size						= UDim2.new(1,0,1,0)
	Scroller.BorderSizePixel			= 0
	Scroller.BottomImage				= Scroller.MidImage
	Scroller.TopImage					= Scroller.MidImage
	Scroller.ScrollBarImageColor3		= Theme:GetColor(Enum.StudioStyleGuideColor.ScrollBar):Lerp(Color3.new(1,1,1),0.2)
	Scroller.ScrollBarThickness			= math.ceil(TextSize*0.75)
	Scroller.VerticalScrollBarInset		= Enum.ScrollBarInset.ScrollBar
	Scroller.HorizontalScrollBarInset	= Enum.ScrollBarInset.ScrollBar
	Scroller.CanvasSize                 = UDim2.new(0, 0, 0, 0)

	Scroller:GetPropertyChangedSignal("CanvasSize"):Connect(function()
		IDE.OnCanvasSizeChanged:Fire(Scroller.CanvasSize, Scroller.AbsoluteWindowSize)
	end)

	local Input = Instance.new("TextBox")

	Input.Name						= "Input"
	Input.BackgroundColor3			= Color3.fromRGB(27, 27, 27)
	Input.Size						= UDim2.new(1,-TextSize*3,1,0)
	Input.Position					= UDim2.new(0,TextSize*3,0,0)
	Input.MultiLine					= true
	Input.ClearTextOnFocus			= false
	Input.TextSize					= TextSize
	Input.Text						= ""
	Input.BorderSizePixel			= 0
	Input.Font						= Enum.Font.Code
	Input.TextColor3				= Theme:GetColor(Enum.StudioStyleGuideColor.ScriptText):Lerp(Scroller.BackgroundColor3, 0.3)
	Input.TextXAlignment			= Enum.TextXAlignment.Left
	Input.TextYAlignment			= Enum.TextYAlignment.Top
	Input.Active					= false

	Input.Parent = Scroller

	local Lines = Instance.new("Frame")

	Lines.Name						= "Lines"
	Lines.BackgroundTransparency	= 0.9
	Lines.BackgroundColor3			= Color3.new()
	Lines.Size						= UDim2.new(0,TextSize*2.5,1,0)
	Lines.BorderSizePixel			= 0

	local LinesLayout = Instance.new("UIListLayout")

	LinesLayout.SortOrder		= Enum.SortOrder.LayoutOrder

	LinesLayout.Parent = Lines

	local LineMarker = Instance.new("TextButton")

	LineMarker.Name						= "Line_1"
	LineMarker.BackgroundTransparency	= 1
	LineMarker.LayoutOrder				= 1
	LineMarker.TextSize					= TextSize
	LineMarker.Font						= Enum.Font.Code
	LineMarker.TextColor3				= Theme:GetColor(Enum.StudioStyleGuideColor.ScriptText)
	LineMarker.TextXAlignment			= Enum.TextXAlignment.Right
	LineMarker.Size						= UDim2.new(1,0,0,TextSize)
	LineMarker.Text						= "1 "

	LineMarker.MouseButton1Click:Connect(function()
		local Lines = string.split(Input.Text,"\n")

		Input.SelectionStart = 0
		Input.CursorPosition = #Lines[1]+1
	end)

	LineMarker.Parent = Lines

	Lines.Parent = Scroller

	-- fix for scrolling in a textbox
	-- unfortunately it has to deselect the text box to work
	-- roblox pls
	Input.InputChanged:Connect(function(inputObject)
		if inputObject.UserInputType == Enum.UserInputType.MouseWheel then
			Input:ReleaseFocus()
		end
	end)

	local PreviousLength = 0
	Input:GetPropertyChangedSignal("Text"):Connect(function()

		RS.Heartbeat:Wait() -- Let the changes process first.

		-- This disgusting mess normalizes the text to not be such a b*tch with control chars and broken tabs
		local Text = string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(Input.Text,"\0",""), "\a", ""), "\b", ""), "\v", ""), "\f", ""), "\r", "")
		local Text,TabChange = string.gsub(Text,"\t", "    ")
		local TotalLines = #string.split(Text, "\n")

		-- Handle retaining tab depth
		if #Text-PreviousLength == 1 then
			local AddedChar = string.sub(Text, Input.CursorPosition-1, Input.CursorPosition-1)
			if AddedChar == "\n" then
				local TextLines		= string.split(string.sub(Text,1,Input.CursorPosition-1), "\n")
				local PreviousLine	= TextLines[#TextLines-1] or ""
				local TabDepth		= string.match(PreviousLine, "^[\t ]+") or ""

				Input.Text = string.sub(Text,1,Input.CursorPosition-1)..TabDepth..string.sub(Text,Input.CursorPosition)

				Input.CursorPosition = Input.CursorPosition+#TabDepth
			end
		else
			Input.Text = Text
		end

		Input.CursorPosition = Input.CursorPosition+(TabChange*3)

		-- Handle line markers on the side
		local MarkedLines = Lines:GetChildren()

		if #MarkedLines-1<TotalLines then
			for i=#MarkedLines,TotalLines do
				local NewLineMarker = LineMarker:Clone()
				NewLineMarker.Name			= "Line_"..i
				NewLineMarker.LayoutOrder	= i
				NewLineMarker.Text			= tostring(i).." "

				NewLineMarker.MouseButton1Click:Connect(function()
					local Lines = string.split(Input.Text,"\n")

					local start = 0
					for l=1,i-1 do
						start = start+1+#Lines[l]
					end

					Input.SelectionStart = start
					Input.CursorPosition = start+#Lines[i]+1
				end)

				NewLineMarker.Parent = Lines	
			end
		elseif #MarkedLines-1>TotalLines then
			for i=TotalLines+2,#MarkedLines do
				MarkedLines[i]:Destroy()	
			end
		end

		-- Handle autosizing the scrollingframe
		local TextBounds = TS:GetTextSize(Text,TextSize,Input.Font, Vector2.new(99999,99999))
		Scroller.CanvasSize = UDim2.new(
			0,TextBounds.X+Input.Position.X.Offset+TextSize,
			0,TextBounds.Y+Scroller.AbsoluteWindowSize.Y-TextSize
		)

		PreviousLength = #Text
		IDE.Content = Input.Text

		Highlighter:Highlight(Input)
	end)

	Scroller.Parent = ParentFrame


	settings().Studio.ThemeChanged:Connect(function()
		Theme = settings().Studio.Theme

		Highlighter:ReloadColors(Input)

		Scroller.BackgroundColor3		= Theme:GetColor(Enum.StudioStyleGuideColor.ScriptBackground)
		Scroller.ScrollBarImageColor3	= Theme:GetColor(Enum.StudioStyleGuideColor.ScrollBar):Lerp(Color3.new(1,1,1),0.2)
		Input.TextColor3				= Theme:GetColor(Enum.StudioStyleGuideColor.ScriptPreprocessor):Lerp(Scroller.BackgroundColor3, 0.3)

		local TextColor = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptText)
		for _,LineMarker in pairs(Lines:GetChildren()) do
			if LineMarker:IsA("TextLabel") then
				LineMarker.TextColor3 = TextColor
			end
		end
	end)

	function IDE:SetContent(Content)
		Highlighter:ClearCache(Input)
		Input.Text = type(Content) == "string" and string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(Content,"\t", "    "), "\0",""), "\a", ""), "\b", ""), "\v", ""), "\f", ""), "\r", "") or Input.Text
	end

	function IDE:ReleaseFocus()
		Input:ReleaseFocus()
	end

	return IDE
end


return IDEModule
]]></ProtectedString>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
								</Properties>
								<Item class="ModuleScript" referent="RBXD34BD460A24445E89B0B3CFD42B35B72">
									<Properties>
										<BinaryString name="AttributesSerialize"></BinaryString>
										<Content name="LinkedSource"><null></null></Content>
										<string name="Name">HighlighterModule</string>
										<string name="ScriptGuid">{C67DFC05-7FAA-4568-BBA0-D1083873F5B8}</string>
										<ProtectedString name="Source"><![CDATA[--[=[

	Highlighter Module
	by boatbomber
	
	Handles Lua syntax highlighting on Roblox text objects
	
	-----------------------
	
	NOTICE: NOT DISTRIBUTED FREELY!
	YOU MUST OBTAIN WRITTEN PERMISSION FROM BOATBOMBER IN ORDER TO USE THIS MODULE IN ANY WORKS.
	ANYONE CAUGHT USING THIS WITHOUT PERMISSION WILL BE PROSECUTED TO THE FULLEST EXTENT OF THE LAW.
	
	-----------------------
	
	
	API:
	
	Module:Highlight(TextObject)
	
		Syntax highlights the text of the TextObject.
		Can be called multiple times, and it will reuse the TextLabels from previous highlights.
	
	Module:ContinuousHighlight(TextObject)
		
		Calls Module:Highlight(TextObject) whenever TextObject.Text is changed.
		Literally just a wrapper for the sake of cleanliness in your code.
	
	Module:ReloadColors(TextObject)
		
		Recolors the highlights in that TextObject to match the currently set colors.
		
	Module:ClearCache(TextObject)
	
		Clears data saved on that TextObject, and removes all highlighting.
	
--]=]

local Player	= game:GetService("Players").LocalPlayer

local RS		= game:GetService("RunService")

local Lexer			= require(script.Lexer)
local ObjectPool	= require(script.ObjectPool)

local ipairs	= ipairs

	
local TokenTemplate = Instance.new("TextLabel")
	TokenTemplate.Name = "Token"
	TokenTemplate.BackgroundTransparency = 1
	TokenTemplate.Font = Enum.Font.Code
	TokenTemplate.TextColor3 = Color3.new(1,1,1)
	TokenTemplate.TextXAlignment = Enum.TextXAlignment.Left
	TokenTemplate.TextYAlignment = Enum.TextYAlignment.Top

local TokenPool = ObjectPool.new(TokenTemplate,50)

local Theme = settings().Studio.Theme
local ScriptColors = {
	Number = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptNumber);
	String = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptString);
	Comment = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptComment);
	Text = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptText);
	Keyword = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptKeyword);
	Builtin = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptBuiltInFunction);
	Operator = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptOperator);
	Background = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptBackground);
}

local Module = {	
	Busy			= {};
	LastLex			= {};
	
	TokenToColor	= {
		['number']		= ScriptColors.Number;
		['string']		= ScriptColors.String;
		['comment']		= ScriptColors.Comment;
		['iden']		= ScriptColors.Text;
		['keyword']		= ScriptColors.Keyword;
		['builtin']		= ScriptColors.Builtin;
		['operator']	= ScriptColors.Operator;
	};
	
	ColorToToken	= {
		[tostring(ScriptColors.Number)]		= 'number';
		[tostring(ScriptColors.String)]		= 'string';
		[tostring(ScriptColors.Comment)]	= 'comment';
		[tostring(ScriptColors.Text)]		= 'iden';
		[tostring(ScriptColors.Keyword)]	= 'keyword';
		[tostring(ScriptColors.Builtin)]	= 'builtin';
		[tostring(ScriptColors.Operator)]	= 'operator';
	};
}

local Libraries = {
	math = {
		abs = true;		acos = true;	asin = true;	atan = true;
		atan2 = true;	ceil = true;	clamp = true;	cos = true;
		cosh = true;	deg = true;		exp = true;		floor = true;
		fmod = true;	frexp = true;	ldexp = true;	log = true;
		log10 = true;	max = true;		min = true;		modf = true;
		noise = true;	pow = true;		rad = true;		random = true;
		sinh = true;	sqrt = true;	tan = true;		tanh = true;
		sign = true;	sin = true;		randomseed = true;
		
		huge = true;	pi = true;
	};
	
	string = {
		byte = true;	char = true;	find = true;	format = true;
		gmatch = true;	gsub = true;	len = true;		lower = true;
		match = true;	rep = true;		reverse = true;	split = true;
		sub = true;		upper = true;
	};
	
	table = {
		concat = true;	foreach = true;	foreachi = true;getn = true;
		insert = true;	remove = true;	remove = true;	sort = true;
		pack = true;	unpack = true;	move = true;	create = true;
		find = true;
	};
	
	debug = {
		profilebegin = true;	profileend = true;	traceback = true
	};
	
	os = {
		time = true;	date = true;	difftime = true;
	};
	
	coroutine = {
		create = true;	isyieldable = true;	resume = true;	running = true;
		status = true;	wrap = true;	yield = true;
	};
}

function Module:Highlight(TextObject)
	
	-- If this TextObject is already being highlighted, the LastLex data is incomplete and
	-- we may end up doing duplicate work or worse, so we give them up to 50 Heartbeats to complete.
	-- Note that it'll almost certainly never be more than a couple beats, but we're cautious.
	if self.Busy[TextObject] then
		for i=1,50 do
			RS.Heartbeat:Wait()
			if not self.Busy[TextObject] then
				break
			end
		end
	end
	
	self.Busy[TextObject] = true
	
	--print("---------------") -- Divides debug prints so that we can tell what happened when
	
	-- Gather data for the TextObject
	local Source		= TextObject.Text
	local TextSize		= TextObject.TextSize
	local TextSizeX		= math.ceil(TextSize*0.5)
	local LineHeight	= TextSize*TextObject.LineHeight
	
	-- Init counters and indexes
	local CurrentLabel	= 0
	local CurrentLine	= 1
	local CurrentDepth	= 0
	local CurrentLex	= 0
	local ChangeFound	= false
	
	-- Find prior highlight data or create if none exists
	local LastLex = self.LastLex[TextObject]
	if LastLex == nil then
		self.LastLex[TextObject] = {}
		LastLex = self.LastLex[TextObject]
	end
	
	-- Iterate through the tokenized source text
	for token,src in Lexer.scan(Source) do
		--print(token,'"'..src..'"')
		CurrentLex = CurrentLex+1
		
		local TokenLines = string.split(src,"\n")		
		if (not ChangeFound) and (LastLex[CurrentLex]) and (LastLex[CurrentLex][1] == token and LastLex[CurrentLex][2] == src) then
			--print("   unchanged",CurrentLex)
			
			-- This token is the same as the last time we highlighted- therefore the label needs no update,
			-- but we do need to update our internal counters and indexes
			
			if string.find(src, "%S") then
				-- This token has text that would have used 1 or more labels, so update our
				-- label index so that we update the correct label when we do find the changes
				for i,LineSrc in ipairs(TokenLines) do
					if string.find(LineSrc,"%S") then
						CurrentLabel = CurrentLabel + 1
					end
				end
			end
			
			if #TokenLines>1 then
				-- There are multiple lines in this token, so update our position indexes
				CurrentLine = CurrentLine+#TokenLines-1
				CurrentDepth = 0
			end
			
			-- Push our depth to the length of the token's final line
			CurrentDepth = CurrentDepth+ #TokenLines[#TokenLines]
			
		else
			--print("   changed",CurrentLex,token)
			
			-- This token has either been changed or is after the changed token, so
			-- the label at this index needs to be updated
			
			-- Mark that the change has been found so further labels are updated
			ChangeFound = true
			-- Update our dictionary so it'll have up-to-date info for next time
			LastLex[CurrentLex] = {token,src}
			
			-- Iterate through the lines in this token and render appropriately
			for i,LineSrc in ipairs(TokenLines) do
				
				-- Update our position to the next line if this a new line
				if i>1 then
					CurrentLine = CurrentLine + 1
					CurrentDepth = 0
				end
				
				-- To avoid rendering any blank labels (which is wasteful) we check for non-whitespace first
				if string.find(LineSrc,"%S") then
					
					CurrentLabel = CurrentLabel + 1
					
					--print("  Rendering",CurrentLabel)
					
					-- Our tokenizer doesn't have backwards propagation so "math.random" doesn't highlight "random"
					-- and math.Random will highlight Random because Random.new() stuff. Therefore, we do our checks
					-- for these things in the highlighter scope. Note that at this point in the logic flow, changing
					-- our `token` value only changes the rendered color and no actual stored values are altered.
					
					if CurrentLex>2 then -- If we're not at least 3 tokens deep, there's no way we have math.X here
						local BackLex = CurrentLex-1
						
						-- Find previous non-whitespace token
						while LastLex[BackLex] and LastLex[BackLex][1] == "space" do
							BackLex = BackLex-1
						end
						
						-- If the previous tokens were `LIB.`				
						if LastLex[BackLex] and LastLex[BackLex][2] == "." then
							local LibraryChildren = Libraries[LastLex[BackLex-1] and LastLex[BackLex-1][2]]
							if LibraryChildren then
								-- This can't be a builtin without space
								if token == "builtin" and BackLex==CurrentLex-1 then
									token = "iden"
								elseif token == "iden" then
									if LibraryChildren[src] then
										token = "builtin"
									end
								end
							end
						end
						
					end
					
					
					local TokenGui = TextObject:FindFirstChild(CurrentLabel) or TokenPool:Get()
						TokenGui.Name			= CurrentLabel
						TokenGui.LayoutOrder	= CurrentLabel
						TokenGui.Text			= LineSrc
						TokenGui.TextSize		= TextSize
						TokenGui.Size			= UDim2.new(0,TextSizeX*#LineSrc,0,TextSize)
						TokenGui.Position		= UDim2.new(0,CurrentDepth*TextSizeX,0,LineHeight*(CurrentLine-1))
						
						local Color = self.TokenToColor[token] or self.TokenToColor.operator
						if TokenGui.TextColor3 ~= Color then
							TokenGui.TextColor3	= Color
						end
					
					TokenGui.Parent = TextObject
				end
				
				-- Push the depth by the length of what we've just processed
				CurrentDepth = CurrentDepth + #LineSrc
			end
			
		end
		
	end
	
	-- Clear unused old tokens
	for i = CurrentLex+1, #LastLex do
		LastLex[i] = nil
	end
	
	-- Clear unused old labels
	for _,t in ipairs(TextObject:GetChildren()) do
		if t.LayoutOrder>CurrentLabel then
			TokenPool:Return(t)
		end
	end
	
	
	self.Busy[TextObject] = nil
end

function Module:ContinuousHighlight(TextObject)
	
	--Initial
	Module:Highlight(TextObject)
	
	-- Dynamic
	TextObject:GetPropertyChangedSignal("Text"):Connect(function()
		Module:Highlight(TextObject)
	end)
	
end

function Module:ClearCache(TextObject)
	
	-- This function is mostly used for debugging, but also used when you're
	-- setting your TextObject to a new content and want a clean slate for it
	
	if self.Busy[TextObject] then
		for i=1,50 do
			RS.Heartbeat:Wait()
			if not self.Busy[TextObject] then
				break
			end
		end
	end
	
	self.Busy[TextObject] = true
	
	self.LastLex[TextObject] = {}
	-- Clear old tokens
	for _,t in ipairs(TextObject:GetChildren()) do
		TokenPool:Return(t)
	end
	
	self.Busy[TextObject] = false
end

function Module:ReloadColors(TextObject)
	
	Theme = settings().Studio.Theme
	ScriptColors = {
		Number = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptNumber);
		String = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptString);
		Comment = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptComment);
		Text = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptText);
		Keyword = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptKeyword);
		Builtin = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptBuiltInFunction);
		Operator = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptOperator);
		Background = Theme:GetColor(Enum.StudioStyleGuideColor.ScriptBackground);
	}
	
	Module.TokenToColor	= {
		['number']		= ScriptColors.Number;
		['string']		= ScriptColors.String;
		['comment']		= ScriptColors.Comment;
		['iden']		= ScriptColors.Text;
		['keyword']		= ScriptColors.Keyword;
		['builtin']		= ScriptColors.Builtin;
		['operator']	= ScriptColors.Operator;
	};
	Module.ColorToToken	= {
		[tostring(ScriptColors.Number)]		= 'number';
		[tostring(ScriptColors.String)]		= 'string';
		[tostring(ScriptColors.Comment)]	= 'comment';
		[tostring(ScriptColors.Text)]		= 'iden';
		[tostring(ScriptColors.Keyword)]	= 'keyword';
		[tostring(ScriptColors.Builtin)]	= 'builtin';
		[tostring(ScriptColors.Operator)]	= 'operator';
	};
	
	TextObject.BackgroundColor3 = ScriptColors.Background
	
	for i,c in ipairs(TextObject:GetChildren()) do
		c.TextColor3 = Module.TokenToColor[Module.ColorToToken[tostring(c.TextColor3)]] or Module.TokenToColor.iden
	end
	
end

return Module]]></ProtectedString>
										<int64 name="SourceAssetId">-1</int64>
										<BinaryString name="Tags"></BinaryString>
									</Properties>
									<Item class="ModuleScript" referent="RBX888CC71349B34EADBEA2CF72539F87BF">
										<Properties>
											<BinaryString name="AttributesSerialize"></BinaryString>
											<Content name="LinkedSource"><null></null></Content>
											<string name="Name">Lexer</string>
											<string name="ScriptGuid">{A2DACD7A-9400-4C91-92A6-5560EFC78909}</string>
											<ProtectedString name="Source"><![CDATA[--[[
	Lexical scanner for creating a sequence of tokens from Lua source code.
	This is a heavily modified and Roblox-optimized version of
	the original Penlight Lexer module:
		https://github.com/stevedonovan/Penlight
	Authors:
		stevedonovan <https://github.com/stevedonovan> ----------------- Original Penlight lexer author
		ryanjmulder <https://github.com/ryanjmulder> ----------------- Penlight lexer contributer
		mpeterv <https://github.com/mpeterv> ----------------- Penlight lexer contributer
		Tieske <https://github.com/Tieske> ----------------- Penlight lexer contributer
		boatbomber <https://github.com/boatbomber> ----------------- Roblox port, added builtin token, added patterns for incomplete strings and comments, bug fixes
		Sleitnick <https://github.com/Sleitnick> ----------------- Roblox optimizations
		howmanysmall <https://github.com/howmanysmall> ----------------- Lua + Roblox optimizations
	 
	Usage:
		local source = "for i = 1,n do end"
		
		-- The 'scan' function returns a token iterator:
		for token,src in lexer.scan(source) do
			print(token, src)
		end
			> keyword for
			> iden i
			> = =
			> number 1
			> , ,
			> iden n
			> keyword do
			> keyword end
	List of tokens:
		- keyword
		- builtin
		- iden
		- string
		- number
		- space
		- comment
	Other tokens that don't fall into the above categories
	will simply be returned as itself. For instance, operators
	like "+" will simply return "+" as the token.
--]]

local lexer = {}

local ipairs = ipairs

local NUMBER_A = "^0x[%da-fA-F]+"
local NUMBER_B = "^%d+%.?%d*[eE][%+%-]?%d+"
local NUMBER_C = "^%d+[%._]?[%d_]*"
local IDEN = "^[%a_][%w_]*"
local WSPACE = "^[ \t]+"
local STRING_EMPTY = "^(['\"])%1"							--Empty String
local STRING_PLAIN = [=[^(['"])[%w%p \t\v\b\f\r\a]-([^%\]%1)]=]	--TODO: Handle escaping escapes
local STRING_INCOMP_A = "^(['\"]).-\n"						--Incompleted String with next line
local STRING_INCOMP_B = "^(['\"])[^\n]*"					--Incompleted String without next line
local STRING_MULTI = "^%[(=*)%[.-%]%1%]"					--Multiline-String
local STRING_MULTI_INCOMP = "^%[%[.-.*"						--Incompleted Multiline-String
local COMMENT_MULTI = "^%-%-%[(=*)%[.-%]%1%]"				--Completed Multiline-Comment
local COMMENT_MULTI_INCOMP = "^%-%-%[%[.-.*"				--Incompleted Multiline-Comment
local COMMENT_PLAIN = "^%-%-.-\n"							--Completed Singleline-Comment
local COMMENT_INCOMP = "^%-%-.*"							--Incompleted Singleline-Comment

local TABLE_EMPTY = {}

local lua_keyword = {
	["and"] = true, ["break"] = true, ["do"] = true, ["else"] = true, ["elseif"] = true,
	["end"] = true, ["false"] = true, ["for"] = true, ["function"] = true, ["if"] = true,
	["in"] = true, ["local"] = true, ["nil"] = true, ["not"] = true, ["while"] = true,
	["or"] = true, ["repeat"] = true, ["return"] = true, ["then"] = true, ["true"] = true,
	["self"] = true, ["until"] = true,
	
	["continue"] = true, -- Roblox supports but doesn't highlight yet? I'm highlighting. Fight me.
	
	["plugin"] = true, --Highlights as a keyword instead of a builtin cuz Roblox is weird
}


local lua_builtin = {
	-- Lua Functions
	["assert"] = true;["collectgarbage"] = true;["error"] = true;["getfenv"] = true;
	["getmetatable"] = true;["ipairs"] = true;["loadstring"] = true;["newproxy"] = true;
	["next"] = true;["pairs"] = true;["pcall"] = true;["print"] = true;["rawequal"] = true;
	["rawget"] = true;["rawset"] = true;["select"] = true;["setfenv"] = true;["setmetatable"] = true;
	["tonumber"] = true;["tostring"] = true;["type"] = true;["unpack"] = true;["xpcall"] = true;

	-- Lua Variables
	["_G"] = true;["_VERSION"] = true;

	-- Lua Tables
	["bit32"] = true;["coroutine"] = true;["debug"] = true;
	["math"] = true;["os"] = true;["string"] = true;
	["table"] = true;["utf8"] = true;

	-- Roblox Functions
	["delay"] = true;["elapsedTime"] = true;["gcinfo"] = true;["require"] = true;
	["settings"] = true;["spawn"] = true;["tick"] = true;["time"] = true;["typeof"] = true;
	["UserSettings"] = true;["wait"] = true;["warn"] = true;["ypcall"] = true;

	-- Roblox Variables
	["Enum"] = true;["game"] = true;["shared"] = true;["script"] = true;
	["workspace"] = true;

	-- Roblox Tables
	["Axes"] = true;["BrickColor"] = true;["CellId"] = true;["CFrame"] = true;["Color3"] = true;
	["ColorSequence"] = true;["ColorSequenceKeypoint"] = true;["DateTime"] = true;
	["DockWidgetPluginGuiInfo"] = true;["Faces"] = true;["Instance"] = true;["NumberRange"] = true;
	["NumberSequence"] = true;["NumberSequenceKeypoint"] = true;["PathWaypoint"] = true;
	["PhysicalProperties"] = true;["PluginDrag"] = true;["Random"] = true;["Ray"] = true;["Rect"] = true;
	["Region3"] = true;["Region3int16"] = true;["TweenInfo"] = true;["UDim"] = true;["UDim2"] = true;
	["Vector2"] = true;["Vector2int16"] = true;["Vector3"] = true;["Vector3int16"] = true;
}

local function tdump(tok)
	return coroutine.yield(tok, tok)
end

local function ndump(tok)
	return coroutine.yield("number", tok)
end

local function sdump(tok)
	return coroutine.yield("string", tok)
end

local function cdump(tok)
	return coroutine.yield("comment", tok)
end

local function wsdump(tok)
	return coroutine.yield("space", tok)
end

local function lua_vdump(tok)
	if lua_keyword[tok] then
		return coroutine.yield("keyword", tok)
	elseif lua_builtin[tok] then
		return coroutine.yield("builtin", tok)
	else
		return coroutine.yield("iden", tok)
	end
end

local lua_matches = {
	-- Indentifiers
	{IDEN, lua_vdump},
	
	 -- Whitespace
	{WSPACE, wsdump},
	
	-- Numbers
	{NUMBER_A, ndump},
	{NUMBER_B, ndump},
	{NUMBER_C, ndump},
	
	-- Strings
	{STRING_EMPTY, sdump},
	{STRING_PLAIN, sdump},
	{STRING_INCOMP_A, sdump},
	{STRING_INCOMP_B, sdump},
	{STRING_MULTI, sdump},
	{STRING_MULTI_INCOMP, sdump},
	
	-- Comments
	{COMMENT_MULTI, cdump},			
	{COMMENT_MULTI_INCOMP, cdump},
	{COMMENT_PLAIN, cdump},
	{COMMENT_INCOMP, cdump},
	
	-- Operators
	{"^==", tdump},
	{"^~=", tdump},
	{"^<=", tdump},
	{"^>=", tdump},
	{"^%.%.%.", tdump},
	{"^%.%.", tdump},
	{"^.", tdump}
}

--- Create a plain token iterator from a string.
-- @tparam string s a string.	
	
function lexer.scan(s)
	local function lex(first_arg)
		local line_nr = 0
		local sz = #s
		local idx = 1
		
		-- res is the value used to resume the coroutine.
		local function handle_requests(res)
			while res do
				local tp = type(res)
				-- Insert a token list:
				if tp == "table" then
					res = coroutine.yield("", "")
					for _, t in ipairs(res) do
						res = coroutine.yield(t[1], t[2])
					end
				elseif tp == "string" then -- Or search up to some special pattern:
					local i1, i2 = string.find(s, res, idx)
					if i1 then
						idx = i2 + 1
						res = coroutine.yield("", string.sub(s, i1, i2))
					else
						res = coroutine.yield("", "")
						idx = sz + 1
					end
				else
					res = coroutine.yield(line_nr, idx)
				end
			end
		end
		
		handle_requests(first_arg)
		line_nr = 1
		
		while true do
			if idx > sz then
				while true do
					handle_requests(coroutine.yield())
				end
			end
			for _, m in ipairs(lua_matches) do
				local findres = table.create(2)
				local i1, i2 = string.find(s, m[1], idx)
				findres[1], findres[2] = i1, i2
				if i1 then
					local tok = string.sub(s, i1, i2)
					idx = i2 + 1
					lexer.finished = idx > sz
					
					local res = m[2](tok, findres)
					
					if string.find(tok, "\n") then
						-- Update line number:
						local _, newlines = string.gsub(tok, "\n", TABLE_EMPTY)
						line_nr = line_nr + newlines
					end
					
					handle_requests(res)
					break
				end
			end
		end
	end
	return coroutine.wrap(lex)
end

return lexer]]></ProtectedString>
											<int64 name="SourceAssetId">-1</int64>
											<BinaryString name="Tags"></BinaryString>
										</Properties>
									</Item>
									<Item class="ModuleScript" referent="RBX334B632A1E954F6E9720D12659094D34">
										<Properties>
											<BinaryString name="AttributesSerialize"></BinaryString>
											<Content name="LinkedSource"><null></null></Content>
											<string name="Name">ObjectPool</string>
											<string name="ScriptGuid">{D62274CC-3E99-43CF-9AE8-3F18CC75C784}</string>
											<ProtectedString name="Source"><![CDATA[local ObjectPool = {}

function ObjectPool.new(Object, InitialAmount)
	
	local Pool = {
		Object		= Object;
		Available	= {};
	}
	
	for i=1, InitialAmount or 1 do
		Pool.Available[i] = Object:Clone()
	end
	
	function Pool:Get()
		
		local o = self.Available[1]
		if o then
			table.remove(self.Available,1)
			
			--print("get: pool")
			return o
		else
			
			--print("get: new")
			return self.Object:Clone()
		end
		
	end
	
	function Pool:Return(o)
		--print("return")
		
		o.Parent = nil
		self.Available[#self.Available+1] = o
	end
	
	
	return Pool
	
end

return ObjectPool
]]></ProtectedString>
											<int64 name="SourceAssetId">-1</int64>
											<BinaryString name="Tags"></BinaryString>
										</Properties>
									</Item>
								</Item>
							</Item>
						</Item>
					</Item>
				</Item>
				<Item class="UIPageLayout" referent="RBX1FCC029DE92F4E168A3723A9B0AF2A47">
					<Properties>
						<bool name="Animated">true</bool>
						<BinaryString name="AttributesSerialize"></BinaryString>
						<bool name="Circular">false</bool>
						<token name="EasingDirection">1</token>
						<token name="EasingStyle">4</token>
						<token name="FillDirection">0</token>
						<bool name="GamepadInputEnabled">false</bool>
						<token name="HorizontalAlignment">0</token>
						<string name="Name">UIPageLayout</string>
						<UDim name="Padding">
							<S>0</S>
							<O>0</O>
						</UDim>
						<bool name="ScrollWheelInputEnabled">true</bool>
						<token name="SortOrder">2</token>
						<int64 name="SourceAssetId">-1</int64>
						<BinaryString name="Tags"></BinaryString>
						<bool name="TouchInputEnabled">false</bool>
						<float name="TweenTime">1</float>
						<token name="VerticalAlignment">1</token>
					</Properties>
				</Item>
				<Item class="Frame" referent="RBXF82AD14452DA430096ACFAF21EBF8A9A">
					<Properties>
						<bool name="Active">false</bool>
						<Vector2 name="AnchorPoint">
							<X>0</X>
							<Y>0</Y>
						</Vector2>
						<BinaryString name="AttributesSerialize"></BinaryString>
						<bool name="AutoLocalize">true</bool>
						<token name="AutomaticSize">0</token>
						<Color3 name="BackgroundColor3">
							<R>1</R>
							<G>1</G>
							<B>1</B>
						</Color3>
						<float name="BackgroundTransparency">1</float>
						<Color3 name="BorderColor3">
							<R>0.105882362</R>
							<G>0.164705887</G>
							<B>0.207843155</B>
						</Color3>
						<token name="BorderMode">0</token>
						<int name="BorderSizePixel">1</int>
						<bool name="ClipsDescendants">false</bool>
						<bool name="Draggable">false</bool>
						<int name="LayoutOrder">0</int>
						<string name="Name">UtilityPage</string>
						<Ref name="NextSelectionDown">null</Ref>
						<Ref name="NextSelectionLeft">null</Ref>
						<Ref name="NextSelectionRight">null</Ref>
						<Ref name="NextSelectionUp">null</Ref>
						<UDim2 name="Position">
							<XS>0</XS>
							<XO>0</XO>
							<YS>0.109289616</YS>
							<YO>0</YO>
						</UDim2>
						<Ref name="RootLocalizationTable">null</Ref>
						<float name="Rotation">0</float>
						<bool name="Selectable">false</bool>
						<token name="SelectionBehaviorDown">0</token>
						<token name="SelectionBehaviorLeft">0</token>
						<token name="SelectionBehaviorRight">0</token>
						<token name="SelectionBehaviorUp">0</token>
						<bool name="SelectionGroup">false</bool>
						<Ref name="SelectionImageObject">null</Ref>
						<int name="SelectionOrder">0</int>
						<UDim2 name="Size">
							<XS>1</XS>
							<XO>0</XO>
							<YS>1</YS>
							<YO>0</YO>
						</UDim2>
						<token name="SizeConstraint">0</token>
						<int64 name="SourceAssetId">-1</int64>
						<token name="Style">0</token>
						<BinaryString name="Tags"></BinaryString>
						<bool name="Visible">true</bool>
						<int name="ZIndex">1</int>
					</Properties>
					<Item class="StringValue" referent="RBXB8F0FA18519B40C6AE5E7CF88EEC43E7">
						<Properties>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<string name="Name">PageNa</string>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
							<string name="Value">UtilityButton</string>
						</Properties>
					</Item>
					<Item class="Frame" referent="RBX757937C1B46349798B4065A9C3F13A4F">
						<Properties>
							<bool name="Active">false</bool>
							<Vector2 name="AnchorPoint">
								<X>0</X>
								<Y>0</Y>
							</Vector2>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<bool name="AutoLocalize">true</bool>
							<token name="AutomaticSize">0</token>
							<Color3 name="BackgroundColor3">
								<R>1</R>
								<G>1</G>
								<B>1</B>
							</Color3>
							<float name="BackgroundTransparency">1</float>
							<Color3 name="BorderColor3">
								<R>0.105882362</R>
								<G>0.164705887</G>
								<B>0.207843155</B>
							</Color3>
							<token name="BorderMode">0</token>
							<int name="BorderSizePixel">0</int>
							<bool name="ClipsDescendants">false</bool>
							<bool name="Draggable">false</bool>
							<int name="LayoutOrder">0</int>
							<string name="Name">List</string>
							<Ref name="NextSelectionDown">null</Ref>
							<Ref name="NextSelectionLeft">null</Ref>
							<Ref name="NextSelectionRight">null</Ref>
							<Ref name="NextSelectionUp">null</Ref>
							<UDim2 name="Position">
								<XS>0.0314278863</XS>
								<XO>0</XO>
								<YS>0.0267415904</YS>
								<YO>0</YO>
							</UDim2>
							<Ref name="RootLocalizationTable">null</Ref>
							<float name="Rotation">0</float>
							<bool name="Selectable">false</bool>
							<token name="SelectionBehaviorDown">0</token>
							<token name="SelectionBehaviorLeft">0</token>
							<token name="SelectionBehaviorRight">0</token>
							<token name="SelectionBehaviorUp">0</token>
							<bool name="SelectionGroup">false</bool>
							<Ref name="SelectionImageObject">null</Ref>
							<int name="SelectionOrder">0</int>
							<UDim2 name="Size">
								<XS>0.948516607</XS>
								<XO>0</XO>
								<YS>0.937810242</YS>
								<YO>0</YO>
							</UDim2>
							<token name="SizeConstraint">0</token>
							<int64 name="SourceAssetId">-1</int64>
							<token name="Style">0</token>
							<BinaryString name="Tags"></BinaryString>
							<bool name="Visible">true</bool>
							<int name="ZIndex">1</int>
						</Properties>
						<Item class="UIListLayout" referent="RBX9A4EF38F0FBD4CC8BC3D7DEAFD32025C">
							<Properties>
								<BinaryString name="AttributesSerialize"></BinaryString>
								<token name="FillDirection">1</token>
								<token name="HorizontalAlignment">1</token>
								<string name="Name">UIListLayout</string>
								<UDim name="Padding">
									<S>0</S>
									<O>0</O>
								</UDim>
								<token name="SortOrder">2</token>
								<int64 name="SourceAssetId">-1</int64>
								<BinaryString name="Tags"></BinaryString>
								<token name="VerticalAlignment">1</token>
							</Properties>
						</Item>
						<Item class="TextButton" referent="RBXBDDD4F8EBC304C859626EBDB13B4DD5F">
							<Properties>
								<bool name="Active">true</bool>
								<Vector2 name="AnchorPoint">
									<X>0</X>
									<Y>0</Y>
								</Vector2>
								<BinaryString name="AttributesSerialize"></BinaryString>
								<bool name="AutoButtonColor">false</bool>
								<bool name="AutoLocalize">true</bool>
								<token name="AutomaticSize">0</token>
								<Color3 name="BackgroundColor3">
									<R>0.105882362</R>
									<G>0.105882362</G>
									<B>0.105882362</B>
								</Color3>
								<float name="BackgroundTransparency">0</float>
								<Color3 name="BorderColor3">
									<R>0.105882362</R>
									<G>0.164705887</G>
									<B>0.207843155</B>
								</Color3>
								<token name="BorderMode">0</token>
								<int name="BorderSizePixel">1</int>
								<bool name="ClipsDescendants">false</bool>
								<bool name="Draggable">false</bool>
								<token name="Font">18</token>
								<Font name="FontFace">
									<Family><url>rbxasset://fonts/families/GothamSSm.json</url></Family>
									<Weight>500</Weight>
									<Style>Normal</Style>
									<CachedFaceId><url>rbxasset://fonts/GothamSSm-Medium.otf</url></CachedFaceId>
								</Font>
								<int name="LayoutOrder">0</int>
								<float name="LineHeight">1</float>
								<int name="MaxVisibleGraphemes">-1</int>
								<bool name="Modal">false</bool>
								<string name="Name">GuiToluaConvertButton</string>
								<Ref name="NextSelectionDown">null</Ref>
								<Ref name="NextSelectionLeft">null</Ref>
								<Ref name="NextSelectionRight">null</Ref>
								<Ref name="NextSelectionUp">null</Ref>
								<UDim2 name="Position">
									<XS>0.0288248342</XS>
									<XO>0</XO>
									<YS>0.901490867</YS>
									<YO>0</YO>
								</UDim2>
								<bool name="RichText">false</bool>
								<Ref name="RootLocalizationTable">null</Ref>
								<float name="Rotation">0</float>
								<bool name="Selectable">true</bool>
								<bool name="Selected">false</bool>
								<token name="SelectionBehaviorDown">0</token>
								<token name="SelectionBehaviorLeft">0</token>
								<token name="SelectionBehaviorRight">0</token>
								<token name="SelectionBehaviorUp">0</token>
								<bool name="SelectionGroup">false</bool>
								<Ref name="SelectionImageObject">null</Ref>
								<int name="SelectionOrder">0</int>
								<UDim2 name="Size">
									<XS>1</XS>
									<XO>0</XO>
									<YS>0.100000001</YS>
									<YO>0</YO>
								</UDim2>
								<token name="SizeConstraint">0</token>
								<int64 name="SourceAssetId">-1</int64>
								<token name="Style">0</token>
								<BinaryString name="Tags"></BinaryString>
								<string name="Text">Convert ui to lua</string>
								<Color3 name="TextColor3">
									<R>0.619607866</R>
									<G>0.619607866</G>
									<B>0.619607866</B>
								</Color3>
								<bool name="TextScaled">false</bool>
								<float name="TextSize">14</float>
								<Color3 name="TextStrokeColor3">
									<R>0</R>
									<G>0</G>
									<B>0</B>
								</Color3>
								<float name="TextStrokeTransparency">1</float>
								<float name="TextTransparency">0</float>
								<token name="TextTruncate">0</token>
								<bool name="TextWrapped">false</bool>
								<token name="TextXAlignment">2</token>
								<token name="TextYAlignment">1</token>
								<bool name="Visible">true</bool>
								<int name="ZIndex">1</int>
							</Properties>
							<Item class="UICorner" referent="RBX5C987CC0D6D5407DA95F6B4626E582C5">
								<Properties>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<UDim name="CornerRadius">
										<S>0</S>
										<O>5</O>
									</UDim>
									<string name="Name">Corner</string>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
								</Properties>
							</Item>
							<Item class="UIStroke" referent="RBXB386580FF4EC4A1C9F7264CE9B69C278">
								<Properties>
									<token name="ApplyStrokeMode">1</token>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<Color3 name="Color">
										<R>0.152941182</R>
										<G>0.152941182</G>
										<B>0.152941182</B>
									</Color3>
									<bool name="Enabled">true</bool>
									<token name="LineJoinMode">0</token>
									<string name="Name">Stroke</string>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
									<float name="Thickness">1</float>
									<float name="Transparency">0</float>
								</Properties>
							</Item>
							<Item class="ImageButton" referent="RBXFF42CCF275504EC98E596659FEF54E44">
								<Properties>
									<bool name="Active">true</bool>
									<Vector2 name="AnchorPoint">
										<X>0</X>
										<Y>0</Y>
									</Vector2>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<bool name="AutoButtonColor">true</bool>
									<bool name="AutoLocalize">true</bool>
									<token name="AutomaticSize">0</token>
									<Color3 name="BackgroundColor3">
										<R>0.639215708</R>
										<G>0.635294139</G>
										<B>0.647058845</B>
									</Color3>
									<float name="BackgroundTransparency">1</float>
									<Color3 name="BorderColor3">
										<R>0.105882362</R>
										<G>0.164705887</G>
										<B>0.207843155</B>
									</Color3>
									<token name="BorderMode">0</token>
									<int name="BorderSizePixel">1</int>
									<bool name="ClipsDescendants">false</bool>
									<bool name="Draggable">false</bool>
									<Content name="HoverImage"><null></null></Content>
									<Content name="Image"><url>rbxassetid://3926305904</url></Content>
									<Color3 name="ImageColor3">
										<R>0.619607866</R>
										<G>0.619607866</G>
										<B>0.619607866</B>
									</Color3>
									<Vector2 name="ImageRectOffset">
										<X>364</X>
										<Y>524</Y>
									</Vector2>
									<Vector2 name="ImageRectSize">
										<X>36</X>
										<Y>36</Y>
									</Vector2>
									<float name="ImageTransparency">0</float>
									<int name="LayoutOrder">23</int>
									<bool name="Modal">false</bool>
									<string name="Name">Icon</string>
									<Ref name="NextSelectionDown">null</Ref>
									<Ref name="NextSelectionLeft">null</Ref>
									<Ref name="NextSelectionRight">null</Ref>
									<Ref name="NextSelectionUp">null</Ref>
									<UDim2 name="Position">
										<XS>0</XS>
										<XO>0</XO>
										<YS>-1.45877522e-07</YS>
										<YO>0</YO>
									</UDim2>
									<Content name="PressedImage"><null></null></Content>
									<token name="ResampleMode">0</token>
									<Ref name="RootLocalizationTable">null</Ref>
									<float name="Rotation">0</float>
									<token name="ScaleType">3</token>
									<bool name="Selectable">true</bool>
									<bool name="Selected">false</bool>
									<token name="SelectionBehaviorDown">0</token>
									<token name="SelectionBehaviorLeft">0</token>
									<token name="SelectionBehaviorRight">0</token>
									<token name="SelectionBehaviorUp">0</token>
									<bool name="SelectionGroup">false</bool>
									<Ref name="SelectionImageObject">null</Ref>
									<int name="SelectionOrder">0</int>
									<UDim2 name="Size">
										<XS>0.0436817147</XS>
										<XO>0</XO>
										<YS>0.899999917</YS>
										<YO>0</YO>
									</UDim2>
									<token name="SizeConstraint">0</token>
									<Rect2D name="SliceCenter">
										<min>
											<X>0</X>
											<Y>0</Y>
										</min>
										<max>
											<X>0</X>
											<Y>0</Y>
										</max>
									</Rect2D>
									<float name="SliceScale">1</float>
									<int64 name="SourceAssetId">-1</int64>
									<token name="Style">0</token>
									<BinaryString name="Tags"></BinaryString>
									<UDim2 name="TileSize">
										<XS>1</XS>
										<XO>0</XO>
										<YS>1</YS>
										<YO>0</YO>
									</UDim2>
									<bool name="Visible">true</bool>
									<int name="ZIndex">2</int>
								</Properties>
								<Item class="UIAspectRatioConstraint" referent="RBX2BF52CD03B0E47ADB0BD40C15FDD4597">
									<Properties>
										<float name="AspectRatio">1.00875354</float>
										<token name="AspectType">0</token>
										<BinaryString name="AttributesSerialize"></BinaryString>
										<token name="DominantAxis">0</token>
										<string name="Name">UIAspectRatioConstraint</string>
										<int64 name="SourceAssetId">-1</int64>
										<BinaryString name="Tags"></BinaryString>
									</Properties>
								</Item>
							</Item>
							<Item class="UIAspectRatioConstraint" referent="RBX69C6348BF80E455A9C61C05923D85DFE">
								<Properties>
									<float name="AspectRatio">20.7839394</float>
									<token name="AspectType">1</token>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<token name="DominantAxis">1</token>
									<string name="Name">UIAspectRatioConstraint</string>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
								</Properties>
							</Item>
						</Item>
					</Item>
				</Item>
				<Item class="Frame" referent="RBXBE6507C905EB412789DFF4F9CFD6C606">
					<Properties>
						<bool name="Active">false</bool>
						<Vector2 name="AnchorPoint">
							<X>0</X>
							<Y>0</Y>
						</Vector2>
						<BinaryString name="AttributesSerialize"></BinaryString>
						<bool name="AutoLocalize">true</bool>
						<token name="AutomaticSize">0</token>
						<Color3 name="BackgroundColor3">
							<R>1</R>
							<G>1</G>
							<B>1</B>
						</Color3>
						<float name="BackgroundTransparency">1</float>
						<Color3 name="BorderColor3">
							<R>0.105882362</R>
							<G>0.164705887</G>
							<B>0.207843155</B>
						</Color3>
						<token name="BorderMode">0</token>
						<int name="BorderSizePixel">1</int>
						<bool name="ClipsDescendants">false</bool>
						<bool name="Draggable">false</bool>
						<int name="LayoutOrder">0</int>
						<string name="Name">SettingsPage</string>
						<Ref name="NextSelectionDown">null</Ref>
						<Ref name="NextSelectionLeft">null</Ref>
						<Ref name="NextSelectionRight">null</Ref>
						<Ref name="NextSelectionUp">null</Ref>
						<UDim2 name="Position">
							<XS>0</XS>
							<XO>0</XO>
							<YS>0.109289616</YS>
							<YO>0</YO>
						</UDim2>
						<Ref name="RootLocalizationTable">null</Ref>
						<float name="Rotation">0</float>
						<bool name="Selectable">false</bool>
						<token name="SelectionBehaviorDown">0</token>
						<token name="SelectionBehaviorLeft">0</token>
						<token name="SelectionBehaviorRight">0</token>
						<token name="SelectionBehaviorUp">0</token>
						<bool name="SelectionGroup">false</bool>
						<Ref name="SelectionImageObject">null</Ref>
						<int name="SelectionOrder">0</int>
						<UDim2 name="Size">
							<XS>1</XS>
							<XO>0</XO>
							<YS>1</YS>
							<YO>0</YO>
						</UDim2>
						<token name="SizeConstraint">0</token>
						<int64 name="SourceAssetId">-1</int64>
						<token name="Style">0</token>
						<BinaryString name="Tags"></BinaryString>
						<bool name="Visible">true</bool>
						<int name="ZIndex">1</int>
					</Properties>
					<Item class="StringValue" referent="RBXF8A53CB095404A23A4F018DB1A155ABB">
						<Properties>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<string name="Name">PageNa</string>
							<int64 name="SourceAssetId">-1</int64>
							<BinaryString name="Tags"></BinaryString>
							<string name="Value">SettingsButton</string>
						</Properties>
					</Item>
					<Item class="Frame" referent="RBXA0DC7A9D395D43AFAD8317EE8B19A68F">
						<Properties>
							<bool name="Active">false</bool>
							<Vector2 name="AnchorPoint">
								<X>0</X>
								<Y>0</Y>
							</Vector2>
							<BinaryString name="AttributesSerialize"></BinaryString>
							<bool name="AutoLocalize">true</bool>
							<token name="AutomaticSize">0</token>
							<Color3 name="BackgroundColor3">
								<R>1</R>
								<G>1</G>
								<B>1</B>
							</Color3>
							<float name="BackgroundTransparency">1</float>
							<Color3 name="BorderColor3">
								<R>0.105882362</R>
								<G>0.164705887</G>
								<B>0.207843155</B>
							</Color3>
							<token name="BorderMode">0</token>
							<int name="BorderSizePixel">0</int>
							<bool name="ClipsDescendants">false</bool>
							<bool name="Draggable">false</bool>
							<int name="LayoutOrder">0</int>
							<string name="Name">List</string>
							<Ref name="NextSelectionDown">null</Ref>
							<Ref name="NextSelectionLeft">null</Ref>
							<Ref name="NextSelectionRight">null</Ref>
							<Ref name="NextSelectionUp">null</Ref>
							<UDim2 name="Position">
								<XS>0.0314278863</XS>
								<XO>0</XO>
								<YS>0.0267415904</YS>
								<YO>0</YO>
							</UDim2>
							<Ref name="RootLocalizationTable">null</Ref>
							<float name="Rotation">0</float>
							<bool name="Selectable">false</bool>
							<token name="SelectionBehaviorDown">0</token>
							<token name="SelectionBehaviorLeft">0</token>
							<token name="SelectionBehaviorRight">0</token>
							<token name="SelectionBehaviorUp">0</token>
							<bool name="SelectionGroup">false</bool>
							<Ref name="SelectionImageObject">null</Ref>
							<int name="SelectionOrder">0</int>
							<UDim2 name="Size">
								<XS>0.948516607</XS>
								<XO>0</XO>
								<YS>0.937810242</YS>
								<YO>0</YO>
							</UDim2>
							<token name="SizeConstraint">0</token>
							<int64 name="SourceAssetId">-1</int64>
							<token name="Style">0</token>
							<BinaryString name="Tags"></BinaryString>
							<bool name="Visible">true</bool>
							<int name="ZIndex">1</int>
						</Properties>
						<Item class="UIListLayout" referent="RBXC5642557049D4B20BFDD00071229DCED">
							<Properties>
								<BinaryString name="AttributesSerialize"></BinaryString>
								<token name="FillDirection">1</token>
								<token name="HorizontalAlignment">1</token>
								<string name="Name">UIListLayout</string>
								<UDim name="Padding">
									<S>0</S>
									<O>0</O>
								</UDim>
								<token name="SortOrder">2</token>
								<int64 name="SourceAssetId">-1</int64>
								<BinaryString name="Tags"></BinaryString>
								<token name="VerticalAlignment">1</token>
							</Properties>
						</Item>
						<Item class="TextButton" referent="RBX2A5F9ED800B941419732D83F35667D35">
							<Properties>
								<bool name="Active">true</bool>
								<Vector2 name="AnchorPoint">
									<X>0</X>
									<Y>0</Y>
								</Vector2>
								<BinaryString name="AttributesSerialize"></BinaryString>
								<bool name="AutoButtonColor">false</bool>
								<bool name="AutoLocalize">true</bool>
								<token name="AutomaticSize">0</token>
								<Color3 name="BackgroundColor3">
									<R>0.105882354</R>
									<G>0.105882354</G>
									<B>0.105882354</B>
								</Color3>
								<float name="BackgroundTransparency">0</float>
								<Color3 name="BorderColor3">
									<R>0.105882362</R>
									<G>0.164705887</G>
									<B>0.207843155</B>
								</Color3>
								<token name="BorderMode">0</token>
								<int name="BorderSizePixel">0</int>
								<bool name="ClipsDescendants">false</bool>
								<bool name="Draggable">false</bool>
								<token name="Font">3</token>
								<Font name="FontFace">
									<Family><url>rbxasset://fonts/families/SourceSansPro.json</url></Family>
									<Weight>400</Weight>
									<Style>Normal</Style>
									<CachedFaceId><url>rbxasset://fonts/SourceSansPro-Regular.ttf</url></CachedFaceId>
								</Font>
								<int name="LayoutOrder">0</int>
								<float name="LineHeight">1</float>
								<int name="MaxVisibleGraphemes">-1</int>
								<bool name="Modal">false</bool>
								<string name="Name">HighlightSetting</string>
								<Ref name="NextSelectionDown">null</Ref>
								<Ref name="NextSelectionLeft">null</Ref>
								<Ref name="NextSelectionRight">null</Ref>
								<Ref name="NextSelectionUp">null</Ref>
								<UDim2 name="Position">
									<XS>0</XS>
									<XO>0</XO>
									<YS>0</YS>
									<YO>0</YO>
								</UDim2>
								<bool name="RichText">false</bool>
								<Ref name="RootLocalizationTable">null</Ref>
								<float name="Rotation">0</float>
								<bool name="Selectable">true</bool>
								<bool name="Selected">false</bool>
								<token name="SelectionBehaviorDown">0</token>
								<token name="SelectionBehaviorLeft">0</token>
								<token name="SelectionBehaviorRight">0</token>
								<token name="SelectionBehaviorUp">0</token>
								<bool name="SelectionGroup">false</bool>
								<Ref name="SelectionImageObject">null</Ref>
								<int name="SelectionOrder">0</int>
								<UDim2 name="Size">
									<XS>1</XS>
									<XO>0</XO>
									<YS>0.120655313</YS>
									<YO>0</YO>
								</UDim2>
								<token name="SizeConstraint">0</token>
								<int64 name="SourceAssetId">-1</int64>
								<token name="Style">0</token>
								<BinaryString name="Tags"></BinaryString>
								<string name="Text"></string>
								<Color3 name="TextColor3">
									<R>0</R>
									<G>0</G>
									<B>0</B>
								</Color3>
								<bool name="TextScaled">false</bool>
								<float name="TextSize">14</float>
								<Color3 name="TextStrokeColor3">
									<R>0</R>
									<G>0</G>
									<B>0</B>
								</Color3>
								<float name="TextStrokeTransparency">1</float>
								<float name="TextTransparency">0</float>
								<token name="TextTruncate">0</token>
								<bool name="TextWrapped">false</bool>
								<token name="TextXAlignment">2</token>
								<token name="TextYAlignment">1</token>
								<bool name="Visible">true</bool>
								<int name="ZIndex">1</int>
							</Properties>
							<Item class="UIStroke" referent="RBXB494113689D04D859F3DE9ABFC747D7B">
								<Properties>
									<token name="ApplyStrokeMode">1</token>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<Color3 name="Color">
										<R>0.152941182</R>
										<G>0.152941182</G>
										<B>0.152941182</B>
									</Color3>
									<bool name="Enabled">true</bool>
									<token name="LineJoinMode">0</token>
									<string name="Name">Stroke</string>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
									<float name="Thickness">1</float>
									<float name="Transparency">0</float>
								</Properties>
							</Item>
							<Item class="Frame" referent="RBX62F00B26DBD84F51A5F158D0A86EFBFB">
								<Properties>
									<bool name="Active">false</bool>
									<Vector2 name="AnchorPoint">
										<X>0</X>
										<Y>0.5</Y>
									</Vector2>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<bool name="AutoLocalize">true</bool>
									<token name="AutomaticSize">0</token>
									<Color3 name="BackgroundColor3">
										<R>0.105882354</R>
										<G>0.105882354</G>
										<B>0.105882354</B>
									</Color3>
									<float name="BackgroundTransparency">0</float>
									<Color3 name="BorderColor3">
										<R>0.105882362</R>
										<G>0.164705887</G>
										<B>0.207843155</B>
									</Color3>
									<token name="BorderMode">0</token>
									<int name="BorderSizePixel">0</int>
									<bool name="ClipsDescendants">false</bool>
									<bool name="Draggable">false</bool>
									<int name="LayoutOrder">0</int>
									<string name="Name">Checker</string>
									<Ref name="NextSelectionDown">null</Ref>
									<Ref name="NextSelectionLeft">null</Ref>
									<Ref name="NextSelectionRight">null</Ref>
									<Ref name="NextSelectionUp">null</Ref>
									<UDim2 name="Position">
										<XS>0.920000017</XS>
										<XO>0</XO>
										<YS>0.5</YS>
										<YO>0</YO>
									</UDim2>
									<Ref name="RootLocalizationTable">null</Ref>
									<float name="Rotation">0</float>
									<bool name="Selectable">false</bool>
									<token name="SelectionBehaviorDown">0</token>
									<token name="SelectionBehaviorLeft">0</token>
									<token name="SelectionBehaviorRight">0</token>
									<token name="SelectionBehaviorUp">0</token>
									<bool name="SelectionGroup">false</bool>
									<Ref name="SelectionImageObject">null</Ref>
									<int name="SelectionOrder">0</int>
									<UDim2 name="Size">
										<XS>0.0350569673</XS>
										<XO>0</XO>
										<YS>0.571428597</YS>
										<YO>0</YO>
									</UDim2>
									<token name="SizeConstraint">0</token>
									<int64 name="SourceAssetId">-1</int64>
									<token name="Style">0</token>
									<BinaryString name="Tags"></BinaryString>
									<bool name="Visible">true</bool>
									<int name="ZIndex">1</int>
								</Properties>
								<Item class="UICorner" referent="RBX4D8F460FDE504786A92E47CF7F1B8C7A">
									<Properties>
										<BinaryString name="AttributesSerialize"></BinaryString>
										<UDim name="CornerRadius">
											<S>0</S>
											<O>5</O>
										</UDim>
										<string name="Name">Corner</string>
										<int64 name="SourceAssetId">-1</int64>
										<BinaryString name="Tags"></BinaryString>
									</Properties>
								</Item>
								<Item class="UIStroke" referent="RBX8146CEF3C5694D079C8C26E978DB8E18">
									<Properties>
										<token name="ApplyStrokeMode">1</token>
										<BinaryString name="AttributesSerialize"></BinaryString>
										<Color3 name="Color">
											<R>0.149019614</R>
											<G>0.149019614</G>
											<B>0.149019614</B>
										</Color3>
										<bool name="Enabled">true</bool>
										<token name="LineJoinMode">0</token>
										<string name="Name">Stroke</string>
										<int64 name="SourceAssetId">-1</int64>
										<BinaryString name="Tags"></BinaryString>
										<float name="Thickness">1</float>
										<float name="Transparency">0</float>
									</Properties>
								</Item>
							</Item>
							<Item class="UICorner" referent="RBXAF0D626491174E88AF5C4EB067105261">
								<Properties>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<UDim name="CornerRadius">
										<S>0</S>
										<O>5</O>
									</UDim>
									<string name="Name">Corner</string>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
								</Properties>
							</Item>
							<Item class="TextLabel" referent="RBX57AAA1ACD54241ABAD59965E5D765E82">
								<Properties>
									<bool name="Active">false</bool>
									<Vector2 name="AnchorPoint">
										<X>0</X>
										<Y>0</Y>
									</Vector2>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<bool name="AutoLocalize">true</bool>
									<token name="AutomaticSize">0</token>
									<Color3 name="BackgroundColor3">
										<R>0.105882354</R>
										<G>0.105882354</G>
										<B>0.105882354</B>
									</Color3>
									<float name="BackgroundTransparency">1</float>
									<Color3 name="BorderColor3">
										<R>0.105882354</R>
										<G>0.164705887</G>
										<B>0.20784314</B>
									</Color3>
									<token name="BorderMode">0</token>
									<int name="BorderSizePixel">0</int>
									<bool name="ClipsDescendants">false</bool>
									<bool name="Draggable">false</bool>
									<token name="Font">18</token>
									<Font name="FontFace">
										<Family><url>rbxasset://fonts/families/GothamSSm.json</url></Family>
										<Weight>500</Weight>
										<Style>Normal</Style>
										<CachedFaceId><url>rbxasset://fonts/GothamSSm-Medium.otf</url></CachedFaceId>
									</Font>
									<int name="LayoutOrder">0</int>
									<float name="LineHeight">1</float>
									<int name="MaxVisibleGraphemes">-1</int>
									<string name="Name">Label</string>
									<Ref name="NextSelectionDown">null</Ref>
									<Ref name="NextSelectionLeft">null</Ref>
									<Ref name="NextSelectionRight">null</Ref>
									<Ref name="NextSelectionUp">null</Ref>
									<UDim2 name="Position">
										<XS>0.0244498774</XS>
										<XO>0</XO>
										<YS>0</YS>
										<YO>0</YO>
									</UDim2>
									<bool name="RichText">false</bool>
									<Ref name="RootLocalizationTable">null</Ref>
									<float name="Rotation">0</float>
									<bool name="Selectable">false</bool>
									<token name="SelectionBehaviorDown">0</token>
									<token name="SelectionBehaviorLeft">0</token>
									<token name="SelectionBehaviorRight">0</token>
									<token name="SelectionBehaviorUp">0</token>
									<bool name="SelectionGroup">false</bool>
									<Ref name="SelectionImageObject">null</Ref>
									<int name="SelectionOrder">0</int>
									<UDim2 name="Size">
										<XS>1</XS>
										<XO>0</XO>
										<YS>1</YS>
										<YO>0</YO>
									</UDim2>
									<token name="SizeConstraint">0</token>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
									<string name="Text">Syntax Highlighting</string>
									<Color3 name="TextColor3">
										<R>1</R>
										<G>1</G>
										<B>1</B>
									</Color3>
									<bool name="TextScaled">false</bool>
									<float name="TextSize">14</float>
									<Color3 name="TextStrokeColor3">
										<R>0</R>
										<G>0</G>
										<B>0</B>
									</Color3>
									<float name="TextStrokeTransparency">1</float>
									<float name="TextTransparency">0</float>
									<token name="TextTruncate">0</token>
									<bool name="TextWrapped">false</bool>
									<token name="TextXAlignment">0</token>
									<token name="TextYAlignment">1</token>
									<bool name="Visible">true</bool>
									<int name="ZIndex">1</int>
								</Properties>
							</Item>
							<Item class="BoolValue" referent="RBX41906333D5824DE6969970B7BECF4A15">
								<Properties>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<string name="Name">Checked</string>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
									<bool name="Value">true</bool>
								</Properties>
							</Item>
							<Item class="LocalScript" referent="RBX4CF63D1873B14FCAA2E5D44DB4563824">
								<Properties>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<bool name="Disabled">false</bool>
									<Content name="LinkedSource"><null></null></Content>
									<string name="Name">LocalScript</string>
									<token name="RunContext">0</token>
									<string name="ScriptGuid">{63903114-807D-46B9-978B-87E2BB1854FF}</string>
									<ProtectedString name="Source"><![CDATA[
script.Parent.MouseButton1Click:Connect(function()
	if script.Parent.Checked.Value then

	else

	end
end)]]></ProtectedString>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
								</Properties>
							</Item>
							<Item class="UIAspectRatioConstraint" referent="RBX4C0EE6D8D4284350A3D688417A84EEA9">
								<Properties>
									<float name="AspectRatio">16.2999992</float>
									<token name="AspectType">1</token>
									<BinaryString name="AttributesSerialize"></BinaryString>
									<token name="DominantAxis">1</token>
									<string name="Name">UIAspectRatioConstraint</string>
									<int64 name="SourceAssetId">-1</int64>
									<BinaryString name="Tags"></BinaryString>
								</Properties>
							</Item>
						</Item>
					</Item>
				</Item>
			</Item>
			<Item class="Frame" referent="RBX0C9D2A164F514A43B873E6AE522A9724">
				<Properties>
					<bool name="Active">false</bool>
					<Vector2 name="AnchorPoint">
						<X>0</X>
						<Y>0</Y>
					</Vector2>
					<BinaryString name="AttributesSerialize"></BinaryString>
					<bool name="AutoLocalize">true</bool>
					<token name="AutomaticSize">0</token>
					<Color3 name="BackgroundColor3">
						<R>0.152941182</R>
						<G>0.152941182</G>
						<B>0.152941182</B>
					</Color3>
					<float name="BackgroundTransparency">0</float>
					<Color3 name="BorderColor3">
						<R>0.105882362</R>
						<G>0.164705887</G>
						<B>0.207843155</B>
					</Color3>
					<token name="BorderMode">0</token>
					<int name="BorderSizePixel">0</int>
					<bool name="ClipsDescendants">false</bool>
					<bool name="Draggable">false</bool>
					<int name="LayoutOrder">0</int>
					<string name="Name">Line</string>
					<Ref name="NextSelectionDown">null</Ref>
					<Ref name="NextSelectionLeft">null</Ref>
					<Ref name="NextSelectionRight">null</Ref>
					<Ref name="NextSelectionUp">null</Ref>
					<UDim2 name="Position">
						<XS>0</XS>
						<XO>0</XO>
						<YS>0.115999997</YS>
						<YO>0</YO>
					</UDim2>
					<Ref name="RootLocalizationTable">null</Ref>
					<float name="Rotation">0</float>
					<bool name="Selectable">false</bool>
					<token name="SelectionBehaviorDown">0</token>
					<token name="SelectionBehaviorLeft">0</token>
					<token name="SelectionBehaviorRight">0</token>
					<token name="SelectionBehaviorUp">0</token>
					<bool name="SelectionGroup">false</bool>
					<Ref name="SelectionImageObject">null</Ref>
					<int name="SelectionOrder">0</int>
					<UDim2 name="Size">
						<XS>1</XS>
						<XO>0</XO>
						<YS>0</YS>
						<YO>1</YO>
					</UDim2>
					<token name="SizeConstraint">0</token>
					<int64 name="SourceAssetId">-1</int64>
					<token name="Style">0</token>
					<BinaryString name="Tags"></BinaryString>
					<bool name="Visible">true</bool>
					<int name="ZIndex">1</int>
				</Properties>
			</Item>
			<Item class="LocalScript" referent="RBX6C179105DAF94D12B70AFC6940D3CCBA">
				<Properties>
					<BinaryString name="AttributesSerialize"></BinaryString>
					<bool name="Disabled">false</bool>
					<Content name="LinkedSource"><null></null></Content>
					<string name="Name">manager</string>
					<token name="RunContext">0</token>
					<string name="ScriptGuid">{B32E574C-4B96-4908-8F09-A9CBBC215C27}</string>
					<ProtectedString name="Source"><![CDATA[local TweenService = game:GetService("TweenService")

for i,v in next,script.Parent:GetDescendants() do
	if v.ClassName == "TextButton" and not v:FindFirstChild("Checker") and v:FindFirstChild("Corner") and v:FindFirstChild("Stroke") then
		local IsMouseOn = false
		v.MouseEnter:Connect(function()
			IsMouseOn = true
			TweenService:Create(v,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(30,30,30)}):Play()
			TweenService:Create(v,TweenInfo.new(0.3),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
			TweenService:Create(v.Stroke,TweenInfo.new(0.3),{Color = Color3.fromRGB(60,60,60)}):Play()
			TweenService:Create(v.Corner,TweenInfo.new(0.3),{CornerRadius = UDim.new(0,10)}):Play()
			if v:FindFirstChild("Icon") then
				TweenService:Create(v.Icon,TweenInfo.new(0.3),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
			end
		end)
		
		v.MouseLeave:Connect(function()
			IsMouseOn = false
			TweenService:Create(v,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(27,27,27)}):Play()
			TweenService:Create(v,TweenInfo.new(0.3),{TextColor3 = Color3.fromRGB(158,158,158)}):Play()
			TweenService:Create(v.Stroke,TweenInfo.new(0.3),{Color = Color3.fromRGB(39,39,39)}):Play()
			TweenService:Create(v.Corner,TweenInfo.new(0.3),{CornerRadius = UDim.new(0,5)}):Play()
			if v:FindFirstChild("Icon") then
				TweenService:Create(v.Icon,TweenInfo.new(0.3),{ImageColor3 = Color3.fromRGB(158,158,158)}):Play()
			end
		end)
		v.MouseButton1Down:Connect(function()
			TweenService:Create(v.Stroke,TweenInfo.new(0.3),{Color = Color3.fromRGB(85,85,85)}):Play()
			TweenService:Create(v.Corner,TweenInfo.new(0.3),{CornerRadius = UDim.new(0,15)}):Play()
			TweenService:Create(v,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()
		end)
		v.MouseButton1Up:Connect(function()
			if not IsMouseOn then
				TweenService:Create(v,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(27,27,27)}):Play()
				TweenService:Create(v,TweenInfo.new(0.3),{TextColor3 = Color3.fromRGB(158,158,158)}):Play()
				TweenService:Create(v.Stroke,TweenInfo.new(0.3),{Color = Color3.fromRGB(39,39,39)}):Play()
			else
				TweenService:Create(v,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(30,30,30)}):Play()
				TweenService:Create(v,TweenInfo.new(0.3),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
				TweenService:Create(v.Stroke,TweenInfo.new(0.3),{Color = Color3.fromRGB(60,60,60)}):Play()
			end
		end)
	end
	if v.ClassName == "TextButton" and v:FindFirstChild("Checker") then
		local IsMouseOn = false
		v.MouseEnter:Connect(function()
			IsMouseOn = true
			TweenService:Create(v.Label,TweenInfo.new(0.3),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
			TweenService:Create(v.Stroke,TweenInfo.new(0.3),{Color = Color3.fromRGB(60,60,60)}):Play()
			TweenService:Create(v.Corner,TweenInfo.new(0.3),{CornerRadius = UDim.new(0,10)}):Play()
			if v:FindFirstChild("Icon") then
				TweenService:Create(v,TweenInfo.new(0.3),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
			end
		end)

		v.MouseLeave:Connect(function()
			IsMouseOn = false
			TweenService:Create(v.Label,TweenInfo.new(0.3),{TextColor3 = Color3.fromRGB(158,158,158)}):Play()
			TweenService:Create(v.Stroke,TweenInfo.new(0.3),{Color = Color3.fromRGB(39,39,39)}):Play()
			TweenService:Create(v.Corner,TweenInfo.new(0.3),{CornerRadius = UDim.new(0,5)}):Play()
			if v:FindFirstChild("Icon") then
				TweenService:Create(v,TweenInfo.new(0.3),{ImageColor3 = Color3.fromRGB(158,158,158)}):Play()
			end
		end)
		
		v.MouseButton1Click:Connect(function()
			v.Checked.Value = not v.Checked.Value
			if not v.Checked.Value then
				TweenService:Create(v.Checker,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(27,27,27)}):Play()
			else
				TweenService:Create(v.Checker,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(85, 255, 127)}):Play()
			end
		end)
		if v.Checked.Value then
			TweenService:Create(v.Checker,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(85, 255, 127)}):Play()
		end
	end
end

]]></ProtectedString>
					<int64 name="SourceAssetId">-1</int64>
					<BinaryString name="Tags"></BinaryString>
				</Properties>
			</Item>
		</Item>
	</Item>
</roblox>