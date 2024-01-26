extends Node2D

class_name Game

@onready var spawn_body_parts: SpawnBodyParts = $SpawnBodyParts
@onready var player: Player = $Player

var is_drop: bool = true

func _process(_delta: float) -> void:
	if Input.is_action_pressed("tap_action"):
		if is_drop:
			spawn_body_parts.drop()
		else:
			var is_paste := player.paste()
			if not is_paste:
				return
		is_drop = !is_drop
