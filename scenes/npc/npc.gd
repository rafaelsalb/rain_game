extends StaticBody2D


@export_file var dialog: String

@onready var animated_sprite = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite.play("idle_front")


func interact() -> void:
	$DialogSpawner.start_dialog(self, dialog, 0)
