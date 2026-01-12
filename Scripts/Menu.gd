extends CanvasLayer
func _on_exit_pressed() -> void:
	Audio_Player.play_sound("click")
	get_tree().quit()

func _on_play_pressed() -> void:
	Audio_Player.play_sound("click")
	MainGameManager.load_save(null)
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
