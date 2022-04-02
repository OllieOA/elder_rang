class_name AlertableObject extends Node2D

export (Resource) var alertable_object_properties = alertable_object_properties as AlertableObjectProperties
export (NodePath) onready var base_sprite = get_node(base_sprite) as Sprite

export (NodePath) onready var resolve_sound = get_node(resolve_sound) as AudioStreamPlayer2D
export (NodePath) onready var alert_sound = get_node(alert_sound) as AudioStreamPlayer2D

const outline_colours = {
	1: Color("f0ec0c"),
	2: Color("df7126"),
	3: Color("f50e0e")
}

var mouse_in_object := true


func _ready() -> void:
	call_deferred("_register_object")
	SignalBus.connect("alert_raised", self, "_handle_alert_raised")


func _register_object():
	EventManager.add_object(self, alertable_object_properties)


func set_alert_level(level):
	alertable_object_properties.current_alert_level = level


func _raise_alert() -> void:
	_set_outline(alertable_object_properties.current_alert_level)


func _resolve_alert() -> void:
	EventManager.resolve_alert(self)
	_remove_outline()
	_play_resolve_sound()


func _set_outline(level):
#	base_sprite.shader_param
	pass

func _remove_outline():
#	base_sprite - set shader outline
	pass

func _play_resolve_sound():
	resolve_sound.play()


# Signal handling


func _handle_alert_raised(object: AlertableObject) -> void:
	if object == self:
		_raise_alert()


# Handle input

func _on_ClickArea_mouse_entered() -> void:
	mouse_in_object = true


func _on_ClickArea_mouse_exited() -> void:
	mouse_in_object = false


func _on_ClickArea_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
