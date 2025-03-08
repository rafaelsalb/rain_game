extends Node


@export_file var dialog_file_path = "res://dialogs/example.json"

var current_line: int = 0
var dialog: Dictionary
var lines: Array

@onready var dialog_scene: PackedScene = preload("res://scenes/dialog/dialog.tscn")


func _ready() -> void:
	var dialog_file = load(dialog_file_path)
	dialog = dialog_file.data
	lines = dialog.get("default")
	next_line()


func next_line() -> void:
	if current_line < len(lines):
		var speaker = lines[current_line].get("speaker")
		var text = lines[current_line].get("text")

		var dialog_instance = dialog_scene.instantiate()
		dialog_instance.connect("dialog_finished", _on_dialog_finished)

		dialog_instance.character_name = speaker
		dialog_instance.text = text
		add_child(dialog_instance)

		current_line += 1
	print(current_line)


func _on_dialog_finished():
	print("aouao")
	next_line()
