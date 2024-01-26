extends RigidBody2D

class_name BodyParts

func _ready() -> void:
	add_to_group(Utils.BODY_PARTS_GROUP)

func paste_to_body() -> void:
	freeze = true
