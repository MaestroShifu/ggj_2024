extends TextureButton

class_name BodyPartsButton

## Teture path button
@export var texture_path: String

@onready var texture_rect: TextureRect = $TextureRect

func _process(delta: float) -> void:
	if not texture_rect.texture:
		if len(texture_path) == 0:
			push_error("plaese set texture path")
			return

		var texture := load(texture_path)
		if not texture: 
			push_error("Failed load texture")
			return
		texture_rect.texture = texture
