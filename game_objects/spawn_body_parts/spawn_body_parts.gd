extends CharacterBody2D

## List eyes scenes for spawn in game
@export var eyes_scenes: Array[PackedScene]

## hand move speed
@export var hand_speed: float

var move_direction: Vector2

func _ready() -> void:
	if randi_range(0, 1) == 0:
		move_direction = Vector2.RIGHT
	else:
		move_direction = Vector2.LEFT

func _process(delta: float) -> void:
	var direction := move_direction * hand_speed * delta
	velocity += direction.normalized()
	if move_and_slide():
		change_direction()
	
func change_direction() -> void:
	if move_direction == Vector2.RIGHT:
		move_direction = Vector2.LEFT
	else:
		move_direction = Vector2.RIGHT
