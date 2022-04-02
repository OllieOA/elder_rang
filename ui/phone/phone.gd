extends MarginContainer

export (NodePath) onready var conversation_length_label = get_node(conversation_length_label) as Label

func _process(delta: float) -> void:
	conversation_length_label.set_text(GameProgress.conversation_length_string)
