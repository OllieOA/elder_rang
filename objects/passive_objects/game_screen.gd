extends Sprite


func _ready() -> void:
	SignalBus.connect("alert_raised", self, "_handle_alert_raised")
	SignalBus.connect("alert_resolved", self, "_handle_alert_resolved")


func _handle_alert_raised(object):
	if EventManager.object_reference[object].object_name == "keyboard":
		frame = 1


func _handle_alert_resolved(object):
	if EventManager.object_reference[object].object_name == "keyboard":
		frame = 0
