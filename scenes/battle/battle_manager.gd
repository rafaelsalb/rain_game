extends Node2D


var combatants: Dictionary = {}


func handle_attack(attack_name: String, target: String) -> void:
	print("Handling attack: ", attack_name, " on ", target)

