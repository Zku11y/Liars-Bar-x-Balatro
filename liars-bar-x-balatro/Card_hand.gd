extends ColorRect
@onready var button: Button = $"../../Button"

const card_scene = preload("res://Cards.tscn")
var hand_ratio
var hand = []
var hand_count = 5
var x_sep : float = 20.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func _process(delta: float) -> void:
	pass
	#print(self.size)

func draw():
	var cards = card_scene.instantiate()
	cards.name = str("card_", self.get_child_count())
	self.add_child(cards)
	hand.append(cards)
	#print(hand.size())
	update_cards()



func update_cards():
	var cards = hand.size()
	var cards_space = Card.SIZE.x * cards + x_sep * (cards - 1)
	var final_sep := x_sep
	
	if size.x < cards_space:
		final_sep = (size.x - (Card.SIZE.x * cards)) / (cards - 1)
		cards_space = size.x
	
	var offset = (size.x - cards_space) / 2
	for i in range(cards):
		var card_i = get_child(i)
		card_i.position.x = offset + (Card.SIZE.x + final_sep) * i
		#print("card " ,i , " position = ", card_i.position.x)
	print(offset, " size of first card = ", hand[0].position.x)
	pass


func _on_button_pressed() -> void:
	draw()
