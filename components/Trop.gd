extends Node2D

var STATE = "NONE"
var destine = Vector2(0,0)
var current_anim
onready var data = { 
	"units":{ "cam":5,"gue":5,"arq":5,"jin":1,"cat":0}, 
	"hps":{}, 
	"hpt":0, 
	"unitsNode":$Units
}

func _ready():
	add_to_group("trops_group")
	yield(get_tree().create_timer(.1),"timeout")
	GC.TropManager.calc_hps(data)
	GC.TropManager.recreate_units_nodes(data)
	pass # Replace with function body.

func _process(delta):
	if( position.distance_to(destine) != 0 ): move_trop()
	else: play_units_anim("idle")
	z_index = position.y

func move_trop():
	play_units_anim("move")
	position += position.direction_to(destine) * GC.OPTIONS.trop_mov_vel
	if( position.distance_to(destine) < GC.OPTIONS.trop_mov_vel ): position = destine

func play_units_anim(anim_name,force=false):
	if current_anim == anim_name && !force: return
	current_anim = anim_name
	for u in $Units.get_children():
		u.play(anim_name)
		u.frame = randi()%4-1

#EXTERNALS
func set_destine(des):
	destine = des

func teleport_trop_to_tile(tile):
	position = GC.tile_to_pos( tile )
	set_destine(position)

func select():
	GC.currentTrop = self
	modulate.b = 2

func unselect():
	GC.currentTrop = null
	modulate.b = 1
