extends Node

const NOTO_COLOR_EMOJI_REGULAR: FontFile = preload ("res://Fonts/NotoColorEmoji-Regular.ttf")

var themes: Array = ["One Dark Pro Darker"];
var theme: String = "One Dark Pro Darker"; # default

# TODO: change me each version
var version: String = "v1.2.2";

var gui: Dictionary = {
	"background_color": str_to_clr("#23272e"),
	"current_line_color": str_to_clr("#23272e"),
	"selection_color": str_to_clr("#23272e"),
	"font_color": str_to_clr("#23272e"),
	"word_highlighted_color": str_to_clr("#23272e"),
	"completion_background_color": str_to_clr("#23272e"),
	"completion_selected_color": str_to_clr("#23272e"),
	"caret_color": str_to_clr("#23272e")
}

# #### SETTINGS ####
# # Info:
# Property = identifier
# Display = the setting name to display.
# Options = dropdown options. Leave empty for no dropdown.
# Icon = nerdfont unicode for the icon
# Value = initial value. Reminder this gets overwritten by the save file.
# Unit = the unit to display after the slider.
# Min = the minimum slider value.
# Max = the maximum slider value.
# Precision = whether or not the slider should go from int to float.
# Shader = whether or not to disable the previously-enabled shader setting, as they can't be stacked.

var editor_theme: Theme = load("res://theme.tres");
var fonts = load_available_fonts()

func load_available_fonts() -> Array:
	var built_ins = load_built_in_fonts()
	var system = load_system_fonts()
	built_ins.append_array(system)
	return built_ins

func load_built_in_fonts() -> Array:
	return Array(editor_theme.get_font_list("MyType")).map(load_built_in_font)

func load_built_in_font(_name: String) -> Dictionary:
	var font = editor_theme.get_font(_name, "MyType");

	return {"display": font.get_font_name(), "value": font, "name": _name}

func load_system_font(font_name: String):
	var font: SystemFont = SystemFont.new()
	font.multichannel_signed_distance_field = true
	font.font_names = [font_name]

	return {"display": font.get_font_name(), "value": font, "name": font_name}

func load_system_fonts() -> Array:
	return Array(OS.get_system_fonts()).map(load_system_font)

var settings: Array = [
	{
		"property": "caret_type",
		"display": "Caret type",
		"options": [{"display": "Line", "value": 0}, {"display": "Block", "value": 1}],
		"icon": "",
		"value": CodeEdit.CARET_TYPE_LINE,
	},
	{
		"property": "caret_blink",
		"display": "Caret blink interval",
		"options": [],
		"icon": "|",
		"value": true
	},
	{
		"property": "editor_font",
		"display": "Editor Font",
		"options": fonts,
		"icon": "",
		"value": 0
	},
	{
		"property": "caret_interval",
		"display": "Caret blink interval",
		"options": [],
		"icon": "",
		"value": 0.6,
		"unit": "sec.",
		"min": 0.1, "max": 3,
		"precision": true,
	},
	{
		"property": "draw_line_numbers",
		"display": "Draw Line Number",
		"options": [],
		"icon": "",
		"value": true
	},
	{
		"property": "code_completion",
		"display": "Code Completion",
		"options": [],
		"icon": "",
		"value": true
	},
	{
		"property": "indentation_size",
		"display": "Indentation Size",
		"options": [],
		"icon": "󰌒",
		"value": 4,
		"unit": "tabs",
		"min": 1, "max": 8,
	},
	{
		"property": "indentation_automatic",
		"display": "Automatic Indentation",
		"options": [],
		"icon": "󰁨",
		"value": true
	},
	{
		"property": "indentation_use_spaces",
		"display": "Indentation: use spaces",
		"options": [],
		"icon": "󱁐",
		"value": false
	},
	{
		"property": "auto_brace_completion",
		"display": "Auto Brace Completion",
		"options": [],
		"icon": "󰅩",
		"value": true
	},
	{
		"property": "auto_brace_highlight_matching",
		"display": "Highlight Matching Braces",
		"options": [],
		"icon": "󱃖",
		"value": true
	},
	{
		"property": "smooth_scrolling",
		"display": "Smooth Scrolling",
		"options": [],
		"icon": "󱕒",
		"value": true
	},
	{
		"property": "v_scroll_speed",
		"display": "Scrolling Speed",
		"options": [],
		"icon": "",
		"value": 150,
		"unit": "px/s",
		"min": 10, "max": 900,
	},
	{
		"property": "minimap",
		"display": "Minimap",
		"options": [],
		"icon": "󰍍",
		"value": true
	},
	{
		"property": "minimap_width",
		"display": "Minimap Width",
		"options": [],
		"icon": "",
		"value": 80,
		"unit": "px",
		"min": 20, "max": 500,
	},
	{
		"property": "glow",
		"display": "Glow",
		"options": [],
		"icon": "󰌶",
		"value": true,
	},
	{
		"property": "sunlight",
		"display": "Shader: Sunlight",
		"options": [],
		"icon": "",
		"value": false,
		"shader": true
	},
	{
		"property": "vhs",
		"display": "Shader: VHS and CRT",
		"options": [],
		"icon": "",
		"value": false,
		"shader": true
	},
	{
		"property": "music",
		"display": "Music",
		"options": [],
		"icon": "󰝚",
		"value": false,
	},
	{
		"property": "music_volume",
		"display": "Music: Volume",
		"options": [],
		"icon": "",
		"value": 100,
		"unit": "%",
		"min": 0, "max": 100,
	},
	{
		"property": "music_move_intensity",
		"display": "Music: Camera Intensity",
		"options": [],
		"icon": "",
		"value": 1,
		"unit": "x",
		"min": 0, "max": 10,
	},
	{
		"property": "discord_sdk",
		"display": "Discord SDK",
		"options": [],
		"icon": "󰙯",
		"value": true,
	},
];

