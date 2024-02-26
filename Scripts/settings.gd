extends CodeEdit

@onready var code: CodeEdit = %Code

const VARIABLE = preload("res://Icons/variable.png")
const FUNCTION = preload("res://Icons/function.png")

@onready var rich_text_labels: Array[RichTextLabel] = [
	%FileDialog,
	$"../Intro/RichTextLabel",
	$"../Intro/RichTextLabel2",
	$"../Intro/RichTextLabel3"
];

var file_modified = false;

var _show = false;
var active_overlay: Variant;
var node_is_transitioning: bool;

func _ready() -> void:
	LuaSingleton.on_theme_load.connect(setup_theme)

	tween_fade(%FileDialog, 0)
	tween_fade(%Settings, 0)

	setup_theme()

func setup_theme() -> void:
	setup_highlighter()

	%Background.color = LuaSingleton.gui.background_color;

	code.add_theme_color_override("background_color", LuaSingleton.gui.background_color)
	code.add_theme_color_override("current_line_color", LuaSingleton.gui.current_line_color)
	code.add_theme_color_override("selection_color", LuaSingleton.gui.selection_color)
	code.add_theme_color_override("font_color", LuaSingleton.gui.font_color)
	code.add_theme_color_override("word_highlighted_color", LuaSingleton.gui.word_highlighted_color)
	code.add_theme_color_override("completion_background_color", LuaSingleton.gui.completion_background_color)
	code.add_theme_color_override("completion_selected_color", LuaSingleton.gui.completion_selected_color)
	code.add_theme_color_override("caret_color", LuaSingleton.gui.caret_color)

	for label in rich_text_labels:
		label.add_theme_color_override("default_color", LuaSingleton.gui.font_color)

func setup_highlighter() -> void:
	var CH: CodeHighlighter = CodeHighlighter.new();

	syntax_highlighter = CH;

	CH.number_color = LuaSingleton.keywords.binary;
	CH.symbol_color = LuaSingleton.keywords.symbol;
	CH.function_color = LuaSingleton.keywords.function;
	CH.member_variable_color = LuaSingleton.keywords.member;

	# i dont remember why this was here, but the code works without it now
	#await LuaSingleton.done_parsing;

	var kth = LuaSingleton.keywords_to_highlight;
	var crth = LuaSingleton.color_regions_to_highlight;

	for key in kth:
		CH.add_keyword_color(key, LuaSingleton.keywords[kth[key]])

	for entry in crth:
		CH.add_color_region(entry[0], entry[1], LuaSingleton.keywords[entry[2]], entry[3])

# CodeEdit functionality
func _on_code_completion_requested() -> void:
	var function_names = LuaSingleton.lua.call_function("detect_functions", [text])
	var variable_names = LuaSingleton.lua.call_function("detect_variables", [text])

	if \
		typeof(function_names) != Variant.Type.TYPE_ARRAY or \
		typeof(variable_names) != Variant.Type.TYPE_ARRAY:
			return;

	for each in function_names:
		add_code_completion_option(CodeEdit.KIND_FUNCTION, each, each+"()", LuaSingleton.keywords.function, FUNCTION)
	for each in variable_names:
		add_code_completion_option(CodeEdit.KIND_VARIABLE, each, each, LuaSingleton.keywords.variable, VARIABLE)

	update_code_completion_options(true)


func _on_text_changed() -> void:
	file_modified = true;
	request_code_completion()

# UI animations
func toggle(node: Object, apply_background: bool = true, factor: float = (18 * 7.5)) -> void:
	# fuck me
	# _show is a boolean to show the editor
	# _show is NOT a boolean to show the overlay

	# i dont know what the fuck is happening here, but ill try explaining it
	if active_overlay != node and active_overlay != null: return # we already have an overlay active, and this function call isn't from it trying to hide, so fuck off
	if active_overlay == node && !_show: return # if the active overlay is the node trying to toggle, and it wants to show even tho it's already shown, it shall fuck off
	if node_is_transitioning: return # node is already trying to go, stop spamming the keys; DO NOT FUCKING REMOVE.

	if _show:
		tween_fade(node, 0)
		slide_from_left(node, 0, factor)
		if apply_background:
			tween_fade(%Background, 0)
		code.grab_focus()

		if node is FileDialogType:
			node.active = false;
	else:
		tween_fade(node, 1)
		slide_from_left(node, 1, factor)

		if apply_background: tween_fade(%Background, 1, true)
		else: node.grab_focus()

		code.release_focus()

		if node is FileDialogType:
			node.active = true;

	_show = !_show;

func tween_fade(node: Object, opacity: float, ignore_gui: bool = false) -> void:
	var tween = create_tween()
	var color = node.modulate;

	if opacity == 1:
		node.show()

	color.a = opacity

	tween.tween_property(node, "modulate", color, 0.2)

	tween.tween_callback(func() -> void:
		if opacity == 0:
			node.hide()

			if !ignore_gui: active_overlay = null;
		else:
			node.show()
			if !ignore_gui: active_overlay = node;
	)

func slide_from_left(node: Object, __show: bool, factor: float) -> void:
	node_is_transitioning = true;

	var tween = create_tween()
	var pos = node.position;

	var future_pos = Vector2(pos.x + factor, pos.y) if __show else Vector2(pos.x - factor, pos.y)

	tween.tween_property(node, "position", future_pos, 0.2)
	tween.tween_callback(func() -> void:
		node_is_transitioning = false;
	)

func _on_file_dialog_ui_close():
	toggle(%FileDialog)


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_open"):      toggle(%FileDialog)
	if Input.is_action_just_pressed("ui_settings"):  toggle(%Settings)
	if Input.is_action_just_pressed("ui_info"):      toggle(%Info, true, 1500)
	if Input.is_action_just_pressed("ui_theme"):     toggle(%ThemeChooser, false, (18 * 28))
	if Input.is_action_just_pressed("ui_cancel"):    toggle(%FileDialog)
