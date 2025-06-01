extends CharacterBody2D


@export var player_character: PlayerCharacter = PlayerCharacter.new()

var aiming_direction: Vector2 = Vector2.ZERO
var movement_direction: Vector2 = Vector2.ZERO
var SPEED: int
var moving_duration: int = 0
const BASE_ZOOM: float = 3

@onready var animated_sprite = $AnimatedSprite2D
@onready var interact_raycast = $InteractRayCast


func _input(event: InputEvent) -> void:
	movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	self.velocity = SPEED * movement_direction.normalized()
	interact_raycast.target_position = 16 * movement_direction.normalized()
	update_animation(movement_direction)

	#if movement_direction:
		#moving_duration += 1
	#else:
		#moving_duration -= 1
	#moving_duration = clamp(moving_duration, 0, 1000)

	if event.is_action_pressed("change_to_red"):
		change_color(Vector3(1.0, 0.0, 0.0))
	elif event.is_action_pressed("change_to_green"):
		change_color(Vector3(0.0, 1.0, 0.0))
	elif event.is_action_pressed("change_to_blue"):
		change_color(Vector3(0.0, 0.0, 1.0))

	if event.is_action_pressed("interact"):
		var collider = interact_raycast.get_collider()
		if collider:
			collider.interact()


func _ready() -> void:
	animated_sprite.play("idle_front")
	change_color(player_character.color)
	set_speed(50)
	
	var camera_limits: Vector4 = get_tree().get_first_node_in_group("camera_limiter").CAMERA_LEVEL_LIMITS
	$Camera2D.limit_top = camera_limits.x
	$Camera2D.limit_left = camera_limits.y
	$Camera2D.limit_bottom = camera_limits.z
	$Camera2D.limit_right = camera_limits.w


func _physics_process(_delta: float) -> void:
	move_and_slide()
	$Aim.position = interact_raycast.target_position
	#print($Camera2D.zoom)
	#var zoom_factor = self.velocity.length() / SPEED * 0.01 * moving_duration
	#zoom_factor = clamp(zoom_factor, 0.0, 1.0)
	#print(zoom_factor)
	#$Camera2D.zoom = Vector2(
		#lerp(BASE_ZOOM, 2.0, zoom_factor),
		#lerp(BASE_ZOOM, 2.0, zoom_factor),
	#)


func update_animation(movement_direction) -> void:
	var animation = "idle_front"

	if movement_direction.x:
		animation = "walk_side"
		animated_sprite.flip_h = movement_direction.x > 0
	elif movement_direction.y:
		animation = "walk_up" if movement_direction.y < 0 else "walk_down"

	animated_sprite.play(animation)


func change_color(rgb: Vector3) -> void:
	player_character.color = rgb
	animated_sprite.material.set_shader_parameter("current_color", rgb)


func set_speed(speed: int) -> void:
	SPEED = speed
