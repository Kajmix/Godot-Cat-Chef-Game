extends Area2D
@onready var Alert : Label = $"../ui/ui/Alert"
@onready var Player : CharacterBody2D = $"../Player"
@onready var Door_open : TileMapLayer = $"../Tilemap/Door_open"

var is_player_in_exit_area : bool = false
func _process(_delta: float) -> void:
	if is_player_in_exit_area:
		if Input.is_action_just_pressed("interact") && MainGameManager.is_door_open:
			Fade.play_transition_and_change("res://Scenes/ending.tscn")
			return
		if Input.is_action_just_pressed("interact"):
			if MainGameManager.is_have_keys:
				%KeyIcon.hide()
				MainGameManager.is_have_keys = false
				MainGameManager.is_door_open = true
				MainGameManager.autosave(Player)
				Door_open.show()
			else:
				Alert.alert("The doors are locked!", true)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_exit_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_exit_area = false
