extends CharacterBody2D


@export_file var dialog: String
@export var walk_around: bool = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_detector = $CollisionDetector


const SPEED: float = 25.0
var movement_direction: Vector2 = Vector2(0.0, 1.0)


func _ready() -> void:
	if animated_sprite:
		animated_sprite.play("idle_front")


func interact() -> void:
	$DialogSpawner.start_dialog(self, dialog, 0)
