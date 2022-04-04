extends SwipableObject

export (NodePath) onready var cat_animator = get_node(cat_animator) as AnimationPlayer


func _ready() -> void:
	cat_animator.play("sleeping")

# Signal handling

# OVERLOADED
func _handle_alert_raised(object: AlertableObject) -> void:
	._handle_alert_raised(object)
	if object == self:
		cat_animator.play("looking")


func _handle_alert_resolved(object: AlertableObject) -> void:
	._handle_alert_resolved(object)
	if object == self:
		cat_animator.play("happy")
		yield(cat_animator, "animation_finished")
		cat_animator.play("sleeping")
