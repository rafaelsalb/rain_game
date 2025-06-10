extends Label


func setup() -> void:
	pass


func set_current_attack_label(attacker: Combatant, attack: AttackDTO) -> void:
	self.text = attacker.combatant_name + " usou " + attack.attack_name
