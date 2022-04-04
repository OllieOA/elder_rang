extends Node

onready var master_bus_id = AudioServer.get_bus_index("Master")
onready var music_bus_id = AudioServer.get_bus_index("Music")

export (NodePath) onready var title_music = get_node(title_music) as AudioStreamPlayer
export (NodePath) onready var title_music_fade = get_node(title_music_fade) as Tween


var bus_to_level = {
	"Master": 1.0,
	"Music": 1.0
}

onready var target_bus_id = {
	"Master": master_bus_id,
	"Music": music_bus_id
}


func _ready() -> void:
	SignalBus.connect("mute_audio_bus", self, "_handle_mute_audio_bus")
	SignalBus.connect("unmute_audio_bus", self, "_handle_unmute_audio_bus")
	SignalBus.connect("audio_volume_changed", self, "_handle_audio_volume_changed")
	SignalBus.connect("dialled_nan", self, "_handle_dialled_nan")
	
	SignalBus.connect("restart_button_pressed", self, "_handle_restart_button_pressed")
	
	title_music.volume_db = linear2db(0)
	title_music.play()
	title_music_fade.interpolate_property(title_music, "volume_db", linear2db(0), linear2db(1), 1.0)
	title_music_fade.start()



# Signal handling

func _handle_mute_audio_bus(target_bus):
	AudioServer.set_bus_mute(target_bus_id[target_bus], true)


func _handle_unmute_audio_bus(target_bus):
	AudioServer.set_bus_mute(target_bus_id[target_bus], false)


func _handle_audio_volume_changed(target_bus):
	var volume_to_set = bus_to_level[target_bus]
	AudioServer.set_bus_volume_db(target_bus_id[target_bus], linear2db(volume_to_set))


func _handle_dialled_nan():
	title_music_fade.interpolate_property(title_music, "volume_db", linear2db(bus_to_level["Music"]), linear2db(0), 3.0)
	title_music_fade.start()
	yield(title_music_fade, "tween_completed")
	title_music.stop()


func _handle_restart_button_pressed():
	title_music.play()
	title_music_fade.interpolate_property(title_music, "volume_db", linear2db(bus_to_level["Music"]), linear2db(1), 1.0)
	title_music_fade.start()
