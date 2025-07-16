extends Node

var queued_dialogue : Array = []
var event_timer : Timer = Timer.new()
@onready var dialogue_manager = get_parent().get_parent().get_parent().get_node("DialogueContainer")

var min_delay_time = 1.4
var max_delay_time = 12

func _ready() -> void:
	event_timer.autostart = false
	event_timer.one_shot = true
	add_child(event_timer)
	event_timer.connect("timeout",choose_new)
	event_timer.start(randf_range(min_delay_time,max_delay_time))
	pass

func choose_new() -> void:
	if GlobalDialogue.talking != true and len(queued_dialogue) > 0:
		var rand_ind = randi_range(0,len(queued_dialogue)-1)
		var new_dialogue = queued_dialogue.pop_at(rand_ind)
		dialogue_manager.load_dialogues(new_dialogue[0],new_dialogue[1])
	event_timer.start(randf_range(min_delay_time,max_delay_time))
