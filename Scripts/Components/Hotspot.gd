extends Area2D

signal hotspot_triggred

func _ready() -> void:
	input_pickable = true
	input_event.connect(_on_input_event)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		hotspot_triggred.emit(name)
		print("CLICK EN HOTSPOT: ", name)	
