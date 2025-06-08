class_name TargetButton
extends HBoxContainer


signal target_button_up(target: Node)

@onready var target_button = $TargetButton
@onready var health_bar = $VBoxContainer/ProgressBar

var index: int
var target: Node


func set_index(index) -> void:
	index = index


func set_data(target: Node, health: float, max_health: float) -> void:
	health_bar.max_value = max_health
	health_bar.value = health
	self.target = target
	target_button.text = target.name


func _on_target_button_button_up() -> void:
	emit_signal("target_button_up", target)
