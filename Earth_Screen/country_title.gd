extends Label
var new_text = "United Federated Republic"
var speed = 5
var i = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	reset(null)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if i<len(new_text)*speed:
		if i%speed==0:
			text+=new_text[i/speed]
		i+=1
	pass

func reset(new):
	if new == null:
		visible=false
	else:
		i=0
		new_text=new
		visible=true
	text=""
