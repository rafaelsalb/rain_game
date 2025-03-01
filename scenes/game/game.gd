extends Node


@onready var player = self.find_child("Player")


func _on_write_savegame() -> void:
	var _save = SaveGame.new()
	_save.player_character = player.player_character
	_save.write_savegame()


func _on_load_savegame() -> void:
	var _save = _create_or_load_save()
	player.change_color(_save.player_character.color)


func _create_or_load_save() -> Resource:
	if SaveGame.save_exists():
		return SaveGame.load_savegame()
	else:
		var _save = SaveGame.new()
		var _player_character = PlayerCharacter.new()
		_player_character.color = player.color

		_save.player_character = _player_character
		_save.write_savegame()
		return SaveGame.load_savegame()


func _on_change_to_red():
	player.change_color(Vector3(1.0, 0.0, 0.0))


func _on_change_to_green():
	player.change_color(Vector3(0.0, 1.0, 0.0))


func _on_change_to_blue():
	player.change_color(Vector3(0.0, 0.0, 1.0))


func _on_speed_changed(speed: int):
	player.set_speed(speed)


# func _process(_delta: float) -> void:
# 	$Rain.emission_offset = player.position
