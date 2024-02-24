extends Node

func save(path: String, content: String) -> void:
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(content)

func _load(path: String) -> String:
	var file = FileAccess.get_file_as_string(path)
	return file
