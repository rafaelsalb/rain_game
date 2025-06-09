class_name Transition
extends CanvasLayer


signal transition_ended


@onready var color_rect = $ColorRect
@export var forwards: bool = true


var progress: float = 0.0

func _ready() -> void:
	connect("transition_ended", _on_transition_ended)
	if not forwards:
		progress = 1.0
	print(color_rect)
	set_process(true)


func _process(delta: float) -> void:
	color_rect.material.set_shader_parameter("progress", progress)
	progress += delta * (1 if forwards else -1)
	progress = clamp(progress, 0.0, 1.0)
	if progress == (1.0 if forwards else 0.0):
		emit_signal("transition_ended")


func _on_transition_ended() -> void:
	queue_free()
