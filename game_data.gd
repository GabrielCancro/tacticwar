extends Node

var REC_NAMES = ["food","wood","stone","gold","pop"]
var TROP_NAMES = ["cam","gue","arq","jin","cat"]
var COLORS = [Color(1,1,1),Color(.8,.8,7), Color(7,.5,.5)]

var VARS = [{
	"farm_prod":5, "sawmill_prod":7, "trop_steps":3
}]

var BUILDS = {
	"house":{"food":20, "wood":50, "desc":"Increment limit of city poblation"},
	"farm":{"food":20, "wood":60, "pop":1, "desc":"Increment production of food"},
	"sawmill":{"food":30, "wood":30, "pop":1, "desc":"Increment production of wood"},
	"tower":{"wood":100, "stone":100, "pop":1, "desc":"Defensive to attack enemy trops"},
	"wall":{"wood":50, "stone":100, "desc":"Defensive to resistence enemies attacks"},
}

var TROPS = {
	"cam":{"name":"farmer","food":20, "wood":30, "pop":1, "desc":"Farmer, weak atack and low hitpoints"},
	"gue":{"name":"warrior","food":20, "gold":10, "pop":1, "desc":"Medium streng, economic and efficient"},
	"arq":{"name":"archer","food":30, "wood":30, "gold":10, "pop":1, "desc":"Ranged attack, effective against weak units and attacks on walls"},
	"jin":{"name":"knight","food":50, "gold":40, "pop":1, "desc":"Powerful warrior, skilled in combat and well equipped"},
	"cat":{"name":"siege","wood":150, "gold":50, "pop":2, "desc":"The siege destroys walls and towers easily"},
}

func _ready():
	for i in range(4): VARS.append(VARS[0])
