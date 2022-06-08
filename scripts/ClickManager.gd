extends Node

var DOWN_POS = Vector2()
var DOWN_POS_CAMERA = Vector2()
var UP_POS = Vector2()
var MOUSE_POS = Vector2()
var MOVING_CAMERA = false

onready var CAMERA = get_node("/root/Battle/Camera2D");
onready var TILE_MAP_NAV = get_node("/root/Battle/Map/TileMapNav");

func _ready():
	CAMERA.get_node("Button").connect("button_down",self,"onDownMouseCamera")
	CAMERA.get_node("Button").connect("button_up",self,"onUpMouseCamera")
	
func _process(delta):
	GC.mouseTile = GC.pos_to_tile( TILE_MAP_NAV.get_global_mouse_position()  )
	GC.mouseTilePos = GC.tile_to_pos( GC.mouseTile )

func onDownMouseCamera():
	DOWN_POS = TILE_MAP_NAV.get_global_mouse_position() 
	DOWN_POS_CAMERA = get_viewport().get_mouse_position()
	MOVING_CAMERA = false

func onUpMouseCamera():
	UP_POS = TILE_MAP_NAV.get_global_mouse_position() 
	if(DOWN_POS.distance_to(UP_POS)<5): onTileClick( GC.pos_to_tile(UP_POS) )
	DOWN_POS = null
	DOWN_POS_CAMERA = null
	UP_POS = null
	MOVING_CAMERA = false
	
func _input(event):
	if DOWN_POS_CAMERA && event is InputEventMouseMotion:
		MOUSE_POS = event.position
		if (DOWN_POS_CAMERA.distance_to(MOUSE_POS)>5): MOVING_CAMERA = true
		if MOVING_CAMERA:
			CAMERA.position += DOWN_POS_CAMERA-MOUSE_POS
			DOWN_POS_CAMERA = MOUSE_POS

func onTileClick(tile):
#	print("onTileClick ",tile)
	GC.UI.get_node("Move_Trop_panel").hide_panel()
	if(GC.currentSelect):
		if(GC.currentSelect.OWN==GC.humanPlayer && GC.currentSelect.OWN==GC.currentTurn): apply_destine_action(tile)
		else: GC.currentSelect.unselect()
	else:
		var build = get_element_in_tile(tile,"builds_group");
		if build: build.select()
		var trop = get_element_in_tile(tile,"trops_group");
		if trop: trop.select()

func get_element_in_tile(tile,group):
	for t in get_tree().get_nodes_in_group(group):
		if(GC.pos_to_tile(t.position)==tile):
			return t

func apply_destine_action(tile):
	var trop_dest = get_element_in_tile(tile,"trops_group");
	var build_dest = get_element_in_tile(tile,"builds_group");
	var this_trop = GC.currentSelect
	
	if GC.currentSelectType == "Trop":
		GC.currentSelect.confirm_move = false
		if trop_dest: 
			if(GC.currentSelect == trop_dest):
				GC.currentSelect.unselect()
			elif(GC.currentSelect.tile_pos.distance_to(trop_dest.tile_pos)<=2):
				if(GC.currentSelect.steps>0): GC.TropManager.atack(GC.currentSelect.data,trop_dest.data)
				GC.currentSelect.unselect()
			else: GC.currentSelect.unselect()
		elif build_dest:
			GC.currentSelect.unselect()
			if(this_trop.OWN==build_dest.OWN && 
			build_dest.TYPE=="CITY" && 
			this_trop.tile_pos.distance_to(GC.pos_to_tile(build_dest.position))<=2):
#				guard_trop_in_build(GC.currentSelect,build_dest)				
				GC.show_move_trop_panel(this_trop,build_dest)
		else:
			if(GC.currentSelect.path.size()>0 && GC.currentSelect.path.back()==GC.mouseTilePos): 
				GC.currentSelect.confirm_move = true
				GC.currentSelect.set_destine(GC.mouseTilePos)
				GC.currentSelect.unselect();
			else: 
				GC.currentSelect.set_destine(GC.mouseTilePos)
	if GC.currentSelectType == "Build":
		GC.currentSelect.unselect()

#func guard_trop_in_build(trop,build):
#	for u in trop.data.units:
#		build.UNITS[u] += trop.data.units[u]
#	trop.remove_trop()
#	build.update_units_label()
