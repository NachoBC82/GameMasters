extends Node2D

@onready var sprite = %Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func change_character(name: Character.Name):
	var sprite_texture = Character.CHARACTER_DETAILS[name]["Sprite2D"]
	if sprite_texture:
		sprite.texture = sprite_texture
	else:
		sprite.texture = Character.get_default()
