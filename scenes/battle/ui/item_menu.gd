extends GridContainer


signal chose_item


@onready var inventory = $Inventory


var battle_ui
var battle_manager


func setup() -> void:
	battle_manager = get_tree().get_first_node_in_group("battle_manager")
	battle_ui = battle_manager.get_battle_ui()
	self.connect("chose_item", battle_ui.player_chose_item)
	var player_inventory = GameState.inventory
	for item in player_inventory:
		inventory.add_item(item.item_name)


func _on_inventory_item_activated(index: int) -> void:
	var action = HealAction.new()
	action.heal_amount = GameState.inventory[index].heal_amount
	var current_turn = battle_manager.get_current_turn()
	current_turn.action = action
	var player = battle_manager.get_player()
	current_turn.target = player
	emit_signal("chose_item", index)
	GameState.remove_from_inventory(index)
	inventory.remove_item(index)
