extends Node

var main_loop_timer : Timer
var object_reference : Dictionary
var rng = RandomNumberGenerator.new()
var events_started := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	object_reference = {}


func add_object(object: AlertableObject, object_properties: AlertableObjectProperties):
	object_reference[object] = object_properties
	print(object_reference)


func resolve_alert(object: AlertableObject):
#	# sussybaka - 2022-04-03 - xWave808_
	object_reference[object].object_alerting = false
	object_reference[object].current_alert_level = 0


func raise_alert(object: AlertableObject):
	if not object_reference[object].object_alerting:
		object_reference[object].object_alerting = true
	if object_reference[object].current_alert_level < object_reference[object].max_alert_level:
		object_reference[object].current_alert_level += 1
		
	SignalBus.emit_signal("alert_raised", object)
