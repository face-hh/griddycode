extends Node

var background_color: String = "#23272e";
var current_line_color: String;
var selection_color: String;
# --
var font_color: String;
var word_highlighted_color: String;
var completion_background_color: String;

var bg = str_to_clr(background_color);
var lg = str_to_clr(current_line_color) if current_line_color else modulate_color(bg, 0.05)
var hl = str_to_clr(selection_color) if selection_color else modulate_color(bg, 0.25)
var fc = str_to_clr(font_color) if font_color else get_opposite_color(bg)
var whc = str_to_clr(word_highlighted_color) if word_highlighted_color else hl
var cbc = str_to_clr(completion_background_color) if completion_background_color else modulate_color(bg, 5)


var keywords: Dictionary = {
	"reserved": str_to_clr("c678cc"),
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

signal done_parsing;

var lua: LuaAPI = LuaAPI.new()

func modulate_color(color: Color, multiplier: float = 0.1) -> Color:
	var r : float = color.r
	var g : float = color.g
	var b : float = color.b

	r += multiplier
	g += multiplier
	b += multiplier

	r = clamp(r, 0, 1)
	g = clamp(g, 0, 1)
	b = clamp(b, 0, 1)

	color = Color(r, g, b, color.a)

	return color;

func get_opposite_color(original_color: Color) -> Color:
	var r : float = 1.0 - original_color.r
	var g : float = 1.0 - original_color.g
	var b : float = 1.0 - original_color.b

	return Color(r, g, b, original_color.a)

func str_to_clr(string: String) -> Color:
	return Color.from_string(string, string);


func _lua_highlight(keyword: String, color: String):
	if !(color in keywords.keys()):
		print("ERROR: provided color (\"%s\") at \"%s\" is invalid." % [color, keyword])
		return

	keywords_to_highlight[keyword] = color;

func _lua_highlight_region(start: String, end: String, color: String, line_only: bool = false):
	if !(color in keywords.keys()):
		print("ERROR: provided color (\"%s\") at color region (start: \"%s\", end: \"%s\") is invalid." % [color, start, end])
		return

	color_regions_to_highlight.append([start, end, color, line_only])

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

	# Most methods return a LuaError in case of an error

	var err: LuaError = lua.do_file("user://langs/" + extension + ".lua")
	if err is LuaError:
		print("ERROR %d: %s" % [err.type, err.message])
		return

	done_parsing.emit()
