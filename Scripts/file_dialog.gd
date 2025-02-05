class_name FileDialogType

extends RichTextLabel

@onready var editor: FileManager = $".."
@onready var code = %Code

var selected_index: int = 0
var dir: DirAccess
var dirs: Array[String]
var bbcode_dirs: Array[String]
var shortened_dirs: Array[String]
var files: Array[String]

var query: String = ""
var search_limit: int = 1000
var current_dirs_count: int = 0
var handled: bool
var erased: bool
var max_coincidence: Array = []
var coincidence: Array = []

var zoom: Vector2;

var active: bool = false;
signal ui_close

var show_hidden_files: bool = false

func _ready():
    # Add shortcut for toggling hidden files
    var shortcut = Shortcut.new()
    var event = InputEventKey.new()
    event.keycode = KEY_H
    event.ctrl_pressed = true
    shortcut.events.append(event)
    
    show_hidden_files = LuaSingleton.get_setting("show_hidden_files")[0].get("value", false)

func change_dir(path) -> void:
	query = ""
	if !dir: dir = DirAccess.open(path)
	dir.include_hidden = show_hidden_files

	dirs = [".."];
	dirs.append_array(dir.get_directories())
	dirs.append_array(dir.get_files())

	shortened_dirs = []
	for dir_ in dirs:
		if len(dir_) > 30:
			dir_ = dir_.left(30) + "..." + dir_.right(3)
		shortened_dirs.append(dir_)

	bbcode_dirs = []
	bbcode_dirs.append_array(dirs)

	current_dirs_count = len(dirs)

	files.clear()
	files.append_array(dir.get_files())

	zoom = %Cam.to_zoom(code.get_longest_line(dirs).length())

	if active:
		%Cam.focus_on(gp(), zoom)

func setup() -> void:
	active = false
	change_dir(editor.current_dir)

	update_ui()

func _input(event: InputEvent) -> void:
	if !active: return
	if !(event is InputEventKey): return

	var key_event = event as InputEventKey
	bbcode_dirs = []
	bbcode_dirs.append_array(dirs)

	if !(key_event.is_pressed()): return;

	handled = true
	if key_event.keycode == KEY_UP:
		selected_index = max(0, selected_index - 1)
	elif key_event.keycode == KEY_DOWN:
		selected_index = min(len(dirs) - 1, selected_index + 1)
	elif key_event.keycode == KEY_ENTER:
		handle_enter_key()
	elif key_event.keycode == KEY_H && key_event.ctrl_pressed:
		show_hidden_files = !show_hidden_files
		LuaSingleton.change_setting("show_hidden_files", show_hidden_files)
		change_dir(dir.get_current_dir())
		editor.warn("[color=green]INFO[/color]: Hidden files are now " + ("shown" if show_hidden_files else "hidden"))
	else:
		handled = false

	erased = false
	if current_dirs_count <= search_limit and !handled:
		if key_event.keycode == KEY_BACKSPACE:
			erased = true
			if len(query) > 0:
				query = query.substr(0, len(query) - 1)
		elif key_event.as_text() == 'Ctrl+Backspace':
			erased = true
			query = ""
		if len(key_event.as_text()) == 1:
			query += key_event.as_text().to_lower()
		elif key_event.keycode == KEY_PERIOD:
			query += "."

	max_coincidence = []

	if len(query) > 0:
		for i in range(1, len(dirs)):
			coincidence = fuzzy_search(shortened_dirs[i].to_lower(), query)
			bbcode_dirs[i] = make_bold(shortened_dirs[i], coincidence)
			if is_closer(max_coincidence, coincidence):
				max_coincidence = coincidence
				if not handled:	selected_index = i

	update_ui()

func update_ui() -> void:
	clear()
    
    # Add breadcrumb navigation
    var current_path = dir.get_current_dir()
    var path_parts = current_path.split("/")
    var breadcrumb = ""
    push_color(LuaSingleton.keywords.function)
    for i in range(len(path_parts)):
        var part = path_parts[i]
        if part == "":
            add_text("/")
        else:
            add_text(part)
            if i < len(path_parts) - 1:
                push_color(LuaSingleton.keywords.symbol)
                add_text(" › ")
                pop()
    pop()
    add_text("\n\n")

    # Show search results if there's a query
    if query != "":
        push_color(LuaSingleton.keywords.comments)
        add_text("Search results for: ")
        pop()
        push_color(LuaSingleton.keywords.string)
        add_text("\"" + query + "\"\n\n")
        pop()

    # Add directories with modern icons
    var index = 0
    for dir_name in dirs:
        var is_file = files.find(dir_name) != -1
        var icon = Icons.get_icon_data(dir_name.split(".")[-1] if is_file else "folder")
        
        # Highlight selected item
        if index == selected_index:
            push_color(LuaSingleton.keywords.function)
            add_text("→ ")
            pop()
        else:
            add_text("  ")
            
        # Add icon with color
        push_color(str_to_color(icon.color))
        add_text(icon.icon + " ")
        pop()
        
        # Add filename
        if index == selected_index:
            push_color(LuaSingleton.keywords.function)
        add_text(shortened_dirs[index])
        if index == selected_index:
            pop()
            
        add_text("\n")
        index += 1

