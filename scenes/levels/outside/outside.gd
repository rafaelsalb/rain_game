extends "res://scenes/levels/Level.gd"


@export var show_tutorials: bool = true
@export var start_from_spawnpoint: bool = true


func _ready():
	spawn_point = $Spawnpoint.position
	$AudioStreamPlayer.play()
	if show_tutorials:
		GameState.show_tutorial_keybindings()
	if start_from_spawnpoint:
		GameState.player.global_position = $Spawnpoint.global_position


func _on_tutorial_item_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player entered area")
		GameState.show_tutorial_indicator()


func _on_keybindings_timer_timeout() -> void:
	GameState.hide_tutorial_keybindings()
