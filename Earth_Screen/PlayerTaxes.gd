extends Label

func _process(_delta: float) -> void:
	text = "$" + str(GlobalFinance.player_money)
