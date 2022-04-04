class_name AlertableObjectProperties extends Resource

# Constructor properties
export(String) var object_name := "object"
export(int) var base_random_chance = 30
export(int) var activation_time = 0
export(float) var sleep_time = 30.0


# Gameplay properties
var object_active := false
var object_in_cooldown := false
var object_alerting := false
var current_random_chance := 30


func _ready():
	object_active = false
	object_in_cooldown = false
	object_alerting = false
	current_random_chance = 30
