extends Node

func _process(delta):
	GC.mouseTile = GC.pos_to_tile( get_node("/root/Battle/Map/TileMapAuto").get_global_mouse_position() )
	GC.mouseTilePos = GC.tile_to_pos( GC.mouseTile )

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			onTileClick(GC.mouseTile)


func onTileClick(tile):
	print("onTileClick ",tile)
	if(GC.currentTrop):
		GC.currentTrop.set_destine(GC.mouseTilePos)
		GC.currentTrop.unselect()
	else:
		for t in get_tree().get_nodes_in_group("trops_group"):
			if(GC.pos_to_tile(t.position)==tile):
				t.select()
				break;
	print("GC.currentTrop ",GC.currentTrop)
