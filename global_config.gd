extends Node

var mouseTile = Vector2(0,0)
var mouseTilePos = Vector2(0,0)
var currentSelect
var currentSelectType
var TropManager

var OPTIONS = {
	"trop_mov_vel":1.5
}

onready var TILE_MAP = get_node("/root/Battle/Map/TileMapAuto")
onready var UI = get_node("/root/Battle/CanvasLayer")
onready var NAV = get_node("/root/Battle/Map")

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
	var points = Array( NAV.get_simple_path(normalize_pos(from),normalize_pos(to), false) )
	points.pop_front()
	if!points: return [from]
	points[points.size()-1] = to
	NAV.get_node("Line2D").points = points
	NAV.get_node("Line2D2").points = PoolVector2Array([from,to])
	return points
