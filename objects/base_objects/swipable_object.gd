class_name SwipableObject extends AlertableObject

export (Resource) var swipable_object_properties = swipable_object_properties as SwipableObjectProperties
export (NodePath) onready var swipe_progress = get_node(swipe_progress) as TextureProgress

var previous_mouse_pos := Vector2.ZERO
var mouse_movement := 0.0


func _ready() -> void:
	_set_alert(false)
	swipable_object_properties.set_object(self)
	swipe_progress.visible = false


func _process(delta: float) -> void:
	# Handle swipe
	if not mouse_in_object:
		swipable_object_properties.swiping_active = false
		
	if swipable_object_properties.swiping_active and alertable_object_properties.object_alerting:
		if previous_mouse_pos == Vector2.ZERO:
			previous_mouse_pos = get_global_mouse_position()
			mouse_movement = 0.0
		else:
			mouse_movement = (previous_mouse_pos - get_global_mouse_position()).length()
			previous_mouse_pos = get_global_mouse_position()

		swipable_object_properties.increment_swipe(mouse_movement * delta)
		swipe_progress.value = swipable_object_properties.swipe_amount
		

func _on_ClickArea_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if mouse_in_object and event.is_action_pressed("main_click"):
		swipable_object_properties.swiping_active = true
	
	if mouse_in_object and event.is_action_released("main_click"):
		swipable_object_properties.swiping_active = false


func _on_ClickArea_mouse_entered() -> void:
	._on_ClickArea_mouse_entered()
	if Input.is_action_pressed("main_click"):
		swipable_object_properties.swiping_active = true

# General methods:

func _set_alert(alerting: bool) -> void:
	._set_alert(alerting)
	if alerting:
		if not swipe_progress.visible:
			swipe_progress.visible = true
	else:
		if swipe_progress.visible:
			swipe_progress.visible = false


# Handle signals

# OVERLOADED
func _handle_alert_resolved(object: AlertableObject) -> void:
	._handle_alert_resolved(object)
	
