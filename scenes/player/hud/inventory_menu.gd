extends Control


@onready var empty_inventory_container: Control = $CenterContainer
@onready var inventory: Control = $VSplitContainer/Inventory


func _on_quit_button_button_up() -> void:
	self.visible = false
	UIEventBus.back_to_main_menu()
	print("sunaothuenaot")


func _on_inventory_item_activated(index: int) -> void:
	UIEventBus.inventory_item_activated(index)


func _process(_delta: float) -> void:
	empty_inventory_container.visible = not inventory.get_item_count()
