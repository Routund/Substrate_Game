extends Node

var talking = false

var countries_base_matrix = [
	[90, 50, 70, 40, 50, 60, 50, 40, 80, 70, 80],
	[50, 90, 50, 50, 70, 50, 50, 30, 40, 50, 80],
	[70, 50, 90, 40, 60, 50, 50, 40, 40, 50, 50],
	[40, 50, 40, 90, 60, 20, 60, 50, 40, 60, 40],
	[50, 70, 60, 60, 90, 50, 00, 40, 00, 00, 00],
	[60, 50, 50, 20, 00, 90, 00, 40, 00, 00, 00],
	[50, 40, 50, 60, 00, 00, 90, 80, 00, 00, 00],
	[40, 30, 40, 50, 40, 40, 80, 90, 00, 50, 00],
	[80, 40, 40, 40, 00, 00, 00, 00, 90, 00, 00],
	[70, 50, 50, 60, 00, 00, 00, 50, 00, 90, 70],
	[80, 80, 50, 40, 00, 00, 00, 00, 00, 70, 90],
]

var name_to_id = {
	"Kaland": 0,
	"FR": 1,
	"Sherod": 2,
	"United Gromm": 3,
	"Borges": 4,
	"Southern Gromm": 5,
	"Lemurria": 6,
	"Mendzova": 7,
	"Fenlaw": 8,
	"Emmerastan": 7,
	"Polar States": 8,
	"Public": 2
}
