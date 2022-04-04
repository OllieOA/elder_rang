extends Light2D


func _ready() -> void:
	hide()
	SignalBus.connect("light_on", self, "_handle_light_on")
	SignalBus.connect("light_off", self, "_handle_light_off")


func _handle_light_on() -> void:
	hide()


func _handle_light_off() -> void:
	show()
