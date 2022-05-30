extends Node

var REC_NAMES = ["food","wood","stone","gold"]

var VARS = [{
	"farm_prod":3, "sawmill_prod":3, 
}]

var BUILDS = {
	"house":{"food":20, "wood":50, "desc":"Increment limit of city poblation"},
	"farm":{"food":20, "wood":60, "desc":"Increment production of food"},
	"sawmill":{"food":30, "wood":30, "desc":"Increment production of wood"},
	"tower":{"wood":100, "stone":100, "desc":"Defensive to attack enemy trops"},
	"wall":{"wood":50, "stone":100, "desc":"Defensive to resistence enemies attacks"},
}

func _ready():
	for i in range(4): VARS.append(VARS[0])
