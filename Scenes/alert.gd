extends Label
@onready var duration : Timer = $Timer
func alert(Text):
	text = Text
	show()
	duration.start()


func _on_duration_time_out() -> void:
	hide()
