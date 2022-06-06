extends NinePatchRect

var GO
var STRUCTURE

func _ready():
	$building/buy/Button.connect("button_down",self,"onBuildHammerClick")
	$units/buy/Button.connect("button_down",self,"onTropHammerClick")
	$units/new_trop/Button.connect("button_down",self,"onNewTropClick")
	for b in $building/HBox.get_children():
		(b.get_node("Button") as Button).connect("button_down",self,"on_button_build_click",[ GAMEDATA.BUILDS.keys()[b.get_index()] ])
	for b in $units/VBox.get_children():
		(b.get_node("Button") as Button).connect("button_down",self,"on_button_unit_click",[ GAMEDATA.TROPS.keys()[b.get_index()] ])

func hide_panel():
	visible = false
	
func show_panel(go):
	GO = go
	visible = true
	set_buttons_info()
	$building/buy.visible = false
	$units/buy.visible = false
	$lb_type.text = GO.TYPE
	$lb_type.modulate = GAMEDATA.COLORS[GO.OWN]
	$lb_prod.text = ""
	var PROD = GO.get_prod()
	for p in PROD: 
		if(PROD[p]!=0 && p!="pob"): 
			$lb_prod.text += p
			if(PROD[p]>0): $lb_prod.text += "+" 
			$lb_prod.text += str(PROD[p])+"   "
	var PANELS = $units/VBox.get_children()
	var index = 0
	for u in GO.UNITS: 
		PANELS[index].set_info( u, GO.UNITS[u] )
		index += 1

func set_buttons_info():
	var i = 0 
	for b in $building/HBox.get_children():
		if(i<GAMEDATA.BUILDS.keys().size()):
			b.visible=true
			var key = GAMEDATA.BUILDS.keys()[i]
			b.get_node("lb_name").text = key.capitalize()
			if(!GO.BUILDS.has(key)):GO.BUILDS[key] = 0
			b.get_node("lb_cant").text = "x"+str(GO.BUILDS[key])
			print("kay build ",key)
		else: b.visible=false
		i+=1

func on_button_build_click(key):
	STRUCTURE = key
	$building/buy.visible=true
	$units/buy.visible=false
	$building/buy/lb_name.text = key.capitalize()
	$building/buy/lb_desc.text = GAMEDATA.BUILDS[key].desc
	if check_recs(GAMEDATA.BUILDS): $building/buy/lb_rec.modulate = Color(1,1,1,1)
	else: $building/buy/lb_rec.modulate = Color(1,.3,.3,1)
	$building/buy/Button.visible = check_recs(GAMEDATA.BUILDS)
	var rec = ""
	for i in GAMEDATA.REC_NAMES:
		if(GAMEDATA.BUILDS[key].has(i)): rec += "   "+i+":"+str(GAMEDATA.BUILDS[key][i])
	$building/buy/lb_rec.text = rec
	print("CLICK ",key)

func onBuildHammerClick():
	if !check_recs(GAMEDATA.BUILDS): return
	if !GO.BUILDS.has(STRUCTURE): GO.BUILDS[STRUCTURE] = 0
	GO.BUILDS[STRUCTURE] += 1
	GC.dec_recs(GAMEDATA.BUILDS[STRUCTURE])
	show_panel(GO)
	on_button_build_click(STRUCTURE)

func check_recs(REQ_ARR):
	for i in GAMEDATA.REC_NAMES:
		if(REQ_ARR[STRUCTURE].has(i)):
			if(GC.RECS[GO.OWN][i]<REQ_ARR[STRUCTURE][i]): return false
	return true

func on_button_unit_click(key):
	STRUCTURE = key
	$building/buy.visible=false
	$units/buy.visible=true
	$units/buy/lb_name.text = GAMEDATA.TROPS[key].name.capitalize()
	$units/buy/lb_desc.text = GAMEDATA.TROPS[key].desc
	if check_recs(GAMEDATA.TROPS): $units/buy/lb_rec.modulate = Color(1,1,1,1)
	else: $units/buy/lb_rec.modulate = Color(1,.3,.3,1)
	$units/buy/Button.visible = check_recs(GAMEDATA.TROPS)
	var rec = ""
	for i in GAMEDATA.REC_NAMES:
		if(GAMEDATA.TROPS[key].has(i)): rec += "   "+i+":"+str(GAMEDATA.TROPS[key][i])
	$units/buy/lb_rec.text = rec

func onTropHammerClick():
	if STRUCTURE == "new_trop":
		onNewTropHammerClick()
		return
	if !check_recs(GAMEDATA.TROPS): return
	if !GO.get_units().has(STRUCTURE): GO.add_units({STRUCTURE:0})
	GO.add_units({STRUCTURE:1})
	GC.dec_recs(GAMEDATA.TROPS[STRUCTURE])
	show_panel(GO)
	on_button_unit_click(STRUCTURE)

func onNewTropClick():
	STRUCTURE = "new_trop"
	$building/buy.visible=false
	$units/buy.visible=true
	$units/buy/lb_name.text = "new trop".capitalize()
	$units/buy/lb_desc.text = "create new trop to move your units on map"
	var RECS = {"new_trop":{"gold":50}}
	if check_recs(RECS): $units/buy/lb_rec.modulate = Color(1,1,1,1)
	else: $units/buy/lb_rec.modulate = Color(1,.3,.3,1)
	$units/buy/Button.visible = check_recs(RECS)
	var rec = ""
	for i in GAMEDATA.REC_NAMES:
		if(RECS[STRUCTURE].has(i)): rec += "   "+i+":"+str(RECS[STRUCTURE][i])
	$units/buy/lb_rec.text = rec

func onNewTropHammerClick():
	var RECS = {"new_trop":{"gold":50}}
	if !check_recs(RECS): return
	GC.dec_recs(RECS[STRUCTURE])
	show_panel(GO)
	onNewTropClick()
	print("onNewTropHammerClick onNewTropHammerClick onNewTropHammerClick")
