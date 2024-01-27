extends Node

signal set_possibles_body_parts(parts: Array[ListBodyParts])
signal select_body_part(index: int)
signal change_attempts(attempts: int) 

func emit_change_attempts(attempts: int) -> void:
	change_attempts.emit(attempts)

func emit_select_body_part(index: int) -> void:
	select_body_part.emit(index)

func emit_set_possibles_body_parts(parts: Array[ListBodyParts]) -> void:
	set_possibles_body_parts.emit(parts)
