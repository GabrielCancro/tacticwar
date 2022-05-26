extends Node

var DOWN_POS = Vector2()
var MOUSE_POS = Vector2()
var MOVING_CAMERA = false

func _process(delta):
	GC.mouseTile = GC.pos_to_tile( get_node("/root/Battle/Map/TileMapAuto").get_global_mouse_position() )
	GC.mouseTilePos = GC.tile_to_pos( GC.mouseTile )

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed(): DOWN_POS = event.position
			else:
				if !MOVING_CAMERA: onTileClick(GC.mouseTile)
				MOVING_CAMERA = false
				DOWN_POS = null
	elif event is InputEventMouseMotion:
		MOUSE_POS = event.position
		if DOWN_POS && (DOWN_POS.distance_to(MOUSE_POS)>5): MOVING_CAMERA=true
		if MOVING_CAMERA: move_map()

func move_map():
#	print("move map",(MOUSE_POS-DOWN_POS))
	get_node("/root/Battle/Camera2D").position += DOWN_POS-MOUSE_POS
	DOWN_POS = MOUSE_POS

func onTileClick(tile):
#	print("onTileClick ",tile)
	if(GC.currentSelect):
		apply_destine_action(tile)
	else:
		var build = get_element_in_tile(tile,"builds_group");
		if build: build.select()
		var trop = get_element_in_tile(tile,"trops_group");
		if trop: trop.select()
#	print("GC.currentSelect ",GC.currentSelectType," ",GC.currentSelect)

func get_element_in_tile(tile,group):
	for t in get_tree().get_nodes_in_group(group):
		if(GC.pos_to_tile(t.position)==tile):
			return t

func apply_destine_action(tile):
	var trop_dest = get_element_in_tile(tile,"trops_group");
	var build_dest = get_element_in_tile(tile,"builds_group");
	
#	print("DESTINE ",GC.currentSelectType," to ",tile)
	
	if GC.currentSelectType == "Trop":
		if trop_dest: 
			if(GC.currentSelect == trop_dest):
				GC.currentSelect.unselect()
			elif(GC.currentSelect.tile_pos.distance_to(trop_dest.tile_pos)<=2):
				GC.TropManager.atack(GC.currentSelect.data,trop_dest.data)
				GC.currentSelect.unselect()
			else: GC.currentSelect.unselect()
		elif build_dest:
			GC.currentSelect.unselect()
		else:
			GC.currentSelect.set_destine(GC.mouseTilePos)
			GC.currentSelect.unselect()
		
	if GC.currentSelectType == "Build":
		GC.currentSelect.unselect()
