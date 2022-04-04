extends ClickableObject

export (String) var rotation_anim
export (NodePath) onready var rotator = get_node(rotator) as AnimationPlayer

export (Texture) var sprite_texture


var seek_value

func _ready() -> void:
	base_sprite.texture = sprite_texture
	base_sprite.rotation_degrees = 0
	rotator.current_animation = rotation_anim


func _process(delta: float) -> void:
	rotator.seek(1 - click_progress.value, true)
