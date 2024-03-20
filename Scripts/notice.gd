extends Control
@onready var rich_text_label: RichTextLabel = $RichTextLabel

func set_notice(notice: String) -> void:
	rich_text_label.text = notice
