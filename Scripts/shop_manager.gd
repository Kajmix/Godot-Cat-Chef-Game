extends Node2D

@onready var Alert : Label = $"../ui/ui/Alert"
@onready var ShopItem : Sprite2D = $Item
@onready var animationPlayer : AnimationPlayer = $Item/CatPaw/AnimationPlayer
@onready var ui : Control = $"../ui/ui"
@onready var Player : CharacterBody2D = $"../Player"
var is_player_in_shop_area = false
var is_milk_bought = false
func _process(_delta: float) -> void:
	if is_player_in_shop_area:
		if Input.is_action_just_pressed("interact") && is_milk_bought == false:
			if MainGameManager.money >= 30:
				Audio_Player.play_sound("katching")
				animationPlayer.play("GiveItem")
				ShopItem.show()
				MainGameManager.sub_money(30)
				ui.update_label()
				is_milk_bought = true
			else:
				Alert.alert("You have not enought money to buy milk!", false)
		else:
			if is_milk_bought == true:
				Alert.alert("Press 'E' to drink milk", false)
				if Input.is_action_just_pressed("interact"):
					Audio_Player.play_sound("gulp")
					is_milk_bought = false
					animationPlayer.stop()
					ShopItem.hide()
					Player.speed_boost()
func _on_player_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Alert.alert("Are you want to buy some milk? \n Price: $30 (Press 'E', or 'Z' to buy)", false)
		is_player_in_shop_area = true

func _on_takeable_item_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Alert.hide_alert()
		is_player_in_shop_area = false
