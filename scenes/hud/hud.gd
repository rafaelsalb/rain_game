extends Control


signal write_savegame
signal load_savegame
signal change_to_red
signal change_to_blue
signal change_to_green
signal speed_changed(new_speed: int)


@onready var slider = $VSlider

func _ready() -> void:
	var parent = get_parent().get_parent()
	self.connect("write_savegame", parent._on_write_savegame)
	self.connect("load_savegame", parent._on_load_savegame)
	self.connect("change_to_red", parent._on_change_to_red)
	self.connect("change_to_blue", parent._on_change_to_blue)
	self.connect("change_to_green", parent._on_change_to_green)
	self.connect("speed_changed", parent._on_speed_changed)


func _on_save_button_button_up() -> void:
	write_savegame.emit()


func _on_load_button_button_up() -> void:
	load_savegame.emit()


func _on_red_button_up() -> void:
	change_to_red.emit()


func _on_green_button_up() -> void:
	change_to_green.emit()


func _on_blue_button_up() -> void:
	change_to_blue.emit()


func _on_v_slider_drag_ended(value_changed: bool) -> void:
	speed_changed.emit(slider.value)

