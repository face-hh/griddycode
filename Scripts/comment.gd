class_name Comment

extends Control

@onready var _name: RichTextLabel = $Name
@onready var comment: RichTextLabel = $Comment
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	_name.clear()
	comment.clear()

func setup(__name: String, __comment: String) -> void:
	var num = randi_range(800, 34000);
	var duration = randi_range(1, 14);

	_name.add_text(__name);
	_name.push_color(LuaSingleton.keywords.comments)
	_name.add_text(" " + str(duration) + "d")
	_name.pop()

	comment.add_text(__comment)
	comment.add_text("\n\n")
	comment.push_color(LuaSingleton.keywords.comments)
	comment.add_text(str(num) + " likes")
	comment.pop()

	var path = "res://Icons/Comments/" + __name + ".png";

	sprite.texture = load(path)
