extends Label


func update(current: int, max: int) -> void:
	self.text = str(current) + "/" + str(max)
