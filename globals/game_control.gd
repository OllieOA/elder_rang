extends Control

export (NodePath) onready var fade_animator = get_node(fade_animator) as AnimationPlayer
export (NodePath) onready var fade_block = get_node(fade_block) as ColorRect

export (NodePath) onready var music_player = get_node(music_player) as AudioStreamPlayer

var nan_index := 0
onready var nan_name = nan_names[nan_index].to_upper()

const nan_names = [
	"Nan",
	"Grandma",
	"Grandmother",
	"Nana",
	"Granny",
	"The Crone",
	"Gram",
	"Mema",
	"The Old One",
	"Gram-Gram",
	"Gramlin"
]

# Scene control
var current_scene
var following_scene


func _ready() -> void:
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
	
	fade_block.color = Color("000000")
	fade_block.color.a = 0

	fade_animator.connect("animation_finished", self, "_handle_animation_finished")
	
	SignalBus.connect("nan_index_update", self, "_handle_nan_index_update")


func _update_nan_index(value):
	nan_index += value
	if nan_index < 0:
		nan_index = len(nan_names) - 1
	elif nan_index >= len(nan_names):
		nan_index = 0
	
	nan_name = nan_names[nan_index].to_upper()
	SignalBus.emit_signal("nan_name_updated")


func goto_scene(path, speed=0.5):
	following_scene = path
	fade_animator.playback_speed = speed
	fade_animator.play("fade_to_black")
	
	
func process_scene_transition(path):
	current_scene.queue_free()
	var new_scene = ResourceLoader.load(path)
	current_scene = new_scene.instance()
	
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	fade_animator.play_backwards()



# Signal handling

func _handle_animation_finished(_anim_name):
	SignalBus.emit_signal("title_fade_complete")
	
	# Only transition once animation has completed
	if GameControl.following_scene != null:
		call_deferred("process_scene_transition", GameControl.following_scene)
	GameControl.following_scene = null


func _handle_nan_index_update(value):
	_update_nan_index(value)

	
