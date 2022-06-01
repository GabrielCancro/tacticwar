extends Node


func _ready():
	pass # Replace with function body.

func onNextTurnClick():
	var own = GC.currentTurn
	for b in get_tree().get_nodes_in_group("builds_group"):
		if(b.OWN != own): continue
		var PROD = b.get_prod()
		for p in PROD: GC.RECS[own][p] += PROD[p]	
	
	for t in get_tree().get_nodes_in_group("trops_group"):
		t.restore_steps()
	
	GC.turn += 1
	
	GC.HEADER.update_header()
	print("END TURN")
