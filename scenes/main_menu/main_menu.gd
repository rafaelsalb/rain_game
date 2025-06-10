extends Control


func _on_button_button_up() -> void:
	LevelManager.change_scene("res://scenes/cutscenes/initial/InitialCutscene.tscn")
