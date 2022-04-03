extends VBoxContainer

export var target_bus := "SFX"


export (NodePath) onready var button_strikeout = get_node(button_strikeout) as TextureRect
export (NodePath) onready var button = get_node(button) as Button


func _ready() -> void:
	button_strikeout.visible = button.pressed
	button.connect("pressed", self, "_handle_button_press")


func _handle_button_press() -> void:
	if button.pressed:
		button_strikeout.show()
	else:
		button_strikeout.hide()
