extends StaticBody2D


@export_enum("Default", "Random") var dialog = 0

@onready var dialog_spawner: DialogManager = $DialogSpawner
@onready var interact_prompt: Sprite2D = $InteractPrompt
@onready var asp: AudioStreamPlayer = $AudioStreamPlayer
@onready var particles: GPUParticles2D = $Particles


var dialog_file_path: String = "res://dialogs/checkpoint/1.json"


func _ready() -> void:
	interact_prompt.visible = false
	if dialog == 1:
		dialog_file_path = "res://dialogs/checkopint/" + str(randi_range(2, 3)) + ".json"


func interact() -> void:
	dialog_spawner.start_dialog(self, dialog_file_path, 0)
	asp.play()
	particles.emitting = true


func _on_mouse_entered() -> void:
	if GameState.is_within_interaction_range(self):
		GameState.set_as_interact(self)
		show_interact_prompt()
	else:
		GameState.set_as_interact(null)


func _on_mouse_exited() -> void:
	hide_interact_prompt()


func show_interact_prompt() -> void:
	interact_prompt.visible = true


func hide_interact_prompt() -> void:
	interact_prompt.visible = false
