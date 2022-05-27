extends Control

func _ready():
	$NextTurn/Button.connect("button_down",GC.TURNER,"onNextTurnClick")
	update_header()

func update_header():
	$lb_recs.text = str( GC.RECS[GC.humanPlayer] )
