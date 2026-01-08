extends CanvasLayer
var is_paused = false
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		is_paused = !is_paused
		if is_paused:
			is_paused = true
			show()
			Engine.time_scale = 0
		else:
			is_paused = false
			hide()
			Engine.time_scale = 1


func _on_play_pressed() -> void:
	is_paused = false
	hide()
	Engine.time_scale = 1

func _on_exit_pressed() -> void:
	get_tree().quit()
