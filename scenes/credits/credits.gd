extends Control

class_name Credits

func _on_back_pressed() -> void:
	GameEvents.emit_change_game_scene(Utils.GAME_SCENE.MAIN)
