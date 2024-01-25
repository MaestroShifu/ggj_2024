@tool
extends Node2D

class_name Player

const BODY_NODE_NAME = "Body"

## Possible body for players
@export var body_player_scenes: Array[PackedScene]

## Speed of rotation in px/sg
@export var rotation_speed: float

## Position percentage from bottom
@export_range(0, 100) var bottom_percentage_position: int

func _ready() -> void:
	if len(body_player_scenes) <= 0:
		push_error("You need load body players valid")
		return
	start_body()

func _process(delta: float) -> void:
	calculate_position()
	
	var body := get_node_or_null(BODY_NODE_NAME) as Body
	if body:
		var vel_degrees_rotation := rotation_speed * delta
		body.rotate(deg_to_rad(vel_degrees_rotation))

func calculate_position() -> void:
	var visible_rect := Utils.get_visible_rect()
	var x := visible_rect.x / 2
	var y := visible_rect.y - ((bottom_percentage_position * visible_rect.y) / 100)
	position = Vector2(x, y)

func start_body() -> void:
	var idx := randi() % body_player_scenes.size()
	var body_player := body_player_scenes[idx]
	var scene := body_player.instantiate() as Body

	scene.name = BODY_NODE_NAME
	scene.body_entered.connect(_on_body_entered)
	scene.body_exited.connect(_on_body_exited)

	add_child(scene)

func restart_body() -> void:
	var body := get_node(BODY_NODE_NAME) as Body
	body.queue_free()
	start_body()

func _on_body_entered(body: Node2D) -> void:
	pass

func _on_body_exited(body: Node2D) -> void:
	pass
