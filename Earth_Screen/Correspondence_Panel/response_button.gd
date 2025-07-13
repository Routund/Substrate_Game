extends Button

var next_speaker = ""
var next_dialogue = ""
var change = 0

func change_data(new_text : String, new_change : int, new_speaker : String, new_dialogue : String):
	text = new_text.strip_edges()
	next_speaker = new_speaker
	next_dialogue = new_dialogue
	change = new_change

func _on_pressed() -> void:
	print("Pressed")
	get_parent().get_parent().get_parent().load_dialogues(next_speaker,next_dialogue)
	pass # Replace with function body.
