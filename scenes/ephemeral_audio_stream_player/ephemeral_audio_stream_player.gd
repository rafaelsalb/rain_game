class_name EphemeralAudioStreamPlayer
extends AudioStreamPlayer


func play_sfx(audio_file_path):
	self.stream = load(audio_file_path)
	self.play()
	print("Playing sound effect from: ", audio_file_path)


func play_audiostream(audio_stream: AudioStream) -> void:
	self.stream = audio_stream
	self.play()


func _on_finished() -> void:
	queue_free()
