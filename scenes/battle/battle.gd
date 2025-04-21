extends Node2D


@onready var battle_manager: Node = get_node("BattleManager")


func _ready():
	battle_manager.combatants = {}
	for node in get_children():
		if node.is_in_group("combatant"):
			battle_manager.combatants[len(battle_manager.combatants)] = node
	print("Battle manager initialized with combatants: ", battle_manager.combatants.keys())


func handle_attack(attack_name: String, target: String) -> void:
	# Handle the attack signal from the combatant
	print("Handling attack: ", attack_name, " on ", target)
	battle_manager.handle_attack(attack_name, target)
