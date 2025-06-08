extends GridContainer


signal chose_attack

var battle_ui: Control
var battle_manager: Node


func setup() -> void:
	battle_manager = get_tree().get_first_node_in_group("battle_manager")
	print("Battle manager ", battle_manager)
	battle_ui = battle_manager.get_battle_ui()
	print("BattleUI from attack ", battle_ui)
	connect("chose_attack", battle_ui.player_chose_attack)


func add_attacks(attacks: Array[AttackDTO]) -> void:
	var attack_button = load("res://scenes/battle/ui/attack_button.tscn")
	for attack in attacks:
		var ab = attack_button.instantiate()
		ab.text = attack.attack_name
		ab.attack = attack
		ab.connect("button_up", self._on_attack_button_up(attack))
		add_child(ab)


func _on_attack_button_up(attack) -> Callable:
	var f = func ():
		var turn = battle_manager.get_current_turn()
		var action = Action.new()
		action.action = attack
		turn.action = action
		emit_signal("chose_attack")
	return f
