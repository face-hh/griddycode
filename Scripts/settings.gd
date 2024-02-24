extends CodeEdit

@onready var code: CodeEdit = %Code

const VARIABLE = preload("res://Icons/variable.png")
const FUNCTION = preload("res://Icons/function.png")

var show = false;
var file_modified = false;

func _ready() -> void:
	%Background.color = LuaSingleton.bg;
	tween_fade(%FileDialog, 0)

	code.add_theme_color_override("background_color", LuaSingleton.bg)
	code.add_theme_color_override("current_line_color", LuaSingleton.lg)
	code.add_theme_color_override("selection_color", LuaSingleton.hl)
	code.add_theme_color_override("font_color", LuaSingleton.fc)
	code.add_theme_color_override("word_highlighted_color", LuaSingleton.whc)
	code.add_theme_color_override("completion_background_color", LuaSingleton.cbc)

	setup_highlighter()

func setup_highlighter() -> void:
	var CH: CodeHighlighter = CodeHighlighter.new();

	syntax_highlighter = CH;

	CH.number_color = LuaSingleton.keywords.binary;
	CH.symbol_color = LuaSingleton.keywords.symbol;
	CH.function_color = LuaSingleton.keywords.function;
	CH.member_variable_color = LuaSingleton.keywords.member;

	await LuaSingleton.done_parsing;

	var kth = LuaSingleton.keywords_to_highlight;
	var crth = LuaSingleton.color_regions_to_highlight;

	for key in kth:
		CH.add_keyword_color(key, LuaSingleton.keywords[kth[key]])

	for entry in crth:
		CH.add_color_region(entry[0], entry[1], LuaSingleton.keywords[entry[2]], entry[3])

func _on_code_completion_requested() -> void:
	var function_names = LuaSingleton.lua.call_function("detect_functions", [text])
	var variable_names = LuaSingleton.lua.call_function("detect_variables", [text])

	for each in function_names:
		add_code_completion_option(CodeEdit.KIND_FUNCTION, each, each+"()", LuaSingleton.keywords.function, FUNCTION)
	for each in variable_names:
		add_code_completion_option(CodeEdit.KIND_VARIABLE, each, each, LuaSingleton.keywords.variable, VARIABLE)

	update_code_completion_options(true)


func _on_text_changed() -> void:
	file_modified = true;
	request_code_completion()

func toggle(node: Object) -> void:
	if show:
		tween_fade(node, 0)
		slide_from_left(node, 0)
		tween_fade(%Background, 0)
		code.grab_focus()
	else:
		tween_fade(node, 1)
		slide_from_left(node, 1)
		tween_fade(%Background, 1)
		code.release_focus()

	show = !show;

func tween_fade(node: Object, opacity: float) -> void:
	var tween = create_tween()
	var color = node.modulate;

	if opacity == 1:
		node.show()

	color.a = opacity

	tween.tween_property(node, "modulate", color, 0.2)

	tween.tween_callback(func() -> void:
		if opacity == 0:
			node.hide()
		else:
			node.show()
	)

func slide_from_left(node: Object, show: bool) -> void:
	var tween = create_tween()
	var pos = node.position;

	var factor = (18 * 7.5)

	var future_pos = Vector2(pos.x + factor, pos.y) if show else Vector2(pos.x - factor, pos.y)

	tween.tween_property(node, "position", future_pos, 0.2)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_open"):
		toggle(%FileDialog)
	if Input.is_action_just_pressed("ui_cancel"):
		toggle(%FileDialog)

func _on_file_dialog_ui_close():
	toggle(%FileDialog)
