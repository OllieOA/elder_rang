extends SwipableObject

export (NodePath) onready var sprite_animator = get_node(sprite_animator) as AnimationPlayer

var seek_spot: float
var anim_length


func _ready() -> void:
	base_sprite.position.x = 0
	sprite_animator.current_animation = "swipe"
	anim_length = sprite_animator.current_animation_length


func _process(delta: float) -> void:
	seek_spot = anim_length * swipe_progress.value
	sprite_animator.seek(seek_spot)
