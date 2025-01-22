extends TextureRect
class_name Card
@onready var card: TextureRect = self
var pop_up = false
var og_scale = Vector2.ZERO
@export var damp = 40
var dp = 0
@export var spring = 50
var velocity = Vector2.ZERO
var old_pos
var mouse_pos_2 = Vector2.ZERO
var os_vel = 0
var mouse_vel = Vector2.ZERO
enum States {IDLE, PICKUP, PLAY}
var state : States = States.IDLE
var new_state : States
var pickedup := false
var screen : Vector2
var pos_before_pickup
var card_size = self.size

func _ready() -> void:
	og_scale = scale
	old_pos = position
	await get_tree().create_timer(3).timeout
	pos_before_pickup = self.global_position

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && state == States.IDLE && Globals.active_card == null:
		var mouse_pos = get_local_mouse_position()
		var diff : Vector2 = (position + size) - mouse_pos
		var move_dir_x = remap(mouse_pos.x, 0.0, size.x, 0, 1)
		var move_dir_y = remap(mouse_pos.y, 0.0, size.y, 0, 1)
		
		move_dir_x = rad_to_deg(lerp_angle(-0.2, 0.2, move_dir_x))
		move_dir_y = rad_to_deg(lerp_angle(0.2, -0.2, move_dir_y))
		
		card.material.set_shader_parameter("x_rot", move_dir_y)
		card.material.set_shader_parameter("y_rot", move_dir_x)


func _process(delta: float) -> void:
	screen = get_viewport_rect().size
	velocity = (position - old_pos) / delta
	old_pos = position
	os_vel += velocity.normalized().x * 1
	var force = (-spring * dp) - (damp * os_vel)
	os_vel += force * delta
	dp += os_vel * delta
	if state == States.IDLE:
		card.rotation = lerp(dp, 0.0, 1)
	else:
		card.rotation = dp
	#print(self.rotation)
	pass

func _physics_process(delta: float) -> void:

	set_state()
	state_behavior()



func _on_mouse_entered() -> void:
	if state != States.IDLE || Globals.active_card:
		return
	if !pop_up:
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(self, "scale", og_scale + Vector2(0.02, 0.02), 0.5)
		pop_up = true



func _on_mouse_exited() -> void:
	if state != States.IDLE || Globals.active_card:
		return
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", og_scale - Vector2(0.02, 0.02), 0.5)
	card.material.set_shader_parameter("x_rot", 0)
	card.material.set_shader_parameter("y_rot", 0)
	pop_up = false


func set_state():
	

	if pickedup && Input.is_action_pressed("left_click"):
		if Globals.active_card == null:
			Globals.active_card = self
		elif Globals.active_card != null:
			return
		new_state = States.PICKUP
		#print("picked up")
	
	elif Input.is_action_just_released("left_click"):
		if Globals.active_card == self:
			Globals.active_card = null
		new_state = States.IDLE
		#print("putdown")
	
	
		


func state_behavior():
	var last_state := state
	state = new_state
	if state == States.PICKUP:
		pickup()
	elif state == States.IDLE && pos_before_pickup:
		self.global_position = lerp(self.global_position, pos_before_pickup, 0.1)
		

func pickup():
	card.material.set_shader_parameter("x_rot", 0)
	card.material.set_shader_parameter("y_rot", 0)
	mouse_pos_2 = get_global_mouse_position()

	# Adjust the global position of the TextureRect to follow the mouse
	self.global_position = lerp(global_position, mouse_pos_2 - (scale * size / 2), 0.4)
	
	# Clamp the position to prevent it from moving out of the screen
	self.global_position.x = clamp(self.global_position.x, -100, screen.x - 100)
	self.global_position.y = clamp(self.global_position.y, -100, screen.y - 100)



func _on_area_2d_mouse_entered() -> void:
	pickedup = true


func _on_area_2d_mouse_exited() -> void:
	pickedup = false
