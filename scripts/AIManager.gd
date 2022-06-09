extends Node

signal finishMoves

func playAI():
	if GC.currentTurn == GC.humanPlayer: return
	for T in get_tree().get_nodes_in_group("trops_group"):
		if T.OWN != GC.currentTurn: continue
		T.confirm_move = true
		T.set_destine(Vector2(200,200))
	for B in get_tree().get_nodes_in_group("builds_group"):
		if B.OWN != GC.currentTurn: continue
		order_building(B)
	emit_signal("finishMoves")

func order_building(B):
	if B.BUILDS["house"] < 3: buy_build(B,"house")

func buy_build(B,STRUCTURE):
	print("BUILDING ",STRUCTURE," ",GC.check_recs(GAMEDATA.BUILDS[STRUCTURE],B.OWN))
	if GC.check_recs(GAMEDATA.BUILDS[STRUCTURE],B.OWN):
		if !B.BUILDS.has(STRUCTURE): B.BUILDS[STRUCTURE] = 0
		B.BUILDS[STRUCTURE] += 1
		GC.dec_recs(GAMEDATA.BUILDS[STRUCTURE],B.OWN)
		return true
	return false
