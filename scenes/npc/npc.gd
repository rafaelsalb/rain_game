extends CharacterBody2D


@export_file var dialog: String
@export_file var battle: String
@export var walk_around: bool = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_detector = $CollisionDetector
@onready var dialog_spawner = $DialogSpawner
@onready var interact_prompt = $InteractPrompt


const SPEED: float = 25.0
var movement_direction: Vector2 = Vector2(0.0, 1.0)


func _ready() -> void:
	if animated_sprite:
		animated_sprite.play("idle_front")
	dialog_spawner.connect("dialog_finished_completely", self._on_dialog_finished_completely)
	interact_prompt.visible = false


func show_interact_prompt() -> void:
	interact_prompt.visible = true


func hide_interact_prompt() -> void:
	interact_prompt.visible = false


func interact() -> void:
	$DialogSpawner.start_dialog(self, dialog, 0)
	$DialogArea.monitoring = false


func _on_dialog_finished_completely():
	if battle:
		var transition_scene = load("res://scenes/transition/Transition.tscn")
		var transition_instance = transition_scene.instantiate()
		transition_instance.connect("transition_ended", start_battle)
		add_child(transition_instance)


func start_battle() -> void:
	LevelManager.change_scene(battle)


func _on_dialog_area_mouse_entered() -> void:
	if GameState.is_within_interaction_range(self):
		GameState.set_as_interact(self)
		show_interact_prompt()


func _on_dialog_area_mouse_exited() -> void:
	hide_interact_prompt()
	GameState.set_as_interact(null)
