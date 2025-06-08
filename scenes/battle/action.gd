class_name Action
extends Node


@export var action: AttackDTO


func execute(target: Combatant) -> void:
	target.take_damage(action.attack_damage)
