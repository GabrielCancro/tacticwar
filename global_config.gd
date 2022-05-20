extends Node

var mouseTile
var mouseTilePos

var OPTIONS = {
	"trop_mov_vel":1.5
}

onready var TILE_MAP = get_node("/root/Battle/Map/TileMapAuto")

func _ready():
	pass # Replace with function body.

func pos_to_tile(pos):
	return TILE_MAP.world_to_map( pos )

func tile_to_pos(tile):
	return TILE_MAP.map_to_world( tile ) + Vector2(16,16)
