extends MeshInstance3D

@onready var bounding : Area3D = $Area3D
@onready var camera : Camera3D = $"../Camera3D"
var current_camera_degreees : float = 0
var bounded  = false
var mouse_down = false
var dragging = false
var sensitivity_inv = 10000
var rotation_velocity : Vector2 = Vector2.ZERO
var rotation_velocity_damping : float = 20

func _ready():
	bounding.mouse_entered.connect(_mouse_entered_area)
	bounding.mouse_exited.connect(_mouse_exited_area)

func _mouse_entered_area():
	bounded = true

func _process(float) -> void:
	if mouse_down:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			mouse_down = false
		else:
			var mouse_vel = Input.get_last_mouse_velocity()
			if mouse_vel.length() > 0.01:
				rotation_velocity = mouse_vel
	
	rotation.y += rotation_velocity.x/sensitivity_inv
	current_camera_degreees = max(-PI/2,min(PI/2,current_camera_degreees + rotation_velocity.y/sensitivity_inv))
	print(current_camera_degreees)
	camera.position.z = cos(current_camera_degreees)
	camera.position.y = sin(current_camera_degreees)
	camera.transform.basis.y = Vector3(0,cos(current_camera_degreees),-sin(current_camera_degreees))
	camera.transform.basis.z = Vector3(0,sin(current_camera_degreees),cos(current_camera_degreees))
	rotation_velocity.x = move_toward(rotation_velocity.x,0,rotation_velocity_damping)
	rotation_velocity.y = move_toward(rotation_velocity.y,0,rotation_velocity_damping)
	

func _mouse_exited_area():
	bounded = false


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and bounded:
		mouse_down = event.pressed
	pass
