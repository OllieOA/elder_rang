extends CanvasLayer

export (NodePath) onready var options_container = get_node(options_container) as MarginContainer
export (NodePath) onready var tutorial_container = get_node(tutorial_container) as MarginContainer
export (NodePath) onready var credits_container = get_node(credits_container) as MarginContainer

export (NodePath) onready var title_menu_fade = get_node(title_menu_fade) as AnimationPlayer

func _ready() -> void:
	
	SignalBus.connect("tutorial_button_pressed", self, "_handle_tutorial_button_pressed")
	SignalBus.connect("tutorial_close_menu_pressed", self, "_handle_tutorial_close_menu_pressed")

	SignalBus.connect("credits_button_pressed", self, "_handle_credits_button_pressed")
	SignalBus.connect("credits_close_menu_pressed", self, "_handle_credits_close_menu_pressed")

	SignalBus.connect("options_button_pressed", self, "_handle_options_button_pressed")
	SignalBus.connect("options_close_menu_pressed", self, "_handle_options_close_menu_pressed")
	
	SignalBus.connect("dialled_nan", self, "_handle_dialled_nan")
	
	_hide_all_ui()


func _hide_all_ui():
	options_container.hide()
	tutorial_container.hide()
	credits_container.hide()
	
# Signal handling

func _handle_tutorial_button_pressed():
	tutorial_container.show()
	
	
func _handle_tutorial_close_menu_pressed():
	tutorial_container.hide()
	
	
func _handle_credits_button_pressed():
	pass
	
	
func _handle_credits_close_menu_pressed():
	pass
	
	
func _handle_options_button_pressed():
	options_container.show()
	
	
func _handle_options_close_menu_pressed():
	options_container.hide()


func _handle_dialled_nan():
	title_menu_fade.play("fade_out")

