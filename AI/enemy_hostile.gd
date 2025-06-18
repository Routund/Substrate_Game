extends Node3D

@onready var spawn_points = $"../Earth".get_node("Spawning_Controller").get_node("Mendzovian")
@onready var units = $"../Earth".get_node("Enemy_Units")
var ship_scene = preload("res://Units/Ship/enemy_ship/enemy_ship.tscn")
var plane_scene = preload("res://Units/Stealth_Plane/enemy_plane/Enemy_plane.tscn")
var sub_scene = preload("res://Units/Submarine/enemy_sub/enemy_sub.tscn")
var unit_types = []
var detected_subs = []
var detected_recon = []

var money = 0

func _ready() -> void:
	unit_types = [plane_scene,sub_scene,ship_scene]

func _process(delta: float) -> void:
	money += delta*1000
	
	for unit in units.get_children():
		pass
	
	if money/5000 > 1:
		money -= 5000
		var rand_ind = randi_range(0,2)
		var new_unit = unit_types[rand_ind].instantiate()
		var rand_pos : Marker2D = spawn_points.get_child(randi_range(0,spawn_points.get_child_count()-1))
		new_unit.position = GlobalRotator.flatto3d(rand_pos.position/1024)
		new_unit.position.y = new_unit.position.y
		new_unit.transform = GlobalRotator.rotate_flat(new_unit.transform,0.501)
		units.add_child(new_unit)
