extends Button


func _on_Options_pressed() -> void:
	SignalBus.emit_signal("options_button_pressed")
