class_name FileDialogType

extends RichTextLabel

@onready var editor: FileManager = $".."
@onready var code = %Code

var selected_index: int = 0
var dir: DirAccess
var dirs: Array[String]
var bbcode_dirs: Array[String]
var files: Array[String]

var query: String = ""
var search_limit: int = 1000
var current_dirs_count: int = 0
var handled: bool

var zoom: Vector2;

var active: bool = false;
signal ui_close

func change_dir(path) -> void:
	query = ""
	if !dir: dir = DirAccess.open(path)
	#dir.include_hidden = true
	# WARNING: this will heavily affect performance if de-commented

	dirs = [".."];
	dirs.append_array(dir.get_directories())
	dirs.append_array(dir.get_files())

	bbcode_dirs = []
	bbcode_dirs.append_array(dirs)

	current_dirs_count = len(dirs)

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
		query = ""
	elif key_event.keycode == KEY_DOWN:
		selected_index = min(dirs.size() - 1, selected_index + 1)
		query = ""
	elif key_event.keycode == KEY_ENTER:
		handle_enter_key()
		query = ""
	else:
		handled = false
	if current_dirs_count <= search_limit and !handled:
		if key_event.keycode == KEY_BACKSPACE:
			if len(query) > 0:
				query = query.substr(0, len(query) - 1)
		elif key_event.as_text() == 'Alt+R':
			query = ""
		if len(key_event.as_text()) == 1:
			query += key_event.as_text().to_lower()
		elif key_event.as_text().to_lower() == "period":
			query += "."
		if dirs[selected_index].to_lower().begins_with(query):
			bbcode_dirs[selected_index] = "[b]"+bbcode_dirs[selected_index].left(len(query))+"[/b]"+bbcode_dirs[selected_index].right(len(dirs[selected_index])-len(query))
		else:
			for i in range(1, len(dirs)):
				if dirs[i].to_lower().begins_with(query):
					selected_index = i
					bbcode_dirs[selected_index] = make_bold(dirs[selected_index], len(query))
					break

	update_ui()

func update_ui() -> void:
	clear()
	show_items()

func show_items() -> void:
	for i in range(bbcode_dirs.size()):
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

	var filename = bbcode_item.split(".")[0];

	if is_dir: filename = bbcode_item

	if filename.length() > 30:
		filename = filename.left(30) + "..." + filename.right(3)

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
	if selected_index > dirs.size(): return
	# ^^ this happens when the cursor was at, i.e., pos. 6, but arr is only has 4 entries

	var item = dirs[selected_index];

	var is_file = files.find(item) != -1;

	if is_file:
		editor.current_dir = dir.get_current_dir();
		editor.open_file(editor.current_dir + "/" + item)

		LuaSingleton.setup_extension(item.split(".")[-1])

		code.setup_highlighter()
		get_tree().create_timer(.1).timeout.connect(func():
			code.grab_focus()
		)

		ui_close.emit()
	else:
		selected_index = 0;
		dir.change_dir(item)
		change_dir(item)
	update_ui()

func make_bold(string: String, size: int):
	return "[b]" + string.left(len(query)) + "[/b]" + string.right(len(string)-len(query))

# global_position is slightly off, so we customize it a little.
func gp() -> Vector2:
	var vec = global_position;

	vec.x += 100;

	return vec;
