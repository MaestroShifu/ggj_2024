@tool
extends RigidBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

## Durtion max in eye closed animation
@export_range(1, 60) var max_time_eye_closed: int

var timer: Timer

func _ready() -> void:
	freeze = true

	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	reset_timer_params()

func _on_timer_timeout() -> void:
	animated_sprite.play("default")
	reset_timer_params()

func reset_timer_params() -> void:
	var time := randi() % max_time_eye_closed + 1
	timer.wait_time = time
	timer.start()
