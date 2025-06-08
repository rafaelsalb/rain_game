extends HBoxContainer


signal finished_turn


@onready var selection_menu: Control = $SelectionMenu

@onready var details_menu: Control = $DetailsMenu
@onready var tab_label: Label = details_menu.find_child("TabLabel")
@onready var attack_menu: Control = details_menu.find_child("AttackMenu")
@onready var target_menu: Control = details_menu.find_child("TargetMenu")


func _ready() -> void:
	show_combatants()


func build_attack_menu(player_attacks: Array[AttackDTO]) -> void:
	attack_menu.add_attacks(player_attacks)


func show_combatants() -> void:
	hide_all_battle_menus()
	tab_label.text = "Combatentes"


func show_attack_menu() -> void:
	hide_all_battle_menus()
	tab_label.text = "Ataques"
	attack_menu.visible = true


func _on_attack_button_button_up() -> void:
	show_attack_menu()


func hide_all_battle_menus() -> void:
	tab_label.text = ""
	var menus = get_tree().get_nodes_in_group("battle_menus")
	for menu in menus:
		menu.visible = false


func show_target_menu() -> void:
	hide_all_battle_menus()
	tab_label.text = "Alvo(s)"
	target_menu.visible = true


func player_chose_attack() -> void:
	show_target_menu()


func player_chose_target() -> void:
	hide_all_battle_menus()
	emit_signal("finished_turn")


func disable_action_buttons() -> void:
	for node in get_tree().get_nodes_in_group("action_buttons"):
		node.disabled = true


func enable_action_buttons() -> void:
	for node in get_tree().get_nodes_in_group("action_buttons"):
		node.disabled = false
