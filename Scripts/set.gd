extends Object

class_name Set

var _dict := {}
var elements: Array:
	get:
		return _dict.values()

func _init(from: Array = []) -> void:
	add_all(from)


func add(element:) -> void:
	_dict[element] = element
	

func add_all(elements: Array) -> void:
	for element in elements:
		add(element)
