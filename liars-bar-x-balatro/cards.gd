extends TextureRect
@onready var card: TextureRect = $"."
var pop_up = false
var og_scale = Vector2.ZERO

func _ready() -> void:
	og_scale = scale

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_pos = get_local_mouse_position()
		var diff : Vector2 = (position + size) - mouse_pos
		var move_dir_x = remap(mouse_pos.x, 0.0, size.x, 0, 1)
		var move_dir_y = remap(mouse_pos.y, 0.0, size.y, 0, 1)
		
		move_dir_x = rad_to_deg(lerp_angle(-0.2, 0.2, move_dir_x))
		move_dir_y = rad_to_deg(lerp_angle(0.2, -0.2, move_dir_y))
		
		card.material.set_shader_parameter("x_rot", move_dir_y)
		card.material.set_shader_parameter("y_rot", move_dir_x)
		print("x rot = ", move_dir_x, " y rot = ", move_dir_y)



func _on_mouse_entered() -> void:
	if !pop_up:
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(self, "scale", og_scale + Vector2(0.02, 0.02), 0.5)
		pop_up = true


func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "scale", og_scale - Vector2(0.02, 0.02), 0.5)
	card.material.set_shader_parameter("x_rot", 0)
	card.material.set_shader_parameter("y_rot", 0)
	pop_up = false
