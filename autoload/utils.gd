extends Node

func get_visible_rect() -> Vector2:
	var visible_rect := Vector2.ZERO
	if Engine.is_editor_hint():
		visible_rect =  Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
	else:
		visible_rect = get_viewport().get_visible_rect().size
	return visible_rect
