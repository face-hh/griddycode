class_name Comments

extends VBoxContainer

const COMMENT = preload ("res://Scenes/comment.tscn")

func _ready():
	await LuaSingleton.done_parsing
	LuaSingleton.on_comments_change.connect(setup)
	setup()

func setup():
	var names = CommentsData.NAMES.duplicate();

	for child in get_children():
		child.queue_free()

	# TODO: if the comments have been erased after this loop, nothing will change.

	for comment in get_random_comments():
		var _name = names.pick_random();

		names.remove_at(names.find(_name))

		var node: Comment = COMMENT.instantiate();

		add_child(node)

		node.setup(_name, comment)

func get_random_comments() -> Array:
	LuaSingleton.comments.shuffle()

	return LuaSingleton.comments.slice(0, 3)
