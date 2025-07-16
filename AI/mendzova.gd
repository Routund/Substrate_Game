extends Node

@onready var manager = get_parent()
var last

func _ready() -> void:
	manager.queued_dialogue.append(["Mendzova","Introduction"])

func process() -> void:
	pass
