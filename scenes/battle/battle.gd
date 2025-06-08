extends Node2D


var combatants = {}
var friends = []
var foes = []
var current_turn: Turn

@onready var battle_ui: Control = find_child("BattleUI")
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	battle_ui.connect("finished_turn", self.finish_turn)
	for node in get_tree().get_nodes_in_group("combatants"):
		combatants[len(combatants)] = node
	for node in get_tree().get_nodes_in_group("friends"):
		friends.append(node)
	for node in get_tree().get_nodes_in_group("foes"):
		foes.append(node)
	start_turn()
	battle_ui.build_attack_menu(friends[0].attacks)


func get_battle_ui() -> Control:
	return battle_ui


func get_current_turn() -> Turn:
	return current_turn


func _on_prepare_ui_timer_timeout() -> void:
	for node in get_tree().get_nodes_in_group("battle_menus"):
		node.setup()


func start_turn() -> void:
	current_turn = Turn.new()
	battle_ui.enable_action_buttons()
	print("Started new turn")


func finish_turn() -> void:
	battle_ui.disable_action_buttons()
	animation_player.play("player_attack")


func start_opponent_turn() -> void:
	current_turn = Turn.new()
	foes[0].choose_random_attack()
	enemy_chose_attack()
	finish_opponent_turn()


func finish_opponent_turn() -> void:
	animation_player.play("enemy_attack")


func enemy_chose_attack() -> void:
	current_turn.target = friends[0]


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "player_attack":
		start_opponent_turn()
	elif anim_name == "enemy_attack":
		start_turn()


func execute_turn() -> void:
	current_turn.execute()
