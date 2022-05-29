extends NinePatchRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hide_panel():
	visible = false
	
func show_panel(go):
	visible = true
	$lb_level.text = "CITY"
	$lb_pob.text = "pob "+str(go.POB.cnt)+" +"+str(go.POB.inc)
	$lb_prod.text = ""
	for p in go.PROD: 
		if(go.PROD[p]!=0 && p!="pob"): 
			$lb_prod.text += p +" "
			if(go.PROD[p]>0): $lb_prod.text += "+" 
			$lb_prod.text += str(go.PROD[p])+"   "
