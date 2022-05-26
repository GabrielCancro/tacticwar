extends Node

var mouseTile = Vector2(0,0)
var mouseTilePos = Vector2(0,0)
var currentSelect
var currentSelectType
var TropManager

var OPTIONS = {
	"trop_mov_vel":1.5
}

onready var TILE_MAP = get_node("/root/Battle/Map/TileMapNav")
onready var UI = get_node("/root/Battle/CanvasLayer")
onready var MAP = get_node("/root/Battle/Map")

func _ready():
	pass # Replace with function body.

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

func get_nav_path(from,to):
	from = GC.pos_to_tile(from)
	to = GC.pos_to_tile(to)
	var points = []
	for p in MAP.get_nav_path(from,to): points.append( GC.tile_to_pos(p) )
	if points.size()<=0: points = [GC.tile_to_pos(from)]
	print("POINTS ",points)
	MAP.get_node("Line2D").points = points
	MAP.get_node("Line2D2").points = PoolVector2Array([from,to])
	return points
