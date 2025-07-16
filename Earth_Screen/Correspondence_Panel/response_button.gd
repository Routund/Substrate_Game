extends Button

var next_speaker = ""
var next_dialogue = ""
var change = ""
var respondees = ""

func change_data(new_text : String, new_change : String, new_speaker : String, new_dialogue : String, new_respondees : String):
	text = new_text.strip_edges()
	next_speaker = new_speaker
	next_dialogue = new_dialogue
	change = new_change
	respondees = new_respondees

func _on_pressed() -> void:
	print("Pressed")
	var respondees_split = respondees.split("_")
	var changes_split = change.split("_")
	for i in range(len(respondees_split)):
		GlobalDialogue.countries_base_matrix[GlobalDialogue.name_to_id[respondees_split[i]]][1] += int(changes_split[i])
	get_parent().get_parent().get_parent().load_dialogues(next_speaker,next_dialogue)
	pass # Replace with function body.
