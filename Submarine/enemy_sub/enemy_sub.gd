extends Node3D
var selected : bool = false
@onready var pos2d = $Marker2D
var last_pos = Vector2(0,0)

func _ready() -> void:
	GlobalRotator.rotate_flat(transform,0.501)
	
	var u = (atan2(basis.y.x, basis.y.z)) / (2 * PI);
	if u < 0:
		u = 1+u
	var v = asin(basis.y.y)/PI + 0.5
	pos2d.position = Vector2(u*1024, v*1024)
	
func _process(delta: float) -> void:
	var new_pos = $Marker2D.position/1024
	if last_pos != new_pos:
		if new_pos.x < 0:
			new_pos.x = 1-new_pos.x
		elif new_pos.x > 1:
			new_pos.x = new_pos.x-1
		position.y = -(sin((new_pos.y - 0.5) * PI))
		var ratio = tan(new_pos.x * 2 * PI)
		position.z = sqrt((1 - position.y*position.y)/(abs(ratio*ratio+1)))
		position.x = sqrt(position.z*position.z * ratio*ratio)
		if new_pos.x > 0.25 and new_pos.x < 0.75:
			position.z = -position.z
		if new_pos.x > 0.5:
			position.x = -position.x
		transform = GlobalRotator.rotate_flat(transform,0.501)
		last_pos = new_pos
	pass

func set_target(pos : Vector3):
	$Marker2D.set_target(pos.normalized())
	pass
