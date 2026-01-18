extends CanvasLayer

func _on_exit_pressed() -> void:
	Audio_Player.play_sound("click")
	get_tree().quit()

func _on_play_pressed() -> void:
	Audio_Player.play_sound("click")
	MainGameManager.load_save(null)
	Fade.play_transition_and_change("res://Scenes/main.tscn")
