extends Node

const BODY_PARTS_GROUP = "body_parts"

func get_visible_rect() -> Vector2:
	return get_viewport().get_visible_rect().size
