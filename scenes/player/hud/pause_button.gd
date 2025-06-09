extends TextureButton


func _on_toggled(toggled_on:bool) -> void:
	if toggled_on:
		GameState.clear_new_item_notification()
		UIEventBus.pause()
	else:
		UIEventBus.unpause()
