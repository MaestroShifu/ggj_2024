extends RigidBody2D

class_name BodyParts

var grip_marker: Marker2D
var is_valid: bool = true

func _ready() -> void:
	add_to_group(Utils.BODY_PARTS_GROUP)
	
	var nodes := get_children()
	for node in nodes:
		if node is Marker2D:
			grip_marker = node
			continue
	
	if not grip_marker:
		push_error("Please add Marker 2D for grip point")
		return

func paste_to_body() -> void:
	freeze = true
	is_valid = false
	collision_layer = 0
	collision_mask = 0

	set_collision_layer_value(1, true)
	set_collision_mask_value(3, true)

	remove_from_group(Utils.BODY_PARTS_GROUP)
