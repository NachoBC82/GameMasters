extends Node2D

@onready var character_sprite = %CharacterSprite
@onready var dialog_ui = %Dialog
@onready var next_sentence_sound = %NextSentenceSound

var dialog_index : int

const dialog_lines : Array[String] = [
	"Lex: Otro dia mas, otro caso mas. Por si fuera poco hoy toca conocer a mi nuevo compañero.",
	"Lex: Encima todos están obsesionados con esas tecnologias inutiles.",
	"Policia: Buenas Lex, la víctima está por aqui. Tu nuevo compañero ya la esta observando."
]

func _ready() -> void:
	# Process firts line
	dialog_index = 0
	process_current_line()

func _input(event):
	if event.is_action_pressed("next_line"):
		if dialog_ui.animate_text:
			dialog_ui.skip_text_animation()
		else:
			if dialog_index < len(dialog_lines) - 1:
				dialog_index += 1
				process_current_line()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func parse_line(line: String):
	var line_info = line.split(":")
	assert(len(line_info) >= 2)
	return {
		"speaker": line_info[0],
		"dialog_line": line_info[1]
	}

func process_current_line():
	var line = dialog_lines[dialog_index]
	var line_info = parse_line(line)
	var character_name = Character.get_enum_from_string(line_info["speaker"])
	
	dialog_ui.change_line(character_name,line_info["dialog_line"])
	character_sprite.change_character(character_name)
