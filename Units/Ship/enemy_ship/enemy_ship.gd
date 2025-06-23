extends Node3D
var selected : bool = false
@onready var pos2d = $Marker2D
var last_pos = Vector2(0,0)
var n_observers = 0
var reached = true
var subs : Array = []
var bad : Array = []

func _ready() -> void:
	transform = GlobalRotator.rotate_flat(transform,0.501)
	var u = (atan2(basis.y.x, basis.y.z)) / (2 * PI);
	if u < 0:
		u = 1+u
	var v = asin(basis.y.y)/PI + 0.5
	pos2d.position = Vector2(u*1024, (1-v)*1024)
	
func _process(_delta: float) -> void:
	var new_pos = pos2d.position/1024
	reached = pos2d.reached
	if last_pos != new_pos:
		position = GlobalRotator.flatto3d(new_pos)
		transform = GlobalRotator.rotate_flat(transform,0.501)
		last_pos = new_pos
	pass

func set_target(pos : Vector3):
	$Marker2D.set_target(pos.normalized())
	pass

func update_vis(entering : bool):
	if entering:
		n_observers+=1
		visible = true
	else:
		n_observers-=1
		if n_observers <= 0:
			visible= false


func _on_monitoring_area_entered(area: Area3D) -> void:
	if area.is_in_group("Player_recon"):
		if area.is_in_group("Ship") or area.is_in_group("Plane"):
			bad.append(area)
		elif area.is_in_group("Submarine"):
			area.get_parent().toggle_destruction(true)
			subs.append(area)

func _on_monitoring_area_exited(area: Area3D) -> void:
	if area.is_in_group("Player_recon"):
		if area.is_in_group("Ship") or area.is_in_group("Plane"):
			bad.pop_at(bad.find(area))
		elif area.is_in_group("Submarine"):
			subs.pop_at(subs.find(area))
			area.get_parent().toggle_destruction(false)
