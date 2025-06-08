extends Button


@export var hover_sound: AudioStream
@export var click_sound: AudioStream


func _ready() -> void:
	var region = Rect2(Vector2(16.0, 0.0), Vector2(16.0, 16.0))
	self.icon.region = region


func _on_mouse_entered() -> void:
	if not self.disabled:
		var region = Rect2(Vector2(0.0, 0.0), Vector2(16.0, 16.0))
		self.icon.region = region
		if hover_sound:
			var asp = EphemeralAudioStreamPlayer.new()
			add_child(asp)
			asp.play_audiostream(hover_sound)


func _on_mouse_exited() -> void:
	var region = Rect2(Vector2(16.0, 0.0), Vector2(16.0, 16.0))
	self.icon.region = region


func _on_button_up() -> void:
	if click_sound:
		var asp = EphemeralAudioStreamPlayer.new()
		add_child(asp)
		asp.play_audiostream(click_sound)
