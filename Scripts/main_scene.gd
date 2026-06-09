extends Node2D

@onready var character = %Character
@onready var dialog_ui = %Dialog
var dialog_index : int

const dialog_lines : Array[String] = [
	"Lex: Otro día más, otro caso más. Encima hoy toca conocer a mi nuevo compañero.",
	"Lex: Encima todos están obsesionados con esas tecnologías inútiles.",
	"Policia: Buenas Lex, la víctima está por aquí. Tu nuevo compañero ya la está observando."
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_index = 0
	process_current_line()

func _input(event):
	if event.is_action_pressed("next_line"):
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
	var line_speaker = parse_line(line)["speaker"]
	var line_info = parse_line(line)["dialog_line"]
		
	dialog_ui.speaker.text = line_speaker
	character.change_character(line_speaker)
	
	dialog_ui.dialog_line.text = line_info
	
