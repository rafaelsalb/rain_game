extends Node


var inventory: Array = []


func _ready() -> void:
	var item = GameItem.new()
	item.heal_amount = 10
	item.item_name = "bulacha"
	inventory.append(item)

func add_to_inventory(item: GameItem) -> void:
	inventory.append(item)

func remove_from_inventory(index: int) -> void:
	inventory.pop_at(index)
