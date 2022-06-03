extends CanvasLayer

func _ready():
	hide_all_ui()

func hide_all_ui():
	$Build_panel.hide_panel()
	$Trop_panel.hide_panel()
	$Move_Trop_panel.hide_panel()

func onSelectObject(go):
	hide_all_ui()
	if !go: return
	elif go.get_class() == "Trop": onSelectTrop(go)
	elif go.get_class() == "Build": onSelectBuild(go)

func onSelectBuild(go):
	$Build_panel.show_panel(go)

func onSelectTrop(go):
	$Trop_panel.show_panel(go)
