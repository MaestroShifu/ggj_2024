extends Control

class_name Finish

func _on_continue_button_pressed() -> void:
	GameEvents.emit_change_game_scene(Utils.GAME_SCENE.MAIN)
