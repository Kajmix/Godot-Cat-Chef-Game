extends Area2D
var is_player_in_zone = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") && is_player_in_zone:
		Audio_Player.play_sound("fabric")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_zone = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_zone = false
