extends Node3D


func _process(delta: float) -> void:
	position += 0.001 * transform.basis.x
	var up = position.normalized()
	var side : Vector3 = up.cross(-basis.z)
	var forward = up.cross(side)
	var new_transform : Transform3D = Transform3D(side,up,forward,up*0.51)
	#print(angle_between)
	transform = new_transform.orthonormalized()
	
	transform = transform.rotated(up,0.02)
