extends CharacterBody2D

var vel_x : float = 11.9
var dir : int = 1
var target_vel :float = 0.0
@onready var anim_tree : AnimationTree = $AnimationTree

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_left"):
		target_vel = -vel_x
	elif Input.is_action_just_pressed("move_right"):
		target_vel = vel_x
	elif !Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"):
		target_vel = 0
	
	velocity.x = move_toward(velocity.x,target_vel,delta * 25)
	
	if velocity.x > 0 and dir == -1:
		dir = 1
		scale.x = scale.y * dir
	elif velocity.x < 0 and dir == 1:
		dir = -1
		scale.x = scale.y * dir
	
	
	if velocity.x != 0:
		anim_tree.set("parameters/Walk_Blend/blend_amount",abs(velocity.x)/vel_x)
	else:
		anim_tree.set("parameters/Walk_Blend/blend_amount",0)
	
	move_and_collide(velocity * delta *50)
