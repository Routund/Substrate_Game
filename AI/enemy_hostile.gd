extends Node3D

@onready var spawn_points = $"../Earth".get_node("Spawning_Controller").get_node("Mendzovian")
@onready var units = $"../Earth".get_node("Enemy_Units")
var ship_scene = preload("res://Units/Ship/enemy_ship/enemy_ship.tscn")
var plane_scene = preload("res://Units/Stealth_Plane/enemy_plane/Enemy_plane.tscn")
var sub_scene = preload("res://Units/Submarine/enemy_sub/enemy_sub.tscn")
var unit_types = []
var check_seen_timer : Timer = Timer.new()
var FR : Vector3 = Vector3(0.426023, -0.117455, -0.233899)
var r = 0.1

var money = 30000
var bad = {}
var subs = {}
var scared_dist = 0.1
var follow_dist = 0.2

func _ready() -> void:
	add_child(check_seen_timer)
	check_seen_timer.start(5)
	unit_types = [plane_scene,ship_scene,sub_scene]

func _process(delta: float) -> void:
	money += delta*1000
	
	for unit in units.get_children():
		for area in unit.bad:
			bad[area.get_parent()] = area.position
		for area in unit.subs:
			subs[area.get_parent()] = area.position
		
		if unit.reached:
			var close = Vector3.ZERO
			for i in subs.keys():
				if (unit.position - subs[i]).length() < follow_dist:
					close = (unit.position-subs[i])
					break
			if close != Vector3.ZERO:
				unit.set_target((unit.position+close).normalized()*0.501)
			else:
				close = Vector3.ZERO
				for i in bad.keys():
					if (unit.position - bad[i]).length() < scared_dist:
						close = close + (unit.position-bad[i])
				if close != Vector3.ZERO:
					unit.set_target((unit.position-close).normalized()*0.501)
				elif unit.is_in_group("Submarine"):
					unit.set_target((unit.position+FR).normalized()*0.50)
				else:
					unit.set_target(Vector3(unit.position.x+ randf_range(-r,r),unit.position.y+ randf_range(-r,r),unit.position.z+ randf_range(-r,r)).normalized()*0.5)
				
	
	
	if money/30000 > 1:
		money -= 30000
		var rand_ind = randi_range(0,2)
		var new_unit = unit_types[rand_ind].instantiate()
		var rand_pos : Marker2D = spawn_points.get_child(randi_range(0,spawn_points.get_child_count()-1))
		new_unit.position = GlobalRotator.flatto3d(rand_pos.position/1024)
		new_unit.transform = GlobalRotator.rotate_flat(new_unit.transform,0.501)
		units.add_child(new_unit)

func clear_seen():
	bad.clear()
	check_seen_timer.start(randf_range(3,10))
	
