## This is a Debug Node wich will show some usefull info and buttons/input
## 
## The DiscordSDK Debug Node will show info about the current values of its variables and some buttons to change them.
##
## @tutorial: https://github.com/vaporvee/discord-sdk-godot/wiki
@tool
extends Node

func _ready() -> void:
	const DebugNodeGroup: PackedScene = preload("res://addons/discord-sdk-gd/nodes/Debug.tscn")
	add_child(DebugNodeGroup.instantiate())
