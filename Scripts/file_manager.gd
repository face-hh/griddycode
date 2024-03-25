class_name FileManager
extends Node2D

@onready var Code: CodeEdit = %Code;
@onready var file_dialog = %FileDialog
@onready var canvas_layer: CanvasLayer = $CanvasLayer
const NOTICE = preload("res://Scenes/notice.tscn")

var current_file: String;
var current_dir: String = "/";

var time_start = 0
var time_now = 0

func _ready():
	print(OS.get_cmdline_args())
	if LuaSingleton.discord_sdk:
		DiscordSDK.app_id = 1220393467738591242 # Application ID

		DiscordSDK.large_image = "griddycode" # Image key from "Art Assets"
		DiscordSDK.large_image_text = "https://github.com/face-hh/griddycode"
		DiscordSDK.start_timestamp = int(Time.get_unix_time_from_system())
	var running_on_gaming_os = OS.get_name() == "Windows"
	if running_on_gaming_os:
		current_dir = "C:/"

	var args = OS.get_cmdline_args()
	var is_debug = OS.is_debug_build()
	var path = []
	# in order to be compatible with the gayming OS...
	var pwd_cmd = "pwd"

	if running_on_gaming_os:
		pwd_cmd = "cd" # running "cd" without any args will only print the path

	OS.execute(pwd_cmd, [], path)

	path = path[0].replace("\n", "")

	if args.size() > 0:
		if args[0] != ".":
			current_file = path + "/" + args[0]
		current_dir = path

	var is_cli = args.size() > 0
	print("INFO: Running inside CLI mode: ", is_cli)

	inject_lua()
	check_for_reserved()

	load_game(is_cli)
	open_file(current_file)

	LuaSingleton.themes = list_themes()

	LuaSingleton.setup_extension(current_file.split(".")[-1])
	LuaSingleton.setup_theme(LuaSingleton.theme)

	file_dialog.setup()

	if !current_file:
		LuaSingleton.setup_discord_sdk("Idle", "")
		Code.toggle(%FileDialog)
		warn("Welcome to [color=#c9daf8]Bussin[/color] [color=#85c6ff]GriddyCode[/color]! Please select a file, then press CTRL + I to get started! :D")

func check_for_reserved() -> void:
	var folders = ["langs", "themes"]

	for folder in folders:
		if !DirAccess.dir_exists_absolute(folder):
			DirAccess.make_dir_recursive_absolute("user://" + folder)

func _on_file_dialog_file_selected(path: String) -> void:
	open_file(path)

func inject_lua() -> void:
	DirAccess.make_dir_absolute("user://themes")
	DirAccess.make_dir_absolute("user://langs")

	var themes = DirAccess.open("res://Lua/Themes").get_files()
	var plugins = DirAccess.open("res://Lua/Plugins").get_files()

	for theme in themes:
		copy_if_not_exist("themes", "Themes", theme)
	for plugin in plugins:
		copy_if_not_exist("langs", "Plugins", plugin)

func copy_from_res(from: String, to: String) -> void:
	var file_from = FileAccess.open(from, FileAccess.READ)
	var file_to = FileAccess.open(to, FileAccess.WRITE)
	file_to.store_buffer(file_from.get_buffer(file_from.get_length()))
	file_to = null
	file_from = null

func copy_if_not_exist(user_path: String, res_path: String, file: String) -> void:
	if !file.contains("lua"): return

	var path = "user://" + user_path + "/" + file;
	var current_path = "res://Lua/" + res_path + "/" + file;

	DirAccess.remove_absolute(path)
	copy_from_res(current_path, path)

func warn(notice: String) -> void:
	var node = NOTICE.instantiate()

	canvas_layer.add_child(node)

	node.set_notice(notice)

	get_tree().create_timer(3).timeout.connect(func():
		node.queue_free()
	)

func open_file(path: String) -> void:
	LuaSingleton.setup_discord_sdk("Editing " + path.split("/")[-1], "In " + current_dir.split("/")[-1])

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

func load_game(cli: bool = false):
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

		if !cli:
			current_dir = node_data["current_dir"]
			current_file = node_data["current_file"]

		LuaSingleton.theme = node_data["theme"]

		var settings = node_data["settings"]
		var new_settings = []

		for dic: Dictionary in settings:
			LuaSingleton.handle_internal_setting_change(dic.property, dic.value)

			var index = LuaSingleton.get_setting(dic.property)[1]

			if index == -1:
				print("WARNING: Omitted setting \"%s\" due to finding operation failing." % dic.property)
				return

			LuaSingleton.settings.remove_at(index)
			new_settings.append(dic)

		for setting in LuaSingleton.settings:
			if not new_settings.has(setting):
				new_settings.append(setting)

		LuaSingleton.settings = new_settings
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
