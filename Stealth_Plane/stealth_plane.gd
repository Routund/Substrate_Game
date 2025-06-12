extends Node3D

var selected = false
var reached = true
var target = position

func set_target(pos : Vector3):
	reached = false
	target = pos
	transform = transform.looking_at(pos)
	transform = transform.rotated(position.normalized(),-PI/2)

func _process(delta: float) -> void:
	var up = position.normalized()
	var side : Vector3 = up.cross(-basis.z)
	var forward = up.cross(side)
	var new_transform : Transform3D = Transform3D(side,up,forward,up*0.51)
	#print(angle_between)
	transform = new_transform.orthonormalized()
	if reached:
		transform = transform.rotated(up,0.02)
		position += 0.0008 * transform.basis.x
	else:
		var dir = target-position
		position += side.normalized()*0.0008
		if dir.length() < 0.04:
			transform = transform.rotated(position.normalized(),-PI/2)
			reached = true
		

func toggle_select(state):
	selected = state
	if selected:
		$AnimationPlayer.play("change_to_selected")
	else:
		$AnimationPlayer.play("change_to_unselected")

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action("select_units"):
		print("HII")
		get_parent().get_parent().deal_with_selected(1)
		$AnimationPlayer.play("change_to_selected")
		selected = true
