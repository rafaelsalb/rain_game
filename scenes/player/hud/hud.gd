extends Control


@onready var inventory_container = find_child("Inventory")
@onready var new_item_notification = $NewItemNotification
@onready var player_menu = find_child("PlayerMenu")


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
