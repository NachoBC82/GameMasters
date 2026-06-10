class_name Character
extends Node

enum Name {
	LEX,
	AGENTE377,
	POLICIA
}

const CHARACTER_DETAILS : Dictionary = {
	Name.LEX: {
		"name": "Lex",
		"gender": "male",
		"Sprite2D": preload("res://assets/Sprite/Lex.png"),
	},
	Name.AGENTE377: {
		"name": "Agente377",
		"gender":"ai",
		"Sprite2D": preload("res://assets/Sprite/Agente337.png"),
	},
	Name.POLICIA: {
		"name": "Policia",
		"gender":"male",
		"Sprite2D": preload("res://assets/Sprite/Policia.png"),
	}	
}

static func get_enum_from_string(string_value: String) -> int:
	var upper_string = string_value.to_upper()
	if Name.has(upper_string):
		return Name[upper_string]
	else:
		push_error("Invalid Character Name: "+string_value)
		return -1
		
static func get_default() -> Resource:
	return Character.CHARACTER_DETAILS[CHARACTER_DETAILS.LEX]["Sprite2D"]
