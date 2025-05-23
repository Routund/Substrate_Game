extends MeshInstance3D

@onready var bounding : Area3D = $Area3D
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
	rotation_velocity.x = move_toward(rotation_velocity.x,0,rotation_velocity_damping)
	

func _mouse_exited_area():
	bounded = false


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and bounded:
		mouse_down = event.pressed
	pass
