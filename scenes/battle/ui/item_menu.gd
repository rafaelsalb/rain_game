extends GridContainer


signal chose_item


var battle_ui
var battle_manager


func setup() -> void:
	battle_manager = get_tree().get_first_node_in_group("battle_manager")
	battle_ui = battle_manager.get_battle_ui()
	self.connect("chose_item", battle_ui.player_chose_item)
	
	var player_inventory = battle_manager.get_player().inventory


func _on_inventory_item_activated(index: int) -> void:
	emit_signal("chose_item", index)
