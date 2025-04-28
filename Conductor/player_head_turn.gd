extends AnimationPlayer

@onready var head : Bone2D = $"../Skeleton2D/Torso/R_Should/R_Fore"
@onready var camera : Camera2D = get_parent().get_node("Camera2D")

func _ready() -> void:
	play("Turn_Head")
	pause()

func _process(delta: float) -> void:
	var canvas_layer_pos = (get_viewport().get_screen_transform() * get_viewport().get_canvas_transform()).affine_inverse() * get_viewport().get_mouse_position()
	var look_vector : Vector2 = head.global_position - (canvas_layer_pos)
	var angle : float = look_vector.angle_to(Vector2.UP)
	
	print(angle)
	seek(abs(angle),true)
