extends Node2D


signal attack_done(attacker: Node, attack: Object, target: int)

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = get_node("HealthBar")


var hp: int = 100
var attacks: Dictionary[String, int] = {
	"attack1": 10,
	"attack2": 20,
	"attack3": 30
}

func _ready():
	# Initialize combatant
	print("Combatant ready with HP: ", hp)
	print("Available attacks: ", attacks.keys())
	animated_sprite.play("default")
	var parent = get_parent()
	if parent.is_in_group("battle_manager"):
		parent.connect("attack_done", parent.handle_attack)
	else:
		print("Parent is not a battle manager.")


func attack(attack_name: String, target: int) -> void:
	# Perform an attack
	if attack_name in attacks:
		print("Attacking with ", attack_name, " for ", attacks[attack_name], " damage.")
	else:
		print("Attack not found: ", attack_name)
	animated_sprite.play(attack_name)
	emit_signal("attack_done", self, attack_name, target)
