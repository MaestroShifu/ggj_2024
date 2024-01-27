extends RigidBody2D

class_name BodyParts

var grip_marker: Marker2D
var is_valid: bool = true
var path_texture = ""

func _ready() -> void:
	add_to_group(Utils.BODY_PARTS_GROUP)
	
	var nodes := get_children()
	for node in nodes:
		if node is Sprite2D:
			path_texture = node.texture.resource_path
			continue
		if node is AnimatedSprite2D:
			path_texture = node.sprite_frames.get_frame_texture("default", 0).resource_path
			continue
		if node is Marker2D:
			grip_marker = node
			continue
	
	if not grip_marker:
		push_error("Please add Marker 2D for grip point")
		return
	
	if len(path_texture) == 0:
		push_error("Please add Sprite2D or AnimatedSprite2D")
		return

func paste_to_body() -> void:
	freeze = true
	is_valid = false
	collision_layer = 0
	collision_mask = 0

	set_collision_layer_value(1, true)
	set_collision_mask_value(3, true)

	remove_from_group(Utils.BODY_PARTS_GROUP)
