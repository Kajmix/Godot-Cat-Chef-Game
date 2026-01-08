extends Node2D
var Player : CharacterBody2D
var label : Label
var money = 0
func _ready():
	Player = get_tree().root.get_node("Main/Player")
	label = get_tree().root.get_node("Main/ui/Label")
func client_exit():
	money += randi_range(10,12)
	label.text = "Money: " + str(money)
	Player.is_any_item_not_taken = true
	Player.hide_order_sprite()
