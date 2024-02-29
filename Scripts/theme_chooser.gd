extends OptionButton
@onready var editor: FileManager = $"../.."
@onready var code = %Code

var zoom: Vector2;

func _ready():
	await LuaSingleton.on_theme_load;

	for _theme in LuaSingleton.themes:
		add_item(_theme)

	selected = LuaSingleton.themes.find(LuaSingleton.theme)

	zoom = Vector2(1,1)
