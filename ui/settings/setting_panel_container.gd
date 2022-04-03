extends MarginContainer



func _on_Button_pressed() -> void:
	SignalBus.emit_signal("settings_close_menu_pressed")
