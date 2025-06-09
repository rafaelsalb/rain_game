extends VBoxContainer


@onready var inventory_button = find_child("InventoryButton")


func highlight_inventory_button() -> void:
	print("called highlight from main_menu.gd")
	if inventory_button:
		inventory_button.modulate = Color(1.0, 0.75, 0.0, 1.0)
	else:
		push_error("Inventory button not found in PlayerMenu.")


func clear_highlight_inventory_button() -> void:
	print("called clear highlight from main_menu.gd")
	if inventory_button:
		inventory_button.modulate = Color(1.0, 1.0, 1.0, 1.0)
