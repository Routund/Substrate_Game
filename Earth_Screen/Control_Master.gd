extends Control

@onready var country_title = $Country_Title
var current = -1
var colour_to_id = {
	2964052966 : 1,
	1921178398: 2,
	2224419762: 3,
	2207183211: 5,
	2034889511: 4,
	400855679: 7,
	1364196581: 6,
	3084949426: 0,
	1185318030 : 9,
	1346035527: 10,
	3569532738: 8
}
var countries = [
	["Kaland"],
	["Federated Republic"],
	["Kingdom of Sherod"],
	["United Gromm"],
	["Borges"],
	["Southern Gromm"],
	["Lemurria"],
	["Great Mendzova"],
	["Fenlaw"],
	["Emmerastan"],
	["Polar States"]
]

func change_selected(id):
	print(id)
	if id != -1:
		if id != current:
			country_title.reset(countries[id][0])
	else:
		country_title.reset(null)
	current = id
