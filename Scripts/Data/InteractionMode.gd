class_name InteractionMode
	
enum gameMode {DIALOG, INVESTIGATION}
static func get_enum_from_string(string_value: String) -> int:
	var upper_string = string_value.to_upper()
	if gameMode.has(upper_string):
		return gameMode[upper_string]
	else:
		push_error("Invalid mode: "+string_value)
		return -1
