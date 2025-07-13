extends Control

@onready var country_title = $Country_Title
@onready var infobox = $InfoBox
@onready var ai_manager = $SubViewportContainer/SubViewport/AI_Parent
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
	["Kaland", 0, "22,608,000"],
	["Federated Republic", 1, "105,070,000"],
	["Kingdom of Sherod", 0, "56,609,000"],
	["United Gromm", 1, "14,514,000"],
	["Borges", 0, "2,099,000"],
	["Southern Gromm", 0, "9,924,000"],
	["Lemurria", 0, "45,576,000"],
	["Great Mendzova", 1, "284,902,000"],
	["Fenlaw", 0, "9,034,000"],
	["Emmerastan", 1, "18,764,000"],
	["Polar States", 1, "98,651,000"]
]

func change_selected(id):
	print(id)
	if id != -1:
		if id != current:
			country_title.reset(countries[id][0])
			infobox.change_info(countries[id],ai_manager.countries_base_matrix[id][1])
			infobox.visible = true
	else:
		country_title.reset(null)
		infobox.visible = false
	current = id
