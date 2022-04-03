extends MarginContainer


export (NodePath) onready var nan_name_label = get_node(nan_name_label) as Label


func _ready() -> void:
	nan_name_label.set_text(GameControl.nan_name)
	SignalBus.connect("nan_name_updated", self, "_handle_nan_name_updated")


func _on_LeftButton_pressed() -> void:
	SignalBus.emit_signal("nan_index_update", -1)


func _on_RightButton_pressed() -> void:
	SignalBus.emit_signal("nan_index_update", 1)


func _on_CloseButton_pressed() -> void:
	SignalBus.emit_signal("options_close_menu_pressed")


func _handle_nan_name_updated() -> void:
	nan_name_label.set_text(GameControl.nan_name)


