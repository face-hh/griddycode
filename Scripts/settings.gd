extends CodeEdit

@onready var code: CodeEdit = %Code
@onready var editor: FileManager = $".."

const VARIABLE = preload("res://Icons/variable.png")
const FUNCTION = preload("res://Icons/function.png")

@onready var rich_text_labels: Array[RichTextLabel] = [
	%FileDialog,
];

var file_modified = false;

var _show = false;
var active_overlay: Variant;
var node_is_transitioning: bool;

var zoom_level: float = 1.0
const ZOOM_STEP: float = 0.1
const MIN_ZOOM: float = 0.5
const MAX_ZOOM: float = 2.0

func _ready() -> void:
	grab_focus()
    
	LuaSingleton.on_theme_load.connect(setup_theme)
    
	tween_fade(%FileDialog, 0)
	tween_fade(%Settings, 0)
    
	setup_theme()
    
    # Set initial zoom from settings
    zoom_level = LuaSingleton.get_setting("editor_zoom")[0].get("value", 1.0)
    _apply_zoom()

func setup_theme() -> void:
	setup_highlighter()

	%Background.color = LuaSingleton.gui.background_color;
	%ExternalBackground.color = LuaSingleton.gui.background_color;

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
		if CH.has_color_region(entry[0]): continue

		CH.add_color_region(entry[0], entry[1], LuaSingleton.keywords[entry[2]], entry[3])

func _apply_zoom() -> void:
    var font = get_theme_font("font")
    if font:
        var base_size = font.size
        add_theme_font_size_override("font_size", int(base_size * zoom_level))
    
    # Update minimap if enabled
    if LuaSingleton.get_setting("minimap")[0].get("value", true):
        draw_minimap = true
        minimap_width = int(LuaSingleton.get_setting("minimap_width")[0].get("value", 80) * zoom_level)
    
    # Emit signal for other components to adjust
    LuaSingleton.on_zoom_change.emit(zoom_level)

func _input(event: InputEvent) -> void:
    if event is InputEventKey and event.pressed:
        if event.ctrl_pressed:
            if event.keycode == KEY_EQUAL: # Ctrl + Plus
                zoom_level = min(zoom_level + ZOOM_STEP, MAX_ZOOM)
                _apply_zoom()
                editor.warn("[color=green]INFO[/color]: Zoom level: " + str(int(zoom_level * 100)) + "%")
            elif event.keycode == KEY_MINUS: # Ctrl + Minus
                zoom_level = max(zoom_level - ZOOM_STEP, MIN_ZOOM)
                _apply_zoom()
                editor.warn("[color=green]INFO[/color]: Zoom level: " + str(int(zoom_level * 100)) + "%")
            elif event.keycode == KEY_0: # Ctrl + 0 (Reset zoom)
                zoom_level = 1.0
                _apply_zoom()
                editor.warn("[color=green]INFO[/color]: Zoom reset to 100%")

# CodeEdit functionality
func _on_code_completion_requested() -> void:
	var function_names = LuaSingleton.lua.call_function("detect_functions", [text, get_caret_line(), get_caret_column()])
	var variable_names = LuaSingleton.lua.call_function("detect_variables", [text, get_caret_line(), get_caret_column()])
	var context = get_line(get_caret_line()).substr(0, get_caret_column()).strip_edges()
    
    # Add context-aware completions
    if context.ends_with("."):
        var obj_name = context.substr(0, context.length() - 1).strip_edges()
        # Add method suggestions based on object type
        if typeof(function_names) == Variant.Type.TYPE_ARRAY:
            for each in unique_array(function_names):
                if each.begins_with(obj_name + "."):
                    var method = each.substr(obj_name.length() + 1)
                    add_code_completion_option(CodeEdit.KIND_FUNCTION, method, method+"()", LuaSingleton.keywords.function, FUNCTION)
    else:
        # Regular completions
        if typeof(function_names) == Variant.Type.TYPE_ARRAY:
            for each in unique_array(function_names):
                add_code_completion_option(CodeEdit.KIND_FUNCTION, each, each+"()", LuaSingleton.keywords.function, FUNCTION)
        if typeof(variable_names) == Variant.Type.TYPE_ARRAY:
            for each in unique_array(variable_names):
                add_code_completion_option(CodeEdit.KIND_VARIABLE, each, each, LuaSingleton.keywords.variable, VARIABLE)

    update_code_completion_options(true)

func unique_array(arr: Array) -> Array:
	var out := {}
	for element in arr:
		out[element] = element
	return out.values()

func _on_text_changed() -> void:
    if !current_file:
        return
    
    file_modified = true
    request_code_completion()
    queue_redraw() # Trigger color preview redraw
    
    # Auto-save after a delay
    if has_node("AutoSaveTimer"):
        $AutoSaveTimer.stop()
        $AutoSaveTimer.start(2.0)  # 2-second delay before auto-save

func _draw_color_preview() -> void:
    var text = get_line(get_caret_line())
    var regex = RegEx.new()
    
    # Match different color formats
    regex.compile("\\b(?:rgb\\(\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+)\\s*\\)|rgba\\(\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*([\\d.]+)\\s*\\)|#([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8}))\\b")
    
    var result = regex.search_all(text)
    if result:
        for match in result:
            var color: Color
            var preview_rect = Rect2(0, 0, 16, 16)
            
            if match.get_string().begins_with("rgb"):
                if match.get_string().begins_with("rgba"):
                    color = Color(
                        float(match.get_string(4)) / 255.0,
                        float(match.get_string(5)) / 255.0,
                        float(match.get_string(6)) / 255.0,
                        float(match.get_string(7))
                    )
                else:
                    color = Color(
                        float(match.get_string(1)) / 255.0,
                        float(match.get_string(2)) / 255.0,
                        float(match.get_string(3)) / 255.0,
                        1.0
                    )
            else: # Hex color
                var hex = match.get_string(8)
                if hex.length() == 3:
                    hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2]
                color = Color.from_string(hex, Color.WHITE)
            
            # Calculate preview position
            var start_pos = get_pos_at_line_column(get_caret_line(), match.get_start())
            preview_rect.position = Vector2(start_pos.x, start_pos.y)
            
            # Draw color preview
            draw_rect(preview_rect, color)
            draw_rect(preview_rect, Color.WHITE, false, 1.0) # Border

