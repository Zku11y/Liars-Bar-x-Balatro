extends Container



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Globals.card.size.x = 56
	print(Globals.card.size.x, "test")
	pass
