class_name BackgroundLayer
extends CanvasLayer

@onready var current_location: Node2D = %CurrentLocation

var _location_instance: Node2D = null

func set_background(location: String) -> void:
	_clear_current_location()

	var scene_path = "res://Scenes/Locations/" + location + ".tscn"
	if not ResourceLoader.exists(scene_path):
		printerr("Error: no existe la escena de localización ", scene_path)
		return

	var location_scene: PackedScene = load(scene_path)
	_location_instance = location_scene.instantiate()
	current_location.add_child(_location_instance)

func _clear_current_location() -> void:
	if _location_instance:
		_location_instance.queue_free()
		_location_instance = null
