extends Node

class_name SFX

@onready var click_sound: AudioStreamPlayer = $ClickSound
@onready var succeed_sound: AudioStreamPlayer = $SucceedSound

@onready var paste_sound: Node = $PasteSound

func _ready() -> void:
	GameEvents.sfx_play_sounds.connect(_on_sfx_play_sounds)

func _on_sfx_play_sounds(sound: Utils.FSX_SOUND) -> void:
	if sound == Utils.FSX_SOUND.CLICK:
		click_sound.play()
	if sound == Utils.FSX_SOUND.SUCCEED:
		succeed_sound.play()
	if sound == Utils.FSX_SOUND.PASTE:
		var sounds := paste_sound.get_children()
		var idx := randi() % sounds.size()
		sounds[idx].play()
