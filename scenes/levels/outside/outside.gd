extends "res://scenes/levels/Level.gd"


func _ready():
	spawn_point = $Spawnpoint.position
	$AudioStreamPlayer.play()


func _on_tutorial_item_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player entered area")
		GameState.show_tutorial_indicator()


func _on_keybindings_timer_timeout() -> void:
	GameState.hide_tutorial_keybindings()
