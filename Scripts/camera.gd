# Info:
# "Caret" refers to the "cursor" of where text is being inserted/deleted in the CodeEdit node.
# "11" refers to the number of characters able to fit on the screen without zooming out.

extends Camera2D

@export var transition_speed: float = 1.0
@onready var code = %Code

signal get_busy

var max_zoom = Vector2(10.0, 10.0);
var min_zoom = Vector2(1.0, 1.0);

# Ignore mouse movement? \/
var busy = false;
var initial_pos = Vector2(952, 536); # cry about it

func _ready() -> void:
	get_busy.connect(func() -> void:
		busy = !busy

		if !busy:
			back_to_normal()
		else:
			back_to_init()
	)

# Called every frame.
func _process(delta: float) -> void:
	if busy: return;

	var line = code.get_caret_line()
	var chars = code.get_line_by_index(line).length();

	var target_zoom = 3 / ((chars + 1) * 0.75);

	var tween = create_tween()

	tween.parallel().tween_property(self, "zoom", Vector2(target_zoom, target_zoom), 1.0);

	var _gp = gp();

	_gp.x /= 2.6;
	_gp.y += 20

	tween.parallel().tween_property(self, "global_position", _gp, 1.0)

# Returns the Global Position of the Caret
func gp() -> Vector2:
	return Vector2(code.get_caret_column(), code.get_caret_line()) * code.get_line_height();

func back_to_normal() -> void:
	busy = true;
	var tween = create_tween()

	tween.parallel().tween_property(self, "global_position", initial_pos, transition_speed)
	tween.parallel().tween_property(self, "zoom", min_zoom, transition_speed)

func back_to_init() -> void:
	busy = false;
	var tween = create_tween()

	tween.parallel().tween_property(self, "global_position", gp(), transition_speed)
	tween.parallel().tween_property(self, "zoom", max_zoom, transition_speed)
