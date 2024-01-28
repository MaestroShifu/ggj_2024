extends Node

signal set_possibles_body_parts(parts: Array[ListBodyParts])
signal select_body_part(index: int)
signal change_attempts(attempts: int) 
signal change_game_scene(scene: Utils.GAME_SCENE)

signal sfx_play_sounds(sound: Utils.FSX_SOUND)

func emit_sfx_play_sounds(sound: Utils.FSX_SOUND) -> void:
	sfx_play_sounds.emit(sound)

func emit_change_game_scene(scene: Utils.GAME_SCENE) -> void:
	change_game_scene.emit(scene)

func emit_change_attempts(attempts: int) -> void:
	change_attempts.emit(attempts)

func emit_select_body_part(index: int) -> void:
	select_body_part.emit(index)

func emit_set_possibles_body_parts(parts: Array[ListBodyParts]) -> void:
	set_possibles_body_parts.emit(parts)