func str_to_color(hex: String) -> Color:
    if hex.begins_with("#"):
        hex = hex.substr(1)
    return Color.from_string(hex, Color.WHITE)

func show_items() -> void:
	for i in range(len(bbcode_dirs)):
		show_item(i)

func show_item(index: int) -> void:
	var item = dirs[index]
	var bbcode_item = bbcode_dirs[index]
	if is_selected(item):
		push_bgcolor(LuaSingleton.gui.selection_color)
	else:
		push_bgcolor(Color(0, 0, 0, 0))  # Reset background color if not selected

	var is_dir = dir.get_directories().find(item) != -1

	if item == "..":
		push_color(LuaSingleton.gui.font_color)
		add_text("󰕌")
	elif is_dir:
		push_color(LuaSingleton.gui.completion_selected_color)
		add_text("")
	else:
		var extension = item.split(".")[-1]
		var data = Icons.get_icon_data(extension)

		push_color(Color.from_string(data.color, data.color))
		add_text(data.icon)

	pop()

	var filename = bbcode_item.split(".")[0]

	if is_dir: filename = bbcode_item


	if bbcode_item == "..":
		append_text(" %s\n" % [ bbcode_item ])
	elif is_dir or !item.contains("."):
		append_text(" %s\n" % [ filename ])
	else:
		append_text(" %s.%s\n" % [ filename, bbcode_item.split(".")[1] ])

	if active: %Cam.focus_on(Vector2(gp().x, global_position.y + (selected_index * 23)), zoom)

# i gave up at that point, sorry for what you're about to witness
func is_selected(item: String) -> bool:
	var dir_item = dirs.find(item);

	var is_dir_item = dir_item != -1;
	var is_dir_current = dir_item == selected_index;

	return (is_dir_item and is_dir_current)

func handle_enter_key() -> void:
    if selected_index >= len(dirs):
        return
    
    var item = dirs[selected_index]
    var is_file = files.find(item) != -1

    if is_file:
        # Check file permissions and existence before proceeding
        var file_path = editor.current_dir + "/" + item
        if !FileAccess.file_exists(file_path):
            editor.warn("[color=yellow]WARNING[/color]: File no longer exists: " + file_path)
            change_dir(editor.current_dir)  # Refresh directory listing
            return
            
        if !OS.is_executable_file_at(file_path) && !FileAccess.file_exists(file_path):
            editor.warn("[color=yellow]WARNING[/color]: File is not accessible: " + file_path)
            return

        editor.current_dir = dir.get_current_dir()
        editor.open_file(file_path)

        var extension = item.split(".")[-1]
        LuaSingleton.setup_extension(extension)

        code.setup_highlighter()
        get_tree().create_timer(.1).timeout.connect(func():
            code.grab_focus()
        )

        ui_close.emit()
    else:
        selected_index = 0
        
        # Check directory permissions before changing
        if !DirAccess.dir_exists_absolute(item):
            editor.warn("[color=yellow]WARNING[/color]: Directory no longer exists: " + item)
            return
            
        var access = DirAccess.open(item)
        if access == null:
            editor.warn("[color=yellow]WARNING[/color]: Cannot access directory: " + item)
            return

        dir.change_dir(item)
        change_dir(item)
        
    update_ui()

func make_bold(string: String, indexes: Array) -> String:
	var new_string: String = ""

	for i in range(len(string)):
		if i in indexes: new_string += "[i][color=yellow]" + string[i] + "[/color][/i]"
		else: new_string += string[i]

	return new_string

func fuzzy_search(string: String, substring: String) -> Array:
	var indexes: Array = []
	var pos: int = 0
	var last_index: int = 0

	for i in range(string.length()):
		if string[i] == substring[pos]:
			indexes.append(i)
			pos += 1
			if pos == substring.length():
				break
		else:
			if last_index < i - 1:
				i = last_index
			pos = 0
			indexes = []

		last_index = i

	return indexes

# Compares 2 fuzzy Arrays and returns if 'new' Array is closer to query than 'old'
func is_closer(old: Array, new: Array) -> bool:
	if len(old) == 0: return true
	if len(new) == 0: return false

	if old == new: return false

	for i in range(len(old)):
		if old[i] > new[i]: return true
		elif old[i] < new[i]: return false

	return false

# global_position is slightly off, so we customize it a little.
func gp() -> Vector2:
	var vec = global_position;

	vec.x += 100;

	return vec;
