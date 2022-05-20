extends Node2D

var STATE = "NONE"
var destine = Vector2(0,0)
var current_anim

func _ready():
	pass # Replace with function body.

func _process(delta):
	if( position.distance_to(destine) != 0 ): move_trop()
	else: play_units_anim("idle")

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
