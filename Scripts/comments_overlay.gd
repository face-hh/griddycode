class_name CommentsOverlay

extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var container: Comments = $VBoxContainer

func _ready():
	color_rect.color = LuaSingleton.gui.current_line_color
