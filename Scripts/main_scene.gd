extends Node2D

@onready var scene_stage: SceneStage = %SceneStage
@onready var dialog_ui = %Dialog

var transition_effect: String = "fade"
var dialog_file: String = "res://resources/story/cap1_sec1_esc1.json"
var dialog_index: int
var dialog_lines: Array = []
var scene_hotspots: Array = []

func _ready() -> void:
	dialog_ui.choice_selected.connect(_on_choice_selected)
	scene_stage.hotspot_triggered.connect(_on_hotspot_triggered)
	SceneManager.transition_out_completed.connect(_on_transition_out_completed)
	SceneManager.transition_in_completed.connect(_on_transition_in_completed)

	load_scene(dialog_file)
	dialog_index = 0
	process_current_line()

func _input(event: InputEvent) -> void:
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
	scene_hotspots = scene_data.get("hotspots", [])
	scene_stage.clear_hotspots()
	scene_stage.spawn_hotspots(scene_hotspots)

func process_current_line() -> void:
	var line = dialog_lines[dialog_index]

	if line.has("next_scene"):
		var next_scene = line["next_scene"]
		dialog_file = "res://resources/story/" + next_scene + ".json" if !next_scene.is_empty() else ""
		transition_effect = line.get("transition", "fade")
		SceneManager.transition_out(transition_effect)
		return

	elif line.has("goto"):
		dialog_index = get_anchor_pos(line["goto"])
		process_current_line()
		return

	elif line.has("anchor"):
		dialog_index += 1
		if dialog_index < len(dialog_lines):
			process_current_line()
		return

	elif line.has("add_clue"):
		# TODO (Roadmap paso 5): añadir la pista al inventario
		dialog_index += 1
		if dialog_index < len(dialog_lines):
			process_current_line()
		return

	elif line.has("choices"):
		dialog_ui.display_choices(line["choices"])

	elif line.has("location"):
		scene_stage.set_background(line["location"])
		dialog_index += 1
		process_current_line()
		return

	else:
		var character_name = Character.get_enum_from_string(line["speaker"])
		dialog_ui.change_line(character_name, line["text"])
		scene_stage.show_character(character_name)

func get_anchor_pos(anchor: String):
	for i in range(dialog_lines.size()):
		if dialog_lines[i].has("anchor") and dialog_lines[i]["anchor"] == anchor:
			return i
	printerr("Error: Could not find anchor " + anchor)
	return null

func _on_choice_selected(anchor: String) -> void:
	dialog_index = get_anchor_pos(anchor)
	process_current_line()

func _on_hotspot_triggered(goto_id: String) -> void:
	# TODO (Roadmap paso 2): esto empezará a dispararse de verdad
	# cuando HotspotLayer genere hotspots reales y se puedan clicar.
	dialog_index = get_anchor_pos(goto_id)
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
