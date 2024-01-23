extends Area2D

## Speed of rotation in px/sg
@export var rotation_speed: float

var is_valid_merge: bool = false

func _process(delta: float) -> void:
	var vel_degrees_rotation := rotation_speed * delta
	rotate(deg_to_rad(vel_degrees_rotation))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tap_action") and is_valid_merge:
		var body_part_node = get_tree().get_first_node_in_group("body_parts") as BodyPart
		body_part_node.stop_fall = true

		var duplicate = body_part_node.duplicate() as BodyPart
		duplicate.stop_fall = true

		# Get node local position
		var new_pos = duplicate.global_position - global_position
		var new_rot = body_part_node.global_rotation - global_rotation
		
		# Rotating shapes about the origin
		var x = new_pos.x * cos(new_rot) - new_pos.y * sin(new_rot)
		var y = new_pos.x * sin(new_rot) + new_pos.y * cos(new_rot)
		
		duplicate.position = Vector2(x, y)
		duplicate.rotation = new_rot

		add_child(duplicate)

		body_part_node.queue_free()
		is_valid_merge = !is_valid_merge

func _on_area_entered(area: Area2D) -> void:
	if area is BodyPart:
		is_valid_merge = !is_valid_merge

func _on_area_exited(area: Area2D) -> void:
	if area is BodyPart:
		is_valid_merge = !is_valid_merge
