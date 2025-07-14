extends Control

@onready var body_text : Label = get_node("Text_Container/Correspondence_Text")
@onready var response_list : VBoxContainer = get_node("Text_Container/Response_Container")
func _ready() -> void:
	var _results = load_dialogues("General","Introduction")

func load_dialogues(speaker : String, dialog_name : String):
	
	if dialog_name == "":
		body_text.text = ""
		$Text_Container/Response_Container.clear_responses()
		$Speaker_Headshot/TextureRect.texture = null
		return
	
	var result = [" ",[]]
	
	# Set up Parser
	var parser = XMLParser.new()
	parser.open("res://Earth_Screen/Correspondence_Panel/Correspondence.xml")
	# Loop to find correct speaker
	while parser.read() != ERR_FILE_EOF:
		if parser.get_named_attribute_value_safe("character") == speaker :
			$Speaker_Headshot/TextureRect.texture = load(parser.get_named_attribute_value("icon"))
			break;
		elif parser.get_node_name() == "speaker":
			parser.skip_section()
	
	# Loop to find correct dialogue option from speaker
	while parser.read() != ERR_FILE_EOF:
		if parser.get_named_attribute_value_safe("message") == dialog_name :
			break;
		elif parser.get_node_name() == "dialog_node":
			parser.skip_section()
	
	# Get text for dialogue
	parser.read()
	result[0] = parser.get_node_data()
	
	var current_node_info = []
	while parser.read() != ERR_FILE_EOF:
		var node_name = parser.get_node_name()
		if parser.get_node_type() == XMLParser.NODE_TEXT:
			var text = parser.get_node_data()
			if text.strip_edges() != "" and len(current_node_info) != 0:
				result[1].append([text, current_node_info[0],current_node_info[1],current_node_info[2]])
		elif node_name == "response":
			var change = int(parser.get_named_attribute_value("change"))
			var next_dialogue =  parser.get_named_attribute_value("next_dialogue")
			var next_speaker = parser.get_named_attribute_value("next_speaker")
			current_node_info = [change, next_speaker, next_dialogue]
			print(current_node_info)
		elif node_name != "text":
			break
	
	body_text.text = result[0].format({"foreign_country_noun": "Mendzova"})
	$Text_Container/Response_Container.clear_responses()
	$Text_Container/Response_Container.add_responses(result[1])
	
	return
