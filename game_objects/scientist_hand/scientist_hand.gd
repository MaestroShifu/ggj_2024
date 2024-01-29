extends CharacterBody2D

class_name ScientistHand

## hand move speed
@export var hand_speed: float

@onready var pin_join: PinJoint2D = $Joins/PinJoint2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var move_direction: Vector2
var selected_body_part: BodyParts

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

func take_body_part(body_part: BodyParts) -> void:
	if selected_body_part:
		selected_body_part.queue_free()
	animated_sprite.play("take")
	get_parent().add_child(body_part)
	body_part.global_position = pin_join.global_position
	var diff := body_part.global_position - body_part.grip_marker.global_position
	body_part.global_position += diff
	pin_join.node_b = "../../%s" % get_path_to(body_part)
	selected_body_part = body_part

func drop() -> void:
	selected_body_part = null
	animated_sprite.play("drop")
	pin_join.node_b = ""
