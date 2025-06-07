extends Area2D


@export var next_level: PackedScene


func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		LevelManager.change_level(next_level)
