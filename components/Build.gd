extends Node2D

export var OWN = 1
export var TYPE = "CITY"
var BUILDS = {"house":2}
var UNITS = { "cam":2,"gue":0,"arq":0,"jin":0,"cat":0}

func _ready():
	add_to_group("builds_group")
	teleport_to_tile(GC.pos_to_tile(position))
	$Panel.modulate = GAMEDATA.COLORS[OWN]
	update_units_label()
	UNITS.cam += 5
	update_units_label()

func _process(delta):
	pass

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

func update_units_label():
	var amount = 0
	for u in UNITS:
		amount += UNITS[u] 
	$Panel/Label.text = str(amount)

func add_units(_units):
	for u in _units:
		if(!UNITS.has(u)): UNITS[u] = 0
		UNITS[u] += _units[u]
	update_units_label()

func get_units(): 
	return UNITS
