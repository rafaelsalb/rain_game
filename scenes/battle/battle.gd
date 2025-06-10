extends Node2D

@export_file var next_scene: String

var current_attacker: Combatant
var combatants = {}
var friends = []
var foes = []
var current_turn: Turn
var ended: bool = false

@onready var battle_ui: Control = find_child("BattleUI")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var victory_audio_stream_player: AudioStreamPlayer = $VictoryAudioStreamPlayer
@onready var defeat_audio_stream_player: AudioStreamPlayer = $DefeatAudioStreamPlayer
@onready var result_container: Control = find_child("ResultContainer")
@onready var victory_container: Control = find_child("VictoryContainer")
@onready var defeat_container: Control = find_child("DefeatContainer")
@onready var current_attack_label: Label = find_child("CurrentAttackLabel")


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
	audio_stream_player.play()


func get_battle_ui() -> Control:
	return battle_ui


func get_current_turn() -> Turn:
	return current_turn


func _on_prepare_ui_timer_timeout() -> void:
	for node in get_tree().get_nodes_in_group("battle_menus"):
		node.setup()


func start_turn() -> void:
	current_attacker = friends[0]
	if not ended:
		current_turn = Turn.new()
		current_turn.setup(self)
		battle_ui.enable_action_buttons()
		print("Started new turn")


func finish_turn() -> void:
	battle_ui.disable_action_buttons()
	animation_player.play("player_attack")
	battle_ui.hide_all_battle_menus()


func start_opponent_turn() -> void:
	current_attacker = foes[0]
	if not ended:
		current_turn = Turn.new()
		current_turn.setup(self)
		foes[0].choose_random_attack()
		enemy_chose_attack()
		finish_opponent_turn()


func finish_opponent_turn() -> void:
	animation_player.play("enemy_attack")
	battle_ui.hide_all_battle_menus()


func enemy_chose_attack() -> void:
	current_turn.target = friends[0]


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"player_attack":
			start_opponent_turn()
		"enemy_attack":
			start_turn()
		"victory":
			LevelManager.change_scene(next_scene)


func execute_turn() -> void:
	current_turn.execute()
	if current_turn.action.action is AttackDTO:
		current_attack_label.set_current_attack_label(current_attacker, current_turn.action.action)
		current_attack_label.visible = true


func battle_ended() -> void:
	ended = true
	if friends[0].hp == 0:
		player_lost()
	elif foes[0].hp == 0:
		player_won()


func player_won() -> void:
	result_container.visible = true
	victory_container.visible = true
	audio_stream_player.stop()
	victory_audio_stream_player.play()


func player_lost() -> void:
	result_container.visible = true
	defeat_container.visible = true
	audio_stream_player.stop()
	defeat_audio_stream_player.play()


func get_player() -> Node:
	return friends[0]


func _on_victory_button_button_up() -> void:
	LevelManager.change_scene(next_scene)


func _on_defeat_button_button_up() -> void:
	LevelManager.go_to_last_checkpoint()


func set_player_animation(animation: String, flip_h: bool) -> void:
	friends[0].update_animation(animation, flip_h)


func set_enemy_animation(animation: String, flip_h: bool) -> void:
	foes[0].update_animation(animation, flip_h)


func player_play_random_attack_animation() -> void:
	friends[0].play_random_attack_animation()


func enemy_play_random_attack_animation() -> void:
	foes[0].play_random_attack_animation()
