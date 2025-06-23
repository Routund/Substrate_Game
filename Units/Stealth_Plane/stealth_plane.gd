extends Node3D

var selected = false
var reached = true
var target = position
var n_observers = 0
var n_destroyers = 0
var timer = Timer.new()

func set_target(pos : Vector3):
	reached = false
	target = pos
	transform = transform.looking_at(pos)
	transform = transform.rotated(position.normalized(),-PI/2)
	add_child(timer)
	timer.connect("timeout",die)

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
		

func toggle_select(state):
	selected = state
	if selected:
		$AnimationPlayer.play("change_to_selected")
	else:
		$AnimationPlayer.play("change_to_unselected")

func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action("select_units"):
		print("HII")
		get_parent().get_parent().deal_with_selected(1)
		$AnimationPlayer.play("change_to_selected")
		selected = true


func _on_area_3d_2_area_entered(area: Area3D) -> void:
	if area.is_in_group("Enemy_high_vis"):
		area.get_parent().update_vis(true)
	pass # Replace with function body.


func _on_area_3d_2_area_exited(area: Area3D) -> void:
	if area.is_in_group("Enemy_high_vis"):
		area.get_parent().update_vis(false)
	pass # Replace with function body.

func toggle_destruction(entering : bool):
	if entering:
		timer.start(5)
		n_destroyers += 1
	else:
		n_destroyers-=1
		if n_destroyers <= 0:
			timer.stop()
		

func die():
	queue_free()
