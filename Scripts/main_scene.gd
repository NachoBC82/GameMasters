extends Node2D

@onready var scene_stage: SceneStage = %SceneStage
@onready var dialog_ui = %Dialog

var transition_effect: String = "fade"
var dialog_file: String = "res://resources/story/cap1_sec1_esc3.json"
var dialog_index: int
var dialog_lines: Array = []
var interaction_mode : InteractionMode.gameMode 

func init_investigation_mode():
	interaction_mode = InteractionMode.gameMode.INVESTIGATION
	scene_stage.hide_ui()
	#dialog_ui.set_process(false)
	dialog_ui.stop_sound()
	
func init_dialog_mode():
	interaction_mode = InteractionMode.gameMode.DIALOG
	scene_stage.show_ui()
	#dialog_ui.set_process(true) 
	 

func _ready() -> void:
	# Conectar señales
	dialog_ui.choice_selected.connect(_on_choice_selected)
	scene_stage.hotspot_trigger.connect(_on_hotspot_triggered)
	SceneManager.transition_out_completed.connect(_on_transition_out_completed)
	SceneManager.transition_in_completed.connect(_on_transition_in_completed)

	# Inicializar variables
	dialog_index = 0
	interaction_mode = InteractionMode.gameMode.DIALOG
	
	load_scene(dialog_file)	
	process_current_line()

func _input(event: InputEvent) -> void:	
	if interaction_mode == InteractionMode.gameMode.DIALOG:
		if dialog_lines.is_empty():
			return
		var line = dialog_lines[dialog_index]
		var has_choices = line.has("choices")
		if event.is_action_pressed("next_line") and not has_choices:
			if dialog_ui.animate_text:
				dialog_ui.skip_text_animation()
			else:
				if dialog_index < len(dialog_lines) - 1:
					dialog_index += 1
					process_current_line()	

func load_scene(file_path: String) -> void:
	var scene_data = SceneLoader.load_scene(file_path)
	dialog_lines = scene_data.get("lines", [])

func process_current_line() -> void:
	var line = dialog_lines[dialog_index]

	if line.has("next_scene"):
		var next_scene = line["next_scene"]
		dialog_file = "res://resources/story/" + next_scene + ".json" if !next_scene.is_empty() else ""
		transition_effect = line.get("transition", "fade")
		SceneManager.transition_out(transition_effect)		

	elif line.has("goto"):
		dialog_index = get_anchor_pos(line["goto"])
		process_current_line()		

	elif line.has("anchor"):
		dialog_index += 1
		if dialog_index < len(dialog_lines):
			process_current_line()		

	elif line.has("add_clue"):
		# TODO (Roadmap paso 5): añadir la pista al inventario
		dialog_index += 1
		if dialog_index < len(dialog_lines):
			process_current_line()		

	elif line.has("choices"):
		dialog_ui.display_choices(line["choices"])

	elif line.has("location"):
		scene_stage.set_background(line["location"])
		dialog_index += 1
		process_current_line()		
		
	elif line.has("mode"):
		if InteractionMode.get_enum_from_string(line["mode"]) == InteractionMode.gameMode.DIALOG:
			init_dialog_mode()			
		elif InteractionMode.get_enum_from_string(line["mode"]) == InteractionMode.gameMode.INVESTIGATION:
			if scene_stage.isAnyHotspotAvailables():
				init_investigation_mode()
			else:
				init_dialog_mode()
				dialog_index += 1
				
	else:
		var character_name = Character.get_enum_from_string(line["speaker"])
		dialog_ui.change_line(character_name, line["text"])
		scene_stage.show_character(character_name)
	
	return

func get_anchor_pos(anchor: String):
	for i in range(dialog_lines.size()):
		if dialog_lines[i].has("anchor") and dialog_lines[i]["anchor"] == anchor:
			return i
	printerr("Error: Could not find anchor " + anchor)
	return null

func _on_choice_selected(anchor: String) -> void:
	dialog_index = get_anchor_pos(anchor)
	process_current_line()

func _on_transition_out_completed() -> void:
	load_scene(dialog_file)
	dialog_index = 0
	if dialog_lines.is_empty():
		return
	var first_line = dialog_lines[dialog_index]
	if first_line.has("location"):
		scene_stage.set_background(first_line["location"])
		dialog_index += 1
	SceneManager.transition_in(transition_effect)

func _on_transition_in_completed() -> void:
	process_current_line()
	
func _on_hotspot_triggered(name:String) -> void:
	init_dialog_mode()	
	dialog_index = get_anchor_pos(name)
	process_current_line()
