extends MarginContainer

export (NodePath) onready var hint_animator = get_node(hint_animator) as AnimationPlayer


func _ready() -> void:
	hint_animator.play("hint")
