extends StaticBody2D
@onready var Customer : StaticBody2D = $Customer
@onready var Customer_Colision : CollisionShape2D = $"Customer/Customer Colision"
@onready var Customer_Sprite : AnimatedSprite2D = $Customer/AnimatedSprite2D
@onready var Order_Item : AnimatedSprite2D = $"Customer/Order/Order Sprite"
@onready var Order : Node2D = $Customer/Order
@onready var Items : StaticBody2D = $"../../Items"

@onready var player : CharacterBody2D = $"../../Player"
@onready var label : Label = $"../../ui/Label"

@export var is_taken = false
var is_player_nearby = false
func hide_customer():
	is_taken = false
	Customer.hide()
	Customer_Colision.disabled = true
	
func show_customer(main_body : StaticBody2D):
	is_taken = true
	Customer.show()
	Customer_Colision.disabled = false
	Customer_Sprite.frame = randi_range(0,3)
	var wanted_food = randi_range(0,2)
	Items.order_handler(main_body, wanted_food)
	Order_Item.frame = wanted_food
	Order.show()
	
func _ready() -> void:
	hide_customer()

func _process(delta: float) -> void:
	if Input.is_action_pressed("interact") && is_player_nearby:
		hide_customer()
		is_player_nearby = false
		player.is_any_item_not_taken = true
		player.hide_order_sprite()
		MainGameManager.client_exit()
		label.text = "Money: " + str(MainGameManager.money)

func _on_order_area_body_entered(body) -> void:
	if body.is_in_group("Player"):
		if body.selected_order_item == Order_Item.frame:
			print(body.selected_order_item)
			print(Order_Item.frame)
			is_player_nearby = true


func _on_order_area_body_exited(body) -> void:
	if body.is_in_group("Player"):
		is_player_nearby = false
