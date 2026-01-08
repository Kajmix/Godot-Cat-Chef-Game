extends CharacterBody2D
@onready var Player_sprite : AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 75.0

func _physics_process(_delta: float) -> void:
	var dir = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("up"):
		Player_sprite.frame = 1
	if Input.is_action_pressed("down"):
		Player_sprite.frame = 0
	if Input.is_action_pressed("left"):
		Player_sprite.frame = 2
	if Input.is_action_pressed("right"):
		Player_sprite.frame = 3
	var target = dir.normalized() * SPEED
	velocity = velocity.lerp(target, 0.3)
	move_and_slide()
