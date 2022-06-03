extends NinePatchRect

func set_info(name,cnt,inc):
	var icon = 0
	if   name=="food": icon = 0
	elif name=="wood": icon = 1
	elif name=="stone": icon = 2
	elif name=="gold": icon = 3
	elif name=="pop": icon = 4
	$Sprite.frame = icon
	$lb_cant.text = str(cnt)
	if inc>=0: get_node("lb_inc").text = "+"+str(inc)
	else: get_node("lb_inc").text = str(inc)
