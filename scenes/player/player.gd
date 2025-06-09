extends CharacterBody2D


@export var player_character: PlayerCharacter = PlayerCharacter.new()
@export var health: int = 100

var aiming_direction: Vector2 = Vector2.ZERO
var movement_direction: Vector2 = Vector2.ZERO
var SPEED: int
var moving_duration: int = 0
const BASE_ZOOM: float = 3
var inventory: Array = []
var is_interacting: bool = false

@onready var HUD = $CanvasLayer/HUD
@onready var animated_sprite = $AnimatedSprite2D
@onready var health_bar = $CanvasLayer/HUD/HealthBar
@onready var step_audio_player = $StepAudioPlayer
@onready var player_menu = $CanvasLayer/HUD/PlayerMenu

var items_container: Control
var interact_target: Node


func _input(event: InputEvent) -> void:
	movement_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	self.velocity = SPEED * movement_direction.normalized()
	update_animation(movement_direction)

	if not step_audio_player.playing:
		step_audio_player.playing = movement_direction != Vector2.ZERO

	if event.is_action_pressed("change_to_red"):
		change_color(Vector3(1.0, 0.0, 0.0))
	elif event.is_action_pressed("change_to_green"):
		change_color(Vector3(0.0, 1.0, 0.0))
	elif event.is_action_pressed("change_to_blue"):
		change_color(Vector3(0.0, 0.0, 1.0))

	if event.is_action_pressed("interact"):
		if interact_target:
			if interact_target.has_method("interact"):
				interact_target.interact()
			else:
				print("Interact target does not have an interact method.")


func stop_moving() -> void:
	movement_direction = Vector2.ZERO
	self.velocity = Vector2.ZERO
	update_animation(movement_direction )


func _ready() -> void:
	items_container = HUD.get_inventory()
	inventory = GameState.inventory

	animated_sprite.play("idle_front")
	change_color(player_character.color)
	set_speed(50)

	var camera_limits: Vector4 = get_tree().get_first_node_in_group("camera_limiter").CAMERA_LEVEL_LIMITS
	$Camera2D.limit_top = camera_limits.x
	$Camera2D.limit_left = camera_limits.y
	$Camera2D.limit_bottom = camera_limits.w
	$Camera2D.limit_right = camera_limits.z

	print($Camera2D.limit_bottom)

	health_bar.update_health(health)
	
	update_inventory()


func _physics_process(_delta: float) -> void:
	move_and_slide()


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


func update_inventory() -> void:
	items_container.clear()
	for item in inventory:
		var icon = ResourceLoader.load("res://resources/item_atlas.tres")
		icon.set_region(Rect2i(item.item_icon * 16, 0, 16, 16))
		items_container.add_item(item.item_name, icon)


func show_notification(message: String) -> void:
	print(message)


func _on_inventory_item_activated(index: int) -> void:
	var ephemeral_audio_stream_player = EphemeralAudioStreamPlayer.new()
	add_child(ephemeral_audio_stream_player)
	ephemeral_audio_stream_player.play_sfx("res://assets/RPG_Essentials_Free/10_UI_Menu_SFX/013_Confirm_03.wav")
	print("heal_amount ", GameState.inventory[index].heal_amount)
	health += GameState.inventory[index].heal_amount
	if health > 100:
		health = 100
	if health_bar:
		health_bar.update_health(health)
	GameState.remove_from_inventory(index)
	update_inventory()
	print("health ", health)


func show_hud() -> void:
	#$CanvasLayer/HUD/HealthBar.visible = true
	pass


func hide_hud() -> void:
	#$CanvasLayer/HUD/HealthBar.visible = false
	pass


func get_stats() -> Dictionary:
	return {
		"max_health": 100,
		"health": health
	}


func got_new_item() -> void:
	inventory = GameState.inventory
	print("Inventory updated: ", inventory)
	update_inventory()


func show_tutorial_keybindings() -> void:
	HUD.show_tutorial_keybindings()


func hide_tutorial_keybindings() -> void:
	HUD.hide_tutorial_keybindings()


func show_tutorial_indicator() -> void:
	HUD.show_tutorial_indicator()


func hide_tutorial_indicator() -> void:
	HUD.hide_tutorial_indicator()
