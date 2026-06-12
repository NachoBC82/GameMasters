extends AudioStreamPlayer2D

const voice_sounds : Dictionary = {
	"lex" : preload('res://assets/Sounds/lex.wav'),
	"male" : preload('res://assets/Sounds/man.wav'),
	"female" : preload('res://assets/Sounds/woman.wav'),
	"ai" : preload('res://assets/Sounds/ai.wav'),
}

func play_sound(character_details: Dictionary):	
	if character_details["name"] == "Lex":
		stream = voice_sounds["lex"]
	else:
		var character_gender = character_details["gender"]
		stream = voice_sounds[character_gender]
	play()
	
