extends NPC


@export var start_invisible: bool = true


func _ready() -> void:
	if animated_sprite:
		animated_sprite.play("idle_front")
	dialog_spawner.connect("dialog_finished_completely", self._on_dialog_finished_completely)
	interact_prompt.visible = false
	if start_invisible:
		$AnimatedSprite2D.modulate = Color(1.0, 1.0, 1.0, 0.0)


func interact() -> void:
	fade_in()
	$DialogArea.monitoring = false


func fade_in() -> void:
	$AnimationPlayer.play("fade_in")
	$AudioStreamPlayer.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("finished")
	$DialogSpawner.start_dialog(self, dialog, 0)


func _on_dialog_finished_completely() -> void:
	if battle:
		var transition_scene = load("res://scenes/transition/Transition.tscn")
		var transition_instance = transition_scene.instantiate()
		transition_instance.connect("transition_ended", start_battle)
		add_child(transition_instance)
