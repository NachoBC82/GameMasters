extends Node2D

@onready var sprite = %Sprite2D

const characters_sprite = {
	"Lex": preload("res://assets/Sprite/Lex.png"),
	"Agente337": preload("res://assets/Sprite/Agente337.png"),
	"Policia": preload("res://assets/Sprite/Policia.png"),
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func change_character(name: String):
	if(characters_sprite.has(name)):
		sprite.texture = characters_sprite[name]
