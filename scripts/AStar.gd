extends Node2D

onready var astar = AStar2D.new()
onready var MAP = get_node("TileMapNav")

func _ready():
	create_all_points(25,25)
	connect_all_points(25,25)

func create_all_points(tx,ty):
	astar.clear()
	for y in range(tx):
		for x in range(ty):
			astar.add_point ( y*1000+x, Vector2(x,y) )

func connect_all_points(tx,ty):
	for y in range(tx):
		for x in range(ty):
			if( MAP.get_cell(x+1,y)!=-1 ): astar.connect_points(y*1000+x, y*1000+x+1, false)
			if( MAP.get_cell(x-1,y)!=-1 ): astar.connect_points(y*1000+x, y*1000+x-1, false)
			if( MAP.get_cell(x,y+1)!=-1 ): astar.connect_points(y*1000+x, (y+1)*1000+x, false)
			if( MAP.get_cell(x,y-1)!=-1 ): astar.connect_points(y*1000+x, (y-1)*1000+x, false)
#			print("(",x,",",y,") ", MAP.get_cell(x,y))

func get_nav_path(from,to):
	var from_id = from.y*1000+from.x
	var to_id = to.y*1000+to.x
	var final_array = []
	for p in astar.get_id_path(from_id,to_id):
		final_array.append( Vector2( p%1000, floor(p/1000) ) );
	return final_array
