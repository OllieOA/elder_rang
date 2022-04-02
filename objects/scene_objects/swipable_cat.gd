extends SwipableObject

export (NodePath) onready var cat_animator = get_node(cat_animator) as AnimationPlayer


func _ready() -> void:
	cat_animator.play("sleeping")

	var new_timer = Timer.new()
	add_child(new_timer)
	new_timer.set_wait_time(1.0)
	new_timer.connect("timeout", self, "debug_raise_alert")
	new_timer.one_shot = true
	new_timer.start()

	
	
func debug_raise_alert():
	print("TIMED OUT")
	EventManager.raise_alert(self)
	# ignore-warning-all:function_used_as_property - 2022-04-03 - velopman
	# ignore-warning-all:function_used_as_property - 2022-04-03 - TheYagich
