extends Button



func _on_Restart_pressed() -> void:
	get_tree().paused = false
	SignalBus.emit_signal("restart_button_pressed")
