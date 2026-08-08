# Hotspot.gd
extends Control

signal hotspot_clicked(data: Dictionary)

var hotspot_data: Dictionary

func setup(data: Dictionary):
	hotspot_data = data
	mouse_filter = Control.MOUSE_FILTER_STOP
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		hotspot_clicked.emit(hotspot_data)

func _on_mouse_entered():
	Input.set_default_cursor_shape(_cursor_for_type(hotspot_data.get("action", "examine")))
	modulate = Color(1, 1, 1, 0.15) # resalte sutil opcional

func _on_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	modulate = Color(1, 1, 1, 0)

func _cursor_for_type(action: String) -> int:
	match action:
		"talk": return Input.CURSOR_POINTING_HAND
		"pickup": return Input.CURSOR_CROSS
		_: return Input.CURSOR_HELP
