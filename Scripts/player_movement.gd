extends CharacterBody2D

@onready var Player_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var Order_Sprite : AnimatedSprite2D = $Order_Sprite
@onready var Booster_Duration : Timer = $BoosterDuration
@onready var Particle_Emiter: CPUParticles2D = $SpeedBoostParticleEmiter
var SPEED = 75.0
#order system:
var is_any_item_not_taken = true
var selected_order_item
var table : StaticBody2D

func _physics_process(_delta: float) -> void:
	if MainGameManager.is_player_frozen:
		return
	var dir = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("up"):
		Player_sprite.play("UpWalk")
	elif Input.is_action_pressed("down"):
		Player_sprite.play("DownWalk")
	elif Input.is_action_pressed("left"):
		Player_sprite.play("LeftWalk")
	elif Input.is_action_pressed("right"):
		Player_sprite.play("RightWalk")
	else:
		Player_sprite.play("Idle")
	var target = dir.normalized() * SPEED
	velocity = velocity.lerp(target, 1.0 - exp(-15 * _delta))
	move_and_slide()

func take_ordered_item_handler(table_body : StaticBody2D, sprite):
	Audio_Player.play_sound("place-something")
	Audio_Player.play()
	Order_Sprite.frame=sprite
	table = table_body
	table.select_customer()
	selected_order_item = sprite
	Order_Sprite.show()

func hide_order_sprite():
	selected_order_item = null
	Order_Sprite.hide()

func speed_boost():
	%MilkIcon.texture = load("res://Assets/Milk boost icon.png")
	Booster_Duration.start()
	Particle_Emiter.emitting = true
	SPEED = 110.0

func _on_booster_duration_timeout() -> void:
	%MilkIcon.texture = load("res://Assets/Without Milk boost icon.png")
	Particle_Emiter.emitting = false
	SPEED = 75.0
