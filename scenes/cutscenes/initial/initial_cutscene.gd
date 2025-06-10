extends Node2D


func _ready() -> void:
	$DialogSpawner.connect("dialog_finished_completely", _on_dialog_finished_completely)
	$DialogSpawner2.connect("dialog_finished_completely", _on_dialog_finished_completely_first)
	$DialogSpawner2.start_dialog(self, "res://dialogs/story/initial.json", 0)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"first":
			$DialogSpawner.start_dialog(self, "res://dialogs/story/ana_1.json", 0)


func _on_dialog_finished_completely() -> void:
	$EndCutsceneTimer.start()


func _on_dialog_finished_completely_first() -> void:
	$PlayerSprite.visible = true
	$Label.visible = true
	$AnimationPlayer.play("first")


func _on_end_cutscene_timer_timeout() -> void:
	var transition_scene = load("res://scenes/transition/Transition.tscn")
	var transition_instance = transition_scene.instantiate()
	transition_instance.connect("transition_ended", _on_transition_end)
	add_child(transition_instance)


func _on_transition_end() -> void:
	LevelManager.change_scene("res://scenes/levels/outside/outside.tscn")
