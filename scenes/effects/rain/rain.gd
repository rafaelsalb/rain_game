extends Node2D


@export var emission_offset: Vector2 = Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var emission_shape_offset = $GPUParticles2D.process_material.emission_shape_offset
	var emission_delta = Vector2(
		lerp(emission_shape_offset.x, emission_offset.x, 0.5),
		lerp(emission_shape_offset.y, emission_offset.y, 0.5),
	)
	$GPUParticles2D.process_material.emission_shape_offset = Vector3(emission_delta.x, emission_delta.y, 0.0)
