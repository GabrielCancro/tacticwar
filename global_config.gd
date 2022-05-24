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

func _ready():
	pass # Replace with function body.

func init_references():
	TropManager = get_node("/root/Battle/TropManager")

func pos_to_tile(pos):
	return TILE_MAP.world_to_map( pos )

func tile_to_pos(tile):
	return TILE_MAP.map_to_world( tile ) + Vector2(16,16)

func setCurrentSelect(go):
	currentSelect = go
	if go == null: currentSelectType = null
	else: currentSelectType = go.get_class()
	UI.onSelectObject(go)
