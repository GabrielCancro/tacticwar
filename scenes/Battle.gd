extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var camera_velocity = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$Trop.position = GC.tile_to_pos( Vector2(3,4) )
	print($Trop.position )
	$Trop.set_destine($Trop.position)

func _process(delta):
	GC.mouseTile = GC.pos_to_tile( $Map/TileMapAuto.get_global_mouse_position() )
	GC.mouseTilePos = GC.tile_to_pos( GC.mouseTile )
	$Map/SelectorMap.position = GC.mouseTilePos
	$Map/SelectorMap/Label.text = "("+str(GC.mouseTile.x)+","+str(GC.mouseTile.y)+")"
	moveCamera()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			$Trop.set_destine(GC.mouseTilePos)

func moveCamera():
	if Input.is_action_pressed("ui_down"): $Camera2D.position.y += camera_velocity
	elif Input.is_action_pressed("ui_up"): $Camera2D.position.y -= camera_velocity
	if Input.is_action_pressed("ui_left"): $Camera2D.position.x -= camera_velocity
	elif Input.is_action_pressed("ui_right"): $Camera2D.position.x += camera_velocity
