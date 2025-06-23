extends Marker2D

var speed = 0.2
var target = Vector2(0,0)
var reached = true

@onready var nav : NavigationAgent2D = $NavigationAgent2D

func set_target(pos : Vector3):
	var u = (atan2(pos.x, pos.z)) / (2 * PI);
	if u < 0:
		u = 1+u
	var v = -asin(pos.y)/PI + 0.5
	nav.target_position = Vector2(u*1024, v*1024)
	var lowest = nav.target_position.distance_to(position)
	var left = nav.target_position.distance_to(Vector2(position.x-1024,position.y))
	var right = nav.target_position.distance_to(Vector2(position.x+1024,position.y))
	if lowest > left:
		position = Vector2(position.x-1024,position.y)
		lowest = left
	if lowest > right:
		position = Vector2(position.x+1024,position.y)
		lowest = right
	nav.target_position=nav.get_final_position()
	reached = false

func _physics_process(_delta: float) -> void:
	if !reached:
		var direction = Vector2()
		direction = (nav.get_next_path_position() - global_position).normalized() * speed
		position += direction
		if (position - nav.target_position).length() < 1.0:
			reached = true
