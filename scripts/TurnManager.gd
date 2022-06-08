extends Node

func _ready():
	GC.HEADER.get_node("NextTurn").modulate = GAMEDATA.COLORS[GC.currentTurn]
	pass # Replace with function body.

func onNextTurnClick():
	GC.currentTurn += 1
	if GC.currentTurn > 2: GC.currentTurn = 1
	GC.HEADER.get_node("NextTurn").modulate = GAMEDATA.COLORS[GC.currentTurn]
	var own = GC.currentTurn
	for b in get_tree().get_nodes_in_group("builds_group"):
		if(b.OWN != own): continue
		var PROD = b.get_prod()
		for p in PROD: GC.RECS[own][p] += PROD[p]
	
	for t in get_tree().get_nodes_in_group("trops_group"):
		t.restore_steps()
	GC.turn += 1
	GC.HEADER.update_header()
	GC.UI.get_node("Build_panel").hide_panel()
	print("END TURN")