var keywords: Dictionary = {
	"reserved": str_to_clr("c678cc"),
	"annotation": str_to_clr("a2b429"),
	"string": str_to_clr("98c379"),
	"binary": str_to_clr("d19a66"),
	"symbol": str_to_clr("839fb6"),
	"variable": str_to_clr("e5c07b"),
	"operator": str_to_clr("56b6c2"),
	"comments": str_to_clr("7f848e"),
	"error": str_to_clr("d31820"),
	"function": str_to_clr("437ed9"),
	"member": str_to_clr("e06c75")
}

var keywords_to_highlight: Dictionary = {}
var color_regions_to_highlight: Array = []
var comments: Array = []

var discord_sdk: bool = true;

const SUNLIGHT = preload ("res://Shaders/sunlight.gdshader")
const VHS_AND_CRT = preload ("res://Shaders/vhs_and_crt.gdshader")

@onready var editor: FileManager = $ / root / Editor;
@onready var code: CodeEdit = $ / root / Editor / Code;
@onready var world_environment: WorldEnvironment = $ / root / Editor / WorldEnvironment
@onready var shader_layer: ColorRect = $ / root / Editor / ShaderLayer
var current_file_extension: String
# used in wrappers to determine if the function should return an empty array (essentially a no-op)
var no_extension: bool = false

signal done_parsing;
signal on_theme_load;
signal on_settings_change;
signal on_comments_change;

func get_setting(property: String) -> Array:
	var i = -1;

	for setting in settings:
		i += 1;

		if setting["property"] == property:
			return [setting, i]

	return [{}, - 1]

func change_setting(property: String, value: Variant) -> void:
	for setting in settings:
		if setting["property"] == property:
			setting["value"] = value
			handle_internal_setting_change(property, value)
			return

func toggle_shader(shader: Shader, value: bool) -> void:
	if value:
		shader_layer.show()
		shader_layer.material.shader = shader
	else:
		shader_layer.material.shader = null
		shader_layer.hide()

func handle_internal_setting_change(property: String, value: Variant) -> void:
	# oh my god he's about to do it
	var p = property;

	if p == "caret_type":
		code.caret_type = value
	if p == "caret_blink":
		code.caret_blink = value
	if p == "caret_interval":
		code.caret_blink_interval = value;
	if p == "draw_line_numbers":
		code.gutters_draw_line_numbers = value;
	if p == "code_completion":
		code.code_completion_enabled = value
	if p == "indentation_size":
		code.indent_size = value
	if p == "indentation_automatic":
		code.indent_automatic = value
	if p == "indentation_use_spaces":
		code.indent_use_spaces = value
	if p == "auto_brace_completion":
		code.auto_brace_completion_enabled = value
	if p == "auto_brace_highlight_matching":
		code.auto_brace_completion_highlight_matching = value
	if p == "smooth_scrolling":
		code.scroll_smooth = value
	if p == "v_scroll_speed":
		code.scroll_v_scroll_speed = value
	if p == "minimap":
		code.minimap_draw = value
	if p == "minimap_width":
		code.minimap_width = value
	if p == "editor_font":
		fonts[value].value.set_fallbacks([NOTO_COLOR_EMOJI_REGULAR])

		editor_theme.set_font("normal_font", "RichTextLabel", fonts[value].value)
		editor_theme.set_font("font", "Label", fonts[value].value)
		editor_theme.set_font("font", "CodeEdit", fonts[value].value)
		editor_theme.set_font("font", "Button", fonts[value].value)

	# SHADERS
	if p == "glow":
		world_environment.environment.glow_enabled = value
	if p == "sunlight":
		toggle_shader(SUNLIGHT, value)
	if p == "vhs":
		toggle_shader(VHS_AND_CRT, value)
	# MUSIC
	if p == "music":
		Music.set_enabled(value)
	if p == "music_volume":
		Music.set_volume(value)
	if p == "music_move_intensity":
		Music.music_move_intensity = value
	if p == "discord_sdk":
		discord_sdk = value;

