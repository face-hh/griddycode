class_name Comment

extends Control

@onready var _name: RichTextLabel = $Name
@onready var comment: RichTextLabel = $Comment
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	_name.clear()
	comment.clear()

func setup(__name: String, __comment: String) -> void:
	_name.text = __name;

	comment.add_text(__comment)
	comment.add_text("\n")
	comment.push_color(LuaSingleton.keywords.comments)
	comment.pop()

	var path = "res://Icons/Comments/" + __name + ".png";

	sprite.texture = load(path)
