extends Area2D

class_name Body

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var showed_monster: bool = false

func add_part(part: BodyParts) -> void:
	add_child(part)

func show_only_one_monster() -> void:
	if not showed_monster:
		showed_monster = true
		animation_player.play("default")
