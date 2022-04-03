class_name BaseLevel extends Node2D


export (NodePath) onready var player_camera = get_node(player_camera) as Camera2D
export (NodePath) onready var background = get_node(background) as Sprite

export (NodePath) onready var debug_label = get_node(debug_label) as Label


# Camera vars
var camera_centre := Vector2.ZERO
var camera_movement_size := Vector2.ZERO
var camera_target_position := Vector2.ZERO
var mouse_to_viewport_ratio := Vector2.ZERO
var mouse_to_viewport_normalised := Vector2.ZERO


func _ready() -> void:
	call_deferred("_get_camera_bounds")


func _process(delta: float) -> void:
	# Set camera positioning
	mouse_to_viewport_ratio = get_viewport().get_mouse_position() / (get_viewport_rect().size * Vector2(0.5, 0.5))
	mouse_to_viewport_normalised = 2 * (mouse_to_viewport_ratio - Vector2(1, 1))
	
	debug_label.set_text(str(mouse_to_viewport_ratio))
	camera_target_position = camera_centre + mouse_to_viewport_normalised * camera_movement_size / 2
	player_camera.position = lerp(player_camera.position, camera_target_position, 0.2)


func _get_camera_bounds() -> void:
	var sprite_rect = background.get_rect()
	camera_centre = sprite_rect.size/2
	
	player_camera.position = camera_centre
	
	# Get camera_movement_size
	camera_movement_size = sprite_rect.size - player_camera.get_viewport_rect().size
	
	player_camera.limit_left = 0
	player_camera.limit_right = sprite_rect.size.x
	player_camera.limit_top = 0 
	player_camera.limit_bottom = sprite_rect.size.y
