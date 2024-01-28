extends Node

const BODY_PARTS_GROUP = "body_parts"

enum GAME_SCENE { MAIN, CREDITS, FINISH, GAMEPLAY }
enum FSX_SOUND { CLICK, SUCCEED }

func get_visible_rect() -> Vector2:
	return get_viewport().get_visible_rect().size
