extends NinePatchRect

var GO
var UNITS

func hide_panel():
	visible = false
	
func show_panel(go):
	GO = go
	visible = true
	
	UNITS = GO.data.units
	var index = 0
	var PANELS = $VBox.get_children()
	for u in UNITS: 
		PANELS[index].set_info( u, UNITS[u] )
		index += 1
	$Label.text = "TROPS"
	$Label.modulate = GAMEDATA.COLORS[GO.OWN]
