extends Panel


@onready var main_menu = find_child("MainMenu")
@onready var inventory_menu = find_child("InventoryMenu")
@onready var options_menu = find_child("OptionsMenu")

@onready var stats: Control = find_child("StatsVBoxContainer")
@onready var health_label: Control = stats.find_child("HealthCountLabel")


func _ready() -> void:
	self.visible = false
	back_to_main_menu()
	UIEventBus.sync_stats()


func go_to_inventory_menu() -> void:
	main_menu.visible = false
	inventory_menu.visible = true
	options_menu.visible = false


func go_to_options_menu() -> void:
	main_menu.visible = false
	inventory_menu.visible = false
	options_menu.visible = true


func _on_quit_button_button_up() -> void:
	get_tree().quit()


func back_to_main_menu() -> void:
	main_menu.visible = true
	inventory_menu.visible = false
	options_menu.visible = false


func _on_close_button_button_up() -> void:
	back_to_main_menu()
	get_tree().paused = false
	self.visible = false
	UIEventBus.closed_menu()


func _on_inventory_button_button_up() -> void:
	main_menu.visible = false
	inventory_menu.visible = true
	main_menu.clear_highlight_inventory_button()


func update_stats(stats: Dictionary) -> void:
	health_label.update(stats["health"], 100)


func _on_options_button_button_up() -> void:
	go_to_options_menu()


func highlight_inventory_button() -> void:
	print("called highlight from player_menu.gd")
	main_menu.highlight_inventory_button()
