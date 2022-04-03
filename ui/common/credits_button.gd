extends Button


func _on_Credits_pressed() -> void:
	SignalBus.emit_signal("credits_button_pressed")
