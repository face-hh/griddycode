extends RichTextLabel


func _ready():
	meta_clicked.connect(func(meta) -> void: OS.shell_open(meta));
