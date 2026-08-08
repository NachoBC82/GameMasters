class_name CharacterLayer
extends CanvasLayer

@onready var character_sprite: Node2D = %CharacterSprite

func show_character(character_name: Character.Name) -> void:
	character_sprite.change_character(character_name)
