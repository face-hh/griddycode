extends OptionButton
@onready var editor: FileManager = $"../.."

func _ready():
	await LuaSingleton.on_theme_load;

	for _theme in LuaSingleton.themes:
		add_item(_theme)

	selected = LuaSingleton.themes.find(LuaSingleton.theme)
