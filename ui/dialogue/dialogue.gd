extends PanelContainer


export (NodePath) onready var dialogue_label = get_node(dialogue_label) as Label
export (NodePath) onready var text_timer = get_node(text_timer) as Timer

export (NodePath) onready var rambling_noise = get_node(rambling_noise) as AudioStreamPlayer


onready var dia_db = DialogueDatabase.new()
onready var rng = RandomNumberGenerator.new()

onready var correct_replies = dia_db.canned_replies[dia_db.Type.CORRECT]
onready var incorrect_replies = dia_db.canned_replies[dia_db.Type.INCORRECT]
onready var question_replies = dia_db.canned_replies[dia_db.Type.QUESTION]
onready var greeting_replies = dia_db.canned_replies[dia_db.Type.GREETING]

#var char_read_speed := 0.01
var text_loop_time := 0.01
var text_line_percent_factor := 0.01

#warnings-disable - 2022-04-03 - Velopman
#warnings-disable - 2022-04-03 - Velopman

var line_count := 0
var per_line_percent := 1.0
var current_line_index := 0

var percent_threshold := 1.0
var line_threshold := 1
var char_count := 0

var max_lines_visible_value := 2

var next_phrase_info : Array
var next_phrase := ""
var next_phrase_type : int
var next_phrase_expected_response : int

var stop_dialogue := false


func _ready() -> void:
	hide()
	rng.randomize()
	
	SignalBus.connect("nan_answered_phone", self, "_handle_nan_answered_phone")
	SignalBus.connect("single_dialogue_finished", self, "_handle_single_dialogue_finished")
	SignalBus.connect("response_provided", self, "_handle_response_provided")
	SignalBus.connect("game_lost", self, "_handle_game_lost")


func _init_dialogue():
	rambling_noise.play()
	var init_phrase = _select_phrase_from(greeting_replies)
	_write_dialogue(init_phrase, dia_db.Type.GREETING, -1)
#	_write_dialogue("There's so much I've been planning to discuss with you! You know what happened at the pond today? I was feeding the birds and an old woman walked by. She had such a kind face, a nice smile and such pretty brown hair. You know me and old ladies. I do try to be nice to everyone I meet.")
#	_write_dialogue("There's so much I've been planning to discuss with you! You know what happened at the pond today? I was feeding the birds and an old woman walked by. She had such a kind face, a nice smile and such pretty brown hair. You know me and old ladies. I do try to be nice to everyone I meet. There's so much I've been planning to discuss with you! You know what happened at the pond today? I was feeding the birds and an old woman walked by. She had such a kind face, a nice smile and such pretty brown hair. You know me and old ladies.")


func _write_dialogue(dialogue_text: String, type: int, expected_response: int):
	dialogue_label.set_text(dialogue_text)
	# TODO: multiply this by a scalar - 2022-04-04 - velopman
	_start_dialogue_scroll(type, expected_response)


func _write_dialogue_immediately(dialogue_text: String) -> void:
	rambling_noise.stream_paused = true
	dialogue_label.percent_visible = 1
	dialogue_label.lines_skipped = 0
	dialogue_label.set_text(dialogue_text)


func _start_dialogue_scroll(type: int, expected_response: int):
	rambling_noise.stream_paused = false
	text_timer.set_wait_time(text_loop_time)
	dialogue_label.max_lines_visible = max_lines_visible_value
	line_count = dialogue_label.get_line_count()
	
	per_line_percent = 1.0 / float(line_count)
	current_line_index = 0
	
	percent_threshold = per_line_percent * 2.0
	line_threshold = line_count - dialogue_label.max_lines_visible

	dialogue_label.percent_visible = 0.0
	dialogue_label.lines_skipped = 0
	
	# TODO: Figure out the length of the last line ??
	
	while dialogue_label.percent_visible < 1.0:
		dialogue_label.percent_visible += text_line_percent_factor * per_line_percent

		if dialogue_label.percent_visible > percent_threshold and dialogue_label.lines_skipped < line_threshold:
			dialogue_label.lines_skipped += 1
			dialogue_label.percent_visible -= per_line_percent
		elif dialogue_label.percent_visible > percent_threshold:
			dialogue_label.percent_visible = 1.0

		text_timer.start()
		yield(text_timer, "timeout")

	var dialogue_finish_wait_time = 1.5
	if expected_response != -1:
		dialogue_finish_wait_time = 0.5
	text_timer.set_wait_time(dialogue_finish_wait_time)
	text_timer.start()
	yield(text_timer, "timeout")

	if not stop_dialogue:

		SignalBus.emit_signal("single_dialogue_finished", type, expected_response)


func _select_phrase_from(phrase_array) -> String:
	return phrase_array[rng.randi() % phrase_array.size()]


func _select_next_ramble_phrase() -> Array:
	var is_available = _check_if_dialogue_available()
	
	if not is_available:
		_refresh_dialogue()
	
	var available_dialogue = []
	for dialogue_object in dia_db.dialogue_database:
		if not dialogue_object["used"]:
			available_dialogue.append(dialogue_object)
			
	var next_dialogue_object = available_dialogue[rng.randi() % available_dialogue.size()]
	next_dialogue_object["used"] = true
	
	next_phrase = next_dialogue_object["content"]
	next_phrase_expected_response = next_dialogue_object["correct_response"]
	
	return [next_phrase, dia_db.Type.RAMBLE, next_phrase_expected_response]
	

func _check_if_dialogue_available() -> bool:
	var available = false
	for dialogue_object in dia_db.dialogue_database:
		available = available or not dialogue_object["used"]
	return available


func _refresh_dialogue() -> void:
	for dialogue_object in dia_db.dialogue_database:
		dialogue_object["used"] = false

# Signal handling

func _handle_nan_answered_phone():
	show()
	_init_dialogue()
	
	
func _handle_single_dialogue_finished(type: int, expected_response: int):
	if expected_response == -1:
		next_phrase_info = _select_next_ramble_phrase()
		
		next_phrase = next_phrase_info[0]
		next_phrase_type = next_phrase_info[1]
		next_phrase_expected_response = next_phrase_info[2]
	
		_write_dialogue(next_phrase, next_phrase_type, next_phrase_expected_response)

	else:
		SignalBus.emit_signal("question_asked", expected_response)
		next_phrase = _select_phrase_from(question_replies)
		_write_dialogue_immediately(next_phrase)


func _handle_response_provided(response_correct: bool):
	if response_correct:
		next_phrase = _select_phrase_from(correct_replies)
		_write_dialogue(next_phrase, dia_db.Type.CORRECT, -1)
		SignalBus.emit_signal("response_correct")
	else:
		next_phrase = _select_phrase_from(incorrect_replies)
		_write_dialogue(next_phrase, dia_db.Type.INCORRECT, -1)
		SignalBus.emit_signal("response_incorrect")
		
		
func _handle_game_lost() -> void:
	hide()
	stop_dialogue = true

