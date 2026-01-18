extends CanvasLayer
@onready var animation_player = $ColorRect/AnimationPlayer
func play_transition_and_change(path: String):
	animation_player.play("Fade_out")
	animation_player.play("Fade_in")
	get_tree().change_scene_to_file(path)
