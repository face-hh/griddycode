extends VBoxContainer

const SETTING = preload("res://Scenes/setting.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	await LuaSingleton.on_theme_load;

	setup_settings()

	LuaSingleton.on_settings_change.connect(setup_settings);

func setup_settings() -> void:
	for child in get_children():
		child.queue_free()

	for setting in LuaSingleton.settings:
		var unit = setting.unit if setting.has("unit") else "";
		var _min = setting.min if setting.has("min") else 0;
		var _max = setting.max if setting.has("max") else 0;
		var precision = setting.precision if setting.has("precision") else false;

		create_setting(setting.display, setting.icon, setting.value, setting.options, setting.property, unit, _min, _max, precision)

func create_setting(text: String, icon: String, value: Variant, options: Array, property: String, unit: String, _min: float, _max: float, precision: bool) -> void:
	var node = SETTING.instantiate()

	add_child(node)

	var label: RichTextLabel = node.get_node("Control/RichTextLabel");

	var slider: HSlider = node.get_node("Control2/HSlider")
	var checkbutton: CheckButton = node.get_node("Control2/CheckButton");
	var value_label: RichTextLabel = node.get_node("Control4/Value");
	var dropdown: OptionButton = node.get_node("Control5/OptionButton");

	label.add_theme_color_override("default_color", LuaSingleton.gui.font_color);
	value_label.add_theme_color_override("default_color", LuaSingleton.gui.font_color);

	label.clear()

	label.push_color(LuaSingleton.keywords.values().pick_random())
	label.add_text(icon)
	label.pop()

	label.add_text("  %s" % text)

	if !precision:
		slider.step = 1

	slider.max_value = _max
	slider.min_value = _min

	checkbutton.hide()
	slider.hide()
	dropdown.hide()
	value_label.hide()

	if typeof(value) == Variant.Type.TYPE_BOOL:
		checkbutton.show()

		checkbutton.button_pressed = value;
	elif options.size() != 0:
		dropdown.show()

		for option in options:
			dropdown.add_item(option.display)

		dropdown.selected = value;
	else:
		value_label.show()

		set_label(value_label, unit, value)

		slider.show()
		slider.value = value

	slider.value_changed.connect(_slider_value_change.bind(property, value_label, unit))
	checkbutton.toggled.connect(_check_button_change.bind(property))
	dropdown.item_selected.connect(_dropdown_change.bind(property))

func set_label(value_label: RichTextLabel, unit: String, value: float) -> void:
	value_label.clear()

	value_label.add_text(str(value) + " ")

	value_label.push_color(LuaSingleton.gui.selection_color)
	value_label.add_text(unit)
	value_label.pop()

func _slider_value_change(value: float, property: String, value_label: RichTextLabel, unit: String) -> void:
	LuaSingleton.change_setting(property, value)

	set_label(value_label, unit, value)

func _check_button_change(toggled_on: bool, property: String) -> void:
	LuaSingleton.change_setting(property, toggled_on)

func _dropdown_change(index: int, property: String):
	LuaSingleton.change_setting(property, index)
