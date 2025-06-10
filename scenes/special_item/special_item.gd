extends Area2D


signal dialog_finished_completely


@export_enum("Wood", "Gem") var kind: int


var dialog_file_path: String


func _ready() -> void:
	if kind == 0:
		$Gem.visible = false
		$Wood.visible = true
		dialog_file_path = "res://dialogs/special_items/wood.json"
	else:
		$Gem.visible = true
		$Wood.visible = false
		dialog_file_path = "res://dialogs/special_items/gem.json"
	$DialogSpawner.connect("dialog_finished_completely", _on_dialog_finished_completely)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$DialogSpawner.start_dialog(self, dialog_file_path, 0)
		$Wood.visible = false
		$Gem.visible = false
		$AudioStreamPlayer.play()
		$GPUParticles2D.emitting = true
		if kind == 0:
			GameState.got_wood()
		else:
			GameState.got_gem()


func _on_dialog_finished_completely() -> void:
	emit_signal("dialog_finished_completely")
	queue_free()
