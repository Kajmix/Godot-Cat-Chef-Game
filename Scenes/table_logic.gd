extends StaticBody2D
@onready var Customer : StaticBody2D = $Customer
@onready var Customer_Colision : CollisionShape2D = $"Customer/Customer Colision"
@onready var Customer_Sprite : AnimatedSprite2D = $Customer/AnimatedSprite2D
@onready var Order_Item : AnimatedSprite2D = $"Customer/Order/Order Sprite"
@onready var Order : Node2D = $Customer/Order
var a = true
func hide_customer():
	Customer.hide()
	Customer_Colision.disabled = true
func show_customer():
	Customer.show()
	Customer_Colision.disabled = false
	Customer_Sprite.frame = randi_range(0,1)
	var wanted_food = randi_range(0,3)
	Order_Item.frame = wanted_food
	if Order_Item.frame == 1 || Order_Item.frame == 2 || Order_Item.frame == 3:
		Order.hide()
	else:
		Order.show()
	
func _ready() -> void:
	hide_customer()
func _process(_delta: float) -> void:
	if Input.is_action_pressed("interact"):
		if a:
			show_customer()
			a = !a
		else:
			hide_customer()
			a = !a
