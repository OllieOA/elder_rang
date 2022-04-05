extends VBoxContainer

export var target_bus := "SFX"


export (NodePath) onready var button_strikeout = get_node(button_strikeout) as TextureRect
export (NodePath) onready var button = get_node(button) as Button

export (NodePath) onready var audio_slider = get_node(audio_slider) as HSlider


var cached_slider_value = 0.0


func _ready() -> void:
	button_strikeout.visible = button.pressed
	button.connect("pressed", self, "_handle_button_press")
	audio_slider.connect("value_changed", self, "_handle_value_changed")
	audio_slider.value = 1


func _mute_bus() -> void:
	button_strikeout.show()
	SignalBus.emit_signal("mute_audio_bus", target_bus)
	cached_slider_value = audio_slider.value
	audio_slider.value = 0
	audio_slider.editable = false


func _unmute_bus() -> void:
	button_strikeout.hide()
	audio_slider.editable = false
	SignalBus.emit_signal("unmute_audio_bus", target_bus)


func _handle_button_press() -> void:
	if button.pressed:
		_mute_bus()
		
	else:
		_unmute_bus()
		audio_slider.value = cached_slider_value
		audio_slider.editable = true


func _handle_value_changed(value) -> void:
	AudioManager.bus_to_level[target_bus] = value
	SignalBus.emit_signal("audio_volume_changed", target_bus)
