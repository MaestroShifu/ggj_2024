extends Node

signal set_possibles_body_parts(parts: Array[BodyParts])
signal select_body_part(index: int)

func emit_select_body_part(index: int) -> void:
	select_body_part.emit(index)

func emit_set_possibles_body_parts(parts: Array[BodyParts]) -> void:
	set_possibles_body_parts.emit(parts)
