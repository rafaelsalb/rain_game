extends Node2D


var starting_position: Vector2 = Vector2.ZERO
var time: float = 0.0;

@onready var animated_sprite = $AnimatedSprite
@onready var effect_overlay = $FadeInCanvasLayer/ColorRect

func _ready() -> void:
	animated_sprite.play()
	$HUDCanvasLayer/Control/Panel/VSplitContainer/HSplitContainer/LineEdit.grab_focus()

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
	var message = $Control/Panel/VSplitContainer/HSplitContainer/LineEdit.text
	print($GeminiAPI.chat(message))


func _on_chat_message_received(message: String) -> void:
	$Control/Panel/VSplitContainer/Label.text = message
	$Control/Panel/VSplitContainer/HSplitContainer/LineEdit.text = ""
	$Control/Panel/VSplitContainer/HSplitContainer/LineEdit.grab_focus()


func _on_button_button_up() -> void:
	var level = load("res://scenes/test_playground.tscn")
	LevelManager.change_level(level)
