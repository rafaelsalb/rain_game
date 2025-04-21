extends Button


func _process(_delta) -> void:
	if is_hovered():
		self.modulate = Color(1, 1, 1, 0.5)
	else:
		self.modulate = Color(1, 1, 1, 1)
