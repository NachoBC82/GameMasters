extends Node2D

# Signals
signal transition_out_completed
signal transition_in_completed

# Black ColorRect for transitions
var transition_layer: CanvasLayer
var transitions_rect: ColorRect
var transition_time: float = 0.5

func _ready() -> void:
	#
	transition_layer = CanvasLayer.new()
	transition_layer.layer = 100 # Hacer que esté por encima de todo
	
	transitions_rect = ColorRect.new() # Pantalla en negro
	transitions_rect.color = Color.BLACK
	
	transitions_rect.anchor_right = 1.0 # Rellenar la pantalla en negro
	transitions_rect.anchor_bottom = 1.0
	transitions_rect.visible = false
	
	transition_layer.add_child(transitions_rect) # Añadir pantalla en negro al layer
	get_tree().root.add_child(transition_layer) # Añadir layer a la escena
	
func transition_out(effect: String = "fade"):
	match effect:
		"fade":
			_fade_out()
		"slide":
			_slide_out()
		_:
			_fade_out()
			
func transition_in(effect: String = "fade"):
	match effect:
		"fade":
			_fade_in()
		"slide":
			_slide_in()
		_:
			_fade_in()

func _fade_out():
	transitions_rect.position = Vector2.ZERO
	transitions_rect.modulate.a = 0
	transitions_rect.z_index = 999
	transitions_rect.visible = true
	
	var tween = create_tween()
	tween.tween_property(transitions_rect, "modulate.a", 1.0, transition_time)
	tween.tween_callback(func(): transition_out_completed.emit()	)
	
func _fade_in():
	transitions_rect.position = Vector2.ZERO
	transitions_rect.modulate.a = 0
	transitions_rect.z_index = 999
	transitions_rect.visible = true
	
	var tween = create_tween()
	tween.tween_property(transitions_rect, "modulate.a", 0.0, transition_time)
	tween.tween_callback(func():
		transitions_rect.visible = false
		transition_in_completed.emit()	)
