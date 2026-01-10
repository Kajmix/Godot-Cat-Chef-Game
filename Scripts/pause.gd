extends CanvasLayer
var is_paused = false
func _physics_process(_delta: float) -> void:
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


func _on_exit_to_main_menu_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
