extends CenterContainer

@onready var buyButton = $Background/VBoxContainer/BuyButton
@onready var titleLabel = $Background/VBoxContainer/Title
@onready var priceLabel = $Background/VBoxContainer/Price
@onready var iconTextureRect = $Background/VBoxContainer/MarginContainer/ItemIconHolder/Item

@export var title = "Milk"
@export var is_bought = false
@export var price = 30
@export var basedprice = 30
@export var icon : Texture2D
@export var is_one_time_buy = false

func refresh_ui():
	if title == "Tables Upgrade":
		price = int(basedprice * pow(1.1,MainGameManager.table_upgrade_tier))
	titleLabel.text = title
	if title != "Milk":
		priceLabel.text = "Tier: " + str(MainGameManager.table_upgrade_tier) + "\n"+ "$" + str(price)
	else:
		priceLabel.text = "\n$" + str(price)
	iconTextureRect.texture = icon
	if is_bought == true:
		buyButton.disabled = true
	else:
		buyButton.disabled = false

func _ready() -> void:
	MainGameManager.loading_finished.connect(on_loading_finished)
	refresh_ui()

func on_loading_finished():
	refresh_ui()

func _on_buy_button_down() -> void:
	if MainGameManager.money >= price:
		MainGameManager.sub_money(price)
		Audio_Player.play_sound("katching")
		SignalBus.emit_signal("buy_item", title)
		is_bought = false
		refresh_ui()
	
