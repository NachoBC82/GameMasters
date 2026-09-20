extends Node2D

@onready var sprite = %Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func change_character(character_name: Character.Name) -> void:
	var sprite_texture: Texture2D = Character.CHARACTER_DETAILS[character_name]["Sprite2D"]
	if sprite_texture:
		sprite.texture = sprite_texture
	else:
		sprite.texture = Character.get_default()
