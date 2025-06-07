extends Panel


@onready var main_menu = find_child("MainMenu")
@onready var inventory_menu = find_child("InventoryMenu")


func _ready() -> void:
	self.visible = false
	main_menu.visible = true
	inventory_menu.visible = false


func _on_quit_button_button_up() -> void:
	get_tree().quit()


func back_to_main_menu() -> void:
	main_menu.visible = true
	inventory_menu.visible = false


func _on_close_button_button_up() -> void:
	back_to_main_menu()
	get_tree().paused = false
	self.visible = false
	UIEventBus.closed_menu()


func _on_inventory_button_button_up() -> void:
	main_menu.visible = false
	inventory_menu.visible = true
