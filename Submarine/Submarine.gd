extends Node3D
var selected : bool = false
@onready var pos2d = $Marker2D

func _ready() -> void:
	var up = position.normalized()
	var side : Vector3 = up.cross(-basis.z)
	var forward = up.cross(side)
	var new_transform : Transform3D = Transform3D(side,up,forward,up*0.501)
	#print(angle_between)
	transform = new_transform.orthonormalized()
	
	var u = (atan2(up.x, up.z)) / (2 * PI);
	if u < 0:
		u = 1+u
	var v = asin(up.y)/PI + 0.5
	pos2d.position = Vector2(u*1024, v*1024)
	print(pos2d.position)
	
func toggle_select(state):
	selected = state
	if selected:
		$AnimationPlayer.play("change_to_selected")
	else:
		$AnimationPlayer.play("change_to_unselected")

func _process(delta: float) -> void:
	var new_pos = $Marker2D.position/1024
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
	var up = position.normalized()
	var forward = up - Vector3(0,0.5,0).normalized()
	var side  = up.cross(forward)
	var new_transform : Transform3D = Transform3D(side,up,forward,up*0.501)
	#print(angle_between)
	transform = new_transform.orthonormalized()
	pass

func set_target(pos : Vector3):
	$Marker2D.set_target(pos.normalized())
	pass

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action("select_units"):
		get_parent().get_parent().deal_with_selected(1)
		$AnimationPlayer.play("change_to_selected")
		selected = true
