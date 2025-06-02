extends Node2D


@export var emission_offset: Vector2 = Vector2.ZERO
@export_range(0.0, 1.0) var audio_volume: float = 1.0
@export_enum("Calm", "Strong") var rain_strength: int

@onready var audio_stream_player_selector = $AudioStreamPlayerSelector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var audio_stream = audio_stream_player_selector.get_children()[rain_strength]
	audio_stream.volume_linear = audio_volume
	audio_stream.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var emission_shape_offset = $GPUParticles2D.process_material.emission_shape_offset
	var emission_delta = Vector2(
		lerp(emission_shape_offset.x, emission_offset.x, 0.5),
		lerp(emission_shape_offset.y, emission_offset.y, 0.5),
	)
	$GPUParticles2D.process_material.emission_shape_offset = Vector3(emission_delta.x, emission_delta.y, 0.0)
