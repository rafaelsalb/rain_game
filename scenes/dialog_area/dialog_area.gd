extends Area2D


@export_file var dialog_path: String
@export var fire_only_once: bool = true


@onready var dialog_spawner: Node = $DialogSpawner


func _ready() -> void:
	dialog_spawner.connect("dialog_finished_completely", _on_dialog_finished_completely)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		dialog_spawner.start_dialog(self, dialog_path, 0)


func _on_dialog_finished_completely() -> void:
	if fire_only_once:
		queue_free()
