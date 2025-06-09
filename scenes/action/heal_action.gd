class_name HealAction
extends Action


@export var heal_amount: float


func execute(target: Combatant) -> void:
	target.heal(heal_amount)
