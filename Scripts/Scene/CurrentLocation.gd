class_name BackgroundLayer
extends CanvasLayer

signal hotspot_clicked(name: String)

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
	
	# Conectar señales del hotspot
	_connect_dynamic_hotspots()

# Función que cuenta el número de Hotspot
func getHotspotCount(node):
	var count = 0
	for N in node.get_children():
		if N.get_child_count() > 0:			
			count += getHotspotCount(N)
		if N is Area2D:
			count += 1			
	return count

func _clear_current_location() -> void:
	if _location_instance:
		_location_instance.queue_free()
		_location_instance = null
			

func _connect_dynamic_hotspots() -> void:
	# Busca los hotspots dentro del nodo de la ubicación actual
	for child in current_location.get_children():
		if child is Area2D:
			if not child.clicked.is_connected(_on_hotspot_clicked):
				child.clicked.connect(_on_hotspot_clicked)

func _on_hotspot_clicked(name: String) -> void:
	print(name)
	hotspot_clicked.emit(name)
