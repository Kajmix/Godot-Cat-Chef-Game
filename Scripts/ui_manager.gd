extends Control
@onready var label : Label = $Control/Money/Label
func update_label():
	label.text = "Money: $" + str(MainGameManager.money)
