extends Control


@onready var volume_slider: Control = find_child("VolumeSlider")
@onready var audio_stream_player: AudioStreamPlayer = find_child("AudioStreamPlayer")


func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		UIEventBus.set_volume(volume_slider.value)
	audio_stream_player.play()


func _on_quit_button_button_up() -> void:
	self.visible = false
	UIEventBus.back_to_main_menu()
