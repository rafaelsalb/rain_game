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


#func _physics_process(delta: float) -> void:
	#if collision_detector.get_collider(0):
		#movement_direction = Vector2.ZERO
	#else:
		#movement_direction = Vector2(randf(), randf()).normalized()
	#if walk_around:
		#self.velocity = SPEED * movement_direction
		#move_and_slide()
		#update_animation(movement_direction)


func update_animation(movement_direction) -> void:
	var animation = "idle_front"

	if movement_direction.x:
		animation = "walk_side"
		animated_sprite.flip_h = movement_direction.x > 0
	elif movement_direction.y:
		animation = "walk_up" if movement_direction.y < 0 else "walk_down"

	animated_sprite.play(animation)
