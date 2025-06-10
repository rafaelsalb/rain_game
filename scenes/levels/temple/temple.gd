extends "res://scenes/levels/outside/outside.gd"


@onready var special_item: Node = find_child("SpecialItem")
@onready var mage: Node = find_child("Mage")


func _ready() -> void:
	for node in get_tree().get_nodes_in_group("globals"):
		connect("scene_loaded", node.reload)
	emit_signal("scene_loaded")
	print("limits", CAMERA_LEVEL_LIMITS)
	if mage:
		print(mage)
	else:
		push_error("mage not found")
	CAMERA_LEVEL_LIMITS = Vector4(0, 0, 1280, 960)
	special_item.connect("dialog_finished_completely", go_to_finish_screen)


func go_to_finish_screen() -> void:
	var go = func ():
		LevelManager.change_scene("res://scenes/levels/finish/finish_screen.tscn")
	var transition_scene = load("res://scenes/transition/Transition.tscn")
	var transition_instance = transition_scene.instantiate()
	transition_instance.connect("transition_ended", go)
	add_child(transition_instance)
