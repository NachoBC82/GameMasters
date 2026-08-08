class_name LocationBackground
extends Sprite2D

func _ready() -> void:
	centered = true
	get_viewport().size_changed.connect(_update_size)
	_update_size()

func _update_size() -> void:
	if not texture:
		return
	var viewport_size = get_viewport().get_visible_rect().size
	position = viewport_size / 2
	scale = viewport_size / texture.get_size()
