extends Label
@onready var duration : Timer = $Timer
@onready var UI : Control = $".."
var is_have_duration_time = true
func _ready() -> void:
	SignalBus.set_alert.connect(_on_set_alert)
	SignalBus.hide_alert.connect(_on_hide_alert)
	SignalBus.bought_table.connect(_on_bought_table)
func alert(Text, is_have_duration_time = true):
	text = Text
	show()
	if is_have_duration_time:
		duration.start()

func hide_alert():
	if is_have_duration_time == false:
		duration.stop()
	hide()

func _on_duration_time_out() -> void:
	hide()

func _on_set_alert(Text):
	alert(Text, false)
	
func _on_hide_alert():
	hide_alert()

func _on_bought_table():
	UI.update_label()
	
