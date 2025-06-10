extends Node2D



@onready var demigod_scene = preload("res://scenes/demigod/demigod.tscn")

var dialog_file_path: String = "res://dialogs/story/oracle_1.json"
var time: float = 0

func _ready():
	$OracleSprite.play()
	$PlayerSprite.play()
	$AnimationPlayer.play("main")
	$DialogSpawner.connect("dialog_finished_completely", _on_dialog_finished_completely)

func _process(delta):
	time += delta
	if time > 2 * PI:
		time = 0
	$OracleSprite.position = $OraclePosition.position + 4 * Vector2(cos(time), sin(time))


func _on_animation_player_animation_finished(anim_name:StringName) -> void:
	if anim_name == "main":
		$DialogSpawner.start_dialog(self, dialog_file_path, 0)


func _on_dialog_finished_completely() -> void:
	LevelManager.change_level(demigod_scene)
