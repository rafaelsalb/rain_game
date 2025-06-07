extends Area2D


@export var item_name: String = "Biscoito"
@export var item_description: String = "Um biscoito saboroso. Hmmm..."
@export var item_type: String = "food"
@export var item_icon: int = 0


@onready var pickup_particles_scene: PackedScene = preload("res://scenes/item/item_pickup_particles.tscn")


func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		var player = body
		var copy = self.duplicate()
		player.inventory.append(copy)
		player.update_inventory(copy)
		player.show_notification("Você pegou um " + item_name + "!")
		var particles = pickup_particles_scene.instantiate()
		particles.global_position = global_position
		get_tree().current_scene.add_child(particles)
		particles.emitting = true
		var ephemeral_audio_stream_player = EphemeralAudioStreamPlayer.new()
		get_tree().current_scene.add_child(ephemeral_audio_stream_player)
		ephemeral_audio_stream_player.play_sfx("res://assets/RPG_Essentials_Free/10_UI_Menu_SFX/051_use_item_01.wav")
		queue_free()
