extends Node2D


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
