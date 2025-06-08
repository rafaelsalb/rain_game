class_name LevelChanger
extends Area2D


@export_file var next_level: String


func _ready() -> void:
	connect("body_entered", self._on_body_entered)


func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		LevelManager.change_scene_with_save(
			next_level,
			LevelManager.current_level,
			{
				"player_position": Vector2(200, 100)
			}
		)
