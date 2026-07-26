extends Node2D

@onready var character_sprite = %CharacterSprite
@onready var dialog_ui = %Dialog
@onready var next_sentence_sound = %NextSentenceSound
@onready var background = %Background

var transition_effect: String = "fade"
var dialog_file: String = "res://resources/story/cap1_sec1_esc1.json"
var dialog_index : int
var dialog_lines : Array = []

func _ready() -> void:
	# Connect signals
	dialog_ui.choice_selected.connect(_on_choice_selected)
	SceneManager.transition_out_completed.connect(_on_transition_out_completed)
	SceneManager.transition_in_completed.connect(_on_transition_in_completed)
	# load dialog
	dialog_lines = load_dialog(dialog_file)
	# Process firts line
	dialog_index = 0
	process_current_line()

func _input(event):
	var line = dialog_lines[dialog_index]
	var has_choices = line.has("choices")
	if event.is_action_pressed("next_line") and not has_choices:
		if dialog_ui.animate_text:
			dialog_ui.skip_text_animation()
		else:
			if dialog_index < len(dialog_lines) - 1:
				dialog_index += 1
				process_current_line()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func process_current_line():
	var line = dialog_lines[dialog_index]
	# Check if is is next scene
	if line.has("next_scene"):
		var next_scene = line["next_scene"]
		dialog_file = "res://resources/story/" + next_scene + ".json" if !next_scene.is_empty() else ""
		transition_effect = line.get("transition", "fade")
		SceneManager.transition_out(transition_effect)
		return		
	
	# Check if is goto command
	elif line.has("goto"):
		dialog_index = get_anchor_pos(line["goto"])
		process_current_line()
		return
	
	# Check if is a anchor
	elif line.has("anchor"):
		dialog_index += 1 
		if dialog_index < len(dialog_lines):
			process_current_line()
		return
		
	# Check if it is a choice
	elif line.has("choices"):
		dialog_ui.display_choices(line["choices"])
	
	elif line.has("location"):
		var background_file = "res://assets/Background/" + line["location"] + ".png"
		background.texture = load(background_file)
		dialog_index += 1
		process_current_line()
		return
	
	# Reading line of dialog
	else:
		var character_name = Character.get_enum_from_string(line["speaker"])
		dialog_ui.change_line(character_name,line["text"])
		character_sprite.change_character(character_name)

func get_anchor_pos(anchor: String):
	# Find the anchor entry with matching name
	for i in range(dialog_lines.size()):
		if dialog_lines[i].has("anchor") and dialog_lines[i]["anchor"] == anchor:
			return i
	
	# Anchor was not found
	printerr("Error: Could not find anchor "+anchor)
	return null

func load_dialog(file_path):
	# Check file exist
	if not FileAccess.file_exists(file_path):
		printerr("Error: file does not exist ", file_path)
		return null
	
	# Open file
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		printerr("Error: Failed to open file ", file_path)
		return null
	
	# Read content
	var content = file.get_as_text()
	
	# Parse json
	var json_content = JSON.parse_string(content)
	if json_content == null:
		printerr("Error: Failed to parse JSON from file ", file_path)
		return null
	
	return json_content
	
func _on_choice_selected(anchor: String):
	dialog_index = get_anchor_pos(anchor)
	process_current_line()
	
func _on_transition_out_completed():
	# Cargamos nuevo dialogo
	dialog_lines = load_dialog(dialog_file)
	dialog_index = 0
	var first_line = dialog_lines[dialog_index]
	if first_line.has("location"):
		background.texture = load("res://assets/Background/" + first_line["location"] + ".png")
		dialog_index += 1
	SceneManager.transition_in(transition_effect)
	
func _on_transition_in_completed():
	# Procesamos linea de dialogo
	process_current_line()
