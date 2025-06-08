extends Node


var saved_scenes: Dictionary = {}  # { "res://scenes/Level1.tscn": {state data} }
var last_scene: String = ""
var current_level: String = "res://test_playground.tscn"

# Save current scene data manually
func save_scene_state(scene_path: String, state: Dictionary) -> void:
	saved_scenes[scene_path] = state

# Get saved data (or empty dict)
func get_scene_state(scene_path: String) -> Dictionary:
	return saved_scenes.get(scene_path, {})

# Change scene while saving the current one
func change_scene_with_save(scene_path: String, current_path: String, current_state: Dictionary):
	save_scene_state(current_path, current_state)
	last_scene = current_path
	get_tree().change_scene_to_file(scene_path)

func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)

func go_to_previous_scene() -> void:
	get_tree().change_scene_to_file(last_scene)

func change_level(scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)
