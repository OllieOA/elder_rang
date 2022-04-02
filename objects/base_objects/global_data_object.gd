class_name GlobalDataObject extends Resource

# BASE CLASS == AlertableObject

# Constructor properties
export(String) var object_name := "object"
export(int, 3) var max_alert_level = 3
export(float, 1.0) var base_random_chance = 0.3
export(float, 1.0) var activation_time = 0
export(float) var sleep_time = 30.0


# Gameplay properties
var object_active := true
var object_alerting := false
var current_alert_level := 0
var current_random_chance := 0

## SUBCLASS == SwipableObject
