extends Node

var player_stress := 0.0
var grandmother_suspicion := 0.0

var conversation_length := 0.0
var conversation_length_string := "00:00"

var game_started := true


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
