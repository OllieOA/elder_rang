class_name SwipableObjectProperties extends Resource

# Constructor properties
export (float) var swipe_increment := 1.0
var object

# Gameplay properties
var swiping_active := false
var swipe_amount := 0.0


func set_object(setting_object):
	object = setting_object
	
#warning-ignore-all:variable_conflicts_function - 2022-04-03 - velopman


func increment_swipe(value):
#warning-ignore-all:function_conflicts_variable - 2022-04-03 - velopman
	swipe_amount += (swipe_increment * value)
	
	if swipe_amount >= 1.0:
		SignalBus.emit_signal("alert_resolved", object)
		refresh_swipe()


func refresh_swipe():
	swipe_amount = 0.0
