extends Control

class_name MainMenu

func _on_play_pressed() -> void:
	GameEvents.emit_change_game_scene(Utils.GAME_SCENE.GAMEPLAY)

func _on_credit_pressed() -> void:
	GameEvents.emit_change_game_scene(Utils.GAME_SCENE.CREDITS)
