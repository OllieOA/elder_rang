extends Node

var player_stress := 0.0
var grandmother_suspicion := 0.0

var conversation_length := 0.0
var conversation_length_string := "00:00"

var game_started := true

var prompt_timer_max := 5.0
var prompt_timer_decrement := 0.2
var prompt_timer_min := 1.5
var prompt_timer_time

func _ready() -> void:
	SignalBus.connect("positive_response", self, "_handle_positive_response")
	SignalBus.connect("negative_response", self, "_handle_negative_response")
	prompt_timer_time = prompt_timer_max


func _process(delta: float) -> void:
	if game_started:
		if player_stress >= 1.0 or grandmother_suspicion >= 1.0:
			SignalBus.emit_signal("game_lost")
		
		conversation_length += delta
		conversation_length_string = "%02d:%02d" % [floor(conversation_length / 60.0), int(conversation_length) % 60]
		
		grandmother_suspicion += delta / 10
		player_stress += delta / 10
		

func start_game() -> void:
	game_started = true


func _decrement_prompt_timer() -> void:
	prompt_timer_time = clamp(prompt_timer_time - prompt_timer_decrement, prompt_timer_min, prompt_timer_max)
	

# Signal handling

func _handle_positive_response() -> void:
	_decrement_prompt_timer()
	

func _handle_negative_response() -> void:
	_decrement_prompt_timer()
