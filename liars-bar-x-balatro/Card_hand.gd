extends ColorRect
@onready var button: Button = $"../../Button"

const card_scene = preload("res://no_animation_card.tscn")
var hand_ratio
var hand = []
var hand_count = 5
var x_sep : float = 20.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func _process(delta: float) -> void:
	print(self.size)

func draw(n):
	for i in range(n):
		var cards = card_scene.instantiate()
		cards.name = str("card_", i)
		self.add_child(cards)
		hand.append(cards)
		print(hand.size())
		update_cards()



func update_cards():
	var cards = hand.size()
	var cards_space = no_anim.SIZE.x * cards + x_sep * (cards - 1)
	var final_sep := x_sep
	
	if size.x < cards_space:
		final_sep = (size.x - (no_anim.SIZE.x * cards)) / (cards - 1)
		cards_space = size.x
	
	var offset = (size.x - cards_space) / 2
	
	for i in cards:
		var card_i = hand[i]
		card_i.position.x = offset + no_anim.SIZE.x * i + final_sep * i
	pass


func _on_button_pressed() -> void:
	draw(1)
