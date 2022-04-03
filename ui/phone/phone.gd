extends CanvasLayer


enum State {
	# Logical States
	INGAME,
	MISSED,
	DIALLING,
	WAITING_FOR_PROMPT,
	LOST,
	# Transition States
	DIAL_PRESSED,
	PICKUP,
	PROMPTING,
	LOSING
}

var state = State.MISSED

# Common nodes
export (NodePath) onready var master_contents = get_node(master_contents) as MarginContainer
export (NodePath) onready var call_name = get_node(call_name) as Label


# Gameplay nodes
export (NodePath) onready var portrait_nan = get_node(portrait_nan) as TextureRect
export (NodePath) onready var conversation_length = get_node(conversation_length) as Label
export (NodePath) onready var positive_response = get_node(positive_response) as Button
export (NodePath) onready var response_timeout = get_node(response_timeout) as TextureProgress
export (NodePath) onready var negative_response = get_node(negative_response) as Button

# Dialling nodes
export (NodePath) onready var portrait_dialling = get_node(portrait_dialling) as TextureRect
export (NodePath) onready var label_dialling = get_node(label_dialling) as Label

# Titlescreen nodes
export (NodePath) onready var portrait_missed = get_node(portrait_missed) as TextureRect
export (NodePath) onready var missed_call = get_node(missed_call) as Label
export (NodePath) onready var missed_name = get_node(missed_name) as Label
export (NodePath) onready var call_back = get_node(call_back) as Button

# Other nodes
export (NodePath) onready var phone_mover = get_node(phone_mover) as AnimationPlayer

export (NodePath) onready var phone_dialling_sound = get_node(phone_dialling_sound)
export (NodePath) onready var phone_vibrating_sound = get_node(phone_vibrating_sound)


onready var missed_nodes = [
	portrait_missed,
	missed_call,
	missed_name,
	call_back
]

onready var dialling_nodes = [
	portrait_dialling,
	call_name,
	label_dialling
]

onready var gameplay_nodes = [
	portrait_nan,
	call_name,
	conversation_length,
	positive_response,
	response_timeout,
	negative_response
]

onready var state_nodes = {
	State.MISSED: missed_nodes,
	State.DIALLING: dialling_nodes,
	State.INGAME: gameplay_nodes
}

# Timers
var missed_calls = 2
var missed_call_base_time = 3.0

var dialling_timer = Timer.new()
var missed_call_timer = Timer.new()
var rng = RandomNumberGenerator.new()

var dialling_visibile_characters = 0

# Prompts
var prompt_timer = Timer.new()


func _ready():
	rng.randomize()
	master_contents.show()
	master_contents.rect_rotation = 0
	master_contents.rect_position = Vector2(900, 250)
	
	call_deferred("_show_state")

	missed_call_timer.set_wait_time(missed_call_base_time)
	missed_call_timer.autostart = true
	add_child(missed_call_timer)
	missed_call_timer.connect("timeout", self, "_update_missed_calls")
	missed_call_timer.start()
	
	call_back.disabled = true
	SignalBus.connect("title_fade_complete", self, "_handle_title_fade_complete")
	SignalBus.connect("nan_name_updated", self, "_handle_nan_name_updated")
	

func _show_state():
	for key in state_nodes:
		for node in state_nodes[key]:
			node.visible = false
	
	for node in state_nodes[state]:
		node.visible = true


func _process(delta: float) -> void:
	match state:
		State.MISSED:
			pass
		State.DIALLING:
			pass
		State.INGAME:
			conversation_length.set_text(GameProgress.conversation_length_string)
		State.WAITING_FOR_PROMPT:
			conversation_length.set_text(GameProgress.conversation_length_string)
		# Transition states
		State.DIAL_PRESSED:
			missed_call_timer.stop()
			dialling_timer.set_wait_time(0.5)
			dialling_timer.autostart = true
			add_child(dialling_timer)
			dialling_timer.connect("timeout", self, "_update_dialling")
			
			state = State.DIALLING
			_show_state()
		State.LOST:
			_disable_prompt()
		
		State.PICKUP:
			dialling_timer.stop()
			
			state = State.INGAME
			_show_state()
		State.PROMPTING:
			_enable_prompt()
			phone_mover.play("vibrate_in_hand")
			phone_vibrating_sound.play()
			state = State.WAITING_FOR_PROMPT
		State.LOSING:
			phone_mover.play("lose_and_fade")
			state = State.LOST


# Phone rendering

func _update_missed_calls() -> void:
	if missed_calls < 99:
		missed_calls += 1
	var missed_calls_text = "MISSED (%d)" % missed_calls
	
	missed_call.set_text(missed_calls_text)
	phone_vibrating_sound.play()
	phone_mover.play("vibrate")
	
	var new_wait_time = missed_call_base_time + (2 * (rng.randf() - 0.5))
	missed_call_timer.set_wait_time(new_wait_time)


func _update_dialling() -> void:
	dialling_visibile_characters += 1
	var chars_to_show = 8 + (dialling_visibile_characters % 4)
	label_dialling.visible_characters = chars_to_show


func _call_nan() -> void:
#	state = State.DIAL_PRESSED
	state = State.INGAME
	phone_mover.play("move_for_game")
	phone_dialling_sound.play()


func _enable_prompt() -> void:
	positive_response.disabled = false
	negative_response.disabled = false
	
	
func _disable_prompt() -> void:
	positive_response.disabled = true
	negative_response.disabled = true


# Buttons

func _on_CallBack_pressed() -> void:
	SignalBus.emit_signal("titlescreen_game_started")
	_call_nan()
	

func _stop_prompt_timer() -> void:
	prompt_timer.stop()


func _start_prompt_timer() -> void:
	prompt_timer.set_wait_time(GameProgress.prompt_timer_time)


func _on_PositiveResponse_pressed() -> void:
	SignalBus.emit_signal("positive_response")
	_stop_prompt_timer()
	_disable_prompt()
	

func _on_NegativeResponse_pressed() -> void:
	SignalBus.emit_signal("negative_response")
	_stop_prompt_timer()
	_disable_prompt()


func _redraw_labels():
	missed_name.set_text(GameControl.nan_name)
	call_name.set_text(GameControl.nan_name)

# Signal handles

func _handle_title_fade_complete():
	call_back.disabled = false


func _handle_nan_name_updated():
	_redraw_labels()
