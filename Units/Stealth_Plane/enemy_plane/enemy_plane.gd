extends Node3D

var n_observers = 0
var reached = true
var target = Vector2(0,0)
var bad = []
var subs = []

func _process(_delta: float) -> void:
	transform = GlobalRotator.rotate_turn(transform,0.51)
	if reached:
		transform = transform.rotated(basis.y,0.02)
		position += 0.0003 * transform.basis.x
	else:
		var dir = target-position
		position += basis.x*0.00095
		if dir.length() < 0.04:
			transform = transform.rotated(basis.y,-PI/2)
			reached = true

func update_vis(entering : bool):
	if entering:
		n_observers+=1
		visible = true
	else:
		n_observers-=1
		if n_observers <= 0:
			visible= false

func set_target(pos : Vector3):
	reached = false
	target = pos
	transform = transform.looking_at(pos)
	transform = transform.rotated(position.normalized(),-PI/2)

func _on_area_3d_2_area_entered(area: Area3D) -> void:
	if area.is_in_group("Player_recon") and (area.is_in_group("Ship") or area.is_in_group("Plane")):
		bad.append(area)
	pass # Replace with function body.


func _on_area_3d_2_area_exited(area: Area3D) -> void:
	if area.is_in_group("Player_recon") and (area.is_in_group("Ship") or area.is_in_group("Plane")):
		bad.pop_at(bad.find(area))
	pass # Replace with function body.
