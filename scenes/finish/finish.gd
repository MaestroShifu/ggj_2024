extends Control

class_name Finish

@export var backgrounds: Array[Texture]

@onready var background: TextureRect = $BG

func _ready() -> void:
	if len(backgrounds) == 0:
		push_error("Please set backgrounds!")
		return
	var idx := randi() % backgrounds.size()
	background.texture = backgrounds[idx]

func _on_continue_button_pressed() -> void:
	GameEvents.emit_sfx_play_sounds(Utils.FSX_SOUND.CLICK)
	GameEvents.emit_change_game_scene(Utils.GAME_SCENE.MAIN)
