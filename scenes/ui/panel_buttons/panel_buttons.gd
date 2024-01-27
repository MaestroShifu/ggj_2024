extends Control

class_name PanelButtons

@export var scene_button: PackedScene

@onready var h_box_container: HBoxContainer = $TextureRect/HBoxContainer

func _ready() -> void:
	GameEvents.set_possibles_body_parts.connect(_on_set_possibles_body_parts)

func _on_set_possibles_body_parts(parts: Array[BodyParts]) -> void:
	for idx in parts.size():
		var scene := scene_button.instantiate() as BodyPartsButton
		h_box_container.add_child(scene)
		scene.texture_path = parts[idx].path_texture
		scene.pressed.connect(_on_button_click.bind(idx))

func _on_button_click(idx: int) -> void:
	print("selecciono esto:", idx)
