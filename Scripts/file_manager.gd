class_name FileManager
extends Node2D

@onready var Code: CodeEdit = %Code;
@onready var file_dialog = %FileDialog

var current_file: String;
var current_dir: String = "/";

func _ready():
	check_for_reserved()

	load_game()
	open_file(current_file)

	LuaSingleton.themes = list_themes()

	LuaSingleton.setup_extension(current_file.split(".")[-1])
	LuaSingleton.setup_theme(LuaSingleton.theme)

	file_dialog.setup()

	if !current_file:
		Code.toggle(%FileDialog)
		%Intro.show()

func check_for_reserved() -> void:
	var folders = ["langs", "themes"]

	for folder in folders:
		if !DirAccess.dir_exists_absolute(folder):
			DirAccess.make_dir_recursive_absolute("user://" + folder)

func _on_file_dialog_file_selected(path: String) -> void:
	open_file(path)
	%Intro.hide()

func open_file(path: String) -> void:
	var src = Fs._load(path)

	Code.text = src

	current_file = path;

func list_themes() -> Array:
	var themes_folder = DirAccess.open("user://themes");

	var curated = [];

	for theme_file in themes_folder.get_files():
		curated.append(theme_file.replace(".lua", ""))

	return curated;

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		var save_dict = {
			"current_file": current_file,
			"current_dir": current_dir,
			"settings": LuaSingleton.settings,
			"theme": LuaSingleton.theme
		}
		save_data(save_dict)
		Fs.save(current_file, Code.text)

		get_tree().quit()
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		Fs.save(current_file, Code.text)
		# ^^ you usually defocus when you want to run the code, so saving is needed

func save_data(dict: Dictionary):
	var save_game = FileAccess.open("user://data.save", FileAccess.WRITE)

	var json_string = JSON.stringify(dict)

	save_game.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("user://data.save"):
		return # Error! We don't have a save to load.

	var save_game = FileAccess.open("user://data.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		var json = JSON.new()

		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		var node_data = json.get_data()

		current_dir = node_data["current_dir"]
		current_file = node_data["current_file"]
		LuaSingleton.theme = node_data["theme"]

		LuaSingleton.settings = node_data["settings"]

		LuaSingleton.on_settings_change.emit()

func _on_auto_save_timer_timeout():
	if !current_file: return
	if !Code.file_modified: return

	Fs.save(current_file, Code.text)
	Code.file_modified = false;

func preview_theme(index: int) -> void:
	var theme_picker: OptionButton = %ThemeChooser
	var theme = theme_picker.get_item_text(index)

	LuaSingleton.setup_theme(theme)
	LuaSingleton.on_settings_change.emit()

func _on_theme_chooser_item_focused(index):
	preview_theme(index)


func _on_theme_chooser_item_selected(index):
	preview_theme(index)
	LuaSingleton.theme = %ThemeChooser.get_item_text(index)
