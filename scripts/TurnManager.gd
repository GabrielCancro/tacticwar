extends Node

func _ready():
	GC.HEADER.get_node("NextTurn").modulate = GAMEDATA.COLORS[GC.currentTurn]
	pass # Replace with function body.

func onNextTurnClick():
	GC.currentTurn += 1
	if GC.currentTurn > 2: GC.currentTurn = 1
	GC.HEADER.get_node("NextTurn").modulate = GAMEDATA.COLORS[GC.currentTurn]
	for b in get_tree().get_nodes_in_group("builds_group"):
		if(b.OWN != GC.currentTurn): continue
		var PROD = b.get_prod()
		for p in PROD: GC.RECS[GC.currentTurn][p] += PROD[p]
	
	for t in get_tree().get_nodes_in_group("trops_group"):
		t.restore_steps()
	
	GC.AI.playAI()
	
	GC.turn += 1
	GC.HEADER.update_header()
	print("GC.currentTurn P",GC.currentTurn, " ", GC.RECS[GC.currentTurn])
	GC.UI.get_node("Build_panel").hide_panel()
	print("NEW TURN ",GC.currentTurn)


		
