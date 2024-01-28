extends Node

class_name FinishGame

var monster: Player
var is_load_monster: bool = false

func _process(_delta: float) -> void:
	if not is_load_monster and monster:
		GameEvents.emit_sfx_play_sounds(Utils.FSX_SOUND.SUCCEED)
		add_child(monster)
		is_load_monster = true
