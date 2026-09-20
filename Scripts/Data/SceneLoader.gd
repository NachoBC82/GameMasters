class_name SceneLoader
extends RefCounted

## Carga un archivo de escena y devuelve {"lines": [...], "hotspots": [...]}
static func load_scene(file_path: String) -> Dictionary:
	if not FileAccess.file_exists(file_path):
		printerr("Error: file does not exist ", file_path)
		return {}

	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		printerr("Error: Failed to open file ", file_path)
		return {}

	var content = file.get_as_text()
	var json_content = JSON.parse_string(content)

	if json_content == null or typeof(json_content) != TYPE_DICTIONARY:
		printerr("Error: Invalid scene JSON in ", file_path)
		return {}

	return {
		"lines": json_content.get("lines", []),
		"hotspots": json_content.get("hotspots", [])
	}
