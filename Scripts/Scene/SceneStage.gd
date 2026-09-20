class_name SceneStage
extends Node2D

signal hotspot_trigger(name:String)

@onready var background_layer: BackgroundLayer = %BackgroundLayer
@onready var character_layer: CharacterLayer = %CharacterLayer
@onready var dialog_layer: Control = %Dialog

var hotspot_clicked: int = 0
var total_hotspot: int = 0

# SceneStage.gd
func _ready() -> void:
	background_layer.hotspot_clicked.connect(_on_hotspot_clicked)

func set_background(location: String) -> void:
	background_layer.set_background(location)
	total_hotspot = background_layer.getHotspotCount(background_layer.current_location)

func show_character(character_name: Character.Name) -> void:
	character_layer.show_character(character_name)
	
func hide_ui():
	dialog_layer.process_mode = Node.PROCESS_MODE_DISABLED
	dialog_layer.propagate_call("stop")
	dialog_layer.hide()
	
	character_layer.process_mode = Node.PROCESS_MODE_DISABLED
	character_layer.propagate_call("stop")
	character_layer.hide()
	
func show_ui():
	dialog_layer.process_mode = Node.PROCESS_MODE_INHERIT
	dialog_layer.propagate_call("play")
	dialog_layer.show()
	
	character_layer.process_mode = Node.PROCESS_MODE_INHERIT
	character_layer.propagate_call("play")
	character_layer.show()

func isAnyHotspotAvailables():
	return hotspot_clicked < total_hotspot
	
func _on_hotspot_clicked(name: String) -> void:
	hotspot_clicked += 1
	hotspot_trigger.emit(name)
