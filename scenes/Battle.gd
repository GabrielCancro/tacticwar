extends Node2D

var camera_velocity = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$Trop.teleport_trop_to_tile( Vector2(3,4) )
	$Trop2.teleport_trop_to_tile( Vector2(8,6) )
	GC.init_references()

func _process(delta):
	$Map/SelectorMap.position = GC.mouseTilePos
	$Map/SelectorMap/Label.text = "("+str(GC.mouseTile.x)+","+str(GC.mouseTile.y)+")"
	moveCamera()

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == 1 and event.is_pressed():
#			$Trop.set_destine(GC.mouseTilePos)

func moveCamera():
	if Input.is_action_pressed("ui_down"): $Camera2D.position.y += camera_velocity
	elif Input.is_action_pressed("ui_up"): $Camera2D.position.y -= camera_velocity
	if Input.is_action_pressed("ui_left"): $Camera2D.position.x -= camera_velocity
	elif Input.is_action_pressed("ui_right"): $Camera2D.position.x += camera_velocity
