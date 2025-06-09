class_name AttackAction
extends Action


func execute(target: Combatant) -> void:
	target.take_damage(action.attack_damage)
