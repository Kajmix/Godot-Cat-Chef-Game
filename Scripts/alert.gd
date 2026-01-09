extends Label
@onready var duration : Timer = $Timer
func alert(Text, is_have_duration_time = true):
	text = Text
	show()
	if is_have_duration_time:
		duration.start()

func hide_alert():
	duration.stop()
	hide()

func _on_duration_time_out() -> void:
	hide()
