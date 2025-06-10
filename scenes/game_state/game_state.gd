extends Node


signal got_new_item
signal saw_notification


var has_wood: bool = false
var has_gem: bool = false
var new_item_notification: bool = false
var inventory: Array = []
var player: Node
var player_hud: Node
var come_back_scene: String
var checkpoint: Dictionary = {
	"scene": "res://scenes/levels/outside/outside.tscn",
	"inventory": []
}


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	if player:
		player_hud = player.find_child("HUD")
		connect("got_new_item", player_hud.turn_on_new_item_notification)
		connect("got_new_item", player.got_new_item)
		connect("saw_notification", player_hud.turn_off_new_item_notification)
	else:
		print("player not present")
		reload()
	self.add_to_group("globals")

func reload() -> void:
	player = get_tree().get_first_node_in_group("player")
	if player:
		print("found player in reload")
		player_hud = player.find_child("HUD")
		print("player_hud in reload ", player_hud)
		connect("got_new_item", player_hud.turn_on_new_item_notification)
		connect("got_new_item", player.got_new_item)
		connect("saw_notification", player_hud.turn_off_new_item_notification)
	else:
		print("player still not present")

func add_to_inventory(item: GameItem) -> void:
	inventory.append(item)
	new_item_notification = true
	emit_signal("got_new_item")

func remove_from_inventory(index: int) -> void:
	inventory.pop_at(index)

func is_within_interaction_range(target: Node) -> float:
	if not target or not player:
		return false
	var dist = player.global_position.distance_to(target.global_position)
	return dist <= 32.0

func set_as_interact(target: Node) -> void:
	if player:
		if not target:
			return
		player.interact_target = target

func clear_new_item_notification() -> void:
	new_item_notification = false
	emit_signal("saw_notification")

func freeze_player() -> void:
	if player:
		player.stop_moving()
		player.set_process_input(false)

func unfreeze_player() -> void:
	if player:
		player.set_process_input(true)

func show_tutorial_keybindings() -> void:
	if player:
		player.show_tutorial_keybindings()

func hide_tutorial_keybindings() -> void:
	if player:
		player.hide_tutorial_keybindings()

func show_tutorial_indicator() -> void:
	if player:
		player.show_tutorial_indicator()

func hide_tutorial_indicator() -> void:
	if player:
		player.hide_tutorial_indicator()

func on_dialog_finished() -> void:
	unfreeze_player()

func got_wood() -> void:
	if player_hud:
		has_wood = true
		player_hud.got_wood()

func got_gem() -> void:
	if player_hud:
		has_gem = true
		player_hud.got_gem()

func save_checkpoint() -> void:
	checkpoint["scene"] = LevelManager.current_level
	while checkpoint["inventory"]:
		checkpoint["inventory"].pop_back()
	checkpoint["inventory"].append_array(inventory)

func load_inventory_from_checkpoint() -> void:
	inventory = checkpoint["inventory"]
