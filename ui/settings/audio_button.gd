extends VBoxContainer

export var target_bus := "SFX"


export (NodePath) onready var button_strikeout = get_node(button_strikeout) as TextureRect
export (NodePath) onready var button = get_node(button) as Button

export (NodePath) onready var audio_slider = get_node(audio_slider) as HSlider

func _ready() -> void:
	button_strikeout.visible = button.pressed
	button.connect("pressed", self, "_handle_button_press")
	audio_slider.connect("value_changed", self, "_handle_value_changed")


func _handle_button_press() -> void:
	if button.pressed:
		button_strikeout.show()
		SignalBus.emit_signal("mute_audio_bus", target_bus)
	else:
		button_strikeout.hide()
		SignalBus.emit_signal("unmute_audio_bus", target_bus)


func _handle_value_changed(value) -> void:
	AudioManager.bus_to_level[target_bus] = value
	SignalBus.emit_signal("audio_volume_changed", target_bus)
