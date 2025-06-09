extends Node


signal got_new_item
signal saw_notification


var new_item_notification: bool = false
var inventory: Array = []
var player: Node
var player_hud: Node


func _ready() -> void:
	var item = GameItem.new()
	item.heal_amount = 10
	item.item_name = "bulacha"
	inventory.append(item)
	player = get_tree().get_first_node_in_group("player")
	player_hud = player.find_child("HUD")
	connect("got_new_item", player_hud.turn_on_new_item_notification)
	connect("got_new_item", player.got_new_item)
	connect("saw_notification", player_hud.turn_off_new_item_notification)

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
	if not target:
		return
	player.interact_target = target

func clear_new_item_notification() -> void:
	new_item_notification = false
	emit_signal("saw_notification")
