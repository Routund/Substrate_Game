extends Button

var corresponding = false
@onready var par = get_parent()

func _on_pressed() -> void:
	corresponding = !corresponding
	
	if corresponding:
		var tween = create_tween()
		tween.tween_property(par,"position",Vector2(-16,par.position.y),0.3)
	else:
		var tween = create_tween()
		tween.tween_property(par,"position",Vector2(-211,par.position.y),0.3)
	pass # Replace with function body.
