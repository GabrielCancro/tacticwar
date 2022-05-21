extends Node

var UNITS_DATA={
	"cam":{ "hp":40,"dam":5,"type_dam":"mele" },
	"gue":{ "hp":80,"dam":15,"type_dam":"mele" },
	"arq":{ "hp":50,"dam":5,"type_dam":"proy" },
	"jin":{ "hp":120,"dam":12,"type_dam":"mele" },
	"cat":{ "hp":120,"dam":10,"type_dam":"build" },
}
var UNITS_ACC={
	"cam":{ "cam":5,"gue":4,"arq":2,"jin":3,"cat":1},
	"gue":{ "cam":5,"gue":4,"arq":2,"jin":3,"cat":1},
	"arq":{ "cam":5,"gue":4,"arq":2,"jin":3,"cat":1},
	"jin":{ "cam":5,"gue":4,"arq":2,"jin":3,"cat":1},
	"cat":{ "cam":5,"gue":4,"arq":2,"jin":3,"cat":1},
}

onready var trop1 = { "units":{ "cam":5,"gue":5,"arq":5,"jin":1,"cat":0}, "hps":{}, "hpt":0, "unitsNode":get_node("/root/Battle/Trop/Units") }
onready var trop2 = { "units":{ "cam":10,"gue":0,"arq":0,"jin":0,"cat":0}, "hps":{}, "hpt":0, "unitsNode":get_node("/root/Battle/Trop/Units") }

func _ready():
	$Button.connect("button_down",self,"onBtn")

func onBtn():
	atack(trop1,trop2)

func calc_hps(trop):
	trop.hpt = 0;
	for u in trop.units:
		trop.hps[u] = UNITS_DATA[u].hp * trop.units[u]
		trop.hpt += trop.hps[u]
#		print(u," x",trop.units[u]," ",trop.hps[u])

func calc_units(trop):
	for u in trop.units:
		trop.units[u] = ceil( trop.hps[u] / UNITS_DATA[u].hp )
#		print("UNIT ",u," ",trop.units[u])

func atack(atk,def):
	print("ATAQUE!!")
	print(" atk -> ",atk)
	print(" def -> ",def)
	print("\n")
	atk.tropNode.fx_atack( def.tropNode.position )
	yield(get_tree().create_timer(.2),"timeout")
	if def.hpt<=0: return
	#calcular el daño de la tropa atacante
	var atk_damage = 0
	for u in atk.units: atk_damage += atk.units[u] * UNITS_DATA[u].dam
	print("atk_damage = ",atk_damage)
	
	#calcular la distribucion de daño
	var acc = {}; var acc_amount = 0;
	for u in atk.units:
		for ud in def.units:
			var amount = UNITS_ACC[u][ud] * def.units[ud]
			if !acc.has(ud): acc[ud] = amount
			else: acc[ud] += amount
			acc_amount += amount
	print("DISTRIBUCION DE DAÑO")
	print(acc," ",acc_amount)
	print("\n")
	
	#to percent
	for u in acc: acc[u] *= 1.0/acc_amount
	print("DISTRIBUCION DE DAÑO (PERCENT)")
	print(acc," ",acc_amount)
	print("\n")
	
	#to damage
	for u in acc: acc[u] *= atk_damage
	print("DISTRIBUCION DE DAÑO (FINAL)")
	print(acc," ",atk_damage)
	print("\n")
	
	#apply damage
	var damage_rest = 0
	for u in acc:
		def.hps[u] -= ceil( acc[u] )
		if(def.hps[u]<0):
			damage_rest -= def.hps[u]
			def.hps[u] = 0
			
	print("RESULTADO TRAS APLICAR EL DAÑO")
	calc_units(def)
	print(def)
	print("daño sobrante ",damage_rest)
	recreate_units_nodes(def)

func recreate_units_nodes(trop):
	var U_SCENE = preload("res://components/Unit.tscn")
	for u in trop.unitsNode.get_children(): 
		trop.unitsNode.remove_child(u)
		u.queue_free()
	for u in trop.units:
		for i in range(trop.units[u]): 
			var elem = U_SCENE.instance()
			trop.unitsNode.add_child(elem)
	order_element_trop(trop)
	trop.unitsNode.get_parent().play_units_anim("idle",true)

func order_element_trop(trop):
	var childs = trop.unitsNode.get_children()
	var tsize = min(childs.size(),20)
	if(childs.size()>20): tsize += ceil( sqrt( childs.size()-20 ) )
	var cuad = ceil( sqrt( tsize ) )
	if cuad == 0: return
	var dist = Vector2(10,10)
	if(cuad>3): dist = Vector2(12-cuad,12-cuad)
	var base = - dist * (cuad / 2) + Vector2(dist.x*0.5,dist.y*1.5)
	print("CUAD ",tsize," ",cuad)
	var last_line_index = cuad * floor(tsize/cuad)
	print( "LAST LINE ",last_line_index )
	var i = 0
	for py in range(cuad):
		for px in range(cuad):
			if i >= tsize: break
			childs[i].position = base + Vector2(px*dist.x,py*dist.y) + Vector2(rand_range(-2,2),rand_range(-2,2))
			childs[i].z_index = childs[i].position.y
			if i >= last_line_index: 
				var move = cuad-(tsize-last_line_index)
				move = (move/2) * dist.x
				print(move)
				childs[i].position.x += move
#				childs[i].modulate.a = 5
			i += 1
