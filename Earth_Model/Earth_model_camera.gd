extends MeshInstance3D

func _process(_delta: float) -> void:
	$"../Camera3D".transform = GlobalCamera.camera_transform
	rotation.y = GlobalCamera.globe_rot
	$"../Camera3D".fov = GlobalCamera.fov
