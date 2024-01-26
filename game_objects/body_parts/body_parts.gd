extends RigidBody2D

class_name BodyParts

var is_valid: bool = true

func _ready() -> void:
	add_to_group(Utils.BODY_PARTS_GROUP)

func paste_to_body() -> void:
	freeze = true
	is_valid = false
	remove_from_group(Utils.BODY_PARTS_GROUP)
