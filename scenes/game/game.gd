extends Node2D

class_name Game

## List of Body parts
@export var body_parts: Array[ListBodyParts]

@onready var scientist_hand: ScientistHand = $ScientistHand
@onready var player: Player = $Player

var is_drop: bool = true
var is_use_tab: bool = false

enum GAME_STATE { SELECT, DROP, PASTE }
var game_state: GAME_STATE = GAME_STATE.SELECT 

var item_pool: Array[ListBodyParts] = []

func _ready() -> void:
	if len(body_parts) == 0:
		push_error("Please fill bodyparts!!")
		return

func _process(_delta: float) -> void:
	if game_state == GAME_STATE.SELECT and len(item_pool) == 0:
		set_pool_items()
	
	if Input.is_action_just_pressed("tap_action") and not is_use_tab:
		is_use_tab = true
		game_events()

	if Input.is_action_just_released("tap_action"):
		is_use_tab = false

func game_events() -> void:
	if game_state == GAME_STATE.SELECT:
		set_pool_items()
		game_state = GAME_STATE.DROP
	elif game_state == GAME_STATE.DROP:
		scientist_hand.drop()
		game_state = GAME_STATE.PASTE
	else:
		var is_paste := player.paste()
		if not is_paste:
			return
		game_state = GAME_STATE.SELECT

func set_pool_items() -> void:
	pass
	#var pool: Array[BodyParts]
	#for i in range(3):
	#	var idx := randi() % 2
	#	var x := body_parts[idx]
	#	pool.append(x)
	#GameEvents.emit_set_possibles_body_parts(pool)

func _on_bottom_limit_body_entered(body: BodyParts) -> void:
	if body.is_valid:
		body.queue_free()
		game_state = GAME_STATE.SELECT
