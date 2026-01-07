extends CharacterBody2D

const SPEED = 100.0

func _physics_process(_delta: float) -> void:
	var dir = Input.get_vector("left", "right", "up", "down")
	velocity = dir.normalized() * SPEED
	move_and_slide()
