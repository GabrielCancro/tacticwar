extends Node2D

var OWN = 1
var POB = {"cnt":3,"inc":1,"max":10}
var PROD = { "food":5,"wood":5,"stone":1,"gold":1}
var BUILDS = {"house":2}

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
