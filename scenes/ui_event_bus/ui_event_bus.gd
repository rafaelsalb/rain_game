extends Node


var main_menu: Control
var player: Node


func _ready():
	main_menu = get_tree().get_first_node_in_group("ui_main_menu")
	player = get_tree().get_first_node_in_group("player")
	self.add_to_group("globals", true)


func reload() -> void:
	main_menu = get_tree().get_first_node_in_group("ui_main_menu")
	player = get_tree().get_first_node_in_group("player")


func back_to_main_menu() -> void:
	if main_menu:
		main_menu.back_to_main_menu()


func closed_menu() -> void:
	if player:
		player.show_hud()


func inventory_item_activated(index: int) -> void:
	if player:
		player._on_inventory_item_activated(index)
		main_menu.update_stats(player.get_stats())


func pause() -> void:
	if player:
		get_tree().paused = true
		main_menu.visible = true
		main_menu.back_to_main_menu()
		player.hide_hud()
		print("Paused")


func unpause() -> void:
	if player:
		get_tree().paused = false
		main_menu.visible = false
		main_menu.back_to_main_menu()
		player.show_hud()
		closed_menu()
		print("Unpaused")


func sync_stats() -> void:
	if player:
		var stats = player.get_stats()
		main_menu.update_stats(stats)


func set_volume(volume: int) -> void:
	AudioManager.set_volume(volume)
