extends NinePatchRect

func set_info(name,cnt):
	var icon = 0
	if name=="cam": icon = 5
	elif name=="gue": icon = 6
	elif name=="arq": icon = 7
	elif name=="jin": icon = 8
	elif name=="cat": icon = 9
	$Sprite.frame = icon
	$lb_cant.text = str(cnt)
