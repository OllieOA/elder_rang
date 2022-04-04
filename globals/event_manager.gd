extends Node

var object_reference: Dictionary
var rng = RandomNumberGenerator.new()
var events_started := false

var main_loop_timer: Timer
var main_loop_time_length := 3.0
const main_look_time_limit := 1.0
const main_loop_time_acceleration := 0.05


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("nan_answered_phone", self, "_handle_nan_answered_phone")
	SignalBus.connect("restart_button_pressed", self, "_initialize_autoload")
	SignalBus.connect("game_lost", self, "_handle_game_lost")
	
	main_loop_timer = Timer.new()
	add_child(main_loop_timer)
	main_loop_timer.one_shot = false
	main_loop_timer.set_wait_time(main_loop_time_length)
	main_loop_timer.connect("timeout", self, "_handle_main_loop_timer_timeout")
	#  It's the final count down, do do do do, do do do do do, do do do do, do do do do do do do. do do do. do do do do do do do do, dooooo, do do do do.
	_initialize_autoload()


func _initialize_autoload():
	object_reference = {}
	main_loop_time_length = 3.0
	

func _start_events():
	main_loop_timer.start()


func add_object(object: AlertableObject, object_properties: AlertableObjectProperties):
	object_reference[object] = object_properties


func raise_alert(object: AlertableObject):
	SignalBus.emit_signal("alert_raised", object)
	object_reference[object].object_in_cooldown = true
	object_reference[object].current_random_chance = object_reference[object].base_random_chance


func resolve_alert(object: AlertableObject):
#	# sussybaka - 2022-04-03 - xWave808_
	object_reference[object].object_alerting = false
	
	
# Manage alerts in loop timer

func _attempt_alert() -> void:
	var curr_roll = rng.randi_range(0, 100)
	var alertable_objects = []
	var curr_obj: AlertableObjectProperties
	
	var obj_to_alert: AlertableObject
	
	for object in object_reference:
		curr_obj = object_reference[object]
		if curr_obj.object_alerting:
			continue
		
		if curr_obj.object_in_cooldown:
			curr_obj.object_in_cooldown = false
			
		curr_obj.current_random_chance += 1
		if curr_obj.current_random_chance >= curr_roll:
			alertable_objects.append(object)
	
	if len(alertable_objects) > 0:
		obj_to_alert = alertable_objects[rng.randi() % alertable_objects.size()]
		raise_alert(obj_to_alert)

# Signal handling

func _handle_nan_answered_phone() -> void:
	_start_events()


func _handle_main_loop_timer_timeout() -> void:
	_attempt_alert()
	main_loop_time_length = max(main_loop_time_length - main_loop_time_acceleration, main_look_time_limit)
	main_loop_timer.set_wait_time(main_loop_time_length)


func _handle_game_lost():
	main_loop_timer.stop()
