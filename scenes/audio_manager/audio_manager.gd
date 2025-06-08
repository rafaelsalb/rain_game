extends Node


func set_volume(volume: int) -> void:
	var volume_linear = volume * 0.01
	var master_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_linear(master_index, volume_linear)
