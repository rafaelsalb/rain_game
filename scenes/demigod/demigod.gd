extends Node2D


var time: float = 0.0;

@onready var animated_sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var glow_intensity = 1.5 + 0.5 * sin(time)
	$AnimatedSprite.modulate = Color(glow_intensity, glow_intensity, glow_intensity, glow_intensity)
	time += delta
	if time >= 2 * PI:
		time = 0
