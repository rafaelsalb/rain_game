extends CharacterBody2D


@export_file var dialog: String
@export_file var battle: String
@export var walk_around: bool = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_detector = $CollisionDetector
@onready var dialog_spawner = $DialogSpawner


const SPEED: float = 25.0
var movement_direction: Vector2 = Vector2(0.0, 1.0)


func _ready() -> void:
	if animated_sprite:
		animated_sprite.play("idle_front")
	dialog_spawner.connect("dialog_finished", self._on_dialog_finished)


func interact() -> void:
	$DialogSpawner.start_dialog(self, dialog, 0)


func _on_dialog_finished():
	if battle:
		var transition_scene = load("res://scenes/transition/Transition.tscn")
		var transition_instance = transition_scene.instantiate()
		transition_instance.connect("transition_ended", start_battle)
		add_child(transition_instance)


func start_battle() -> void:
	LevelManager.change_scene(battle)
