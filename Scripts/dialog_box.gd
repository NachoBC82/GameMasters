extends Control

@onready var dialog_line = %DialogLine
@onready var speaker_name = %DialogSpeaker
@onready var text_blip_sound = %TextBlipSound
@onready var text_blip_timer = %TextBlipTimer
@onready var sentence_pause_timer = %SentencePauseTimer

const Animation_speed : int = 30
const no_sound_chars : Array = [".","?","!"]

var animate_text : bool = false
var current_visible_char : int = 0
var current_character_details : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect signals
	text_blip_timer.timeout.connect(_on_text_blip_timeout)
	sentence_pause_timer.timeout.connect(_on_sentence_pause_timer)
	
func _process(delta: float):
	if animate_text and sentence_pause_timer.is_stopped():
		if dialog_line.visible_ratio < 1:
			dialog_line.visible_ratio += (1.0/dialog_line.text.length()) * (Animation_speed * delta)
			if dialog_line.visible_characters > current_visible_char:				
				current_visible_char = dialog_line.visible_characters
				var current_char = dialog_line.text[current_visible_char - 1]
				if current_visible_char < dialog_line.text.length():
					var next_char = dialog_line.text[current_visible_char]
					if no_sound_chars.has(current_char) and next_char == " ":
						text_blip_timer.stop()
						sentence_pause_timer.start()
		else:
			animate_text = false
			text_blip_timer.stop()

func change_line(speaker:Character.Name, line: String):
	current_character_details = Character.CHARACTER_DETAILS[speaker]
	speaker_name.text = current_character_details["name"]
	current_visible_char = 0
	
	dialog_line.text = line
	dialog_line.visible_characters = 0
	animate_text = true
	text_blip_timer.start()
	
func skip_text_animation():
	dialog_line.visible_ratio = 1
	
func _on_text_blip_timeout():
	text_blip_sound.play_sound(current_character_details)
	
func _on_sentence_pause_timer():
	text_blip_timer.start()
