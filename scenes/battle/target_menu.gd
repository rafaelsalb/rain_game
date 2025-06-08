extends GridContainer


signal chose_target


var battle_ui
var battle_manager


func _ready() -> void:
	var target_button_container_scene = load("res://scenes/battle/ui/target_button.tscn")
	var foes = get_tree().get_nodes_in_group("foes")
	var i = 0
	for node in foes:
		var target_button = target_button_container_scene.instantiate()
		add_child(target_button)
		target_button.set_data(node, node.hp, node.hp)
		target_button.set_index(i)
		target_button.connect("target_button_up", self._on_target_button_up)
		i += 1


func setup() -> void:
	battle_manager = get_tree().get_first_node_in_group("battle_manager")
	battle_ui = battle_manager.get_battle_ui()
	self.connect("chose_target", battle_ui.player_chose_target)


func _on_target_button_up(target: Node) -> void:
	var turn = battle_manager.get_current_turn()
	turn.target = target
	print("chose target ", target)
	print(turn, turn.action, turn.target)
	emit_signal("chose_target")
