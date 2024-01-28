extends Node2D

class_name Game

## List of Body parts
@export var category_body_parts: Array[CategoryBodyParts]

# Maximum attempts the player
@export var maximum_attempts: int

@onready var scientist_hand: ScientistHand = $ScientistHand
@onready var player: Player = $Player

var is_use_tab: bool = false
var is_selected: bool = false

enum GAME_STATE { SELECT, DROP, PASTE, FINISH }
var game_state: GAME_STATE = GAME_STATE.SELECT 

var item_pool: Array[ListBodyParts] = []

var current_attempts: int = 0

func _ready() -> void:
	if len(category_body_parts) == 0:
		push_error("Please fill category body parts!!")
		return
	GameEvents.select_body_part.connect(_on_select_body_part)
	current_attempts = maximum_attempts

func _process(_delta: float) -> void:
	if game_state == GAME_STATE.FINISH:
		return
	
	if game_state == GAME_STATE.SELECT and len(item_pool) == 0:
		set_pool_items()
		if current_attempts == maximum_attempts:
			GameEvents.emit_change_attempts(current_attempts)

	if Input.is_action_just_pressed("tap_action") and not is_use_tab:
		is_use_tab = true
		game_events()

	if Input.is_action_just_released("tap_action"):
		is_use_tab = false

func game_events() -> void:
	if game_state == GAME_STATE.SELECT and not is_selected:
		game_state = GAME_STATE.DROP
	elif game_state == GAME_STATE.DROP and is_selected:
		scientist_hand.drop()
		game_state = GAME_STATE.PASTE
	elif game_state == GAME_STATE.PASTE:
		var is_paste := player.paste()
		if is_selected and is_paste:
			reset_loop_game()

func set_pool_items() -> void:
	var categories: Array[CategoryBodyParts]

	var is_finish: bool = true
	while is_finish:
		var idx := randi() % category_body_parts.size()
		if len(categories) == 0:
			categories.append(category_body_parts[idx])
			continue

		var temp_category := category_body_parts[idx]
		var is_valid := false
		for category in categories:
			if category.category == temp_category.category:
				is_valid = true
				break

		if not is_valid:
			categories.append(category_body_parts[idx])

		if categories.size() == 3:
			is_finish = false

	for category in categories:
		var idx := randi() % category.list_body_parts.size()
		item_pool.append(category.list_body_parts[idx])

	GameEvents.emit_set_possibles_body_parts(item_pool)

func reset_item_pool() -> void:
	item_pool = []

func reset_loop_game() -> void:
	game_state = GAME_STATE.SELECT
	is_selected = false

	current_attempts -= 1
	GameEvents.emit_change_attempts(current_attempts)
	if current_attempts == 0:
		game_state = GAME_STATE.FINISH
		GameEvents.emit_change_game_scene(Utils.GAME_SCENE.FINISH)

func _on_bottom_limit_body_entered(body: BodyParts) -> void:
	if body.is_valid:
		body.queue_free()
		reset_loop_game()

func _on_select_body_part(idx: int) -> void:
	is_selected = true
	GameEvents.emit_sfx_play_sounds(Utils.FSX_SOUND.CLICK)
	var scene := item_pool[idx].body_part.instantiate()
	scientist_hand.take_body_part(scene)
	reset_item_pool()
