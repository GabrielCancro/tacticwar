extends Control

var ALL_PROD = {}

func _ready():
	$NextTurn/Button.connect("button_down",GC.TURNER,"onNextTurnClick")
	update_header()

func update_header():
	$lb_recs.text = ""
	calc_all_prod()
	for r in GAMEDATA.REC_NAMES:
		$lb_recs.text += r.capitalize() + ":"+str( floor(GC.RECS[GC.humanPlayer][r]) )+"+"+str(ALL_PROD[r])+"    "

func calc_all_prod():
	ALL_PROD = {}
	for b in get_tree().get_nodes_in_group("builds_group"):
		if(b.OWN != GC.humanPlayer): continue
		var B_PROD = b.get_prod()
		for r in GAMEDATA.REC_NAMES:
			if(!ALL_PROD.has(r)): ALL_PROD[r] = 0
			if(B_PROD.has(r)): ALL_PROD[r] += B_PROD[r]
	return ALL_PROD
