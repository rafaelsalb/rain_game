extends TextureButton


func _on_toggled(toggled_on:bool) -> void:
	if toggled_on:
		print("paused")
		GameState.clear_new_item_notification()
		UIEventBus.pause()
		GameState.hide_tutorial_indicator()
	else:
		print("unpaused")
		UIEventBus.unpause()
