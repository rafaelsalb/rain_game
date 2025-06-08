extends Area2D


@onready var demigod_scene = preload("res://scenes/demigod/demigod.tscn")
@onready var effect_overlay = $CanvasLayer/ColorRect

var base_color = null
var player_is_inside = false

func _ready() -> void:
	base_color = effect_overlay.modulate

#func _process(_delta: float) -> void:
	#effect_overlay.visible = player_is_inside
	#if player_is_inside:
		## Fade in effect
		#var intensity = lerp(1.0, 0.0, $Timer.get_time_left() / $Timer.wait_time)
		#effect_overlay.modulate = Color(base_color.r, base_color.g, base_color.b, intensity)
	#else:
		## Fade out effect
		#var intensity = lerp(0.0, 1.0, $Timer.get_time_left() / $Timer.wait_time)
		#effect_overlay.modulate = Color(base_color.r, base_color.g, base_color.b, intensity)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_is_inside = true
		effect_overlay.visible = true
		$Timer.start()

func _on_body_exited(body:Node2D) -> void:
	if body.is_in_group("player"):
		player_is_inside = false
		effect_overlay.visible = false
		$Timer.start()
		$Timer.stop()

func _on_timer_timeout() -> void:
	if player_is_inside:
		LevelManager.change_level(demigod_scene)
