extends Node2D

@onready var Alert : Label = $"../ui/ui/Alert"
@onready var ShopItem : Sprite2D = $Item
@onready var animationPlayer : AnimationPlayer = $Item/CatPaw/AnimationPlayer
@onready var ui : Control = $"../ui/ui"
@onready var Player : CharacterBody2D = $"../Player"

@onready var Shop = $"../ui/Shop"

var is_player_in_shop_area = false
var is_milk_bought = false
@export var milk_price = 30

func _ready() -> void:
	SignalBus.buy_item.connect(on_buy_item)

func _process(_delta: float) -> void:
	if is_player_in_shop_area:
		if is_milk_bought == true:
			Shop.hide()
			Alert.alert("Press 'E' to drink milk", false)
			if Input.is_action_just_pressed("interact"):
				Audio_Player.play_sound("gulp")
				animationPlayer.stop()
				ShopItem.hide()
				is_milk_bought = false
				Player.speed_boost()
		else:
			Shop.show()
func _on_player_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_in_shop_area = true

func _on_takeable_item_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Shop.hide()
		Alert.hide_alert()
		is_player_in_shop_area = false	

func buy_milk():
	animationPlayer.play("GiveItem")
	ShopItem.show()
	is_milk_bought = true

func buy_tables_upgrade():
	MainGameManager.table_upgrade_tier_up()

func on_buy_item(item):
	if item == "Milk":
		Shop.hide()
		buy_milk()
	if item == "Tables Upgrade":
		buy_tables_upgrade()
	ui.update_label()
