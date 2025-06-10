extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("default")
	$DialogSpawner.connect("dialog_finished_completely", dialog_finished_completely)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$DialogSpawner.start_dialog(self, "res://dialogs/story/finish.json", 0)


func dialog_finished_completely() -> void:
	$GameOverScreen.visible = true


func _on_button_button_up() -> void:
	get_tree().quit()
