extends Node

func rotate_turn(transform : Transform3D, level : float):
	var up = transform.origin.normalized()
	var side : Vector3 = up.cross(-transform.basis.z)
	var forward = up.cross(side)
	return Transform3D(side,up,forward,up*level).orthonormalized()

func rotate_flat(transform : Transform3D, level : float):
	var up = transform.origin.normalized()
	var forward = up - Vector3(0,0.5,0).normalized()
	var side  = up.cross(forward)
	return Transform3D(side,up,forward,up*level).orthonormalized()
