extends StaticBody2D


@onready var interact_prompt: Sprite2D = $InteractPrompt


func _ready() -> void:
	interact_prompt.visible = false


func interact() -> void:
	print("interacted with checkpoint")


func _on_mouse_entered() -> void:
	print("hovering checkpoint")
	if GameState.is_within_interaction_range(self):
		GameState.set_as_interact(self)
		show_interact_prompt()
	else:
		GameState.set_as_interact(null)


func _on_mouse_exited() -> void:
	print("unhovering checkpoint")
	hide_interact_prompt()


func show_interact_prompt() -> void:
	interact_prompt.visible = true


func hide_interact_prompt() -> void:
	interact_prompt.visible = false
