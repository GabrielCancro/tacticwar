extends Node


func _ready():
	pass # Replace with function body.

func onNextTurnClick():
	var own = GC.currentTurn
	for b in get_tree().get_nodes_in_group("builds_group"):
		if(b.OWN != own): continue
		for p in b.PROD: GC.RECS[own][p] += b.PROD[p]
		b.POB.cnt = min(b.POB.max, b.POB.cnt+b.POB.inc)
	GC.HEADER.update_header()
	print("END TURN")
