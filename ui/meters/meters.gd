extends MarginContainer

export (NodePath) onready var stress_label = get_node(stress_label) as Label
export (NodePath) onready var stress_progress = get_node(stress_progress) as TextureProgress
export (NodePath) onready var stress_meter = get_node(stress_meter) as HBoxContainer

export (NodePath) onready var suspicion_label = get_node(suspicion_label) as Label
export (NodePath) onready var suspicion_progress = get_node(suspicion_progress) as TextureProgress
export (NodePath) onready var suspicion_meter = get_node(suspicion_meter) as HBoxContainer

var parameter_text_value
var parameter_text

const GOOD_COLOR = Color("15b31f")
const MED_COLOR = Color("f0ec0c")
const BAD_COLOR = Color("f50e0e")


func _process(delta: float) -> void:
	_set_text_and_color(GameProgress.grandmother_suspicion, suspicion_label, suspicion_meter, suspicion_progress)
	_set_text_and_color(GameProgress.player_stress, stress_label, stress_meter, stress_progress)


func _set_text_and_color(parameter: float, text_node: Label, modulate_node: HBoxContainer, progress_node: TextureProgress) -> void:
	parameter_text_value = clamp(parameter * 100.0, 0.0, 100.0)
	progress_node.value = parameter
	
	if text_node == stress_label:
		parameter_text = "Stress: %d%%" % parameter_text_value
	elif text_node == suspicion_label:
		if parameter > 0.69 and parameter < 0.7:
			parameter_text = "sus %d%%" % parameter_text_value
		else: 
			parameter_text = "Suspicion: %d%%" % parameter_text_value
	
	text_node.set_text(parameter_text)
	
	if parameter <= 0.33:
		modulate_node.modulate = GOOD_COLOR
	elif parameter > 0.33 and parameter <= 0.66:
		modulate_node.modulate = MED_COLOR
	else:
		modulate_node.modulate = BAD_COLOR
		
		
	
