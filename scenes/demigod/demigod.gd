extends Node2D


var starting_position: Vector2 = Vector2.ZERO
var time: float = 0.0;

@onready var animated_sprite = $AnimatedSprite
@onready var effect_overlay = $FadeInCanvasLayer/ColorRect
@onready var hud_canvas_layer = $HUDCanvasLayer
@onready var response_label = hud_canvas_layer.find_child("ResponseLabel")
@onready var input_field = hud_canvas_layer.find_child("InputField")
@onready var send_button = hud_canvas_layer.find_child("SendButton")

func _ready() -> void:
	animated_sprite.play()
	input_field.grab_focus()
	$AnimationPlayer.play("fade_in")
	starting_position = animated_sprite.position


func _process(delta: float) -> void:
	$AnimatedSprite.position.y = starting_position.y + 2.0 * sin(time) + 2.0
	var glow_intensity = 1.5 + 0.5 * sin(time)
	$AnimatedSprite.modulate = Color(glow_intensity, glow_intensity, glow_intensity, glow_intensity)
	time += delta
	if time >= 2 * PI:
		time = 0


func _on_button_button_down() -> void:
	var message = input_field.text
	print($GeminiAPI.chat(message))
	response_label.text = "Estou pensando..."


func _on_chat_message_received(message: String) -> void:
	response_label.text = message
	input_field.text = ""
	input_field.grab_focus()


func _on_quit_button_up() -> void:
	LevelManager.change_scene(GameState.next_scene)
