extends Node2D

class_name Game

@onready var spawn_body_parts: SpawnBodyParts = $SpawnBodyParts
@onready var player: Player = $Player

var is_drop: bool = true

var is_use_tab: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("tap_action") and not is_use_tab:
		is_use_tab = true
		game_events()

	if Input.is_action_just_released("tap_action"):
		is_use_tab = false

func game_events() -> void:
	if is_drop:
		spawn_body_parts.drop()
	else:
		var is_paste := player.paste()
		if not is_paste:
			return
	is_drop = !is_drop
