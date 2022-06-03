extends NinePatchRect

var GO1
var GO2

func _ready():
	for b in $VBox.get_children():
		b.get_node("Button").connect("button_down",self,"onBoxClick",[GAMEDATA.TROP_NAMES[b.get_index()],"LEFT"])
	for b in $VBox2.get_children():
		b.get_node("Button").connect("button_down",self,"onBoxClick",[GAMEDATA.TROP_NAMES[b.get_index()],"RIGHT"])

func onBoxClick(name,side):
	if (side=="LEFT" && GO2.get_units()[name]>0):
		GO2.add_units({name:-1})
		GO1.add_units({name:+1})
	if (side=="RIGHT" && GO1.get_units()[name]>0):
		GO1.add_units({name:-1})
		GO2.add_units({name:+1})
	show_panel(GO1,GO2)

func onBoxRightClick(name):
	print(name)

func hide_panel():
	visible = false
	
func show_panel(go1,go2):
	visible = true
	GO1 = go1
	GO2 = go2
	$Label.text = go1.TYPE
	setDataTrop($VBox,go1)
	$Label2.text = go2.TYPE
	setDataCity($VBox2,go2)

func setDataTrop(VBOX,trop):
	for pan in VBOX.get_children():
		var u = GAMEDATA.TROP_NAMES[pan.get_index()]
		pan.set_info( u, trop.data.units[u] )

func setDataCity(VBOX,city):
	for pan in VBOX.get_children():
		var u = GAMEDATA.TROP_NAMES[pan.get_index()]
		pan.set_info( u, city.UNITS[u] )
