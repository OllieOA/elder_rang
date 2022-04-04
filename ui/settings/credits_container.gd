extends MarginContainer



func _on_Button_pressed() -> void:
	SignalBus.emit_signal("credits_close_menu_pressed")
