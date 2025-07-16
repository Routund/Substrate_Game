extends PanelContainer
@onready var nuke_indicator = $HBoxContainer/NukeIndicator

func change_info(info_array,diplomacy):
	nuke_indicator.modulate.a = 0.3 + 0.7*info_array[1]
	$HBoxContainer/Sillies/Population.text = "Population: %s" % info_array[2]
	if info_array[0] != "Federated Republic":
		$"HBoxContainer/Sillies/Diplomacy Status".visible = true
		$"HBoxContainer/Sillies/Diplomacy Display".visible = true
		if diplomacy <= 20:
			$"HBoxContainer/Sillies/Diplomacy Display".text = "At war"
		elif diplomacy <= 40:
			$"HBoxContainer/Sillies/Diplomacy Display".text = "Unfavourable"
		elif diplomacy <= 60:
			$"HBoxContainer/Sillies/Diplomacy Display".text = "Neutral"
		elif diplomacy == 70:
			$"HBoxContainer/Sillies/Diplomacy Display".text = "Favourable"
		elif diplomacy < 90:
			$"HBoxContainer/Sillies/Diplomacy Display".text = "Ally"
	else:
		$"HBoxContainer/Sillies/Diplomacy Status".visible = false
		$"HBoxContainer/Sillies/Diplomacy Display".visible = false
