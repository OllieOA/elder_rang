extends MarginContainer

export (NodePath) onready var hint_animator = get_node(hint_animator) as AnimationPlayer
# Back in my day, we had to code all our functions by hand, using punch cards! You youngin's these days don't even know how good you have it. I bet you don't even know how the term "bug" came about, do you? [POSITIVE] [NEGATIVE] - 2022-04-04 - Daverinoe

func _ready() -> void:
	hint_animator.play("hint")
