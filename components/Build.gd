extends Node2D

export var OWN = 1
export var TYPE = "CITY"
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

func get_prod():
	var PROD = { "food":0,"wood":0,"stone":0,"gold":0,"pop":0}
	if TYPE == "CITY":
		if (BUILDS.has("house")): PROD.pop += BUILDS.house * .2
		if (BUILDS.has("farm")): PROD.food += BUILDS.farm * GAMEDATA.VARS[OWN].farm_prod
		if (BUILDS.has("sawmill")): PROD.wood += BUILDS.sawmill * GAMEDATA.VARS[OWN].sawmill_prod
	return PROD
