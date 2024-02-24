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
	LuaSingleton.setup(current_file.split(".")[-1])
	file_dialog.setup()

func check_for_reserved() -> void:
	var folders = ["langs", "themes"]

	for folder in folders:
		if !DirAccess.dir_exists_absolute(folder):
			DirAccess.make_dir_recursive_absolute("user://" + folder)

func _on_file_dialog_file_selected(path: String) -> void:
	open_file(path)

func open_file(path: String) -> void:
	var src = Fs._load(path)

	Code.text = src

	current_file = path;

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		var save_dict = {
			"current_file": current_file,
			"current_dir": current_dir,
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

func _on_auto_save_timer_timeout():
	if !current_file: return
	if !Code.file_modified: return

	Fs.save(current_file, Code.text)
	Code.file_modified = false;
