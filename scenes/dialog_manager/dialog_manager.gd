class_name DialogManager
extends Node


signal dialog_finished
signal dialog_finished_completely


@export_file var dialog_file_path = "res://dialogs/example.json"

var current_line: int = 0
var dialog: Dictionary
var lines: Array
var root: Node

@onready var dialog_scene: PackedScene = preload("res://scenes/dialog/dialog.tscn")


func next_line() -> bool:
	if current_line < len(lines):
		var portrait_path = lines[current_line].get("portrait")
		var speaker = lines[current_line].get("speaker")
		var text = lines[current_line].get("text")

		var dialog_instance = dialog_scene.instantiate()
		dialog_instance.connect("dialog_finished", _on_dialog_finished)

		var portrait = load(portrait_path)
		root.add_child(dialog_instance)
		dialog_instance.setup(speaker, portrait, text)

		current_line += 1
		return true
	else:
		return false


func _on_dialog_finished():
	if not next_line():
		current_line = 0
		emit_signal("dialog_finished_completely")
	emit_signal("dialog_finished")


func start_dialog(asker: Node, dialog_file_path: String, from: int) -> void:
	var dialog_file = load(dialog_file_path)
	if not dialog_file:
		push_error("Error loading dialog file: " + dialog_file_path)
		return
	root = asker
	dialog = dialog_file.data
	lines = dialog.get("default")
	next_line()
