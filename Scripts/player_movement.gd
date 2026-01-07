extends CharacterBody2D
@onready var Player_sprite : Sprite2D = $Sprite2D
const SPEED = 50.0

func _physics_process(_delta: float) -> void:
	var dir = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("up"):
		Player_sprite.texture = load("res://Assets/Player Sprite-back.png")
	if Input.is_action_pressed("down"):
		Player_sprite.texture = load("res://Assets/Player Sprite.png")
	if Input.is_action_pressed("left"):
		Player_sprite.texture = load("res://Assets/Player Sprite.png")
	if Input.is_action_pressed("right"):
		Player_sprite.texture = load("res://Assets/Player Sprite.png")
	var target = dir.normalized() * SPEED
	velocity = velocity.lerp(target, 0.3)
	move_and_slide()
