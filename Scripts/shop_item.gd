extends CenterContainer

@onready var buyButton = $Background/VBoxContainer/BuyButton
@onready var titleLabel = $Background/VBoxContainer/Title
@onready var priceLabel = $Background/VBoxContainer/Price
@onready var iconTextureRect = $Background/VBoxContainer/MarginContainer/ItemIconHolder/Item

@export var title = "Milk"
@export var is_bought = false
@export var tier = 1
@export var price = 30
@export var icon : Texture2D

func _ready() -> void:
	titleLabel.text = title
	priceLabel.text = "$" + str(price)
	iconTextureRect.texture = icon
	if is_bought == true:
		buyButton.disabled == true
	else:
		buyButton.disabled == false
