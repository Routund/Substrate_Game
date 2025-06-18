extends Node3D

var n_observers = 0
var bad = []

func _process(_delta: float) -> void:
	transform = GlobalRotator.rotate_turn(transform,0.51)
	transform = transform.rotated(basis.y,0.02)
	position += 0.0003 * transform.basis.x

func update_vis(entering : bool):
	if entering:
		n_observers+=1
		visible = true
	else:
		n_observers-=1
		if n_observers <= 0:
			visible= false
	


func _on_area_3d_2_area_entered(area: Area3D) -> void:
	if area.is_in_group("Player_recon") and (area.is_in_group("Ship") or area.is_in_group("Plane")):
		bad.append(area.position)
	pass # Replace with function body.


func _on_area_3d_2_area_exited(area: Area3D) -> void:
	if area.is_in_group("Player_recon") and (area.is_in_group("Ship") or area.is_in_group("Plane")):
		pass
	pass # Replace with function body.
