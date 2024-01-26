extends CharacterBody2D

class_name SpawnBodyParts

## List eyes scenes for spawn in game
@export var eyes_scenes: Array[PackedScene]

## hand move speed
@export var hand_speed: float

@onready var pin_join: PinJoint2D = $Joins/PinJoint2D

var move_direction: Vector2

func _ready() -> void:
	if randi_range(0, 1) == 0:
		move_direction = Vector2.RIGHT
	else:
		move_direction = Vector2.LEFT

func _process(delta: float) -> void:
	var direction := move_direction * hand_speed * delta
	velocity += direction.normalized() * hand_speed * delta
	if move_and_slide():
		change_direction()
	
func change_direction() -> void:
	if move_direction == Vector2.RIGHT:
		move_direction = Vector2.LEFT
	else:
		move_direction = Vector2.RIGHT

func drop() -> void:
	pin_join.node_b = ""
