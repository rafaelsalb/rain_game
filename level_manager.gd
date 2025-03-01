extends Node


func change_level(scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)
