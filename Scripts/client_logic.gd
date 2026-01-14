extends StaticBody2D
@onready var Customer : StaticBody2D = $Customer
@onready var Customer_Colision : CollisionShape2D = $"Customer/Customer Colision"
@onready var Customer_Sprite : AnimatedSprite2D = $Customer/AnimatedSprite2D
@onready var Order_Item : AnimatedSprite2D = $"Customer/Order/Order Sprite"
@onready var TableSprite : Sprite2D = $"Table Sprite"
@onready var Order : Node2D = $Customer/Order
@onready var Items : StaticBody2D = $"../../Items"
@onready var player : CharacterBody2D = $"../../Player"
@onready var ui : Control = $"../../ui/ui"
@onready var arrow : Sprite2D = $Arrow
@onready var Money_Particle_Emiter : CPUParticles2D = $MoneyParticleEmiter
@onready var Lock : Sprite2D = $lock
@export var is_taken = false
@export var is_not_bought = true
@export var price = 200
@export var id : int

signal set_alert(Text)
signal hide_alert()
signal bought_table()

var is_player_nearby = false
var is_player_in_buy_area = false
var TableSprite_modulate : Color
var order_value : int = 0

const normal_clients_animations_list = [
	"ball_guy",
	"green_guy",
	"purple_ball_guy",
	"purple_guy"
]
const special_clients_animations_list = [
	"cat",
	"businessman"
]

func set_alert_signal():
	SignalBus.emit_signal("set_alert", "Cost: $" + str(price) + "\n Press 'E', or 'Z' to buy")

func set_hide_alert():
	SignalBus.emit_signal("hide_alert")

func hide_customer():
	is_taken = false
	Customer.hide()
	Customer_Colision.disabled = true
	
func show_customer(main_body : StaticBody2D):
	is_taken = true
	var scale_value = randf_range(0.9, 1.1)
	Customer.scale = Vector2(scale_value, scale_value)
	Customer_Colision.scale = Vector2(scale_value, scale_value)
	Customer.show()
	Customer_Colision.disabled = false
	if randi_range(1,50) == 1: #Special Cats
		Customer_Sprite.play(special_clients_animations_list[randi_range(0, special_clients_animations_list.size() - 1)])
		order_value = randi_range(15, 50)
	else: #Normal customers
		Customer_Sprite.play(normal_clients_animations_list[randi_range(0, normal_clients_animations_list.size() - 1)])
		order_value = randi_range(8, 15)
	var wanted_food = randi_range(0,2)
	Items.order_handler(main_body, wanted_food)
	Order_Item.frame = wanted_food
	Order.show()
	
func _ready() -> void:
	MainGameManager.loading_finished.connect(_on_loading_finished)
	TableSprite_modulate = TableSprite.modulate
	hide_customer()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") && is_player_nearby:
		hide_customer()
		is_player_nearby = false
		player.is_any_item_not_taken = true
		player.hide_order_sprite()
		MainGameManager.client_exit(order_value)
		unselect_customer()
		ui.update_label()
		Money_Particle_Emiter.emitting = true
		Audio_Player.play_sound("money")
	if Input.is_action_just_pressed("interact") && is_player_in_buy_area == true && is_not_bought == true && MainGameManager.money >= price:
		MainGameManager.sub_money(price)
		is_not_bought = false
		TableSprite.modulate = TableSprite_modulate
		Lock.hide()
		SignalBus.emit_signal("hide_alert")
		SignalBus.emit_signal("bought_table")
		Audio_Player.play_sound("katching")

func _on_order_area_body_entered(body) -> void:
	if body.is_in_group("Player"):
		is_player_in_buy_area = true
		if body.selected_order_item == Order_Item.frame && body.table == self:
			is_player_nearby = true
		if is_not_bought == true:
			set_alert_signal()

func _on_order_area_body_exited(body) -> void:
	if body.is_in_group("Player"):
		is_player_in_buy_area = false
		is_player_nearby = false
		if is_not_bought == true:
			set_hide_alert()

func select_customer():
	arrow.show()
func unselect_customer():
	arrow.hide()
func _on_loading_finished():
	if is_not_bought == true:
		TableSprite.modulate = Color(0,0,0)
		Lock.show()
	else:
		Lock.hide()
