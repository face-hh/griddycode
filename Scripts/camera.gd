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

var shake_strength: float = 15.0;

var d := 0.0;
var radius := 4.0
var speed := 2.0

func _ready() -> void:
	limit_right = code.size.x


func get_font_metrics() -> Vector2:
	var font: Font = code.get_theme_default_font()
	var font_size: int = code.get_theme_font_size("font", "CodeEdit")
	# NOTE: imo this is a good approximation of the average character size for a non
	# monospaced font.
	return font.get_char_size(0x30, font_size)


const SCALE = 7.0;


func _process(delta: float) -> void:
	d += delta;

	offset = Vector2(
		sin(d * speed) * radius,
		cos(d * speed) * radius
	);

	if busy: return;

	var tween = create_tween();

	var longest_line: String = code.get_longest_line();
	var chars: int = longest_line.length();

	var target_zoom = ((chars+1)) / SCALE;

	target_zoom = max_zoom.x - target_zoom;

	var final_zoom = clamp(Vector2(target_zoom, target_zoom), min_zoom, max_zoom);
	var char_size: Vector2 = get_font_metrics();
	var gp = code.get_caret_draw_pos();

	gp.x -= 2*char_size.x;

	tween.parallel().tween_property(self, "zoom", final_zoom, 1.0);
	tween.parallel().tween_property(self, "global_position", gp, 1.0);

func focus_on(pos: Vector2, _zoom: Vector2) -> void:
	busy = true;
	var tween = create_tween()

	tween.parallel().tween_property(self, "global_position", pos, transition_speed)
	tween.parallel().tween_property(self, "zoom", _zoom, transition_speed)

func focus_die() -> void:
	busy = false
	var tween = create_tween()

	tween.parallel().tween_property(self, "global_position", code.get_caret_draw_pos(), transition_speed)

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
