extends Node2D

var STATE = "NONE"
var current_anim
var tile_pos = Vector2(0,0)
var path = []
onready var data = { 
	"own":1,
	"units":{ "cam":5,"gue":5,"arq":5,"jin":1,"cat":0}, 
	"hps":{}, 
	"hpt":0, 
	"unitsNode":$Units,
	"tropNode":self
}

func _ready():
	add_to_group("trops_group")
	yield(get_tree().create_timer(.1),"timeout")
	GC.TropManager.calc_hps(data)
	GC.TropManager.recreate_units_nodes(data)
	teleport_to_tile(GC.pos_to_tile(position))
	pass # Replace with function body.

func _process(delta):
	if( path.size() != 0 ): move_trop()
	else: play_units_anim("idle")
	z_index = position.y

func move_trop():
#	print("MOVING TROP",path)
	play_units_anim("move")
	position += position.direction_to(path[0]) * GC.OPTIONS.trop_mov_vel
	if( position.distance_to(path[0]) < GC.OPTIONS.trop_mov_vel ): 
		position = path[0]
		path.pop_front()
	tile_pos = GC.pos_to_tile(position)

func play_units_anim(anim_name,force=false):
	if current_anim == anim_name && !force: return
	current_anim = anim_name
	for u in $Units.get_children():
		u.play(anim_name)
		u.frame = randi()%4-1

#EXTERNALS
func set_destine(des):
	path = GC.get_nav_path(position,des)

func teleport_to_tile(tile):
	position = GC.tile_to_pos( tile )
	set_destine(position)

func select():
	GC.setCurrentSelect(self)
	modulate.b = 2

func unselect():
	GC.setCurrentSelect(null)
	modulate.b = 1

func fx_atack(def):
	var orig_pos = position
	$Tween.interpolate_property(self,"position", position, (position+def.position)/2, .2,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_completed")
	$Tween.interpolate_property(self,"position", position, orig_pos, .2,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()

func get_class(): return "Trop"

func remove_trop():
	queue_free()

func update_label(amount):
	$Panel/Label.text = str(amount)
