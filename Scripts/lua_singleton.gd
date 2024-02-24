extends Node

var theme: String = "One Dark Pro Darker";

var gui: Dictionary = {
	"background_color":            str_to_clr("#23272e"),
	"current_line_color":          str_to_clr("#23272e"),
	"selection_color":             str_to_clr("#23272e"),
	"font_color":                  str_to_clr("#23272e"),
	"word_highlighted_color":      str_to_clr("#23272e"),
	"completion_background_color": str_to_clr("#23272e"),
	"caret_color": str_to_clr("#23272e")
}

var settings: Array = [
	{
		"property": "caret_type",
		"display": "Caret type",
		"options": [{"display": "Line", "value": 0}, {"display": "Block", "value": 1}],
		"icon": "",
		"value": CodeEdit.CARET_TYPE_LINE
	},
	{
		"property": "caret_blink",
		"display": "Caret blink",
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
		"unit": "sec."
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
		"unit": "tabs"
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
		"unit": "px/s"
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

signal done_parsing;
signal on_theme_load;

func change_setting(property: String, value: Variant) -> void:
	for setting in settings:
		if setting["property"] == property:
			setting["value"] = value
			return

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

func _splitstr(input: String, separator: String):
	return input.split(separator)

func _trim(input: String):
	return input.strip_edges()

func setup(extension):
	keywords_to_highlight = {}
	color_regions_to_highlight = []

	# All builtin libraries are available to bind with. Use Debug, OS and IO at your own risk.
	lua.bind_libraries(["base", "table", "string"])

	lua.push_variant("highlight", _lua_highlight)
	lua.push_variant("highlight_region", _lua_highlight_region)

	lua.push_variant("splitstr", _splitstr)
	lua.push_variant("trim", _trim)



	theme_lua.bind_libraries(["base", "table", "string"])

	theme_lua.push_variant("set_keywords", _lua_set_keywords)
	theme_lua.push_variant("set_gui", _lua_set_gui)

	var err: LuaError = lua.do_file("user://langs/" + extension + ".lua")
	if err is LuaError:
		print("ERROR %d: %s" % [err.type, err.message])
		return

	var theme_err: LuaError = theme_lua.do_file("user://themes/" + theme + ".lua")
	if theme_err is LuaError:
		print("ERROR %d: %s" % [err.type, err.message])
		return

	done_parsing.emit()
	on_theme_load.emit()
