extends Control


@onready var inventory_container = find_child("Inventory")
@onready var new_item_notification = $NewItemNotification
@onready var player_menu = find_child("PlayerMenu")
@onready var keybindings_tutorial = find_child("KeybindingsTutorial")


func _ready() -> void:
	new_item_notification.visible = false


func get_inventory() -> Control:
	if inventory_container:
		return inventory_container
	else:
		push_error("Inventory container not found in HUD.")
		return null


func turn_on_new_item_notification() -> void:
	new_item_notification.visible = true
	player_menu.highlight_inventory_button()


func turn_off_new_item_notification() -> void:
	new_item_notification.visible = false


func show_tutorial_keybindings() -> void:
	keybindings_tutorial.visible = true


func hide_tutorial_keybindings() -> void:
	keybindings_tutorial.visible = false


func show_tutorial_indicator() -> void:
	$TutorialIndicator.visible = true


func hide_tutorial_indicator() -> void:
	$TutorialIndicator.visible = false


func got_wood() -> void:
	player_menu.got_wood()


func got_gem() -> void:
	player_menu.got_gem()
