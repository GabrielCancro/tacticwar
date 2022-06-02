extends NinePatchRect

func set_info(name,cnt,inc):
	var icon = 0
	if   name=="food": icon = 0
	elif name=="wood": icon = 1
	elif name=="stone": icon = 2
	elif name=="gold": icon = 3
	elif name=="pop": icon = 4
	elif name=="cam": icon = 5
	elif name=="gue": icon = 6
	elif name=="arq": icon = 7
	elif name=="jin": icon = 8
	elif name=="cat": icon = 9
	$Sprite.frame = icon
	$lb_cant.text = str(cnt)
	if(get_node("lb_inc")):
		if inc>=0: get_node("lb_inc").text = "+"+str(inc)
		else: get_node("lb_inc").text = str(inc)
