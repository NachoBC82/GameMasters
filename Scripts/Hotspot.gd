extends Area2D

func _ready() -> void:
	print("HOTSPOT INICIADO: ", name)
	print("Input Pickable: ", input_pickable)
	print("Collision Layer: ", collision_layer)

	input_pickable = true
	input_event.connect(_on_input_event)

func _on_input_event(
	_viewport: Node,
	event: InputEvent,
	_shape_idx: int
) -> void:
	print("EVENTO RECIBIDO")

	if event is InputEventMouseButton and event.pressed:
		print("CLICK EN HOTSPOT: ", name)
