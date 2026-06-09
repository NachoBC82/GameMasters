extends Control

@onready var dialog_line = %DialogLine
@onready var speaker_name = %DialogSpeaker

const Animation_speed : int = 30
var animate_text : bool = false
var current_visible_characters : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _process(delta: float):
	if animate_text:
		if dialog_line.visible_ratio < 1:
			dialog_line.visible_ratio += (1.0/dialog_line.text.length()) * (Animation_speed * delta)
		else:
			animate_text = false 

func change_line(speaker:String, line: String):
	speaker_name.text = speaker
	current_visible_characters = 0
	
	dialog_line.text = line
	dialog_line.visible_characters = 0
	animate_text = true
