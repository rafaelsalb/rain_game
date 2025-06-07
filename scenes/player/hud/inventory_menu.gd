extends Control


func _on_quit_button_button_up() -> void:
	self.visible = false
	UIEventBus.back_to_main_menu()
	UIEventBus.closed_menu()


func _on_inventory_item_activated(index:int) -> void:
	UIEventBus.inventory_item_activated(index)


func _process(_delta: float) -> void:
	$Label.visible = not $Inventory.get_item_count()
