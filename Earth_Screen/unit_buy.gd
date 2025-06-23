extends VBoxContainer

var units : Array = [
	["Plane",20000,preload("res://Units/Stealth_Plane/Stealth_Plane.tscn")],
	["Submarine", 120000, preload("res://Units/Submarine/Submarine.tscn")],
	["Ship", 60000, preload("res://Units/Ship/Ship.tscn")]
]
@onready var player_units : Node3D = get_parent().get_parent().get_node("SubViewportContainer/SubViewport/Earth/Player_Units")  
@onready var spawn_points : Node2D = get_parent().get_parent().get_node("SubViewportContainer/SubViewport/Earth/Spawning_Controller/Federated")

func _ready() -> void:
	for child in get_children():
		child.connect("bought",buy)

func buy(ind : int):
	if GlobalFinance.player_money >= units[ind][1]:
		GlobalFinance.player_money -= units[ind][1]
		var rand_pos = spawn_points.get_children()[randi_range(0,len(spawn_points.get_children())-1)].position
		var new_unit = units[ind][2].instantiate()
		new_unit.position = GlobalRotator.flatto3d(rand_pos/1024)
		new_unit.transform = GlobalRotator.rotate_flat(new_unit.transform,0.501)
		player_units.add_child(new_unit)
