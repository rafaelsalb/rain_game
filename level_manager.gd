extends Node


var saved_scenes: Dictionary = {}  # { "res://scenes/Level1.tscn": {state data} }
var last_scene: String = "res://scenes/levels/temple.tscn"
var current_level: String = "res://test_playground.tscn"


func change_scene(scene_path: String) -> void:
	current_level = scene_path
	get_tree().change_scene_to_file(scene_path)
	for node in get_tree().get_nodes_in_group("globals"):
		node.reload()

func go_to_previous_scene() -> void:
	get_tree().change_scene_to_file(last_scene)

func change_level(scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)

func go_to_last_checkpoint() -> void:
	change_scene(GameState.checkpoint["scene"])
	GameState.load_inventory_from_checkpoint()
