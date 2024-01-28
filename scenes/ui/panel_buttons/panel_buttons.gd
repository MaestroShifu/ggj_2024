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

func reset_options() -> void:
	for button in h_box_container.get_children() as Array[BodyPartsButton]:
		button.queue_free()

func disable_options() -> void:
	for btn in h_box_container.get_children() as Array[BodyPartsButton]:
		btn.disabled = true

func _on_change_attempts(attempt: int) -> void:
	current_attempts = attempt

func _on_set_possibles_body_parts(parts: Array[ListBodyParts]) -> void:
	reset_options()
	for idx in parts.size():
		var scene := scene_button.instantiate() as BodyPartsButton
		h_box_container.add_child(scene)
		scene.texture_path = parts[idx].icon_texture.resource_path
		scene.pressed.connect(_on_button_click.bind(idx, scene))

func _on_button_click(idx: int, button: BodyPartsButton) -> void:
	if is_first_time:
		tutorial.visible = false
		is_first_time = false

	disable_options()
	button.selectable()
	GameEvents.emit_select_body_part(idx)
