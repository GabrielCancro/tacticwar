extends Node

var mouseTile = Vector2(0,0)
var mouseTilePos = Vector2(0,0)
var currentSelect
var currentSelectType
var TropManager
var currentTurn = 1
var humanPlayer = 1
var turn = 1

var RECS = [
	{"food":100, "wood":100, "stone":50, "gold":50, "pop":2}
]

var OPTIONS = {
	"trop_mov_vel":1.5
}

onready var TILE_MAP = get_node("/root/Battle/Map/TileMapNav")
onready var UI = get_node("/root/Battle/CanvasLayer")
onready var HEADER = get_node("/root/Battle/CanvasLayer/Header")
onready var MAP = get_node("/root/Battle/Map")
onready var TURNER = get_node("/root/Battle/TurnManager")
onready var AI = get_node("/root/Battle/AIManager")

func _ready():
	for i in range(4): RECS.append(RECS[0].duplicate())

func init_references():
	TropManager = get_node("/root/Battle/TropManager")

func pos_to_tile(pos):
	return TILE_MAP.world_to_map( pos )

func tile_to_pos(tile):
	return TILE_MAP.map_to_world( tile ) + Vector2(16,16)

func normalize_pos(pos):
	pos = pos/32
	pos = Vector2(floor(pos.x),floor(pos.y))
	return pos*32+Vector2(16,16)

func setCurrentSelect(go):
	currentSelect = go
	if go == null: currentSelectType = null
	else: currentSelectType = go.get_class()
	UI.onSelectObject(go)

func get_nav_path(from,to,steps=20):
	from = GC.pos_to_tile(from)
	to = GC.pos_to_tile(to)
	var points = []
	for p in MAP.get_nav_path(from,to): points.append( GC.tile_to_pos(p) )
	if points.size()<=0: points = [GC.tile_to_pos(from)]
	var cuted_points = points.slice(0,steps)
	print("POINTS ",cuted_points, steps)
	MAP.get_node("Line2D").points = cuted_points
	MAP.get_node("Line2D2").points = points
	return points

func clear_path_lines():
	MAP.get_node("Line2D").points = []
	MAP.get_node("Line2D2").points = []

func show_move_trop_panel(go1,go2):
	UI.get_node("Move_Trop_panel").show_panel(go1,go2)

func add_recs(TO_ADD_RECS,OWN=currentTurn):
	for r in GAMEDATA.REC_NAMES:
		if TO_ADD_RECS.has(r):
			RECS[OWN][r] += TO_ADD_RECS[r]
	if OWN==humanPlayer: HEADER.update_header()

func dec_recs(TO_ADD_RECS,OWN=currentTurn):
	TO_ADD_RECS = TO_ADD_RECS.duplicate()
	for r in GAMEDATA.REC_NAMES:
		if(TO_ADD_RECS.has(r)): TO_ADD_RECS[r] *= -1	
	add_recs(TO_ADD_RECS,OWN)

func new_trop(own,tile_pos):
	var TROP = preload("res://components/Trop.tscn").instance()
	TROP.OWN = own
	MAP.get_node("Objects").add_child(TROP)
	TROP.teleport_to_tile(tile_pos)

func check_recs(REQ_ARR,OWN=humanPlayer):
	for i in GAMEDATA.REC_NAMES:
		if(REQ_ARR.has(i)):
			if(GC.RECS[OWN][i]<REQ_ARR[i]): return false
	return true
