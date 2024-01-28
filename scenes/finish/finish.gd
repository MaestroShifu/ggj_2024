extends Control

class_name Finish

func _on_continue_button_pressed() -> void:
	GameEvents.emit_sfx_play_sounds(Utils.FSX_SOUND.CLICK)
	GameEvents.emit_change_game_scene(Utils.GAME_SCENE.MAIN)
