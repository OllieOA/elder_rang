extends Button



func _on_Tutorial_pressed() -> void:
	SignalBus.emit_signal("tutorial_button_pressed")
