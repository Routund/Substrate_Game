extends Node

func rotate_turn(transform : Transform3D, level : float):
	var up = transform.origin.normalized()
	var side : Vector3 = up.cross(-transform.basis.z)
	var forward = up.cross(side)
	return Transform3D(side,up,forward,up*level).orthonormalized()

func rotate_flat(transform : Transform3D, level : float):
	var up = transform.origin.normalized()
	var forward = (up - Vector3(0,0.5,0)).normalized()
	var side  = up.cross(forward)
	return Transform3D(side,up,forward,up*level).orthonormalized()

func flatto3d(new_pos : Vector2) -> Vector3:
	var pos = Vector3.ZERO
	if new_pos.x < 0:
		new_pos.x = 1-new_pos.x
	elif new_pos.x > 1:
		new_pos.x = new_pos.x-1
	pos.y = -(sin((new_pos.y - 0.5) * PI))
	var ratio = tan(new_pos.x * 2 * PI)
	pos.z = sqrt((1 - pos.y*pos.y)/(abs(ratio*ratio+1)))
	pos.x = sqrt(pos.z*pos.z * ratio*ratio)
	if new_pos.x > 0.25 and new_pos.x < 0.75:
		pos.z = -pos.z
	if new_pos.x > 0.5:
		pos.x = -pos.x
	return pos
