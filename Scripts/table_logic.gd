extends StaticBody2D
@onready var Customer : StaticBody2D = $Customer
@onready var Customer_Colision : CollisionShape2D = $"Customer/Customer Colision"
@onready var Customer_Sprite : AnimatedSprite2D = $Customer/AnimatedSprite2D
@onready var Order_Item : AnimatedSprite2D = $"Customer/Order/Order Sprite"
@onready var Order : Node2D = $Customer/Order
@onready var Items : StaticBody2D = $"../../Items"

@export var is_taken = false
func hide_customer():
	is_taken = false
	Customer.hide()
	Customer_Colision.disabled = true
	
func show_customer(main_body : StaticBody2D):
	is_taken = true
	Customer.show()
	Customer_Colision.disabled = false
	Customer_Sprite.frame = randi_range(0,1)
	var wanted_food = randi_range(0,2)
	Items.order_handler(main_body, wanted_food)
	Order_Item.frame = wanted_food
	Order.show()
	
func _ready() -> void:
	hide_customer()
