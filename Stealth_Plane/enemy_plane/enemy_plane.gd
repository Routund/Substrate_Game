extends Node3D

var n_observersers = 0

func _process(delta: float) -> void:
	transform = GlobalRotator.rotate_turn(transform,0.51)
	transform = transform.rotated(basis.y,0.02)
	position += 0.0003 * transform.basis.x


func _on_discovery_radius_area_entered(area: Area3D) -> void:
	print(area.get_groups())
	if area.is_in_group("Player_recon"):
		$MeshInstance3D.visible = true
		n_observersers +=1
	pass # Replace with function body.


func _on_discovery_radius_area_exited(area: Area3D) -> void:
	if area.is_in_group("Player_recon"):
		n_observersers -=1
		if n_observersers <=0:
			$DiscoveryRadius.visible = false
	pass # Replace with function body.
