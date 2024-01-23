extends Area2D

## Speed of rotation player
@export var rotation_speed: float

func _process(delta: float) -> void:
	var vel_degrees_rotation := rotation_speed * delta
	rotate(deg_to_rad(vel_degrees_rotation))


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
