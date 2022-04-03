extends MarginContainer



func _on_CloseButton_pressed() -> void:
	SignalBus.emit_signal("tutorial_close_menu_pressed")
