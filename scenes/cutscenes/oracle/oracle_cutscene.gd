extends Node2D



@onready var demigod_scene = preload("res://scenes/demigod/demigod.tscn")

var time: float = 0

func _ready():
	$OracleSprite.play()
	$PlayerSprite.play()
	$AnimationPlayer.play("main")

func _process(delta):
	time += delta
	if time > 2 * PI:
		time = 0
	$OracleSprite.position = $OraclePosition.position + 4 * Vector2(cos(time), sin(time))


func _on_animation_player_animation_finished(anim_name:StringName) -> void:
	if anim_name == "main":
		LevelManager.change_level(demigod_scene)
