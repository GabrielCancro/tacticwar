extends Node2D

var own = 1

func _ready():
	add_to_group("builds_group")
	teleport_to_tile(GC.pos_to_tile(position))

func teleport_to_tile(tile):
	position = GC.tile_to_pos( tile )

func select():
	GC.currentSelect = self
	GC.currentSelectType = "build"
	modulate.b = 2

func unselect():
	GC.currentSelect = null
	GC.currentSelectType = null
	modulate.b = 1
