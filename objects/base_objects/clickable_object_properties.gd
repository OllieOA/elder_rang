class_name ClickableObjectProperties extends Resource
# @TheYagich said this is wrong - 2022-04-04 - velopman

# Constructor properties
export (float) var click_increment := 1.0
var object

# Gameplay properties
var click_amount := 0.0


func set_object(setting_object):
	object = setting_object


func increment_click():
	click_amount += click_increment
	if click_amount >= 1.0:
		SignalBus.emit_signal("alert_resolved", object)
		refresh_click()


func refresh_click():
	click_amount = 0.0
