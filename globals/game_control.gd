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


func _ready() -> void:
	fade_block.color = Color("000000")
	fade_block.color.a = 255

	fade_animator.connect("animation_finished", self, "_handle_animation_finished")
	fade_animator.play_backwards("fade_to_black")
	
	SignalBus.connect("nan_index_update", self, "_handle_nan_index_update")


func _update_nan_index(value):
	nan_index += value
	if nan_index < 0:
		nan_index = len(nan_names) - 1
	elif nan_index >= len(nan_names):
		nan_index = 0
	
	nan_name = nan_names[nan_index].to_upper()
	SignalBus.emit_signal("nan_name_updated")


# Signal handling

func _handle_animation_finished(_anim_name):
	SignalBus.emit_signal("title_fade_complete")


func _handle_nan_index_update(value):
	_update_nan_index(value)

	
