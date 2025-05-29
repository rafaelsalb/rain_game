extends Node

var GEMINI_API_KEY = ""

func _ready():
	var file = FileAccess.open("res://.env", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	GEMINI_API_KEY = content.GEMINI_API_KEY
