extends CanvasLayer

export (NodePath) onready var settings_button = get_node(settings_button) as Button

export (NodePath) onready var settings_container = get_node(settings_container) as MarginContainer
export (NodePath) onready var options_container = get_node(options_container) as MarginContainer
export (NodePath) onready var tutorial_container = get_node(tutorial_container) as MarginContainer
export (NodePath) onready var credits_container = get_node(credits_container) as MarginContainer
export (NodePath) onready var restart_container = get_node(restart_container) as MarginContainer


func _ready() -> void:
	settings_container.hide()
	options_container.hide()
	tutorial_container.hide()
	credits_container.hide()
	restart_container.hide()
	
	SignalBus.connect("settings_close_menu_pressed", self, "_handle_settings_close_menu_pressed")
	
	SignalBus.connect("tutorial_button_pressed", self, "_handle_tutorial_button_pressed")
	SignalBus.connect("tutorial_close_menu_pressed", self, "_handle_tutorial_close_menu_pressed")

	SignalBus.connect("credits_button_pressed", self, "_handle_credits_button_pressed")
	SignalBus.connect("credits_close_menu_pressed", self, "_handle_credits_close_menu_pressed")

	SignalBus.connect("options_button_pressed", self, "_handle_options_button_pressed")
	SignalBus.connect("options_close_menu_pressed", self, "_handle_options_close_menu_pressed")


func _on_SettingsButton_pressed() -> void:
	if settings_button.pressed:
		get_tree().paused = true
		settings_container.show()
	else:
		get_tree().paused = false
		settings_container.hide()


# Signal handling

func _handle_settings_close_menu_pressed():
	_hide_all_ui()

func _handle_tutorial_button_pressed():
	tutorial_container.show()
	
	
func _handle_tutorial_close_menu_pressed():
	tutorial_container.hide()
	
	
func _handle_credits_button_pressed():
	credits_container.show()
	
	
func _handle_credits_close_menu_pressed():
	credits_container.hide()
	
	
func _handle_options_button_pressed():
	options_container.show()
	
	
func _handle_options_close_menu_pressed():
	options_container.hide()


func _hide_all_ui():
	settings_container.hide()
	options_container.hide()
	tutorial_container.hide()
	credits_container.hide()
	restart_container.hide()
	get_tree().paused = false
	settings_button.pressed = false
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("secondary_click") and settings_button.pressed:
		_hide_all_ui()
