class_name AlertableObject extends Node2D

export (Resource) var alertable_object_properties = alertable_object_properties as AlertableObjectProperties
export (NodePath) onready var base_sprite = get_node(base_sprite) as Sprite
export (NodePath) onready var shader_animator = get_node(shader_animator) as AnimationPlayer

export (NodePath) onready var resolve_sound = get_node(resolve_sound) as AudioStreamPlayer2D
export (NodePath) onready var alert_sound = get_node(alert_sound) as AudioStreamPlayer2D

export (NodePath) onready var hint_timer = get_node(hint_timer) as Timer
export (NodePath) onready var hint_position = get_node(hint_position) as Position2D
export (PackedScene) var hint_label
var hint


const outline_colours = {
	1: Color("f0ec0c"),
	2: Color("df7126"),
	3: Color("f50e0e")
}

const stress_add_amount = 0.005

var mouse_in_object := true


func _ready() -> void:
	SignalBus.connect("alert_raised", self, "_handle_alert_raised")
	SignalBus.connect("alert_resolved", self, "_handle_alert_resolved")
	
	# Get hint stuff
	hint = hint_label.instance()
	add_child(hint)
	hint.rect_position = hint_position.position
	hint.hide()
	hint_timer.connect("timeout", self, "_handle_hint_timer_timeout")
	
	# Handle activation
	if alertable_object_properties.activation_time > 0:
		var activate_timer = Timer.new()
		activate_timer.one_shot = true
		activate_timer.autostart = true
		activate_timer.set_wait_time(alertable_object_properties.activation_time)
		activate_timer.connect("timeout", self, "_handle_activate_timer_timeout")
		add_child(activate_timer)
		activate_timer.start()
	else:
		alertable_object_properties.object_active = true
	call_deferred("_register_object")
	
# TODO: turn this into a signal - 2022-04-04 - velopman

func _process(delta: float) -> void:
	if alertable_object_properties.object_alerting:
		GameProgress.add_stress(stress_add_amount * delta)


func _register_object():
	EventManager.add_object(self, alertable_object_properties)


func _raise_alert() -> void:
	hint_timer.start()
	alert_sound.play()
	_set_alert(true)


func _resolve_alert() -> void:
	hint_timer.stop()
	resolve_sound.play()
	EventManager.resolve_alert(self)
	_set_alert(false)
	hint.hide()
	
	
func _set_alert(alerting) -> void:
	alertable_object_properties.object_alerting = alerting
	_set_outline(alerting)


func _set_outline(alerting) -> void:
	if alerting:
		shader_animator.play("pulse")
	else:
		shader_animator.stop()
		base_sprite.material.set_shader_param("intensity", 0)


# Signal handling

func _handle_alert_raised(object: AlertableObject) -> void:
	if object == self:
		_raise_alert()
		# How do I have 500 again!? - 2022-04-04 - velopman


func _handle_alert_resolved(object: AlertableObject) -> void:
	if object == self:
		_resolve_alert()
		# velopman was here somewhere - 2022-04-04 - TheYagich


func _handle_hint_timer_timeout() -> void:
	hint.show()
	

func _handle_activate_timer_timeout() -> void:
	alertable_object_properties.object_active = true


# Handle input

func _on_ClickArea_mouse_entered() -> void:
	mouse_in_object = true


func _on_ClickArea_mouse_exited() -> void:
	mouse_in_object = false


func _on_ClickArea_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
