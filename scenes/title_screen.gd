extends Control


func _ready() -> void:
	SignalBus.emit_signal("title_screen_loaded")
