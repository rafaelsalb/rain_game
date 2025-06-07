extends Node


var default = load("res://assets/kenney_cursor-pixel-pack/Tiles/tile_0028.png")
var pointing = load("res://assets/kenney_cursor-pixel-pack/Tiles/tile_0137.png")


func _ready() -> void:
	Input.set_custom_mouse_cursor(default)
	Input.set_custom_mouse_cursor(pointing, Input.CURSOR_POINTING_HAND)
