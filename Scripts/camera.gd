# Info:
# "Caret" refers to the "cursor" of where text is being inserted/deleted in the CodeEdit node.
# "11" refers to the number of characters able to fit on the screen without zooming out.
class_name Camera
extends Camera2D

@export var transition_speed: float = 1.0
@onready var code = %Code

var max_zoom = Vector2(10.0, 10.0);
var min_zoom = Vector2(1.0, 1.0);

# Ignore mouse movement? \/
var busy = false;
var boundaries_exceeded = null;

var shake_strength: float = 10.0;

var d := 0.0;
var radius := 4.0
var speed := 5.0

var user_zoom := 1.0

func _ready() -> void:
	limit_right = code.size.x

func _process(delta: float) -> void:
	d += delta;

	offset = Vector2(
		sin(d * speed) * radius,
		cos(d * speed) * radius
	)

	if busy: return;

	var tween = create_tween()

	var chars = code.get_longest_line().length();

	var target_zoom = (chars + 1) / 7.0;

	target_zoom = max_zoom.x - target_zoom

	# this is where user zoom is taken into consideration. for future records.
	if(target_zoom < 1): target_zoom = 1
	target_zoom *= user_zoom

	if(target_zoom < min_zoom.x):
		target_zoom = min_zoom.x
	

	tween.parallel().tween_property(self, "zoom", Vector2(target_zoom, target_zoom), 1.0);

	var _gp = gp();

	_gp.x /= 2.6;
	_gp.y += 20

	tween.parallel().tween_property(self, "global_position", _gp, 1.0)

# process user key input
func _input(_event):
	if Input.is_key_pressed(KEY_CTRL):
		if Input.is_key_pressed(KEY_PLUS):
			user_zoom += 0.25
		if Input.is_key_pressed(KEY_MINUS):
			user_zoom -= 0.25
		
		if user_zoom > 6: user_zoom = 6.0
		if user_zoom < 0.25: user_zoom = 0.25

# Returns the Global Position of the Caret
func gp() -> Vector2:
	return Vector2(code.get_caret_column(), code.get_caret_line()) * code.get_line_height();

func focus_on(pos: Vector2, _zoom: Vector2) -> void:
	busy = true;
	var tween = create_tween()

	tween.parallel().tween_property(self, "global_position", pos, transition_speed)
	tween.parallel().tween_property(self, "zoom", _zoom, transition_speed)

func focus_die() -> void:
	busy = false
	var tween = create_tween()

	tween.parallel().tween_property(self, "global_position", gp(), transition_speed)

func focus_temp(intensity: float) -> void:
	if busy: return

	var tween = create_tween()

	tween.parallel().tween_property(self, "zoom", zoom + Vector2(intensity, intensity), 0.5)

func shake_camera(_shake_strength):
	return Vector2(randf_range(-_shake_strength, _shake_strength), randf_range(-_shake_strength, _shake_strength))

func to_zoom(num: float) -> Vector2:
	if num > 40:
		num += 120;

	num /= 100 # 44 -> 0.44

	num = 4 - num;

	return Vector2(num, num)
