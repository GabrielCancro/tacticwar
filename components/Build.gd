extends Node2D

var OWN = 1
var POB = {"cnt":3,"inc":1,"max":10}
var PROD = { "com":5,"mad":5,"pie":1,"oro":1}

func _ready():
	add_to_group("builds_group")
	teleport_to_tile(GC.pos_to_tile(position))

func teleport_to_tile(tile):
	position = GC.tile_to_pos( tile )

func select():
	GC.setCurrentSelect(self)
	modulate.b = 2

func unselect():
	GC.setCurrentSelect(null)
	modulate.b = 1

func get_class(): return "Build"
