extends Button


func _ready() -> void:
	var region = Rect2(Vector2(16.0, 0.0), Vector2(16.0, 16.0))
	self.icon.region = region


func _on_mouse_entered() -> void:
	if not self.disabled:
		var region = Rect2(Vector2(0.0, 0.0), Vector2(16.0, 16.0))
		self.icon.region = region


func _on_mouse_exited() -> void:
	var region = Rect2(Vector2(16.0, 0.0), Vector2(16.0, 16.0))
	self.icon.region = region
