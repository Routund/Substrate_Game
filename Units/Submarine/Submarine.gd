extends Node3D
var selected : bool = false
@onready var pos2d = $Marker2D
var last_pos = Vector2(0,0)
var n_observers = 0
var n_destroyers = 0
var timer = Timer.new()

func _ready() -> void:
	add_child(timer)
	timer.connect("timeout",die)
	transform = GlobalRotator.rotate_flat(transform,0.501)
	var u = (atan2(basis.y.x, basis.y.z)) / (2 * PI);
	if u < 0:
		u = 1+u
	var v = asin(basis.y.y)/PI + 0.5
	pos2d.position = Vector2(u*1024, (1-v)*1024)
	
func toggle_select(state):
	selected = state
	if selected:
		$AnimationPlayer.play("change_to_selected")
	else:
		$AnimationPlayer.play("change_to_unselected")

func _process(_delta: float) -> void:
	var new_pos = $Marker2D.position/1024
	if last_pos != new_pos:
		position = GlobalRotator.flatto3d(new_pos)
		transform = GlobalRotator.rotate_flat(transform,0.501)
		last_pos = new_pos
	pass

func set_target(pos : Vector3):
	$Marker2D.set_target(pos.normalized())
	pass

func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action("select_units"):
		get_parent().get_parent().deal_with_selected(1)
		$AnimationPlayer.play("change_to_selected")
		selected = true

func _on_area_3d_2_area_entered(area: Area3D) -> void:
	if area.is_in_group("Enemy_high_vis") or area.is_in_group("Enemy_low_vis"):
		area.get_parent().update_vis(true)

func _on_area_3d_2_area_exited(area: Area3D) -> void:
	if area.is_in_group("Enemy_high_vis") or area.is_in_group("Enemy_low_vis"):
		area.get_parent().update_vis(false)

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
