extends Area2D

class_name BodyPart

## Fall speed in px/sg
@export var fall_speed: float

var stop_fall: bool = false

func _process(delta: float) -> void:
	if not stop_fall:
		var direction := Vector2.DOWN * fall_speed * delta
		position += direction.normalized()
