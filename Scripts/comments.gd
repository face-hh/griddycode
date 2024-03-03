extends VBoxContainer

const COMMENT = preload("res://Scenes/comment.tscn")

func _ready():
	await LuaSingleton.done_parsing

	setup()

func setup():
	for child in get_children():
		child.queue_free()

	for comment in get_random_comments():
		var node: Comment = COMMENT.instantiate();

		add_child(node)

		node.setup(CommentsData.NAMES.pick_random(), comment)

func get_random_comments() -> Array:
	LuaSingleton.comments.shuffle()

	return LuaSingleton.comments.slice(0, 3)
