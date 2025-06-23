extends CenterContainer

@onready var texture : TextureRect= $Panel2/Panel/TextureRect
@onready var price_text : Label = $Panel2/Panel/Price
@onready var title : Label = $Panel2/Panel/Title
@onready var button : Button = $Panel2

var prices = [20000,120000,60000]
signal bought(ind : int)
var ind = 0

func _ready() -> void:
	if is_in_group("Plane"):
		price_text.text = "$" + str(prices[0])
		texture.texture = load("res://Units/Stealth_Plane/Recon_plane.png")
		title.text = "Recon Plane"
		ind = 0
	elif is_in_group("Submarine"):
		price_text.text = "$" + str(prices[1])
		texture.texture = load("res://Units/Submarine/M.A.D Sub_Texture.png")
		title.text = "Submarine"
		ind = 1
	elif is_in_group("Ship"):
		price_text.text = "$" + str(prices[2])
		texture.texture = load("res://Units/Ship/BattleShip.png")
		title.text = "Battleship"
		ind = 2


func _on_panel_2_pressed() -> void:
	print("WHE")
	bought.emit(ind)
	pass # Replace with function body.
