extends CanvasLayer

func _ready():
	hide_all_ui()

func hide_all_ui():
	$Build_panel.hide_panel()
	$Trop.visible = false

func onSelectObject(go):
	hide_all_ui()
	if !go: return
	elif go.get_class() == "Trop": onSelectTrop(go)
	elif go.get_class() == "Build": onSelectBuild(go)

func onSelectBuild(go):
	$Build_panel.show_panel(go)

func onSelectTrop(go):
	$Trop.visible = true
	$Trop/Panel/Label.text = "TROP"
	for u in go.data.units:
		$Trop/Panel/Label.text += "\n  "+u+":"+str(go.data.units[u])
