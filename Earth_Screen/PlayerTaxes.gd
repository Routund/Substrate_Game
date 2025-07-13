extends PanelContainer

func _process(_delta: float) -> void:
	$Label.text = "$" + str(GlobalFinance.player_money)
