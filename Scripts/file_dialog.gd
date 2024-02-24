extends RichTextLabel

@onready var editor: FileManager = $".."
@onready var code = %Code

var selected_index: int = 0
var dir: DirAccess
var dirs: Array[String]
var files: Array[String]

signal ui_close

func change_dir(path) -> void:
	if !dir: dir = DirAccess.open(path)

	dirs = [".."];
	dirs.append_array(dir.get_directories())
	dirs.append_array(dir.get_files())

	files.append_array(dir.get_files());

func setup() -> void:
	change_dir(editor.current_dir)

	update_ui()

func _input(event: InputEvent) -> void:
	if !(event is InputEventKey): return

	var key_event = event as InputEventKey

	if !(key_event.is_pressed()): return;

	if key_event.keycode == KEY_UP:
		selected_index = max(0, selected_index - 1)
	elif key_event.keycode == KEY_DOWN:
		selected_index = min(dirs.size() - 1, selected_index + 1)
	elif key_event.keycode == KEY_ENTER:
		handle_enter_key()

	update_ui()

func update_ui() -> void:
	clear()
	show_items()

func show_items() -> void:
	for i in range(dirs.size()):
		show_item(dirs[i])

func show_item(item: String) -> void:
	if is_selected(item):
		push_bgcolor(Color.from_string("#444", "#444"))
	else:
		push_bgcolor(Color(0, 0, 0, 0))  # Reset background color if not selected

	if item == "..":
		push_color(Color.from_string("#ffffff", "#ffffff"))
		add_text("󰕌")
	elif dir.get_directories().find(item) != -1:
		push_color(Color.from_string("#575757", "#575757"))
		add_text("")
	else:
		var extension = item.split(".")[-1]
		var data = Icons.get_icon_data(extension)

		push_color(Color.from_string(data.color, data.color))
		add_text(data.icon)

	pop()
	add_text(" " + item + '\n')

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
		%Intro.hide()
		code.setup_highlighter()
		LuaSingleton.setup(item.split(".")[-1])

		ui_close.emit()
	else:
		dir.change_dir(item)
		change_dir(item)
	update_ui()
