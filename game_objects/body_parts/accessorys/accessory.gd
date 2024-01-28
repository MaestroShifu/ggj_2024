@tool
extends BodyParts

class_name Accessory

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	super._ready()
	animation_player.play("default")
