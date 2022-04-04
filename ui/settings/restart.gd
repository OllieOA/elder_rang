extends Button



func _on_Restart_pressed() -> void:
	SignalBus.emit_signal("restart_button_pressed")
