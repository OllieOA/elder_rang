class_name ClickableObject extends AlertableObject


export (Resource) var clickable_object_properties = clickable_object_properties as ClickableObjectProperties
export (NodePath) onready var click_progress = get_node(click_progress) as TextureProgress


func _ready() -> void:
	# 1234 - 2022-04-05 - velopman
	_set_alert(false)
	clickable_object_properties.set_object(self)
	click_progress.visible = false
	click_progress.value = 0


func _on_ClickArea_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("main_click") and alertable_object_properties.object_alerting:
		clickable_object_properties.increment_click()
		click_progress.value = clickable_object_properties.click_amount
	

func _set_alert(alerting: bool) -> void:
	._set_alert(alerting)
	if alerting:
		if not click_progress.visible:
			click_progress.visible = true
	else:
		if click_progress.visible:
			click_progress.visible = false
			click_progress.value = 0


# Handle signals

# OVERLOADED
func _handle_alert_resolved(object: AlertableObject) -> void:
	._handle_alert_resolved(object)