func setup_discord_sdk(detail: String, state: String) -> void:
	if !discord_sdk: return
	DiscordSDK.details = detail
	DiscordSDK.state = state

	DiscordSDK.refresh()

# LUA
var lua: LuaAPI = LuaAPI.new()
var theme_lua: LuaAPI = LuaAPI.new()

func str_to_clr(string: String) -> Color:
	return Color.from_string(string, "#ff0000");

func _lua_highlight(keyword: String, color: String):
	if !(color in keywords.keys()):
		print("ERROR: provided color property (\"%s\") at \"%s\" is invalid." % [color, keyword])
		return

	keywords_to_highlight[keyword] = color;

func _lua_highlight_region(start: String, end: String, color: String, line_only: bool=false):
	if !(color in keywords.keys()):
		print("ERROR: provided color (\"%s\") at color region (start: \"%s\", end: \"%s\") is invalid." % [color, start, end])
		return

	color_regions_to_highlight.append([start, end, color, line_only])

func _lua_set_keywords(property: String, new_color: String) -> void:
	if !(property in keywords.keys()):
		print("ERROR: provided color property (\"%s\") in theme (KEYWORD) is invalid." % [property])
		return

	keywords[property] = str_to_clr(new_color)

func _lua_disable_glow() -> void:
	editor.warn("[color=yellow]WARNING[/color]: This theme disabled the \"glow\".")
	handle_internal_setting_change("glow", false)

func _lua_set_gui(property: String, new_color: String) -> void:
	if !(property in gui.keys()):
		print("ERROR: provided color property (\"%s\") in theme (GUI) is invalid." % [property])
		return

	gui[property] = str_to_clr(new_color)

func _add_comment(comment: String) -> void:
	comments.append(comment)

func _splitstr(input: String, separator: String):
	return input.split(separator)

func _trim(input: String):
	return input.strip_edges()

# wrappers (no-op if `no_extension` is `true`)

func detect_functions(text: String, line: int, column: int) -> Array:
	if no_extension:
		return []
	return lua.call_function("detect_functions", [text, line, column])

func detect_variables(text: String, line: int, column: int) -> Array:
	if no_extension:
		return []
	return lua.call_function("detect_variables", [text, line, column])

func _ready():
	editor.on_open_file.connect(func(file: String):
		var extension: String=file.get_extension()
		if extension != current_file_extension:
			keywords_to_highlight.clear()
			color_regions_to_highlight.clear()
			comments.clear()
			on_comments_change.emit()
	)

func setup_extension(extension):
	# FILE EXTENSIONS
	lua.bind_libraries(["base", "table", "string"])

	lua.push_variant("highlight", _lua_highlight)
	lua.push_variant("highlight_region", _lua_highlight_region)
	lua.push_variant("add_comment", _add_comment)

	lua.push_variant("splitstr", _splitstr)
	lua.push_variant("trim", _trim)

	var err: LuaError = lua.do_file("user://langs/" + extension + ".lua")
	if err is LuaError:
		editor.warn("[color=yellow]WARNING[/color]: This file isn’t supported. Highlighting, autocomplete, comments and other features won’t work properly.")
		print("ERROR %d: %s" % [err.type, err.message])
		no_extension = true
		return
	no_extension = false
	done_parsing.emit()

func setup_theme(given_theme: String) -> void:
	theme_lua.bind_libraries(["base", "table", "string"])

	theme_lua.push_variant("disable_glow", _lua_disable_glow)
	theme_lua.push_variant("set_keywords", _lua_set_keywords)
	theme_lua.push_variant("set_gui", _lua_set_gui)

	var theme_err: LuaError = theme_lua.do_file("user://themes/" + given_theme + ".lua")
	if theme_err is LuaError:
		editor.warn("[color=yellow]WARNING[/color]: Failed to load theme: " + theme_err.message)
		print("ERROR %d: %s" % [theme_err.type, theme_err.message])
		return

	on_theme_load.emit()
