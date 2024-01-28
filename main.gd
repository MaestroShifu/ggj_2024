extends Node

@export var gameplay_scene: PackedScene
@export var finish_scene: PackedScene
@export var credits_scene: PackedScene 
@export var main_menu_scene: PackedScene

var current_scene: Node
var current_monster: Player
var current_game_scene: Utils.GAME_SCENE

func _ready() -> void:
	set_game_scene(Utils.GAME_SCENE.MAIN)
	GameEvents.change_game_scene.connect(_on_change_game_scene)

func _process(_delta: float) -> void:
	if current_scene and current_monster and current_game_scene == Utils.GAME_SCENE.FINISH:
		current_scene.add_child(current_monster)

func set_game_scene(game_scene: Utils.GAME_SCENE) -> void:
	var temp_scene: Node
	current_game_scene = game_scene
	if game_scene == Utils.GAME_SCENE.MAIN:
		temp_scene = main_menu_scene.instantiate()
	if game_scene == Utils.GAME_SCENE.CREDITS:
		temp_scene = credits_scene.instantiate()
	if game_scene == Utils.GAME_SCENE.GAMEPLAY:
		temp_scene = gameplay_scene.instantiate()
	if game_scene == Utils.GAME_SCENE.FINISH:
		current_monster = (current_scene as Gameplay).game.player.duplicate()
		temp_scene = finish_scene.instantiate()

	add_child(temp_scene)
	if current_scene:
		current_scene.queue_free()
	current_scene = temp_scene

func _on_change_game_scene(scene: Utils.GAME_SCENE) -> void:
	set_game_scene(scene)
