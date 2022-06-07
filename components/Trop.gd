extends Node2D

var STATE = "NONE"
export var OWN = 1
export var TYPE = "TROP"
export var st_cam = 0
var current_anim
var tile_pos = Vector2(0,0)
var path = []
var confirm_move = false
var steps = 0

onready var data = { 
	"own":1,
	"units":{ "cam":3,"gue":0,"arq":0,"jin":0,"cat":0}, 
	"hps":{}, 
	"hpt":0, 
	"unitsNode":$Units,
	"tropNode":self
}

func _ready():
	add_to_group("trops_group")
	yield(get_tree().create_timer(.1),"timeout")
	if st_cam>0: data.units["cam"] = st_cam
	GC.TropManager.calc_hps(data)
	GC.TropManager.recreate_units_nodes(data)
	teleport_to_tile(GC.pos_to_tile(position))
	tile_pos = GC.pos_to_tile(position)
	restore_steps()
	$Panel.modulate = GAMEDATA.COLORS[OWN]

func _process(delta):
	if( path.size() != 0 && confirm_move && steps>0): move_trop()
	else: play_units_anim("idle")
	z_index = (position.y/32)+100

func move_trop():
#	print("MOVING TROP",path)
	play_units_anim("move")
	position += position.direction_to(path[0]) * GC.OPTIONS.trop_mov_vel
	if( position.distance_to(path[0]) < GC.OPTIONS.trop_mov_vel ): 
		position = path[0]
		path.pop_front()
		steps -= 1
		if(steps==0): path = []
	tile_pos = GC.pos_to_tile(position)

func restore_steps():
	steps = GAMEDATA.VARS[OWN].trop_steps
	play_units_anim("idle",true)

func play_units_anim(anim_name,force=false):
	if current_anim == anim_name && !force: return
	current_anim = anim_name	
	for u in $Units.get_children():
		u.play(anim_name)
		u.playing = (steps>0)
		u.frame = randi()%4-1

#EXTERNALS
func set_destine(des):
	path = GC.get_nav_path(position,des,steps)
	path.pop_front()

func teleport_to_tile(tile):
	position = GC.tile_to_pos( tile )
	set_destine(position)

func select():
	GC.setCurrentSelect(self)
	modulate.b = 2

func unselect():
	GC.setCurrentSelect(null)
	GC.clear_path_lines()
	modulate.b = 1

func fx_atack(def):
	steps = 0
	play_units_anim("idle",true)
	var orig_pos = position
	$Tween.interpolate_property(self,"position", position, (position+def.position)/2, .2,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_completed")
	$Tween.interpolate_property(self,"position", position, orig_pos, .2,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()

func get_class(): return "Trop"

func remove_trop():
	queue_free()

func update_label():
	var amount=0
	for u in data.units:
		amount += data.units[u]
	$Panel/Label.text = str(amount)

func add_units(_units):
	for u in _units:
		if(!data.units.has(u)): data.units[u] = 0
		data.units[u] += _units[u]
	update_label()

func get_units():
	return data.units
