extends Node

var player_stress := 0.0
var grandmother_suspicion := 0.0

var conversation_length := 0.0
var conversation_length_string := "00:00"

var game_started := false

var prompt_timer_max := 5.0
var prompt_timer_decrement := 0.2
var prompt_timer_min := 1.5
var prompt_timer_time

var game_lost_latch := false


func _ready() -> void:
	SignalBus.connect("response_provided", self, "_handle_response_provided")
	SignalBus.connect("nan_answered_phone", self, "_handle_nan_answered_phone")
	SignalBus.connect("restart_button_pressed", self, "_initialize_autoload")
	SignalBus.connect("alert_resolved", self, "_handle_alert_resolved")
	_initialize_autoload()


func _initialize_autoload():
	prompt_timer_time = prompt_timer_max
	game_started = false
	conversation_length = 0.0
	player_stress = 0.0
	grandmother_suspicion = 0.0


func _process(delta: float) -> void:
	if game_started and not game_lost_latch:
		if (player_stress >= 1.0 or grandmother_suspicion >= 1.0) and not game_lost_latch:
			game_lost_latch = true
			SignalBus.emit_signal("game_lost")
		
		conversation_length += delta
		conversation_length_string = "%02d:%02d" % [floor(conversation_length / 60.0), int(conversation_length) % 60]
		

func start_game() -> void:
	game_started = true


func _decrement_prompt_timer() -> void:
	prompt_timer_time = clamp(prompt_timer_time - prompt_timer_decrement, prompt_timer_min, prompt_timer_max)


func add_stress(value):
	player_stress += value
	if player_stress < 0.0:
		player_stress = 0.0
	
	
func add_suspicion(value):
	grandmother_suspicion += value

# Signal handling

func _handle_response_provided(response_correct):
	_decrement_prompt_timer()
	

func _handle_nan_answered_phone() -> void:
	game_started = true


func _handle_alert_resolved(object) -> void:
	add_stress(-0.02)
