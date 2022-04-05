class_name BaseLevel extends Node2D


export (NodePath) onready var player_camera = get_node(player_camera) as Camera2D
export (NodePath) onready var background = get_node(background) as Sprite
export (NodePath) onready var black_fade = get_node(black_fade) as ColorRect
export (NodePath) onready var black_fade_animator = get_node(black_fade_animator) as AnimationPlayer
export (NodePath) onready var you_died_label = get_node(you_died_label) as Label
export (NodePath) onready var end_game_restart = get_node(end_game_restart) as MarginContainer
export (NodePath) onready var settings_button_container = get_node(settings_button_container) as MarginContainer
export (NodePath) onready var settings_panel_container = get_node(settings_panel_container) as MarginContainer


# Camera vars
var camera_centre := Vector2.ZERO
var camera_movement_size := Vector2.ZERO
var camera_target_position := Vector2.ZERO
var mouse_to_viewport_ratio := Vector2.ZERO
var mouse_to_viewport_normalised := Vector2.ZERO


func _ready() -> void:
	settings_button_container.show()
	you_died_label.hide()
	black_fade.color.a = 0
	end_game_restart.hide()
	call_deferred("_get_camera_bounds")
	SignalBus.connect("game_lost", self, "_handle_game_lost")
	yield(get_tree().create_timer(5.0), "timeout")
	SignalBus.connect("restart_button_pressed", self, "_handle_restart_button_pressed")


func _process(delta: float) -> void:
	if not Input.is_action_pressed("main_click"):
		# Set camera positioning
		mouse_to_viewport_ratio = get_viewport().get_mouse_position() / (get_viewport_rect().size * Vector2(0.5, 0.5))
		mouse_to_viewport_normalised = 2 * (mouse_to_viewport_ratio - Vector2(1, 1))
		
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
	
	
func _handle_game_lost():
	black_fade_animator.play("fade_to_black")
	yield(black_fade_animator, "animation_finished")
	var t_fade = Tween.new()
	var t_write = Tween.new()
	
	add_child(t_fade)
	add_child(t_write)
	
	settings_button_container.hide()
	you_died_label.modulate.a = 0
	you_died_label.show()
	t_fade.interpolate_property(you_died_label, "modulate", Color("ffffff00"), Color("ffffffff"), 2.0)
	t_fade.start()
	yield(t_fade, "tween_completed")
	
	t_write.interpolate_property(you_died_label, "percent_visible", 0.082, 1.0, 1.0)
	t_write.start()

	yield(t_write, "tween_completed")
	yield(get_tree().create_timer(5.0), "timeout")
	
	end_game_restart.show()

func _handle_restart_button_pressed():
	settings_panel_container.hide()
	GameControl.goto_scene("res://scenes/title_screen.tscn")
	
