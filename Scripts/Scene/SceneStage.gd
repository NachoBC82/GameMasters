class_name SceneStage
extends Node2D

## Señal única hacia arriba: cualquier hotspot pulsado llega aquí
## y se reenvía a main_scene.gd, sea cual sea la capa de origen.
signal hotspot_triggered(goto_id: String)

@onready var background_layer: BackgroundLayer = %BackgroundLayer
@onready var character_layer: CharacterLayer = %CharacterLayer
@onready var hotspot_layer: HotspotLayer = %HotspotLayer

func _ready() -> void:
	hotspot_layer.hotspot_triggered.connect(_on_hotspot_triggered)

func set_background(location: String) -> void:
	background_layer.set_background(location)

func show_character(character_name: Character.Name) -> void:
	character_layer.show_character(character_name)

func spawn_hotspots(hotspots_data: Array) -> void:
	hotspot_layer.spawn_hotspots(hotspots_data)

func clear_hotspots() -> void:
	hotspot_layer.clear_hotspots()

func _on_hotspot_triggered(goto_id: String) -> void:
	hotspot_triggered.emit(goto_id)
