extends Area2D
@onready var Alert : Label = $"../ui/Alert"
@onready var Player : CharacterBody2D = $"../Player"
var is_player_in_exit_area : bool = false
func _process(_delta: float) -> void:
	if is_player_in_exit_area:
		if Input.is_action_just_pressed("interact"):
			if Player.is_player_have_key:
				print("You escaped!")
			else:
				Alert.alert("The doors are locked!")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_exit_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_exit_area = false