# UI animations
func toggle(node: Object, apply_background: bool = true, factor: float = (18 * 7.5)) -> void:
	# fuck me
	# _show is a boolean to show the editor
	# _show is NOT a boolean to show the overlay

	# i dont know what the fuck is happening here, but ill try explaining it
	if active_overlay != node and active_overlay != null: return # we already have an overlay active, and this function call isn't from it trying to hide, so fuck off
	if active_overlay == node && !_show: return # if the active overlay is the node trying to toggle, and it wants to show even tho it's already shown, it shall fuck off
	if node_is_transitioning: return # node is already trying to go, stop spamming the keys; DO NOT FUCKING REMOVE.

	var opacity = 0 if _show else 1;

	tween_fade(node, opacity)

	var future_pos = slide_from_left(node, opacity, factor)

	if node is FileDialogType:
		node.active = !_show;

		if _show && !editor.current_file:
			editor.warn("[color=yellow]WARNING[/color]: You are currently in an empty file. No autosave will be performed.")

	if apply_background:
		tween_fade(%Background, opacity, !_show)
	elif not apply_background and !_show:
		node.grab_focus()

	if _show:
		%Cam.focus_die()
		if !node is FileDialogType:
			code.grab_focus()
	else:
		if node.name == "Info":
			future_pos.x += 700
			future_pos.y += 500
		if node.name == "Settings":
			future_pos.x += 200
			future_pos.y += 300
		if node.name == "Comments":
			future_pos.x += 200
			future_pos.y += 300

		%Cam.focus_on(future_pos, node.zoom if ("zoom" in node) else Vector2(1,1))
		code.release_focus()

	_show = !_show;

func tween_fade(node: Object, opacity: float, ignore_gui: bool = false) -> void:
	var tween = create_tween()
	var color = node.modulate
    
    # Add smooth easing
    tween.set_ease(Tween.EASE_OUT)
    tween.set_trans(Tween.TRANS_CUBIC)
    
    if opacity == 1:
        node.show()
        # Slide up animation
        var start_pos = node.position
        start_pos.y += 20
        node.position = start_pos
        tween.parallel().tween_property(node, "position:y", start_pos.y - 20, 0.3)
    
    color.a = opacity
    tween.parallel().tween_property(node, "modulate", color, 0.3)
    
    tween.tween_callback(func() -> void:
        if opacity == 0:
            node.hide()
            if !ignore_gui: active_overlay = null
            if node is CommentsOverlay:
                node.container.setup()
        else:
            node.show()
            if !ignore_gui: active_overlay = node
    )

func slide_from_left(node: Object, __show: bool, factor: float) -> Vector2:
	node_is_transitioning = true
    
    var tween = create_tween()
    tween.set_ease(Tween.EASE_OUT)
    tween.set_trans(Tween.TRANS_CUBIC)
    
    var pos = node.global_position
    var future_pos = Vector2(pos.x + factor, pos.y) if __show else Vector2(pos.x - factor, pos.y)
    
    # Add slight y-axis movement for more natural feel
    var y_offset = 10
    if __show:
        node.position.y += y_offset
        tween.parallel().tween_property(node, "position:y", node.position.y - y_offset, 0.3)
    
    tween.parallel().tween_property(node, "position:x", future_pos.x, 0.3)
    tween.tween_callback(func() -> void:
        node_is_transitioning = false
    )
    
    return future_pos

func _on_file_dialog_ui_close():
	toggle(%FileDialog)


# MISC

func get_longest_line(lines: Array = text.split("\n")) -> String:
	var longestLine := ""

	for line in lines:
		if line.length() > longestLine.length():
			longestLine = line

	return longestLine

func _process(_delta):
	if Input.is_action_just_pressed("ui_open"):      toggle(%FileDialog)
	if Input.is_action_just_pressed("ui_settings"):  toggle(%Settings, true, (18 * 7.5) * 2)
	if Input.is_action_just_pressed("ui_info"):      toggle(%Info, true, 1500)
	if Input.is_action_just_pressed("ui_theme"):     toggle(%ThemeChooser, false, (18 * 28))
	if Input.is_action_just_pressed("ui_cancel"):    toggle(%FileDialog)
	if Input.is_action_just_pressed("ui_comments"):  toggle(%Comments, false, -(18 * 7.5))

func _on_gui_input(_event):
	if Input.is_action_just_pressed("ui_open"):      accept_event(); toggle(%FileDialog)
	if Input.is_action_just_pressed("ui_settings"):  accept_event(); toggle(%Settings, true, (18 * 7.5) * 2)
	if Input.is_action_just_pressed("ui_info"):      accept_event(); toggle(%Info, true, 1500)
	if Input.is_action_just_pressed("ui_theme"):     accept_event(); toggle(%ThemeChooser, false, (18 * 28))
	if Input.is_action_just_pressed("ui_cancel"):    accept_event(); toggle(%FileDialog)
	if Input.is_action_just_pressed("ui_comments"):  accept_event(); toggle(%Comments, false, -(18 * 7.5))
