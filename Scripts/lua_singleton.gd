extends Node

var themes: Array = ["One Dark Pro Darker"];
var theme: String = "One Dark Pro Darker"; # default

var gui: Dictionary = {
	"background_color":            str_to_clr("#23272e"),
	"current_line_color":          str_to_clr("#23272e"),
	"selection_color":             str_to_clr("#23272e"),
	"font_color":                  str_to_clr("#23272e"),
	"word_highlighted_color":      str_to_clr("#23272e"),
	"completion_background_color": str_to_clr("#23272e"),
	"completion_selected_color":   str_to_clr("#23272e"),
	"caret_color":                 str_to_clr("#23272e")
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

# BUG: to apply changes to these settings, it's required to delete your save data. Contributions fixing that are appreciated.
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
];

var keywords: Dictionary = {
	"reserved": str_to_clr("c678cc"),
	"string":   str_to_clr("98c379"),
	"binary":   str_to_clr("d19a66"),
	"symbol":   str_to_clr("839fb6"),
	"variable": str_to_clr("e5c07b"),
	"operator": str_to_clr("56b6c2"),
	"comments": str_to_clr("7f848e"),
	"error":    str_to_clr("d31820"),
	"function": str_to_clr("437ed9"),
	"member":   str_to_clr("e06c75")
}

var keywords_to_highlight: Dictionary = {}
var color_regions_to_highlight: Array = []
var comments: Array = []

const SUNLIGHT = preload("res://Shaders/sunlight.gdshader")
const VHS_AND_CRT = preload("res://Shaders/vhs_and_crt.gdshader")

@onready var code: CodeEdit = $/root/Editor/Code;
@onready var world_environment: WorldEnvironment = $/root/Editor/WorldEnvironment
@onready var shader_layer: ColorRect = $/root/Editor/ShaderLayer

signal done_parsing;
signal on_theme_load;
signal on_settings_change;

func get_setting(property: String) -> Array:
	var i = -1;

	for setting in settings:
		i += 1;

		if setting["property"] == property:
			return [setting, i]

	return [{}, -1]

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

func _lua_highlight_region(start: String, end: String, color: String, line_only: bool = false):
	if !(color in keywords.keys()):
		print("ERROR: provided color (\"%s\") at color region (start: \"%s\", end: \"%s\") is invalid." % [color, start, end])
		return

	color_regions_to_highlight.append([start, end, color, line_only])

func _lua_set_keywords(property: String, new_color: String) -> void:
	if !(property in keywords.keys()):
		print("ERROR: provided color property (\"%s\") in theme (KEYWORD) is invalid." % [property])
		return

	keywords[property] = str_to_clr(new_color)

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

func setup_extension(extension):
	keywords_to_highlight = {}
	color_regions_to_highlight = []
	comments = []

	# FILE EXTENSIONS
	lua.bind_libraries(["base", "table", "string"])

	lua.push_variant("highlight", _lua_highlight)
	lua.push_variant("highlight_region", _lua_highlight_region)
	lua.push_variant("add_comment", _add_comment)

	lua.push_variant("splitstr", _splitstr)
	lua.push_variant("trim", _trim)

	var err: LuaError = lua.do_file("user://langs/" + extension + ".lua")
	if err is LuaError:
		print("ERROR %d: %s" % [err.type, err.message])
		return

	done_parsing.emit()

func setup_theme(given_theme: String) -> void:
	theme_lua.bind_libraries(["base", "table", "string"])

	theme_lua.push_variant("set_keywords", _lua_set_keywords)
	theme_lua.push_variant("set_gui", _lua_set_gui)

	var theme_err: LuaError = theme_lua.do_file("user://themes/" + given_theme + ".lua")
	if theme_err is LuaError:
		print("ERROR %d: %s" % [theme_err.type, theme_err.message])
		return

	on_theme_load.emit()
