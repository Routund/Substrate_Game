extends VBoxContainer

var response_button_preload = preload("res://Earth_Screen/Correspondence_Panel/response_button.tscn")

func add_responses(responses):
	for response in responses:
		var new_button = response_button_preload.instantiate()
		add_child(new_button)
		new_button.change_data(response[0], response[1], response[3], response[4], response[2])

func clear_responses():
	for child in get_children():
		child.queue_free()
