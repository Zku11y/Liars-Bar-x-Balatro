extends ColorRect



var hand_cards = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var card
	for i in range(0 , 6):
		card = preload("res://Cards.tscn").instantiate()
		card.name = str("card_", i)
		self.add_child(card)
		card.position = card.position + Vector2(40 * i, 0)
		hand_cards.insert(i, card)
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var i = 5
	while i:
		print("card ", i, hand_cards[i].scale)
		i -= 1
	i = 0
	pass
