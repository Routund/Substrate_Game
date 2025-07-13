extends MeshInstance3D

@onready var bounding : Area3D = $Area3D
@onready var camera : Camera3D = $"../Camera3D"
@onready var controller : Control = get_parent().get_parent().get_parent()
var current_camera_degreees : float = 0
var mouse_down = false
var sensitivity_inv = 10000 
var rotation_velocity : Vector2 = Vector2.ZERO
var rotation_velocity_damping : float = 35
var last_mouse_pos : Vector3 = Vector3(0,0,0)

@onready var world_map : Image = $Spawning_Controller/Sprite2D2.texture.get_image()
@onready var neon_shader : SubViewportContainer = get_parent().get_parent()

@onready var player_units_list = $Player_Units

func _ready():
	GlobalCamera.globe_rot=rotation.y

func change_selected(colour):
	var vec = (Vector3(colour.r,colour.g,colour.b))
	if ((vec-Vector3(0.133333, 0.133333, 0.133333)).length() > 0.01):
		neon_shader.material.set("shader_parameter/exclusive_colour",colour)
		var id = controller.colour_to_id.get(hash(vec),-1)
		controller.change_selected(id)
		return true
	controller.change_selected(-1)
	return false
	

func sample(point : Vector3) -> bool:
	point = point.normalized()
	var u = (atan2(point.x, point.z)) / (2 * PI);
	if u < 0:
		u = 1+u
	var v = asin(point.y)/PI + 0.5
	var colour = world_map.get_pixel(u*world_map.get_size().x-1,(1-v)*world_map.get_size().y)
	return change_selected(colour)

func _process(_delta : float) -> void:
	if mouse_down:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			mouse_down = false
		else:
			var mouse_vel = Input.get_last_mouse_velocity()
			if mouse_vel.length() > 0.1:
				rotation_velocity = mouse_vel
	
	if rotation_velocity.length() > 0:
		rotation.y += rotation_velocity.x/sensitivity_inv
		current_camera_degreees = max(-PI/2,min(PI/2,current_camera_degreees + rotation_velocity.y/sensitivity_inv))
		camera.position.z = cos(current_camera_degreees)
		camera.position.y = sin(current_camera_degreees)
		camera.transform.basis.y = Vector3(0,cos(current_camera_degreees),-sin(current_camera_degreees))
		camera.transform.basis.z = Vector3(0,sin(current_camera_degreees),cos(current_camera_degreees))
		GlobalCamera.camera_transform = camera.transform
		GlobalCamera.globe_rot=rotation.y
		rotation_velocity.x = move_toward(rotation_velocity.x,0,rotation_velocity_damping)
		rotation_velocity.y = move_toward(rotation_velocity.y,0,rotation_velocity_damping)
	

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 5:
			$"../Camera3D".fov = min(150,$"../Camera3D".fov+1)
		elif event.button_index == 4:
			$"../Camera3D".fov = max(30,$"../Camera3D".fov-1)
		else:
			mouse_down = true
			last_mouse_pos = to_local(event_position)
		GlobalCamera.fov = camera.fov
	if event.is_action_pressed("select_new_positions",true):
		for child in player_units_list.get_children():
			if child.selected:
				child.set_target(last_mouse_pos)
		return
	if event.is_action_pressed("select_units"):
		deal_with_selected(0)
		return
	pass # Replace with function body.

func deal_with_selected(item):
	if item == 0:
		if !sample(last_mouse_pos):
			change_selected(Color(0,0,1,1))
		for child in player_units_list.get_children():
			child.toggle_select(false)
	if item == 1:
		change_selected(Color(0,0,1,1))
		for child in player_units_list.get_children():
			child.toggle_select(false)
