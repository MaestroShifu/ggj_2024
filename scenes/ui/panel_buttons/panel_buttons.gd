extends Control

class_name PanelButtons

@export var scene_button: PackedScene

@onready var h_box_container: HBoxContainer = $TextureRect/HBoxContainer
@onready var tutorial: TextureRect = $Tutorial
@onready var attempts: Label = $VBoxContainer/Attempts

var is_first_time: bool = true
var current_attempts: int = 0

func _ready() -> void:
	GameEvents.set_possibles_body_parts.connect(_on_set_possibles_body_parts)
	GameEvents.change_attempts.connect(_on_change_attempts)

func _process(_delta: float) -> void:
	attempts.text = str(current_attempts)

func _on_change_attempts(attempt: int) -> void:
	current_attempts = attempt

func _on_set_possibles_body_parts(parts: Array[ListBodyParts]) -> void:
	visible = true
	for idx in parts.size():
		var scene := scene_button.instantiate() as BodyPartsButton
		h_box_container.add_child(scene)
		scene.texture_path = parts[idx].icon_texture.resource_path
		scene.pressed.connect(_on_button_click.bind(idx))

func _on_button_click(idx: int) -> void:
	if is_first_time:
		tutorial.visible = false
		is_first_time = false

	visible = false
	GameEvents.emit_select_body_part(idx)
	var buttons := h_box_container.get_children()
	for button in buttons:
		button.queue_free()
