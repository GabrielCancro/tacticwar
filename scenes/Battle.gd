extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouseTile
var camera_velocity = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	mouseTile = $Map/TileMapAuto.world_to_map( $Map/TileMapAuto.get_global_mouse_position()/2 )
	$Map/SelectorMap.position = mouseTile * 32 + Vector2(16,16)
	$Map/SelectorMap/Label.text = "("+str(mouseTile.x)+","+str(mouseTile.y)+")"
	
	moveCamera()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			print("CLICK",mouseTile)

func moveCamera():
	if Input.is_action_pressed("ui_down"): $Camera2D.position.y += camera_velocity
	elif Input.is_action_pressed("ui_up"): $Camera2D.position.y -= camera_velocity
	if Input.is_action_pressed("ui_left"): $Camera2D.position.x -= camera_velocity
	elif Input.is_action_pressed("ui_right"): $Camera2D.position.x += camera_velocity
