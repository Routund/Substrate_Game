extends Node

var tax_time : Timer = Timer.new()
var player_money = 0

func _ready() -> void:
	add_child(tax_time)
	tax_time.one_shot = true
	tax_time.autostart = false
	tax_time.connect("timeout",collect_taxes)
	tax_time.start(2)

func collect_taxes():
	tax_time.start(randf_range(0.5,2.5))
	player_money += randi_range(5000,13000)
