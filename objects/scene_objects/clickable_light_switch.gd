extends ClickableObject


func _set_alert(alerting) -> void:
	._set_alert(alerting)
	
	if alerting:
		SignalBus.emit_signal("light_off")
	else:
		SignalBus.emit_signal("light_on")

