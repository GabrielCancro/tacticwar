extends CanvasLayer

func _ready():
	hide_all_ui()

func hide_all_ui():
	$Build.visible = false
	$Trop.visible = false

func onSelectObject(go):
	hide_all_ui()
	if !go: return
	elif go.get_class() == "Trop": onSelectTrop(go)
	elif go.get_class() == "Build": onSelectBuild(go)

func onSelectBuild(go):
	$Build.visible = true
	$Build/lb_level.text = "CITY"
	$Build/lb_pob.text = "pob "+str(go.POB.cnt)+" +"+str(go.POB.inc)
	$Build/lb_prod.text = ""
	for p in go.PROD: 
		if(go.PROD[p]!=0 && p!="pob"): 
			$Build/lb_prod.text += p +" "
			if(go.PROD[p]>0): $Build/lb_prod.text += "+" 
			$Build/lb_prod.text += str(go.PROD[p])+"   "
		

func onSelectTrop(go):
	$Trop.visible = true
	$Trop/Panel/Label.text = "TROP"
	for u in go.data.units:
		$Trop/Panel/Label.text += "\n  "+u+":"+str(go.data.units[u])
