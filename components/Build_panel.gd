extends NinePatchRect

var GO
var STRUCTURE

# Called when the node enters the scene tree for the first time.
func _ready():
	$building/buy/Button.connect("button_down",self,"onBuildHammerClick")
	pass

func hide_panel():
	visible = false
	
func show_panel(go):
	GO = go
	visible = true
	set_buttons_info()
	$building/buy.visible = false
	$lb_level.text = "CITY"
#	$lb_pob.text = "pob "+str(GO.POB.cnt)+"/"+str(GO.POB.max)+"    "+str(GO.POB.prg_inc*10)+"% +"+ str(GO.POB.inc)
	$lb_prod.text = ""
	var PROD = GO.get_prod()
	for p in PROD: 
		if(PROD[p]!=0 && p!="pob"): 
			$lb_prod.text += p
			if(PROD[p]>0): $lb_prod.text += "+" 
			$lb_prod.text += str(PROD[p])+"   "
	$lb_units.text = str(GO.UNITS)

func set_buttons_info():
	var i = 0 
	for b in $building/HBox.get_children():
		if(i<GAMEDATA.BUILDS.keys().size()):
			b.visible=true
			var key = GAMEDATA.BUILDS.keys()[i]
			b.get_node("lb_name").text = key.capitalize()
			if(!GO.BUILDS.has(key)):GO.BUILDS[key] = 0
			b.get_node("lb_cant").text = "x"+str(GO.BUILDS[key])
			(b.get_node("Button") as Button).connect("button_down",self,"on_button_build_click",[key])
			print("kay build ",key)
		else: b.visible=false
		i+=1

func on_button_build_click(key):
	STRUCTURE = key
	$building/buy.visible=true
	$building/buy/lb_name.text = key.capitalize()
	$building/buy/lb_desc.text = GAMEDATA.BUILDS[key].desc
	if check_recs(): $building/buy/lb_rec.modulate = Color(1,1,1,1)
	else: $building/buy/lb_rec.modulate = Color(30,10,10,1)
	$building/buy/Button.visible = check_recs()
	var rec = ""
	for i in GAMEDATA.REC_NAMES:
		if(GAMEDATA.BUILDS[key].has(i)): rec += "   "+i+":"+str(GAMEDATA.BUILDS[key][i])
	$building/buy/lb_rec.text = rec
	print("CLICK ",key)

func onBuildHammerClick():
	if !check_recs(): return
	if !GO.BUILDS.has(STRUCTURE): GO.BUILDS[STRUCTURE] = 0
	GO.BUILDS[STRUCTURE] += 1
	for i in GAMEDATA.REC_NAMES:
		if(GAMEDATA.BUILDS[STRUCTURE].has(i)):
			GC.RECS[GO.OWN][i] -= GAMEDATA.BUILDS[STRUCTURE][i]
	GC.HEADER.update_header()
	show_panel(GO)

func check_recs():
	for i in GAMEDATA.REC_NAMES:
		if(GAMEDATA.BUILDS[STRUCTURE].has(i)):
			if(GC.RECS[GO.OWN][i]<GAMEDATA.BUILDS[STRUCTURE][i]): return false
	return true
