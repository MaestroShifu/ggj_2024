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

var valid_node: String = ""
var show_monster: bool = false

func _ready() -> void:
	if len(body_player_scenes) <= 0:
		push_error("You need load body players valid")
		return

	var nodes := get_children()
	if len(nodes) == 0:
		start_body()
	else:
		show_monster = true

func _process(delta: float) -> void:
	calculate_position()
	var body := get_node_or_null(BODY_NODE_NAME) as Body
	if body:
		var vel_degrees_rotation := rotation_speed * delta
		body.rotate(deg_to_rad(vel_degrees_rotation))
		if show_monster:
			bottom_percentage_position = 55

func paste() -> bool:
	var body_part: BodyParts
	for bp in get_tree().get_nodes_in_group(Utils.BODY_PARTS_GROUP):
		if bp.name == valid_node:
			body_part = bp
			break  
	if body_part:
		copy_merge_body_part(body_part)
		valid_node = ""
		return true
	return false

func copy_merge_body_part(body_part: BodyParts) -> void:
	var body := get_node_or_null(BODY_NODE_NAME) as Body

	var part_duplicate := body_part.duplicate() as BodyParts
	body.add_part(part_duplicate)

	part_duplicate.paste_to_body()
	part_duplicate.global_transform = body_part.global_transform
	
	part_duplicate.body_entered.connect(_on_body_entered)
	part_duplicate.body_exited.connect(_on_body_exited)

	body_part.queue_free()

func calculate_position() -> void:
	var visible_rect := Vector2.ZERO
	if Engine.is_editor_hint():
		visible_rect =  Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
	else:
		visible_rect = Utils.get_visible_rect()
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

func _on_body_entered(body: BodyParts) -> void:
	if valid_node != body.name and body.is_valid:
		valid_node = body.name

func _on_body_exited(body: BodyParts) -> void:
	if body.is_valid and len(valid_node) > 0:
		valid_node = ""
