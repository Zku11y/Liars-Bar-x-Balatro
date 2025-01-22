extends Control
const card_scene = preload("res://Cards.tscn")
var hand_ratio
var hand = []
var hand_count = 5
var x_sep : float = 20.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_D):
		draw(1)

func draw(n):
	for i in range(n):
		var cards = card_scene.instantiate()
		Globals.card.size = cards.size
		cards.name = str("card_", i)
		self.add_child(cards)
		hand.append(cards)
		print(hand.size())
	update_cards()



func update_cards():
	var cards := get_child_count()
	var cards_space = Globals.card.size.x * cards + x_sep * (cards - 1)
	var final_sep := x_sep
	
	if size.x < cards_space:
		final_sep = (size.x - (Globals.card.size.x * cards)) / (cards - 1)
		cards_space = size.x
	
	var offset = (size.x - cards_space) / 2
	
	for i in cards:
		self.position.x = offset + Globals.card.size.x * i + final_sep * i
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
