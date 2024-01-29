extends Node

@onready var audio_credits: AudioStreamPlayer = $Credits
@onready var audio_gameplay: AudioStreamPlayer = $Gameplay
@onready var audio_menu: AudioStreamPlayer = $Menu

var current_audio: AudioStreamPlayer

func _ready() -> void:
	GameEvents.play_music.connect(_on_play_music)

func _process(_delta: float) -> void:
	if not current_audio.playing:
		current_audio.play()

func _on_play_music(sound: Utils.MUSIC) -> void:
	if current_audio:
		current_audio.stop()

	if sound == Utils.MUSIC.MENU:
		current_audio = audio_menu
	if sound == Utils.MUSIC.CREDITS:
		current_audio = audio_credits
	if sound == Utils.MUSIC.GAMEPLAY:
		current_audio = audio_gameplay

	if not current_audio.playing:
		current_audio.play()
